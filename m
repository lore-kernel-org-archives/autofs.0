From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs reload
Date: Fri, 26 Mar 2004 11:11:46 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16484.22082.53177.910078@segfault.boston.redhat.com>
References: <E1B6tS8-0009vh-00.ia6432-inbox-ru@f10.mail.ru>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B6tS8-0009vh-00.ia6432-inbox-ru@f10.mail.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs reload; "Peter Lojkin"  <ia6432@inbox.ru> adds:

ia6432> Hello, how to do correct autofs map reload?  with older
ia6432> (3.9.99-4.0.0pre10) autofs updating nis maps works ok.  for example
ia6432> changing in auto.home:
ia6432> host1:/export/home/user
ia6432> to
ia6432> host2:/export/home/user
ia6432> and doing ls /home/user leads to mounting new users home.

ia6432> in autofs 4.1.0 (autofs4-20031201 in kernel) it tries to mount
ia6432> host1 even after 5 hours wait and nscd/nis restart.

Hmm, was the share ever umounted?  You can check this using either lsof of
fuser before you try to do the ls.  If this is the case, your only option
is to kill off users of the mount point and try again.

ia6432> if i do /etc/init.d/autofs reload it rereads nis maps but starts
ia6432> _new_ automount processes for all maps i.e. i get 2 automount for
ia6432> each map.  after another reload i get 3 etc. and if i understand it
ia6432> correctly they all try to manage mount points...

ia6432> if i do /etc/init.d/autofs restart (or stop/start) i get all
ia6432> directories that were mounted prior to restart empty. all of them
ia6432> are mounted but ls gives empty directory.

ia6432> so how to do correct autofs map reload?

Ok, the automount daemon shouldn't start up if the mountpoint is already
controlled by autofs.  Attached is a patch which addresses this.  Comments
welcome.


Cheers,

Jeff

--- autofs-4.1.1/daemon/automount.c.orig	2004-03-18 15:08:30.000000000 -0500
+++ autofs-4.1.1/daemon/automount.c	2004-03-18 15:09:06.000000000 -0500
@@ -388,8 +388,8 @@ static int mount_autofs(char *path)
 	struct stat st;
 	int len;
 
-	if (ap.state != ST_INIT) {
-		/* This can't happen */
+	if ((ap.state != ST_INIT) || is_mounted(path)) {
+		/* This can happen if an autofs process is already running*/
 		error("mount_autofs: already mounted");
 		return -1;
 	}
