From: Steven Hirsch <snhirsch@gmail.com>
Subject: Re: Need help w/ autofs application
Date: Mon, 2 Feb 2009 07:47:50 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0902020738360.27957@duo>
References: <alpine.DEB.2.00.0901271826510.7987@duo>
	<1233113623.3005.25.camel@zeus.themaw.net>
	<alpine.DEB.2.00.0902011047400.27957@duo>
	<1233546965.3224.45.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1233546965.3224.45.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, 2 Feb 2009, Ian Kent wrote:

>> 1. If I create /net beforehand and attempt to log directly to a home
>>     directory in NFS at start of the chroot'ed session:
>>
>> Feb  1 11:07:21 duo automount[23853]: starting automounter version 4.1.4, path = /net, maptype = file, mapname = /etc/aut
>> Feb  1 11:07:21 duo automount[23853]: parse(sun): init gathered options: intr
>> Feb  1 11:07:21 duo automount[23853]: mount(bind): bind_works = 1
>> Feb  1 11:07:21 duo automount[23853]: using kernel protocol version 4.00
>> Feb  1 11:07:21 duo automount[23853]: using timeout 300 seconds; freq 75 secs
>> Feb  1 11:07:21 duo automount[23853]: sig 12 switching from 1 to 5
>
> I have no idea where the SIGUSR2 signal is coming from but it will cause
> autofs to shutdown if there are no mounts that are busy when it gets it.

That's just the point!  I'm not generating the SIGUSR2, nor is anything in 
schroot.  The only difference between the failing run above and the 
working one below is that the latter does not try to cd directly into the 
automounted home directory before starting the interactive session.

Can you think of any possible reason for the difference in behavior?

Any ideas how to track down what's issuing the signal?


>> 3. If I create /net beforehand and log to a local filesystem initially at
>>     start of the chroot'ed session:
>>
>> Feb  1 11:11:14 duo automount[25830]: starting automounter version 4.1.4, path = /net, maptype = file, mapname = /etc/auto.net
>> Feb  1 11:11:14 duo automount[25830]: parse(sun): init gathered options: intr
>> Feb  1 11:11:14 duo automount[25830]: mount(bind): bind_works = 1
>> Feb  1 11:11:14 duo automount[25830]: using kernel protocol version 4.00
>> Feb  1 11:11:14 duo automount[25830]: using timeout 300 seconds; freq 75 secs
>> Feb  1 11:11:14 duo automount[25830]: handle_packet: type = 0
>> Feb  1 11:11:14 duo automount[25830]: handle_packet_missing: token 35, name home
>> Feb  1 11:11:14 duo automount[25830]: attempting to mount entry /net/home
>> Feb  1 11:11:14 duo automount[25835]: lookup(file): home -> -rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): expanded entry: -rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): dequote("rsize=65536,wsize=65536,tcp") -> rsize=65536,wsize=65536,tcp
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): gathered options: intr,rsize=65536,wsize=65536,tcp
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): dequote("pii.fast.net:/ips_home/home") -> pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): core of entry: options=intr,rsize=65536,wsize=65536,tcp, loc=pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: parse(sun): mounting root /net, mountpoint home, what pii.fast.net:/ips_home/home, fstype nfs, options intr,rsize=65536,wsize=65536,tcp
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): root=/net name=home what=pii.fast.net:/ips_home/home, fstype=nfs, options=intr,rsize=65536,wsize=65536,tcp
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): nfs options="intr,rsize=65536,wsize=65536,tcp", nosymlink=0, symlink=0, ro=0
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): is_local_mount: pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): from pii.fast.net:/ips_home/home elected pii.fast.net:/ips_home/home
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): calling mkdir_path /net/home
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): calling mount -t nfs -s  -o intr,rsize=65536,wsize=65536,tcp pii.fast.net:/ips_home/home /net/home
>> Feb  1 11:11:14 duo automount[25835]: mount(nfs): mounted pii.fast.net:/ips_home/home on /net/home
>> Feb  1 11:11:14 duo automount[25830]: handle_child: got pid 25835, sig 0 (0), stat 0
>> Feb  1 11:11:14 duo automount[25830]: sig_child: found pending iop pid 25835: signalled 0 (sig 0), exit status 0
>> Feb  1 11:11:14 duo automount[25830]: send_ready: token=35
>>
>> !! ====> Now I have an accessible home directory and can cd into it.
>
> And no SIGUSR2, so that is expected I guess!



-- 
