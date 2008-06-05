From: "Max Harvest" <rootserver94@googlemail.com>
Subject: automount ignores remote log ins
Date: Thu, 5 Jun 2008 17:52:16 +0200
Message-ID: <9e9c61c30806050852t737a01c0gf530f7b1e5fef1b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6774747122475812529=="
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

--===============6774747122475812529==
Content-Type: multipart/alternative; 
	boundary="----=_Part_377_2434798.1212681136638"

------=_Part_377_2434798.1212681136638
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

since I'm using the automount 5, I'm confronted with a very strange
behaviour. I use it to mount user directories over nfs. The automounter
maps are provided by NIS and users usually have to log in only into
client computers remotely using rsh or ssh. Now i encounter the following
misbehaviour:

At the init, automounter seems to start properly, but if someone log ins
over the network into the client machine, the automounter ignores all
mount requests (i.e. there is no automounter activity at all). Even a
restart changes nothing. But if someone log ins on the client machine
over a tty, everything works fine. Therefor i enabled debug mode
verbosity and this is the output from syslog:

after the start up during boot or after a restart later:

automount[1910]: Starting automounter version 5.0.2, master map auto.master
automount[1910]: using kernel protocol version 5.00
automount[1910]: lookup_nss_read_master: reading master nis auto.master
automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.master
automount[1910]: parse_init: parse(sun): init gathered global options:
(null)
automount[1910]: mount_init: mount(bind): bind_works = 1

after login per tty:

automount[1910]: master_do_mount: mounting /users
automount[1910]: lookup_nss_read_map: reading map yp auto.users
automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.users
automount[1910]: parse_init: parse(sun): init gathered global options:
(null)
automount[1910]: mount_init: mount(bind): bind_works = 1
automount[1910]: mounted indirect mount on /users with timeout 600, freq 150
seconds
automount[1910]: ghosting enabled

It seems, that a login through tty sends an wake up event to the
automount daemon, because all remote log ins are ignored. This
behaviour seems also to be independent of all different automounter
and NIS configuration variants or options. I have tried a lot of different
(properly working over tty) configurations without any effect on this
strange behaviour.

Any idea?

------=_Part_377_2434798.1212681136638
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody, <br><br>since I&#39;m using the automount 5, I&#39;m confronted with a very strange <br>behaviour. I use it to mount user directories over nfs. The automounter <br>maps are provided by NIS and users usually have to log in only into <br>
 client computers remotely using rsh or ssh. Now i encounter the following<br>misbehaviour: <br><br>At the init, automounter seems to start properly, but if someone log ins <br>over the network into the client machine, the automounter ignores all <br>
 mount requests (i.e. there is no automounter activity at all). Even a <br>restart changes nothing. But if someone log ins on the client machine <br>over a tty, everything works fine. Therefor i enabled debug mode <br>verbosity and this is the output from syslog: <br>
<br>after the start up during boot or after a restart later:<br><br>automount[1910]: Starting automounter version 5.0.2, master map auto.master <br>automount[1910]: using kernel protocol version 5.00 <br>automount[1910]: lookup_nss_read_master: reading master nis auto.master <br>
 automount[1910]: lookup_init: lookup(yp): ctxt-&gt;mapname=auto.master <br>automount[1910]: parse_init: parse(sun): init gathered global options: (null) <br>automount[1910]: mount_init: mount(bind): bind_works = 1 <br><br>
 after login per tty:<br><br>automount[1910]: master_do_mount: mounting /users <br>automount[1910]: lookup_nss_read_map: reading map yp auto.users <br>automount[1910]: lookup_init: lookup(yp): ctxt-&gt;mapname=auto.users <br>
 automount[1910]: parse_init: parse(sun): init gathered global options: (null) <br>automount[1910]: mount_init: mount(bind): bind_works = 1 <br>automount[1910]: mounted indirect mount on /users with timeout 600, freq 150 seconds <br>
 automount[1910]: ghosting enabled <br><br>It seems, that a login through tty sends an wake up event to the <br>automount daemon, because all remote log ins are ignored. This <br>behaviour seems also to be independent of all different automounter <br>
 and NIS configuration variants or options. I have tried a lot of different <br>(properly working over tty) configurations without any effect on this <br>strange behaviour. <br><br>Any idea?<br><br>

------=_Part_377_2434798.1212681136638--


--===============6774747122475812529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6774747122475812529==--

