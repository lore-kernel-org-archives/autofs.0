From: Ian Kent <raven@themaw.net>
Subject: Re: Re: unacceptable bug in autofs kernel module
Date: Wed, 23 Mar 2005 12:08:32 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0503231139130.8473@wombat.indigo.net.au>
References: <Pine.LNX.4.61.0503211425190.29378@pod.adc.idt.com>
	<Pine.LNX.4.58.0503220858230.4244@wombat.indigo.net.au>
	<Pine.LNX.4.61.0503221500170.8797@pod.adc.idt.com>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0503221500170.8797@pod.adc.idt.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

On Tue, 22 Mar 2005 devnull@adc.idt.com wrote:

> >> can run the job locally on the machine and reproduce it.
> >>
> >> The application I run creates a directory to store certain results, and to
> >> make sure that I am not looking at older results, my script deletes that
> >> directory at the very beginning of the job.
> >
> > Interesting!
> >
> > So this is not a directory in the autofs filesystem but one in the mounted
> > filesystem?
> 
> root      9708     1  0 15:07 ?        00:00:00 /usr/sbin/automount --ghost -v --debug /home yp auto.home nobrowse

Only the -v or -d is needed.
The -d would give more output bu it seems people are having trouble 
getting debug severity messages. I'm not sure why.

> 
> We use YP with ghosting enabled.
> 
> 
> Now under /home/me I run this perl script
> 
> SNIP
> 
> #!/usr/local/bin/perl
> use File::Path;
> 
> open HANDLE1, file1 ;
> open HANDLE2, file2 ;
> 
> $line1 = <HANDLE1>;
> $line2 = <HANDLE2>;
> 
> rmtree "run_details";
> 
> # system("bsub -q normal -I mkdirhier run_details/me");
> # You need to change MachineName to something else here.
> system("rsh MachineName mkdirhier /home/me/run_details/me");

What's happening here?
Is this an "rsh" to another machine?

> 
> # DO NOT REMOVE -- have to have this to make x86_64 work
> # If you comment this line out, the script fails.
> my $touchret = `/bin/touch run_details`;
> open HANDLE3, ">>run_details/file3" or die "No run_details dir found";
> print HANDLE3 $line1;
> print HANDLE3 $line2;
> 
> opendir DIR, "run_details" or die "1. couldn't open run_details ($!)\n";
> my @dirlist = readdir DIR;
> printf "@dirlist\n";
> 
> /SNIP

Which is the bit that causes trouble here exactly.
I might be able to duplicate this in an LSF environment but I'm not sure 
I'll be allowed to update autofs on any processing machine.

> 
> I have tried, but a simple 
> /var/log/messages has this relevant stuff
> 
> 
> Mar 22 15:07:36 pod automount[9507]: starting automounter version 4.1.4_beta2, path = /misc, maptype = file, mapname = /etc/auto.misc
> Mar 22 15:07:36 pod automount[9519]: starting automounter version 4.1.4_beta2, path = /net, maptype = program, mapname = /etc/auto.net
> Mar 22 15:07:36 pod automount[9519]: using kernel protocol version 4.05
> Mar 22 15:07:36 pod automount[9519]: using timeout 300 seconds; freq 75 secs
> Mar 22 15:07:36 pod automount[9507]: using kernel protocol version 4.05
> Mar 22 15:07:36 pod automount[9507]: using timeout 300 seconds; freq 75 secs
> Mar 22 15:07:36 pod automount[9507]: ghosting enabled
> Mar 22 15:07:36 pod automount[9708]: starting automounter version 4.1.4_beta2, path = /home, maptype = yp, mapname = auto.home
> Mar 22 15:07:36 pod automount[9708]: ghosting enabled
> Mar 22 15:07:36 pod automount[9708]: ghosting enabled
> Mar 22 15:07:39 pod automount[9708]: attempting to mount entry /home/x86_64linuxlocal
> Mar 22 15:07:39 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:05 pod udev[9755]: removing device node '/udev/vcs2'
> Mar 22 15:08:05 pod udev[9766]: removing device node '/udev/vcsa2'
> Mar 22 15:08:05 pod login(pam_unix)[3067]: session closed for user root
> Mar 22 15:08:06 pod udev[9778]: creating device node '/udev/vcs2'
> Mar 22 15:08:06 pod udev[9785]: creating device node '/udev/vcsa2'
> Mar 22 15:08:06 pod udev[9814]: removing device node '/udev/vcs2'
> Mar 22 15:08:06 pod udev[9823]: removing device node '/udev/vcsa2'
> Mar 22 15:08:06 pod udev[9828]: creating device node '/udev/vcs2'
> Mar 22 15:08:06 pod udev[9829]: creating device node '/udev/vcsa2'
> Mar 22 15:08:08 pod login(pam_unix)[8863]: session closed for user root
> Mar 22 15:08:12 pod login(pam_unix)[9839]: session opened for user ram by LOGIN(uid=0)
> Mar 22 15:08:12 pod automount[9708]: attempting to mount entry /home/ram
> Mar 22 15:08:12 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:12 pod  -- ram[9839]: LOGIN ON tty1 BY ram
> Mar 22 15:08:12 pod automount[9708]: attempting to mount entry /home/allmail
> Mar 22 15:08:12 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:12 pod automount[9708]: attempting to mount entry /home/icdag
> Mar 22 15:08:12 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:12 pod automount[9708]: attempting to mount entry /home/dag
> Mar 22 15:08:12 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:12 pod automount[9708]: attempting to mount entry /home/lsf6.0
> Mar 22 15:08:12 pod kernel: nfs warning: mount version older than kernel
> Mar 22 15:08:12 pod kernel: agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
> Mar 22 15:08:12 pod kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> Mar 22 15:08:12 pod kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> Mar 22 15:08:13 pod kernel: agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
> Mar 22 15:08:13 pod kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> Mar 22 15:08:13 pod kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> Mar 22 15:08:13 pod udev[9903]: creating device node '/udev/vcs7'
> Mar 22 15:08:13 pod udev[9910]: creating device node '/udev/vcsa7'
> Mar 22 15:08:31 pod su(pam_unix)[9953]: session opened for user root by ram(uid=3147)
> 
> enabled x86_64 workaround
> and no more messages.

Yes. There's not really enough info here.
The debug severity info appears to be missing.

I can't see any failed mount messages, is that usual?

I have found some problems in a couple of areas recently which I've been 
working on. One area is in thre replicated server code. Although 
I've previously claimed that mount entries without replcated server syntax 
aren't affected by this code that's completely wrong. atm it appears that 
if you have a busy network with variable round trip times that mounts 
can fail intermitently. I first found this when the wireless connection to 
my test machine at home was intermitently disconecting causing longish 
timeouts and hence mount failures.

Would you be able to test out a patch?

> 
> 
> 
> >>
> >> Somehow this causes a problem, the directory is always reported
> >> missing, however if i remove the directory by hand, then run the script,
> >> everything works great.

Is the rmtree of the File::Path perl module where the problem occures. 

> >>
> >> Where would I need to look to see what process is caching the contents of
> >> the directory.
> >
> > An example first.
> > When you reproduce the problem give the map (master and entry maps).
> > The steps to reproduce.
> > The syslog output with the "--debug" option on the master map entry.
> >
> > Ian
> >
> >
> Thanks for taking a look at this Ian, I really appreciate this.
> 
> Thanks.
> 
