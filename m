From: Ian Kent <raven@themaw.net>
Subject: Re: Mount very when reboot
Date: Tue, 19 Feb 2008 18:35:46 +0900
Message-ID: <1203413746.16791.12.camel@raven.themaw.net>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
	<1202717516.24318.8.camel@raven.themaw.net>
	<3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
	<1202797905.3233.57.camel@raven.themaw.net>
	<3a98c5000802190105v3ccb2c4h6153f334a1610004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3a98c5000802190105v3ccb2c4h6153f334a1610004@mail.gmail.com>
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
To: Vincent LEFORT <vincent.lefort@gmail.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-02-19 at 10:05 +0100, Vincent LEFORT wrote:
> Hello, soory for late response, but always the problems :s
> 
> When i installed computers, i put a link :
> 
> ln -s /etc/init.d/autofs /etc/init.d/rc5.d/S22autofs
> 
> So when computer start, autofs start... By defaut after install and
> first restart, suse change name to : S13autofs

I don't know what I can do about SuSE.
If the SuSE setup is broken then they need to fix it.

> 
> My startup in init.d/rc5.d is :
> 
> S01earlysyslog -> ../earlysyslog
> S01fbset -> ../fbset
> S01irq_balancer -> ../irq_balancer
> S01random -> ../random
> S01resmgr -> ../resmgr
> S02earlykbd -> ../earlykbd
> S03dbus -> ../dbus
> S04boot.udev -> ../boot.udev
> S05network -> ../network
> S06syslog -> ../syslog
> S07netdaemon -> ../netdaemon
> S07nmb -> ../nmb
> S08mdnsd -> ../mdnsd
> S08portmap -> ../portmap
> S08splash_early -> ../splash_early
> S10nfs -> ../nfs
> S10nfsboot -> ../nfsboot
> S12acpid -> ../acpid
> S12alsasound -> ../alsasound
> S12cups -> ../cups
> S12kbd -> ../kbd
> S12microcode -> ../microcode
> S12running-kernel -> ../running-kernel
> S12splash -> ../splash
> S12sshd -> ../sshd
> S13autofs -> ../autofs
> S13smb -> ../smb
> S13xdm -> ../xdm
> S14nscd -> ../nscd
> S14postfix -> ../postfix
> S14smbfs -> ../smbfs
> S14xinetd -> ../xinetd
> S15cron -> ../cron
> S16haldaemon -> ../haldaemon
> S17powersaved -> ../powersaved
> S18cupsrenice -> ../cupsrenice
> S21SuSEfirewall2_setup -> ../SuSEfirewall2_setup

Why is the firewall started last.
Maybe this is the cause, starting the firewall so late must mean
everything is blocked until it completes. That would be the only sane
way to start the firewall last.

> 
> 
> I'm tried to do the debug output but when i put the option --debug in
> my auto.master, and restart autofs the line command is :
> 
> /usr/sbin/automount --debug --timeout 60 /serveurpasta
> file /etc/auto.pasta debug
> 
> 
> When i check (after reboot) the clients i can read :
> 
> Feb 19 09:52:45 linux kernel: RPC: error 5 connecting to server
> 192.168.0.48
> Feb 19 09:53:45 linux kernel: RPC: error 5 connecting to server
> 192.168.0.48
> Feb 19 09:53:45 linux automount[7534]: >> mount:
> 192.168.0.48:/media/disk1_prods1: can't read superblock
> Feb 19 09:53:45 linux automount[7534]: mount(nfs): nfs: mount failure
> 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1
> Feb 19 09:53:45 linux automount[7534]: failed to
> mount /serveurpasta/prods1
> Feb 19 09:54:45 linux kernel: RPC: error 5 connecting to server
> 192.168.0.48
> Feb 19 09:55:45 linux kernel: RPC: error 5 connecting to server
> 192.168.0.48
> Feb 19 09:55:45 linux automount[7610]: >> mount:
> 192.168.0.48:/media/disk1_prods1: can't read superblock
> Feb 19 09:55:45 linux automount[7610]: mount(nfs): nfs: mount failure
> 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1
> Feb 19 09:55:45 linux automount[7610]: failed to
> mount /serveurpasta/prods1
> 
> etc.....
> 
> And on server :
> 
> 
> Feb 19 09:54:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:816 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:54:36 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.85:936 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:55:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:818 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:56:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:927 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:57:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:929 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:58:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:1003 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 09:59:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:1005 for /media/disk1_prods1 (/media/disk1_prods1)
> Feb 19 10:00:08 lin48a rpc.mountd: authenticated mount request from
> 192.168.0.245:654 for /media/disk1_prods1 (/media/disk1_prods1)
> 
> 
> Thanls for the help :(
> 
> 
> 
> On Feb 12, 2008 7:31 AM, Ian Kent <raven@themaw.net> wrote:
>         
>         On Mon, 2008-02-11 at 16:37 +0100, Vincent LEFORT wrote:
>         > So
>         >
>         > rpm -q autofs : autofs-4.1.4-6
>         > uname -r : 2.6.13-15.18-smp
>         >
>         > auto.master on clients :
>         >      /serveurpst /etc/auto.pst --timeout 60
>         >
>         > auto.pst on clients :
>         >     prods1  -soft,intr,rsize=8192,wsize=8192,timeo=15,rw
>         > 192.168.0.48:/media/disk1_prods1
>         >
>         
>         
>         snip ...
>         
>         >
>         > I will do the debug output, do you see some problems here ?
>         
>         
>         This all looks OK.
>         Have you checked the order of the startup on you're
>         distribution?
>         If the network isn't up before autofs starts that will be a
>         problem.
>         
>         Ian
>         
>         
> 
> 
> 
> -- 
> LEFORT Vincent
