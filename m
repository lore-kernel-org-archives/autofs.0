From: Ian Kent <raven@themaw.net>
Subject: Re: More CIFS $ Share Woes
Date: Mon, 7 Sep 2009 15:33:56 +0800
Message-ID: <20090907073355.GA12484@zeus.themaw.net>
References: <85c7eb2d0908280709u35cd5cfci7f50413da61539e7@mail.gmail.com>
	<4A9B5274.4040800@themaw.net>
	<85c7eb2d0908310522u18907b17pd1399a1cf79ad1e5@mail.gmail.com>
	<85c7eb2d0908311255j5b457221ld88131f111611f04@mail.gmail.com>
	<4A9C8B01.9060708@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to;
	s=smtpout; bh=toJs5MvDrmmz5PqkV6meFcvcOXs=;
	b=OO5eSqCEknqrl3j5RCZw4R9g1PZbQVNybt1/mElNnGhUrrXpesQ6Hjz9zj7RMLQ36USI38etAzIrhkNj1GKNHH+bnJgW7M/qOWbPNeoNOmFKHeF6V+cNKc0209DQfAMRiRE0goyMYLMmNt0JnQd45Gu+dkic0adL5zNbsfIlZ7g=
Content-Disposition: inline
In-Reply-To: <4A9C8B01.9060708@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Jason T. Masker" <jason.fmic@masker.net>
Cc: autofs@linux.kernel.org

On Tue, Sep 01, 2009 at 10:46:25AM +0800, Ian Kent wrote:
> Jason T. Masker wrote:
> > I also tried changing the print line to the following:
> > 
> > print " \\\n\t \"/" dir "\"", "://" key "/" lo
> > 
> > 
> > 
> > so that the output looks like this:
> > 
> > $ sudo /etc/auto.cifs VMW1013
> > -fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
> > \
> >          "/My Documents" ://VMW1013/My Documents \
> >          "/ADMIN$" ://VMW1013/ADMIN\$ \
> >          "/C$" ://VMW1013/C\$ \
> >          "/Shared" ://VMW1013/Shared
> > 
> > 
> > However, this results in automount dropping the $ as well.  The debug
> > looks identical to what I just posted.
> 
> Yes, the location does need to double escape the dollar in the mount.
> The double quotes are meant to preserve any spaces present in the
> location but the "$" is also used as a macro introducer so it needs to
> be escaped a second time so it doesn't get substituted with NULL when
> the entry is expanded. What makes this difficult is the "\" is also a
> separator and gets translated to "/" by mount.cifs. When you run the
> mount from the command line the shell translates the "\$" to "$" before
> it gets to mount.cifs.
> 
> I think the problem occurs because, when the entry is initially broken
> up into mount triggers for each share and each is mounted, expanding the
> map entry needs to preserve the "\$", but when the individual triggers
> are walked on expanding the entry needs to substitute the "\$" for "$"
> so the mount works. The problem being that the expand subroutine doesn't
> know the difference between these two invocations.
> 
> I'll have a look and see.

Does this patch help at all?
Ian

autofs-5.0.5 - special case cifs escapes

From: Ian Kent <raven@themaw.net>

Since "\" is a valid seperator for cifs shares it can't be used to escape
characters in the share name passed to mount.cifs. So we have no choice
but to require that the seperator we use is "/" and de-quote the string
before sending it to mount.cifs.
---

 modules/mount_generic.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)


diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index 8edad8b..baa64dd 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -39,6 +39,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 {
 	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
+	char *loc
 	int err;
 	int len, status, existed = 1;
 
@@ -74,22 +75,44 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	if (!status)
 		existed = 0;
 
+	/*
+	 * Special case quoting for cifs share names.
+	 *
+	 * Since "\" is a valid seperator for cifs shares it can't be
+	 * used to escape characters in the share name passed to
+	 * mount.cifs. So we have no choice but to require that the
+	 * seperator we use is "/" and de-quote the string before
+	 * sending it to mount.cifs.
+	 */
+	loc = NULL;
+	if (strcmp(fstype, "cifs"))
+		loc = strdup(what);
+	else
+		loc = dequote(what, strlen(what), ap->logopt);
+	if (!loc) {
+		error(ap->logopt,
+		      MODPREFIX "failed to alloc buffer for mount location");
+		return 1;
+	}
+
 	if (options && options[0]) {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
-		      fstype, options, what, fullpath);
+		      fstype, options, loc, fullpath);
 
 		err = spawn_mount(ap->logopt, "-t", fstype,
-			     SLOPPYOPT "-o", options, what, fullpath, NULL);
+			     SLOPPYOPT "-o", options, loc, fullpath, NULL);
 	} else {
 		debug(ap->logopt, MODPREFIX "calling mount -t %s %s %s",
-		      fstype, what, fullpath);
-		err = spawn_mount(ap->logopt, "-t", fstype, what, fullpath, NULL);
+		      fstype, loc, fullpath);
+		err = spawn_mount(ap->logopt, "-t", fstype, loc, fullpath, NULL);
 	}
 
 	if (err) {
 		info(ap->logopt, MODPREFIX "failed to mount %s (type %s) on %s",
-		     what, fstype, fullpath);
+		     loc, fstype, fullpath);
+
+		free(loc);
 
 		if (ap->type != LKP_INDIRECT)
 			return 1;
@@ -100,7 +123,8 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		return 1;
 	} else {
 		info(ap->logopt, MODPREFIX "mounted %s type %s on %s",
-		    what, fstype, fullpath);
+		     loc, fstype, fullpath);
+		free(loc);
 		return 0;
 	}
 }
