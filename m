From: "Max Harvest" <rootserver94@googlemail.com>
Subject: automount ignores remote logins
Date: Thu, 5 Jun 2008 17:16:22 +0200
Message-ID: <9e9c61c30806050816l18e0cf5ao973cb3332ee9b9d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2794995923565828292=="
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

--===============2794995923565828292==
Content-Type: multipart/alternative; 
	boundary="----=_Part_370_13170927.1212678983240"

------=_Part_370_13170927.1212678983240
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

since i'm using the automount 5, i'm confronted with a very strange
behaviour. I use it to mount user directories over nfs. The automounter
maps are provided by NIS und users ususally have to login only into
client computers remotely using rsh or ssh. Now i encounter the following
missbehaviour:

At the init, automounter seems to start propperly, but if someone logins
over the network into the client machine, the automounter ignores all
mount requests (i.e. there is no automounter activity at all). Even a
restart changes nothing. But if someone logins on the client machine
over a tty, everything works fine. Therefor i enabled debug mode
verbosity and this is the output from syslog:

after the startup during boot or after a restart later:

automount[1910]: Starting automounter version 5.0.2, master map auto.master
automount[1910]: using kernel protocol version 5.00
automount[1910]: lookup_nss_read_master: reading master nis auto.master
automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.master
automount[1910]: parse_init: parse(sun): init gathered global
options: (null)
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
automount deamon, because all remote logins are ignored. This
behaviour seems also to be independent of all different automounter
and NIS configuration variants or options. I have tried a lot of different
(propperly working over tty) configurations without any effect on this
strange behaviour.

Any idea?

------=_Part_370_13170927.1212678983240
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody, <br><br>since i&#39;m using the automount 5, i&#39;m confronted with a very strange <br>behaviour. I use it to mount user directories over nfs. The automounter <br>maps are provided by NIS und users ususally have to&nbsp;login only into <br>
client computers remotely using rsh or ssh.  Now i encounter the following<br> missbehaviour: <br><br>At the init, automounter seems to start propperly, but if someone&nbsp;logins <br>over the network into the client machine, the&nbsp;automounter&nbsp;ignores&nbsp;all&nbsp;<br>
mount requests (i.e. there is no automounter activity at all). Even a <br>restart changes nothing. But if someone logins on the client machine <br>over a&nbsp;tty,&nbsp;everything works fine. Therefor i enabled debug mode <br>verbosity and this is the output from syslog: <br>
<br>after the startup during boot or  after a restart later:<br><br>automount[1910]: Starting automounter version 5.0.2, master map&nbsp;auto.master <br>automount[1910]: using kernel protocol version 5.00 <br>automount[1910]: lookup_nss_read_master: reading master nis&nbsp;auto.master <br>
automount[1910]: lookup_init: lookup(yp): ctxt-&gt;mapname=auto.master <br>automount[1910]: parse_init: parse(sun): init gathered global options:&nbsp;(null) <br>automount[1910]: mount_init: mount(bind): bind_works = 1 <br><br>
after login per tty:<br><br>automount[1910]: master_do_mount: mounting /users <br>automount[1910]: lookup_nss_read_map: reading map yp auto.users <br>automount[1910]: lookup_init: lookup(yp): ctxt-&gt;mapname=auto.users <br>
automount[1910]: parse_init: parse(sun): init gathered global options: (null) <br>automount[1910]: mount_init: mount(bind): bind_works = 1 <br>automount[1910]: mounted indirect mount on /users with timeout 600,&nbsp;freq 150 seconds <br>
automount[1910]: ghosting enabled <br><br>It seems, that a login through tty sends an wake up event to the&nbsp;<br>automount deamon, because all remote logins are ignored. This&nbsp;<br>behaviour seems also to be independent of all different automounter&nbsp;<br>
and NIS configuration variants or options. I have tried a lot of different&nbsp;<br>(propperly working&nbsp;over&nbsp;tty) configurations&nbsp;without any effect on&nbsp;this <br>strange behaviour. <br><br>Any idea?<br><br>

------=_Part_370_13170927.1212678983240--


--===============2794995923565828292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2794995923565828292==--

