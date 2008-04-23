From: jimc@math.ucla.edu (Jim Carter)
Subject: (no subject)
Date: Wed, 23 Apr 2008 11:50:17 -0700 (PDT)
Message-ID: <20080423185018.122C53C3B1@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Our two webservers serve UserDirs that are automounted (NFS) from other
hosts.  Every few days we discover a catatonic webserver (Apache2) with
$ServerLimit child processes (150 of them), and many but not all home
directories cannot be accessed manually (ls -d ~$user, which hangs).
This started immediately after we upgraded the server host from SuSE
10.1 to SuSE 10.3; autofs version changed from 4.1.4 to 5.0.2.

A test program reproduces the problem.  First it identifies all
filesystems that can be NFS/auto mounted.  Then it goes through
/proc/mounts and for each one that is not currently mounted, it forks a
process which enumerates the mountpoint directory, causing automounting.
This is repeated every 2 secs, so when automount unmounts a directory
the test program promptly makes it get mounted again.  With our about
250 exported filesystems and default (5 min.) timeout, the test does
about 1 unmount-mount pair per second on average.  Simultaneous 
mounting and unmounting is a distinct possibility.

The program will run for 15 minutes to 1 hour with no failures, but then
directory-reading processes will start to hang.  My impression is that
about half of them hang.  (Like the webserver, the program gives up when
too many subprocesses are hung.)  If I kill and restart autofs, the test
program can be run again with similar behavior, i.e. runs for a while
with no failures, then starts hanging.  I do *not* see hanging mount
commands; they either succeed or fail and promptly exit.  The hung
directory-reading processes do not respond to SIGTERM but can be killed
with SIGKILL.

If I revert autofs back to 4.1.4 the test program can run for over 4
hours with no hangs (but with occasional, tolerable issues from the
obsolete version).  This is with module autofs4.ko from kernel
2.6.22.17, not compiling and reverting to an older module.  We have
reverted autofs on the webservers to avoid being lynched by our faculty.

I was hoping to include debug output from autofs, but when I set
DEFAULT_LOGGING=debug and started the test program it totally locked up
the machine and I haven't been able to get on it since (because I'm
working from home).  Update: a co-worker rebooted it for me and I was
able to clear the debug switch and recover the syslog output (attached).
But evidently the test program also seized up; I don't see a lot of
actual mounting going on.  Anyway I've included it, for what it's worth.

I was hoping to include useful strace output, and I have 80 Mbytes of
turgid information (on a different machine), but I have a feeling that
it's going to be more useful to include the test program and let 
someone overload their own testbed system.  Here's my impression of the
traces:  

Due to the structure of my map files, the autofs main process spawns a
thread for each host, and that thread spawns another thread that forks
and execve's /bin/mount or /bin/umount, which forks and execve's
/sbin/mount.nfs or /sbin/umount.nfs.  I followed ten of these threads
and each one exited seemingly normally.  I followed one (a mounter) in
line-by-line detail and everything was entirely plausible without any
apparent errors.  Others which were followed less meticulously also
seemed error-free.  During one segment of 10 Mbytes of tracing, lasting
62 elapsed secs, during the period when lots of client threads were
hanging, there were 88 execve(..., "/sbin/mount.nfs"...) and 226
execve("/sbin/umount.nfs").  Each time a filesystem was unmounted the
test script should have accessed it within 2 seconds, but evidently
about 2/3 of the access events did not result in spawning
/sbin/umount.nfs followed by letting the client's readdir finish.

I'm not able to identify where the main thread is getting notified of
which filesystem to automount.  It only seems to wait on a futex that
either times out or returns EAGAIN, call time(), and clone subthreads.
(Shared memory?)  Thus I can't tell whether the main thread was notified
but lost the information, or whether the kernel module failed to notify
userspace.

/bin/mount used to have notorious problems locking /etc/mtab.  But I
compare /etc/mtab with /proc/mounts before forking the directory access
process, and it was the same on several thousand comparisons with only
two unequal comparisons; in both cases the filesystem about to be
accessed (remounted) was in mtab and not /proc/mounts, and at most 8
seconds later it was in both and the content had been read.  2 minutes
after the second such event, and 38 minutes into the test run, client
processes started to hang.

Here are the particulars of our autofs setup.

Distro:		OpenSuSE 10.3
Kernel:		2.6.22.17 (kernel-default-2.6.22.17-0.1)
Autofs:		5.0.2-30.2 (recompiled with the DNS timeout mitigation 
		patch that Ian Kent made for us) (and identical behavior 
		without the patch)
Mount program:	util-linux-2.12r+2.13rc2+git20070725-24.2 (/bin/mount)
NFS:		nfs-client-1.1.0-8 (/sbin/mount.nfs)

=-- auto.master --- (comments omitted in all conf files)
/net            /etc/auto.net		<== giving trouble
/home           yp:auto.home

=-- auto.net ---
*       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&    file:/etc/auto.net.generic

=-- auto.net.generic ---
*       ${SERVER}:/&

(The effect is that when you refer to /net/$HOST/$DIR it starts a 
thread for $HOST which then mounts the exported filesystem(s).)

=-- nsswitch.conf --
passwd:         compat nis
shadow:         compat nis
group:          compat nis

hosts:          files dns
networks:       files dns

netgroup:       nis
aliases:        files nis

services:       files
protocols:      files
rpc:            files
ethers:         files
netmasks:       files
publickey:      files

bootparams:     files
automount:      files

=-- /etc/sysconfig/autofs --- (comments deleted)
AUTOFS_OPTIONS=""
NISMASTERMAP="auto.master"		<== map exists but not actually used
UNDERSCORETODOT="yes"			<== we have no underscores
LOCAL_OPTIONS=""
APPEND_OPTIONS="yes"
DEFAULT_MASTER_MAP_NAME="auto.master"
DEFAULT_TIMEOUT=600
DEFAULT_BROWSE_MODE="yes"
DEFAULT_LOGGING="none"			<== NOT changed to "debug"
	I tried with "debug" and the machine was totally overloaded, 
	could not get any session response.  

DEFAULT_MAP_OBJECT_CLASS="nisMap"	<== pro forma; we have no LDAP
DEFAULT_ENTRY_OBJECT_CLASS="nisObject"
DEFAULT_MAP_ATTRIBUTE="nisMapName"
DEFAULT_ENTRY_ATTRIBUTE="cn"
DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"
DEFAULT_AUTH_CONF_FILE="etc/autofs_ldap_auth.conf"

=------- Test Program ---------
#!/usr/bin/perl -w
# Automount is giving us trouble.  This script beats on the automounter.
# Algorithm:
#   1.	Guess a set of candidate filesystems that could be automounted.
#   2.	Read /proc/mounts and find out which are not currently mounted.
#   3.	For each non-mounted filesys, fork a process that enumerates the
#	mountpoint directory, causing automounting and/or hanging.
#   3a.	On the first pass only, if a mount fails suppress that filesystem
#	silently -- our guess was wrong of which filesystems actually exist.
#   4.	Sleep 2 secs and repeat from step 2.  Eventually filesystems will
#	be auto-unmounted and this program will cause them to be remounted.

use Hostgroup;				# A local package giving sets of hosts.
	# If it would be useful to the test person to have this package,
	# rather than rewriting getfilesys() according to local conventions
	# for naming exported filesystems, I can send it over.
use POSIX qw(:sys_wait_h strftime);
use Time::HiRes qw(time sleep);
use strict;

# Adjustable parameters
# Minimum sleep time between automount actions (in secs)
our $dt = 0.2;
# Sleep time (secs) between repeats of the whole algorithm
our $dpass = 2;
# If the mounting process runs longer than this it is considered to be hung.
our $dmax = 25;
# If a filesystem can't be mounted (failed, not hung), how long for retrying
our $dfail = 900;


$| = 1;			# Line buffered standard output

# Message output
#   $mtpt	The mount point
#   $msg	Text of message
#   Returns:	nothing
our ($now, @now);		# Cached value of time()
sub message {
    my($mtpt, $msg) = @_;
    printf("%s %-20s %s\n", strftime("%H:%M:%S", @now), $mtpt, $msg);
}

# Get candidate filesystems.  This depends heavily on local conventions
# and on the Hostgroup.pm package, locally written.  
#   \%fsys	Ref. to hash to be stuffed.  Key = mount point, e.g.
#		/net/julia/h1; value = {host, mtpt}.  Filesystems are not
#		guaranteed to exist.
#   Returns:	Nothing.
# Interpretation of $fsys->{$mtpt}{state}
#   0		Uninitialized
#   1		Checking process was started
#   2		Success: mount point has some content
#   3		Failed: mount point has no directory entries
#   4		Hung: Checking process ran over 25 secs
#   5		Suppress: Mount point failed and should not be tried again.
sub getfilesys {
    my($fsys) = @_;
		# Let's try not to have 1500 candidates most of which
		# don't exist.  Adjust parameters per hostgroup.
    &getf1($fsys, 'server', [qw(h m s)], [1..4]);
    &getf1($fsys, 'nfsx-server', [qw(h)], [1]);
    &getf1($fsys, 'nfsx-server', [qw(m)], [1..2]);
}

# Expands potential filesystems within reasonable limits.
# At Mathnet an exported filesystem is named /${pfx}${digit}, e.g.
# /h1 or /m2.  
#   \%fsys	Ref. to hash to be stuffed.
#   $hgrp	Hostgroup expression giving hosts to be tried ('down' 
#		not needed)
#   \@pfx	Prefixes for names of exported filesystems
#   \@nbrs	Suffix numbers for the filesystems.
sub getf1 {
    my($fsys, $hgrp, $pfx, $nbrs) = @_;
    foreach my $host (&GetHostgroup("$hgrp-down-rogue")) {
	foreach my $ltr (@$pfx) {
	    foreach my $nbr (@$nbrs) {
		my $mtpt = "/net/$host/$ltr$nbr";
		$fsys->{$mtpt} = {
		    host => $host,
		    mtpt => $mtpt,
		    state => 0,		# 0 -> uninitialized
		    oldstate => 0,	# 0 -> uninitialized
		};
	    }
	}
    }
}

# Checks if a filesystem can be mounted.  This subroutine just spawns 
# the checking process.
#   $mtpt	Mount point being checked.
#   \%fsys	Hash of per mount point data.
#   Returns:	PID of subprocess.  It will return 0 on success, 1 on failure,
#		or it could hang forever; this is the symptom we are seeing.
our %pid2mtpt;
sub spawncheck {
    my($mtpt, $fsys) = @_;
    my $val = $fsys->{$mtpt};
    $val->{whenchecked} = $now;
    $val->{oldstate} = $val->{state};
    $val->{state} = 1;			# 1 = process running
    my $pid = fork();
    if (!$pid) {
		# In child process...
	my @content = glob("$mtpt/*");
	my $rc = @content ? 0 : 1;
	exit $rc;
    }
		# In parent process...
    $val->{pid} = $pid;
    $pid2mtpt{$pid} = $mtpt;		# Translation from PID to mount point
    $pid;
}

# Common processing for the result.  Args:
#   \%fsys	Ref. to mount point hash.
#   $pid	PID of checking process.
#   $rc		Return code of process: 0 = success, positive = failed,
#		negative = hung.
#   \@list	List of finished mount points
#   Returns:	Mount point that the process was checking.
sub fileresult {
    my($fsys, $pid, $rc, $list) = @_;
    my $mtpt = $pid2mtpt{$pid};
    if (defined($mtpt)) {
	my $val = $fsys->{$mtpt};
	if (defined($val)) {
	    $val->{state} = ($rc == 0) ? 2 : ($rc > 0) ? 3 : 4;
	    push(@$list, $mtpt);
	} else {
	    &message($mtpt, "not in fsys (fileresult)");
	}
    } else {
	&message($pid, "not in pid2mtpt (fileresult)");
    }
    delete $pid2mtpt{$pid} if $rc >= 0;
}

# Reaps any exited processes, then returns.  Also checks for hung processes.
# If a process is judged hung and later finishes, this is self-healing.
#   \%fsys	Hash of per mount point data.
#   Returns:	List of finished mount points (could be empty).  
sub spawnreap {
    my($fsys) = @_;
    my @finished;
    my($pid, $mtpt);
    REAP: {
	$pid = waitpid(-1, WNOHANG);
	last if $pid <= 0;
	&fileresult($fsys, $pid, $?, \@finished);
	redo;
    }
		# Check for hung processes.  It takes 10 secs to recognize
		# that the NFS server is down.
    my $timeout = $now - $dmax;			# Allow 25 secs 
    foreach $pid (keys %pid2mtpt) {
	$mtpt = $pid2mtpt{$pid};
	my $val = $fsys->{$mtpt};
	if (!defined($val)) {
	    delete $fsys->{$mtpt};
	    delete $pid2mtpt{$pid};
	    next;
	}
	next if defined($val) && ($val->{state} >= 4 || 
	    $val->{whenchecked} >= $timeout);
	&fileresult($fsys, $pid, -1, \@finished);
    }
    @finished;
}

# Checks if /etc/mtab agrees with /proc/mounts.  Only NFS mounts are 
# looked at.  Args:
#   $curse	Recursion depth, starting with 0.
#   $msg	Error message passed in from earlier recursion.
#   Returns:	Discrepancies as text string, or "" if no discreps
sub checkmtab {
    my($curse, $msg) = @_;
    $msg = "" unless defined($msg);
    return $msg if (++$curse > 5);
    my(%mounted, $i);
		# Identify which mtab we're reading today.
    my @stat1 = stat("/etc/mtab") or 
	return &checkmtab($curse, "can't stat /etc/mtab: $!");
		# Read /etc/mtab and save a list of what's mounted.
    open(MTAB, "/etc/mtab") or 
	return &checkmtab($curse, "can't read /etc/mtab: $!");
    while (<MTAB>) {
	my @line = split;
	$mounted{$line[1]} ++ if $line[2] eq 'nfs';
    }
    close(MTAB);
		# Read /proc/mounts and save a list of what's mounted.
    open(MTAB, "/proc/mounts") or 
	return &checkmtab($curse, "can't read /proc/mounts: $!");
    while (<MTAB>) {
	my @line = split;
	$mounted{$line[1]} += 16 if $line[2] eq 'nfs';
    }
    close(MTAB);
		# Detect if mtab was altered since first read.  (Can't do much
		# about /proc/mounts changing; stat() doesn't even give the
		# length.)  Recurse if mtab changed in inode, size or mtime.
    my @stat2 = stat("/etc/mtab") or 
	return &checkmtab($curse, "can't stat /etc/mtab: $!");
    foreach $i ((1, 7, 9)) {
	return &checkmtab($curse, $msg) if $stat1[$i] != $stat2[$i];
    }
		# We successfully read both files.  Detect discrepancies.
    $msg = "";
    my $nbad = 0;
    my($mtpt, $in);
    my @hdr = ("mtab: ", "<=> mounts: ");
    foreach $i (0..1) {
	$msg .= $hdr[$i];
	while (($mtpt, $in) = each %mounted) {
	    if ($in != 17 && ($in >= 16 || 0) == $i) {
		$msg .= "$mtpt ";
		$nbad++;
	    }
	}
    }
    return $nbad ? $msg : "";
}

# Digests and reports the results for finished mount points.
# Arg: list of mount points (could be empty).  First arg is ref. to
# mountpoint index.
our @digestxl = qw(uninitialized running success failed hung suppressed);
sub digest {
    my ($fsys) = shift;
    foreach my $mtpt (@_) {
	my $val = $fsys->{$mtpt};
	next unless defined($val);
	if ($val->{state} == 2) {
	    # Success, ignore silently.
	} elsif ($val->{oldstate} <= 0 ) {
		# Failed during initialization, do not report, suppress
		# permanently.
	    delete $fsys->{$mtpt};
	} else {
		# Failed during operation, so complain.
	    &message($mtpt, $digestxl[${$val}{state}]);
	}
    }
}

# Initialize the set of filesystems.
our %filesys;
$now = time();
@now = localtime($now);
our $passes = 0;
our $checked = 9999999;
&getfilesys(\%filesys);
open(MOUNTS, "/proc/mounts") or die "Can't read /proc/mounts: $!\n";
POUND: {
    $passes++;
    my $npids = scalar(keys %pid2mtpt);
    if ($npids >= 100) {
	message("--", "$npids hung processes, exiting");
	last;
    }
    if ($checked > 50) {
	&message("--", "Pass $passes starting, $npids processes running");
	$checked = 0;
    }
		# Turn off the "mounted" flag on all filesystems.
    my($mtpt, $val);
    my $n = 0;
    while (($mtpt, $val) = each %filesys) {
	$val->{mounted} = 0;
	$n++;
    }
    &message('--', "$n filesystems known") if $passes == 3;
		# Turn on the "mounted" flag if it is mounted.
    seek(MOUNTS, 0, 0);
    $n = 0;
    while (<MOUNTS>) {
	my @mt = split;
	next unless exists($filesys{$mt[1]});
	$filesys{$mt[1]}{mounted} = 1;
	$n++;
    }
    &message('--', "$n filesystems mounted") if $passes == 3;
		# For each filesystem that is not mounted, mount it.
    $now = time();
    @now = localtime($now);
    my $failtime = $now - $dfail;	# Re-check failed filesys every 15 mins
    $n = 0;
    foreach $mtpt (keys %filesys) {
	$val = $filesys{$mtpt};		# Could be deleted behind our backs.
	next if !defined($val) || $val->{mounted} || 
	    ($val->{state} == 3 && $val->{whenchecked} >= $failtime) ||
	    $val->{state} >= 4;
	my $msg = &checkmtab(0, "");
	&message($mtpt, $msg) if $msg ne '';	# Validate /etc/mtab
	&spawncheck($mtpt, \%filesys);
	sleep $dt;
	$now = time();
	@now = localtime($now);
	my @finished = &spawnreap(\%filesys);
	&digest(\%filesys, @finished);
	$checked++;
	$n++;
    }
    sleep $dpass;
    redo;
}

=------------- Output from DEFAULT_LOGGING=debug -------
Apr 21 17:13:50 serval automount[20419]: Starting automounter version 5.0.2, master map auto.master
Apr 21 17:13:50 serval automount[20419]: using kernel protocol version 5.00
Apr 21 17:13:50 serval automount[20419]: lookup_nss_read_master: reading master files auto.master
Apr 21 17:13:50 serval automount[20419]: parse_init: parse(sun): init gathered global options: (null)
Apr 21 17:13:50 serval automount[20419]: mount_init: mount(bind): bind_works = 1
Apr 21 17:13:50 serval automount[20419]: lookup_read_master: lookup(file): read entry /net
Apr 21 17:13:50 serval automount[20419]: lookup_read_master: lookup(file): read entry /home
Apr 21 17:13:50 serval automount[20419]: master_do_mount: mounting /net
Apr 21 17:13:50 serval automount[20419]: lookup_nss_read_map: reading map file /etc/auto.net
Apr 21 17:13:50 serval automount[20419]: parse_init: parse(sun): init gathered global options: (null)
Apr 21 17:13:50 serval automount[20419]: mount_init: mount(bind): bind_works = 1
Apr 21 17:13:50 serval automount[20419]: >> umount: /net/naseberry/m1: not mounted
Apr 21 17:13:51 serval automount[20419]: >> umount: /net/zuma/h1: not mounted
Apr 21 17:13:51 serval automount[20419]: >> umount: /net/pong/m2: not mounted
Apr 21 17:13:51 serval automount[20419]: >> umount: /net/lodi/m1: not mounted
(140 of these, all different filesystems that actually exist, probably 
leftover state from previously running the test program)
Apr 21 17:13:51 serval automount[20419]: mounted indirect mount on /net with timeout 600, freq 150 seconds
Apr 21 17:13:51 serval automount[20419]: ghosting enabled
Apr 21 17:13:51 serval automount[20419]: master_do_mount: mounting /home
Apr 21 17:13:51 serval automount[20419]: lookup_nss_read_map: reading map yp auto.home
Apr 21 17:13:51 serval automount[20419]: lookup_init: lookup(yp): ctxt->mapname=auto.home
Apr 21 17:13:51 serval automount[20419]: parse_init: parse(sun): init gathered global options: (null)
Apr 21 17:13:51 serval automount[20419]: mounted indirect mount on /home with timeout 600, freq 150 seconds
Apr 21 17:13:51 serval automount[20419]: ghosting enabled
Apr 21 17:13:57 serval automount[20419]: handle_packet: type = 3
Apr 21 17:13:57 serval automount[20419]: handle_packet_missing_indirect: token 2268, name serval, request pid 15617
Apr 21 17:13:57 serval automount[20419]: handle_packet: type = 3
Apr 21 17:13:57 serval automount[20419]: handle_packet_missing_indirect: token 2269, name julia, request pid 20846
Apr 21 17:13:57 serval automount[20419]: attempting to mount entry /net/serval
Apr 21 17:13:57 serval automount[20419]: attempting to mount entry /net/julia
Apr 21 17:13:57 serval automount[20419]: lookup_mount: lookup(file): looking up serval
Apr 21 17:13:57 serval automount[20419]: lookup_mount: lookup(file): serval -> -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&	file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): expanded entry: -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=serval	file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): gathered options: rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=serval
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): dequote("file:/etc/auto.net.generic") -> file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): core of entry: options=rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=serval, loc=file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: sun_mount: parse(sun): mounting root /net, mountpoint serval, what file:/etc/auto.net.generic, fstype autofs, options rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval
Apr 21 17:13:57 serval automount[20419]: do_mount: file:/etc/auto.net.generic /net/serval type autofs options rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval using module autofs
Apr 21 17:13:57 serval automount[20419]: mount_mount: mount(autofs): fullpath=/net/serval what=file:/etc/auto.net.generic options=rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval
Apr 21 17:13:57 serval automount[20419]: lookup_mount: lookup(file): looking up julia
Apr 21 17:13:57 serval automount[20419]: lookup_mount: lookup(file): julia -> -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&	file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): expanded entry: -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=julia	file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): gathered options: rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=julia
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): dequote("file:/etc/auto.net.generic") -> file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: parse_mount: parse(sun): core of entry: options=rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=julia, loc=file:/etc/auto.net.generic
Apr 21 17:13:57 serval automount[20419]: sun_mount: parse(sun): mounting root /net, mountpoint julia, what file:/etc/auto.net.generic, fstype autofs, options rsize=8192,wsize=8192,retry=1,soft,-DSERVER=julia
Apr 21 17:13:57 serval automount[20419]: do_mount: file:/etc/auto.net.generic /net/julia type autofs options rsize=8192,wsize=8192,retry=1,soft,-DSERVER=julia using module autofs
Apr 21 17:13:57 serval automount[20419]: mount_mount: mount(autofs): fullpath=/net/julia what=file:/etc/auto.net.generic options=rsize=8192,wsize=8192,retry=1,soft,-DSERVER=julia
Apr 21 17:17:28 serval syslog-ng[2743]: STATS: dropped 0
Apr 21 17:17:55 serval automount[20419]: st_expire: state 1 path /home
Apr 21 17:17:55 serval automount[20419]: expire_proc: exp_proc = 3071929232 path /home
Apr 21 17:17:55 serval automount[20419]: expire_cleanup: got thid 3071929232 path /home stat 0
Apr 21 17:17:55 serval automount[20419]: expire_cleanup: sigchld: exp 3071929232 finished, switching from 2 to 1
Apr 21 17:17:55 serval automount[20419]: st_ready: st_ready(): state = 2 path /home
Apr 21 17:18:29 serval automount[20419]: st_expire: state 1 path /net
Apr 21 17:18:29 serval automount[20419]: expire_proc: exp_proc = 3071929232 path /net
Apr 21 17:18:29 serval automount[20419]: mount still busy /net
Apr 21 17:18:29 serval automount[20419]: expire_cleanup: got thid 3071929232 path /net stat 0
Apr 21 17:18:29 serval automount[20419]: expire_cleanup: sigchld: exp 3071929232 finished, switching from 2 to 1
Apr 21 17:18:29 serval automount[20419]: st_ready: st_ready(): state = 2 path /net
Apr 21 17:18:32 serval sshd[20852]: Accepted publickey for root from 128.97.4.254 port 52557 ssh2
Apr 21 17:19:35 serval sshd[20866]: Accepted publickey for root from 128.97.4.254 port 48299 ssh2
(I'm trying to kill the test program; ssh accepted the command line
but shell execution hung probably due to a need to automount in 
/root/.profile)
Apr 21 17:20:25 serval automount[20419]: st_expire: state 1 path /home
Apr 21 17:20:25 serval automount[20419]: expire_proc: exp_proc = 3071929232 path /home
Apr 21 17:20:25 serval automount[20419]: expire_cleanup: got thid 3071929232 path /home stat 0
Apr 21 17:20:25 serval automount[20419]: expire_cleanup: sigchld: exp 3071929232 finished, switching from 2 to 1
Apr 21 17:20:25 serval automount[20419]: st_ready: st_ready(): state = 2 path /home
Apr 21 17:20:59 serval automount[20419]: st_expire: state 1 path /net
Apr 21 17:20:59 serval automount[20419]: expire_proc: exp_proc = 3071929232 path /net
Apr 21 17:20:59 serval automount[20419]: mount still busy /net
Apr 21 17:20:59 serval automount[20419]: expire_cleanup: got thid 3071929232 path /net stat 0
Apr 21 17:20:59 serval automount[20419]: expire_cleanup: sigchld: exp 3071929232 finished, switching from 2 to 1
Apr 21 17:20:59 serval automount[20419]: st_ready: st_ready(): state = 2 path /net
(The above continues all night and through the next day)



James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
