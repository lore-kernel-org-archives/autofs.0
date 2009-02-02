From: Ian Kent <raven@themaw.net>
Subject: Re: Need help w/ autofs application
Date: Mon, 02 Feb 2009 12:56:05 +0900
Message-ID: <1233546965.3224.45.camel@zeus.themaw.net>
References: <alpine.DEB.2.00.0901271826510.7987@duo>
	<1233113623.3005.25.camel@zeus.themaw.net>
	<alpine.DEB.2.00.0902011047400.27957@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.DEB.2.00.0902011047400.27957@duo>
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
To: Steven Hirsch <snhirsch@gmail.com>
Cc: autofs@linux.kernel.org

On Sun, 2009-02-01 at 11:32 -0500, Steven Hirsch wrote:
> On Wed, 28 Jan 2009, Ian Kent wrote:
> 
> >> The question is this:  WHAT is going on with the autofs startup that
> >> requires me to first end up in location outside of it before it will work?
> >> Thinking it might be a race, I started experimenting with sleep calls to
> >> give autofs a chance to initialize before trying to move into it.  No
> >> dice.  Whether I wait 2 seconds or a minute, the results were the same.
> >>
> >> The schroot maintainer is mildly convinced that there must be an easier
> >> way to get automount working in the chroot and I tend to agree.  Does
> >> anyone have any advice?
> >
> > Collect some debug logs of the different things you've tried and we'll
> > see if we can work out what is happening. Versions or autofs and kernel
> > could be useful.
> 
> Autofs:  4.1.4+debian-2.1ubuntu1
> 
> Kernel: 2.6.24-23-generic
> 
> auto.master:
> 
> #
> # $Id: auto.master,v 1.4 2005/01/04 14:36:54 raven Exp $
> #
> # Sample auto.master file
> # This is an automounter map and it has the following format
> # key [ -mount-options-separated-by-comma ] location
> # For details of the format look at autofs(5).
> #/misc  /etc/auto.misc --timeout=60
> #/smb   /etc/auto.smb
> #/misc  /etc/auto.misc
> /net    /etc/auto.net --debug -intr
> 
> auto.net:
> 
> pii     -rsize=65536,wsize=65536,tcp,noatime pii.fast.net:/
> src     -rsize=65536,wsize=65536,tcp,noatime pii.fast.net:/ips_src
> ips     -rsize=65536,wsize=65536,tcp,noatime pii.fast.net:/ips
> home    -rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home
> dosD    -rsize=65536,wsize=65536,tcp,noatime pii.fast.net:/ips_dos/dos
> 
> 
> /etc/nsswitch.conf:
> 
> # /etc/nsswitch.conf
> #
> # Example configuration of GNU Name Service Switch functionality.
> # If you have the `glibc-doc-reference' and `info' packages installed, 
> try:
> # `info libc "Name Service Switch"' for information about this file.
> 
> passwd:         compat
> group:          compat
> shadow:         compat
> 
> hosts:          files dns
> networks:       files
> 
> protocols:      db files
> services:       db files
> ethers:         db files
> rpc:            db files
> 
> netgroup:       nis
> 
> Here are the debugging traces:
> 
> Note: If I simply try to bind-mount the root environment's /net directory
> into the chroot tree, there is nothing in the log file.  Autofs simply
> does not see it.  I can only assume that the Linux VFS does not support 
> bind mounting of automounter directories.
> 
> All the following involve an init script that starts a second automount 
> deamon inside the chroot environment:
> 
> 1. If I create /net beforehand and attempt to log directly to a home
>     directory in NFS at start of the chroot'ed session:
> 
> Feb  1 11:07:21 duo automount[23853]: starting automounter version 4.1.4, path = /net, maptype = file, mapname = /etc/aut
> Feb  1 11:07:21 duo automount[23853]: parse(sun): init gathered options: intr
> Feb  1 11:07:21 duo automount[23853]: mount(bind): bind_works = 1 
> Feb  1 11:07:21 duo automount[23853]: using kernel protocol version 4.00
> Feb  1 11:07:21 duo automount[23853]: using timeout 300 seconds; freq 75 secs
> Feb  1 11:07:21 duo automount[23853]: sig 12 switching from 1 to 5

I have no idea where the SIGUSR2 signal is coming from but it will cause
autofs to shutdown if there are no mounts that are busy when it gets it.

> Feb  1 11:07:21 duo automount[23853]: get_pkt: state 1, next 5
> Feb  1 11:07:21 duo automount[23853]: prep_shutdown: state = 1 
> Feb  1 11:07:21 duo automount[23853]: signal_children: send 12 to process group 23853
> Feb  1 11:07:21 duo automount[23853]: expire_proc: exp_proc=23872
> Feb  1 11:07:21 duo automount[23853]: prep_shutdown: expire returns 1 
> Feb  1 11:07:21 duo automount[23853]: handle_child: got pid 23872, sig 0 (0), stat 0 
> Feb  1 11:07:21 duo automount[23853]: sigchld: exp 23872 finished, switching from 5 to 6
> Feb  1 11:07:21 duo automount[23853]: get_pkt: state 5, next 6
> Feb  1 11:07:21 duo automount[23853]: umount_multi: path=/net incl=0 
> Feb  1 11:07:21 duo automount[23853]: umount_multi: no mounts found under /net
> Feb  1 11:07:21 duo automount[23853]: shut down, path = /net
> 
> 2. If I do not create /net beforehand and try to log directly to home:

autofs must be able to create directories for it's mount points if they
don't already exist. So not really a useful test.

> 
> Feb  1 11:09:01 duo automount[24610]: starting automounter version 4.1.4, path = /net, maptype = file, mapname = /etc/auto.net
> Feb  1 11:09:01 duo automount[24610]: parse(sun): init gathered options: intr
> Feb  1 11:09:01 duo automount[24610]: mount(bind): bind_works = 1 
> Feb  1 11:09:01 duo automount[24610]: failed to create iautofs directory /net
> Feb  1 11:09:01 duo automount[24610]: /net: mount failed!
> 
> 3. If I create /net beforehand and log to a local filesystem initially at
>     start of the chroot'ed session:
> 
> Feb  1 11:11:14 duo automount[25830]: starting automounter version 4.1.4, path = /net, maptype = file, mapname = /etc/auto.net
> Feb  1 11:11:14 duo automount[25830]: parse(sun): init gathered options: intr
> Feb  1 11:11:14 duo automount[25830]: mount(bind): bind_works = 1 
> Feb  1 11:11:14 duo automount[25830]: using kernel protocol version 4.00
> Feb  1 11:11:14 duo automount[25830]: using timeout 300 seconds; freq 75 secs
> Feb  1 11:11:14 duo automount[25830]: handle_packet: type = 0 
> Feb  1 11:11:14 duo automount[25830]: handle_packet_missing: token 35, name home 
> Feb  1 11:11:14 duo automount[25830]: attempting to mount entry /net/home
> Feb  1 11:11:14 duo automount[25835]: lookup(file): home -> -rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: parse(sun): expanded entry: -rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: parse(sun): dequote("rsize=65536,wsize=65536,tcp") -> rsize=65536,wsize=65536,tcp
> Feb  1 11:11:14 duo automount[25835]: parse(sun): gathered options: intr,rsize=65536,wsize=65536,tcp
> Feb  1 11:11:14 duo automount[25835]: parse(sun): dequote("pii.fast.net:/ips_home/home") -> pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: parse(sun): core of entry: options=intr,rsize=65536,wsize=65536,tcp, loc=pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: parse(sun): mounting root /net, mountpoint home, what pii.fast.net:/ips_home/home, fstype nfs, options intr,rsize=65536,wsize=65536,tcp 
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): root=/net name=home what=pii.fast.net:/ips_home/home, fstype=nfs, options=intr,rsize=65536,wsize=65536,tcp
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): nfs options="intr,rsize=65536,wsize=65536,tcp", nosymlink=0, symlink=0, ro=0
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): is_local_mount: pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): from pii.fast.net:/ips_home/home elected pii.fast.net:/ips_home/home
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): calling mkdir_path /net/home
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): calling mount -t nfs -s  -o intr,rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home /net/home
> Feb  1 11:11:14 duo automount[25835]: mount(nfs): mounted pii.fast.net:/ips_home/home on /net/home
> Feb  1 11:11:14 duo automount[25830]: handle_child: got pid 25835, sig 0 (0), stat 0 
> Feb  1 11:11:14 duo automount[25830]: sig_child: found pending iop pid 25835: signalled 0 (sig 0), exit status 0
> Feb  1 11:11:14 duo automount[25830]: send_ready: token=35
> 
> !! ====> Now I have an accessible home directory and can cd into it.

And no SIGUSR2, so that is expected I guess!

> 
> 
> Please let me know if more information is needed?
> 
> Steve
> 
> 
