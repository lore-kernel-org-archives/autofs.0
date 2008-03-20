From: jimc@math.ucla.edu (Jim Carter)
Subject: Long timeout on broken DNS server
Date: Wed, 19 Mar 2008 22:06:35 -0700 (PDT)
Message-ID: <20080320050635.E2FA33C3B0@xena.cft.ca.us>
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

Today I upgraded one of my three DNS servers, the first listed in
/etc/resolv.conf, and until I got it back on the air, autofs mounting
was glacial.  To investigate, on my own workstation I prepended an IP
address not assigned to any machine, and reproduced the problem.  The
symptom is that automount takes 40 to 45 seconds, while other actions 
involving DNS or hostnames take around 5 seconds, as expected: 
"dig math.ucla.edu. soa" and "mount -t nfs tupelo:/h1 /mnt" were 
tested.  The command to test automounting was "ls /net/$HOST/$DIR/.",
in this case, "ls /net/serval/h1/." but I use a different host each 
time to make sure DNS resolution happens.  We use nscd, but the result
is the same whether or not it is running.

I've appended a debug log, but there is no smoking gun; in fact there
is no sign of any misbehavior except for a long delay.  Does anyone
have any idea why, when autofs resolves a hostname, the DNS timeout
is so much longer than the default of 5 seconds?

The distro on the test machine is OpenSuSE 10.3.  The autofs version
is 5.0.2, although 4.1.4 is affected similarly.  Kernel is 2.6.22.17
(SMP).  

=-- auto.master --- (comments omitted in all conf files)
/net            /etc/auto.net		<== giving trouble
/home           yp:auto.home

=-- auto.net ---
*       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&    file:/etc/auto.net.generic

=-- auto.net.generic ---
*       ${SERVER}:/&

(The effect is that when you refer to /net/$HOST/$DIR it starts a 
sub-daemon for $HOST which then mounts the exported filesystem(s).)

=-- nsswitch.conf --
passwd:         compat nis
shadow:         compat nis
group:          compat nis

hosts:          files dns	<== servers tested are not in /etc/hosts
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

=-- resolv.conf ---
nameserver	128.97.4.35	<== dead machine prepended for test
nameserver      128.97.4.254
nameserver      128.97.12.3
search          math.ucla.edu pic.ucla.edu


=-- /etc/sysconfig/autofs --- (comments deleted)
AUTOFS_OPTIONS=""
NISMASTERMAP="auto.master"		<== map exists but not actually used
UNDERSCORETODOT="yes"			<== we have no underscores
LOCAL_OPTIONS=""
APPEND_OPTIONS="yes"
DEFAULT_MASTER_MAP_NAME="auto.master"
DEFAULT_TIMEOUT=600
DEFAULT_BROWSE_MODE="yes"
DEFAULT_LOGGING="none"			<== changed to "debug"

DEFAULT_MAP_OBJECT_CLASS="nisMap"	<== pro forma; we have no LDAP
DEFAULT_ENTRY_OBJECT_CLASS="nisObject"
DEFAULT_MAP_ATTRIBUTE="nisMapName"
DEFAULT_ENTRY_ATTRIBUTE="cn"
DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"
DEFAULT_AUTH_CONF_FILE="etc/autofs_ldap_auth.conf"

=-- Debug output (annotated) ---
Mar 19 21:14:06 simba automount[4468]: handle_packet: type = 3
Mar 19 21:14:06 simba automount[4468]: handle_packet_missing_indirect: 
    token 41600, name serval, request pid 4529
Mar 19 21:14:06 simba automount[4468]: attempting to mount entry /net/serval
Mar 19 21:14:06 simba automount[4468]: lookup_mount: lookup(file): 
    looking up serval
Mar 19 21:14:06 simba automount[4468]: lookup_mount: lookup(file): 
    serval -> -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&
    file:/etc/auto.net.generic
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    expanded entry: -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,
    -DSERVER=serval file:/etc/auto.net.generic
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    gathered options: rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,
    -DSERVER=serval
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    dequote("file:/etc/auto.net.generic") -> file:/etc/auto.net.generic
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    core of entry: options=rsize=8192,wsize=8192,retry=1,soft,
    fstype=autofs,-DSERVER=serval, loc=file:/etc/auto.net.generic
Mar 19 21:14:06 simba automount[4468]: sun_mount: parse(sun): 
    mounting root /net, mountpoint serval, what file:/etc/auto.net.generic, 
    fstype autofs, options rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval
Mar 19 21:14:06 simba automount[4468]: do_mount: 
    file:/etc/auto.net.generic /net/serval type autofs options 
    rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval using module autofs
Mar 19 21:14:06 simba automount[4468]: mount_mount: mount(autofs): 
    fullpath=/net/serval what=file:/etc/auto.net.generic 
    options=rsize=8192,wsize=8192,retry=1,soft,-DSERVER=serval
Mar 19 21:14:06 simba automount[4468]: lookup_nss_read_map: reading map 
    file /etc/auto.net.generic
Mar 19 21:14:06 simba automount[4468]: parse_init: parse(sun): 
    init gathered global options: rsize=8192,wsize=8192,retry=1,soft
Mar 19 21:14:06 simba automount[4468]: mounted indirect mount on 
    /net/serval with timeout 600, freq 150 seconds
Mar 19 21:14:06 simba automount[4468]: ghosting enabled
Mar 19 21:14:06 simba automount[4468]: send_ready: token = 41600
Mar 19 21:14:06 simba automount[4468]: mounted /net/serval
Mar 19 21:14:06 simba automount[4468]: handle_packet: type = 3
Mar 19 21:14:06 simba automount[4468]: handle_packet_missing_indirect: 
    token 41601, name m1, request pid 4529
Mar 19 21:14:06 simba automount[4468]: attempting to mount 
    entry /net/serval/m1
Mar 19 21:14:06 simba automount[4468]: lookup_mount: lookup(file): 
    looking up m1
Mar 19 21:14:06 simba automount[4468]: lookup_mount: lookup(file): 
    m1 -> ${SERVER}:/&
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    expanded entry: serval:/m1
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    gathered options: rsize=8192,wsize=8192,retry=1,soft
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    dequote("serval:/m1") -> serval:/m1
Mar 19 21:14:06 simba automount[4468]: parse_mount: parse(sun): 
    core of entry: options=rsize=8192,wsize=8192,retry=1,soft, loc=serval:/m1
Mar 19 21:14:06 simba automount[4468]: sun_mount: parse(sun): 
    mounting root /net/serval, mountpoint m1, what serval:/m1, fstype nfs, 
    options rsize=8192,wsize=8192,retry=1,soft
Mar 19 21:14:06 simba automount[4468]: mount_mount: mount(nfs): 
    root=/net/serval name=m1 what=serval:/m1, fstype=nfs, 
    options=rsize=8192,wsize=8192,retry=1,soft
Mar 19 21:14:06 simba automount[4468]: mount_mount: mount(nfs): nfs 
    options="rsize=8192,wsize=8192,retry=1,soft", nosymlink=0, ro=0

=== While waiting, mounts from previous testing expired.
Mar 19 21:14:14 simba automount[4468]: st_expire: state 1 path /net
Mar 19 21:14:14 simba automount[4468]: expire_proc: exp_proc = 3046157200 
    path /net
Mar 19 21:14:14 simba automount[4468]: expire_proc_indirect: 
    expire /net/bustamove/m1
Mar 19 21:14:14 simba automount[4468]: st_expire: state 1 path /net/bustamove
Mar 19 21:14:14 simba automount[4468]: expire_proc: exp_proc = 3045104528 
    path /net/bustamove
Mar 19 21:14:14 simba automount[4468]: expire_proc_indirect: 
    expire /net/bustamove/m1
Mar 19 21:14:15 simba automount[4468]: expire_proc_indirect: 1 remaining 
    in /net/bustamove
Mar 19 21:14:15 simba automount[4468]: mount still busy /net/bustamove
Mar 19 21:14:15 simba automount[4468]: expire_cleanup: got thid 3045104528 
    path /net/bustamove stat 2
Mar 19 21:14:15 simba automount[4468]: expire_cleanup: sigchld: 
    exp 3045104528 finished, switching from 2 to 1
Mar 19 21:14:15 simba automount[4468]: st_ready: st_ready(): state = 2 
    path /net/bustamove

=== and 2 more, omitted, then it noticed it was working on Serval:
Mar 19 21:14:17 simba automount[4468]: mount still busy /net/serval
Mar 19 21:14:17 simba automount[4468]: expire_cleanup: got thid 3045104528 
    path /net/serval stat 0
Mar 19 21:14:17 simba automount[4468]: expire_cleanup: sigchld: 
    exp 3045104528 finished, switching from 2 to 1
Mar 19 21:14:17 simba automount[4468]: st_ready: st_ready(): state = 2 
    path /net/serval
Mar 19 21:14:17 simba automount[4468]: st_expire: state 1 path /net/simba

=== omitted stuff for (not) expiring Simba and Julia
Mar 19 21:14:22 simba automount[4468]: expire_proc_indirect: 
    4 submounts remaining in /net
Mar 19 21:14:22 simba automount[4468]: expire_proc_indirect: 
    4 remaining in /net
Mar 19 21:14:22 simba automount[4468]: mount still busy /net
Mar 19 21:14:22 simba automount[4468]: expire_cleanup: got thid 3046157200 
    path /net stat 5
Mar 19 21:14:22 simba automount[4468]: expire_cleanup: sigchld: 
    exp 3046157200 finished, switching from 2 to 1
Mar 19 21:14:22 simba automount[4468]: st_ready: st_ready(): 
    state = 2 path /net

=== It sits there for 20 seconds more...
Mar 19 21:14:41 simba automount[4468]: mount_mount: mount(nfs): 
    calling mkdir_path /net/serval/m1
Mar 19 21:14:41 simba automount[4468]: mount_mount: mount(nfs): calling 
    mount -t nfs -s -o rsize=8192,wsize=8192,retry=1,soft 
    serval:/m1 /net/serval/m1

=== Looks like a normal 5 second timeout in /sbin/mount
Mar 19 21:14:46 simba automount[4468]: mount(nfs): 
    mounted serval:/m1 on /net/serval/m1
Mar 19 21:14:46 simba automount[4468]: send_ready: token = 41601
Mar 19 21:14:46 simba automount[4468]: mounted /net/serval/m1
=== and the content was delivered.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
