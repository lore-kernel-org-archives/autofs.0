From: "Vincent LEFORT" <vincent.lefort@gmail.com>
Subject: Re: Mount very when reboot
Date: Tue, 26 Feb 2008 09:08:04 +0100
Message-ID: <3a98c5000802260008l28a2ccb1qbc49953bd03bcdff@mail.gmail.com>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
	<1202717516.24318.8.camel@raven.themaw.net>
	<3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
	<1202797905.3233.57.camel@raven.themaw.net>
	<3a98c5000802190105v3ccb2c4h6153f334a1610004@mail.gmail.com>
	<1203413746.16791.12.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3007320671234013341=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1203413746.16791.12.camel@raven.themaw.net>
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

--===============3007320671234013341==
Content-Type: multipart/alternative; 
	boundary="----=_Part_7835_27971103.1204013284783"

------=_Part_7835_27971103.1204013284783
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello !

I found the problem !

In the shower this morning, I thought : "Hey you put a link S22autofs to
start autofs automatically but you havn't put a link to shutdown them when
stop"...

So i put au link : K11autos juste before nfs (K12nfs) and now when i reboot
all its ok... I can connect directly to the server...

Greatttttttttttttttttt

Thanks a lot.

Vincent

On Tue, Feb 19, 2008 at 10:35 AM, Ian Kent <raven@themaw.net> wrote:

>
> On Tue, 2008-02-19 at 10:05 +0100, Vincent LEFORT wrote:
> > Hello, soory for late response, but always the problems :s
> >
> > When i installed computers, i put a link :
> >
> > ln -s /etc/init.d/autofs /etc/init.d/rc5.d/S22autofs
> >
> > So when computer start, autofs start... By defaut after install and
> > first restart, suse change name to : S13autofs
>
> I don't know what I can do about SuSE.
> If the SuSE setup is broken then they need to fix it.
>
> >
> > My startup in init.d/rc5.d is :
> >
> > S01earlysyslog -> ../earlysyslog
> > S01fbset -> ../fbset
> > S01irq_balancer -> ../irq_balancer
> > S01random -> ../random
> > S01resmgr -> ../resmgr
> > S02earlykbd -> ../earlykbd
> > S03dbus -> ../dbus
> > S04boot.udev -> ../boot.udev
> > S05network -> ../network
> > S06syslog -> ../syslog
> > S07netdaemon -> ../netdaemon
> > S07nmb -> ../nmb
> > S08mdnsd -> ../mdnsd
> > S08portmap -> ../portmap
> > S08splash_early -> ../splash_early
> > S10nfs -> ../nfs
> > S10nfsboot -> ../nfsboot
> > S12acpid -> ../acpid
> > S12alsasound -> ../alsasound
> > S12cups -> ../cups
> > S12kbd -> ../kbd
> > S12microcode -> ../microcode
> > S12running-kernel -> ../running-kernel
> > S12splash -> ../splash
> > S12sshd -> ../sshd
> > S13autofs -> ../autofs
> > S13smb -> ../smb
> > S13xdm -> ../xdm
> > S14nscd -> ../nscd
> > S14postfix -> ../postfix
> > S14smbfs -> ../smbfs
> > S14xinetd -> ../xinetd
> > S15cron -> ../cron
> > S16haldaemon -> ../haldaemon
> > S17powersaved -> ../powersaved
> > S18cupsrenice -> ../cupsrenice
> > S21SuSEfirewall2_setup -> ../SuSEfirewall2_setup
>
> Why is the firewall started last.
> Maybe this is the cause, starting the firewall so late must mean
> everything is blocked until it completes. That would be the only sane
> way to start the firewall last.
>
> >
> >
> > I'm tried to do the debug output but when i put the option --debug in
> > my auto.master, and restart autofs the line command is :
> >
> > /usr/sbin/automount --debug --timeout 60 /serveurpasta
> > file /etc/auto.pasta debug
> >
> >
> > When i check (after reboot) the clients i can read :
> >
> > Feb 19 09:52:45 linux kernel: RPC: error 5 connecting to server
> > 192.168.0.48
> > Feb 19 09:53:45 linux kernel: RPC: error 5 connecting to server
> > 192.168.0.48
> > Feb 19 09:53:45 linux automount[7534]: >> mount:
> > 192.168.0.48:/media/disk1_prods1: can't read superblock
> > Feb 19 09:53:45 linux automount[7534]: mount(nfs): nfs: mount failure
> > 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1
> > Feb 19 09:53:45 linux automount[7534]: failed to
> > mount /serveurpasta/prods1
> > Feb 19 09:54:45 linux kernel: RPC: error 5 connecting to server
> > 192.168.0.48
> > Feb 19 09:55:45 linux kernel: RPC: error 5 connecting to server
> > 192.168.0.48
> > Feb 19 09:55:45 linux automount[7610]: >> mount:
> > 192.168.0.48:/media/disk1_prods1: can't read superblock
> > Feb 19 09:55:45 linux automount[7610]: mount(nfs): nfs: mount failure
> > 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1
> > Feb 19 09:55:45 linux automount[7610]: failed to
> > mount /serveurpasta/prods1
> >
> > etc.....
> >
> > And on server :
> >
> >
> > Feb 19 09:54:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:816 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:54:36 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.85:936 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:55:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:818 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:56:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:927 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:57:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:929 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:58:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:1003 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 09:59:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:1005 for /media/disk1_prods1 (/media/disk1_prods1)
> > Feb 19 10:00:08 lin48a rpc.mountd: authenticated mount request from
> > 192.168.0.245:654 for /media/disk1_prods1 (/media/disk1_prods1)
> >
> >
> > Thanls for the help :(
> >
> >
> >
> > On Feb 12, 2008 7:31 AM, Ian Kent <raven@themaw.net> wrote:
> >
> >         On Mon, 2008-02-11 at 16:37 +0100, Vincent LEFORT wrote:
> >         > So
> >         >
> >         > rpm -q autofs : autofs-4.1.4-6
> >         > uname -r : 2.6.13-15.18-smp
> >         >
> >         > auto.master on clients :
> >         >      /serveurpst /etc/auto.pst --timeout 60
> >         >
> >         > auto.pst on clients :
> >         >     prods1  -soft,intr,rsize=8192,wsize=8192,timeo=15,rw
> >         > 192.168.0.48:/media/disk1_prods1
> >         >
> >
> >
> >         snip ...
> >
> >         >
> >         > I will do the debug output, do you see some problems here ?
> >
> >
> >         This all looks OK.
> >         Have you checked the order of the startup on you're
> >         distribution?
> >         If the network isn't up before autofs starts that will be a
> >         problem.
> >
> >         Ian
> >
> >
> >
> >
> >
> > --
> > LEFORT Vincent
>
>


-- 
LEFORT Vincent

------=_Part_7835_27971103.1204013284783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello !<br><br>I found the problem ! <br><br>In the shower this morning, I thought : &quot;Hey you put a link S22autofs to start autofs automatically but you havn&#39;t put a link to shutdown them when stop&quot;...<br><br>
So i put au link : K11autos juste before nfs (K12nfs) and now when i reboot all its ok... I can connect directly to the server...<br><br>Greatttttttttttttttttt<br><br>Thanks a lot.<br><br>Vincent<br><br><div class="gmail_quote">
On Tue, Feb 19, 2008 at 10:35 AM, Ian Kent &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
On Tue, 2008-02-19 at 10:05 +0100, Vincent LEFORT wrote:<br>
&gt; Hello, soory for late response, but always the problems :s<br>
&gt;<br>
&gt; When i installed computers, i put a link :<br>
&gt;<br>
&gt; ln -s /etc/init.d/autofs /etc/init.d/rc5.d/S22autofs<br>
&gt;<br>
&gt; So when computer start, autofs start... By defaut after install and<br>
&gt; first restart, suse change name to : S13autofs<br>
<br>
</div>I don&#39;t know what I can do about SuSE.<br>
If the SuSE setup is broken then they need to fix it.<br>
<div><div></div><div class="Wj3C7c"><br>
&gt;<br>
&gt; My startup in init.d/rc5.d is :<br>
&gt;<br>
&gt; S01earlysyslog -&gt; ../earlysyslog<br>
&gt; S01fbset -&gt; ../fbset<br>
&gt; S01irq_balancer -&gt; ../irq_balancer<br>
&gt; S01random -&gt; ../random<br>
&gt; S01resmgr -&gt; ../resmgr<br>
&gt; S02earlykbd -&gt; ../earlykbd<br>
&gt; S03dbus -&gt; ../dbus<br>
&gt; S04boot.udev -&gt; ../boot.udev<br>
&gt; S05network -&gt; ../network<br>
&gt; S06syslog -&gt; ../syslog<br>
&gt; S07netdaemon -&gt; ../netdaemon<br>
&gt; S07nmb -&gt; ../nmb<br>
&gt; S08mdnsd -&gt; ../mdnsd<br>
&gt; S08portmap -&gt; ../portmap<br>
&gt; S08splash_early -&gt; ../splash_early<br>
&gt; S10nfs -&gt; ../nfs<br>
&gt; S10nfsboot -&gt; ../nfsboot<br>
&gt; S12acpid -&gt; ../acpid<br>
&gt; S12alsasound -&gt; ../alsasound<br>
&gt; S12cups -&gt; ../cups<br>
&gt; S12kbd -&gt; ../kbd<br>
&gt; S12microcode -&gt; ../microcode<br>
&gt; S12running-kernel -&gt; ../running-kernel<br>
&gt; S12splash -&gt; ../splash<br>
&gt; S12sshd -&gt; ../sshd<br>
&gt; S13autofs -&gt; ../autofs<br>
&gt; S13smb -&gt; ../smb<br>
&gt; S13xdm -&gt; ../xdm<br>
&gt; S14nscd -&gt; ../nscd<br>
&gt; S14postfix -&gt; ../postfix<br>
&gt; S14smbfs -&gt; ../smbfs<br>
&gt; S14xinetd -&gt; ../xinetd<br>
&gt; S15cron -&gt; ../cron<br>
&gt; S16haldaemon -&gt; ../haldaemon<br>
&gt; S17powersaved -&gt; ../powersaved<br>
&gt; S18cupsrenice -&gt; ../cupsrenice<br>
&gt; S21SuSEfirewall2_setup -&gt; ../SuSEfirewall2_setup<br>
<br>
</div></div>Why is the firewall started last.<br>
Maybe this is the cause, starting the firewall so late must mean<br>
everything is blocked until it completes. That would be the only sane<br>
way to start the firewall last.<br>
<div><div></div><div class="Wj3C7c"><br>
&gt;<br>
&gt;<br>
&gt; I&#39;m tried to do the debug output but when i put the option --debug in<br>
&gt; my auto.master, and restart autofs the line command is :<br>
&gt;<br>
&gt; /usr/sbin/automount --debug --timeout 60 /serveurpasta<br>
&gt; file /etc/auto.pasta debug<br>
&gt;<br>
&gt;<br>
&gt; When i check (after reboot) the clients i can read :<br>
&gt;<br>
&gt; Feb 19 09:52:45 linux kernel: RPC: error 5 connecting to server<br>
&gt; <a href="http://192.168.0.48" target="_blank">192.168.0.48</a><br>
&gt; Feb 19 09:53:45 linux kernel: RPC: error 5 connecting to server<br>
&gt; <a href="http://192.168.0.48" target="_blank">192.168.0.48</a><br>
&gt; Feb 19 09:53:45 linux automount[7534]: &gt;&gt; mount:<br>
&gt; 192.168.0.48:/media/disk1_prods1: can&#39;t read superblock<br>
&gt; Feb 19 09:53:45 linux automount[7534]: mount(nfs): nfs: mount failure<br>
&gt; 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1<br>
&gt; Feb 19 09:53:45 linux automount[7534]: failed to<br>
&gt; mount /serveurpasta/prods1<br>
&gt; Feb 19 09:54:45 linux kernel: RPC: error 5 connecting to server<br>
&gt; <a href="http://192.168.0.48" target="_blank">192.168.0.48</a><br>
&gt; Feb 19 09:55:45 linux kernel: RPC: error 5 connecting to server<br>
&gt; <a href="http://192.168.0.48" target="_blank">192.168.0.48</a><br>
&gt; Feb 19 09:55:45 linux automount[7610]: &gt;&gt; mount:<br>
&gt; 192.168.0.48:/media/disk1_prods1: can&#39;t read superblock<br>
&gt; Feb 19 09:55:45 linux automount[7610]: mount(nfs): nfs: mount failure<br>
&gt; 192.168.0.48:/media/disk1_prods1 on /serveurpasta/prods1<br>
&gt; Feb 19 09:55:45 linux automount[7610]: failed to<br>
&gt; mount /serveurpasta/prods1<br>
&gt;<br>
&gt; etc.....<br>
&gt;<br>
&gt; And on server :<br>
&gt;<br>
&gt;<br>
&gt; Feb 19 09:54:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:816" target="_blank">192.168.0.245:816</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:54:36 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.85:936" target="_blank">192.168.0.85:936</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:55:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:818" target="_blank">192.168.0.245:818</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:56:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:927" target="_blank">192.168.0.245:927</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:57:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:929" target="_blank">192.168.0.245:929</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:58:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:1003" target="_blank">192.168.0.245:1003</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 09:59:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:1005" target="_blank">192.168.0.245:1005</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt; Feb 19 10:00:08 lin48a rpc.mountd: authenticated mount request from<br>
&gt; <a href="http://192.168.0.245:654" target="_blank">192.168.0.245:654</a> for /media/disk1_prods1 (/media/disk1_prods1)<br>
&gt;<br>
&gt;<br>
&gt; Thanls for the help :(<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Feb 12, 2008 7:31 AM, Ian Kent &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; On Mon, 2008-02-11 at 16:37 +0100, Vincent LEFORT wrote:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; So<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; rpm -q autofs : autofs-4.1.4-6<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; uname -r : 2.6.13-15.18-smp<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; auto.master on clients :<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp;/serveurpst /etc/auto.pst --timeout 60<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; auto.pst on clients :<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; prods1 &nbsp;-soft,intr,rsize=8192,wsize=8192,timeo=15,rw<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; 192.168.0.48:/media/disk1_prods1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; snip ...<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; I will do the debug output, do you see some problems here ?<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; This all looks OK.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Have you checked the order of the startup on you&#39;re<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; distribution?<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; If the network isn&#39;t up before autofs starts that will be a<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; problem.<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Ian<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; LEFORT Vincent<br>
<br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>LEFORT Vincent

------=_Part_7835_27971103.1204013284783--


--===============3007320671234013341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3007320671234013341==--

