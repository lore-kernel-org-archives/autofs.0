From: "Max Harvest" <rootserver94@googlemail.com>
Subject: automount ignores remote logins
Date: Fri, 6 Jun 2008 01:11:47 +0200
Message-ID: <9e9c61c30806051611k7a8c57fev9aa0d7b27655608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hello everybody,

since I'm using the automount 5, I'm confronted with a very strange
behaviour. I use it to mount user directories over nfs. The automounter
maps are provided by NIS und users usually have to login only into
client computers remotely using rsh or ssh. Now i encounter the following
misbehaviour:

At the init, automounter seems to start properly, but if someone logins
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
automount[1910]: parse_init: parse(sun): init gathered global options: (null)
automount[1910]: mount_init: mount(bind): bind_works = 1

after login per tty:

automount[1910]: master_do_mount: mounting /users
automount[1910]: lookup_nss_read_map: reading map yp auto.users
automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.users
automount[1910]: parse_init: parse(sun): init gathered global options: (null)
automount[1910]: mount_init: mount(bind): bind_works = 1
automount[1910]: mounted indirect mount on /users with timeout 600,
freq 150 seconds
automount[1910]: ghosting enabled

It seems, that a login through tty sends an wake up event to the
automount deamon, because all remote logins are ignored. This
behaviour seems also to be independent of all different automounter
and NIS configuration variants or options. I have tried a lot of different
(properly working over tty) configurations without any effect on this
strange behaviour.

Any idea?
