From: Ian Kent <raven@themaw.net>
Subject: Re: Mountpoint string corruption in autofs5.0.3-3?
Date: Tue, 28 Apr 2009 12:52:40 +0800
Message-ID: <20090428045239.GA15243@zeus.themaw.net>
References: <49F0F494.4030008@modwest.com>
	<20090426034752.GA3084@zeus.themaw.net>
	<49F48D8C.3060803@modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <49F48D8C.3060803@modwest.com>
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
To: Thomas Connell <tconnell@modwest.com>
Cc: autofs@linux.kernel.org

On Sun, Apr 26, 2009 at 10:36:28AM -0600, Thomas Connell wrote:
>
> I gave it a shot; I am largely a complete C novice, but:

Right, and I find working with the Debian packaging system a bit of a
nightmare. That's why I was hoping you would do this for me.

>
> Following the debugging from the nfs module, the log shows:
> Apr 26 09:49:30 web6 automount[3920]: mount_mount: mount(bind): 
> root=/domains/f/federalhousingtaxcredit.com name=/  
> what=/www/vhosts/f/federalhousingtaxcredit.com, fstype=bind, options=
>
> Which all looks right to me.

Me too, but it isn't, as we now see from your effort.

>
> Since I could see in the logs that fullpath was garbled, I was wondering 
> if maybe alloca wasn't getting the right length.  I did a bit of trial 
> and error, and it seems consistent that fullpaths of 33 or over become 
> garbled.
>
> So, in mount_bind.c, I added:
>
> debug(ap->logopt, MODPREFIX "name_len=%d", name_len);
>
> right after
>
> int i, rlen;
>
> and
>
> debug(ap->logopt, MODPREFIX "name_len=%d rlen=%d", name_len, rlen);
>
> right after
>
> rlen = strlen(root);
>
>
> The logs show:
>
> Apr 26 10:05:46 web6 automount[7353]: mount_mount: mount(bind): name_len=0
> Apr 26 10:05:46 web6 automount[7353]: mount_mount: mount(bind): name_len=0 rlen=0

That is wrong.

It's due to improper use of name_len in modules/mount_nfs.c:mount_mount()
as, in 5.0.3, name_len is set to 0 prior to the call to perform the bind
mount.

The problem now is that this has been fixed in 5.0.4 as part of a much
larger patch.

The hunk in that patch, which should stand alone anyway, is:

diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index d7f42a7..0b253d8 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -64,7 +64,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	struct host *this, *hosts = NULL;
 	unsigned int vers;
 	char *nfsoptions = NULL;
-	int len, rlen, status, err, existed = 1;
+	int len, status, err, existed = 1;
 	int nosymlink = 0;
 	int ro = 0;            /* Set if mount bind should be read-only */
 
@@ -146,30 +146,18 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	/* Construct and perhaps create mount point directory */
 
 	/* Root offset of multi-mount */
-	if (*name == '/' && name_len == 1) {
-		rlen = strlen(root);
-		name_len = 0;
+	len = strlen(root);
+	if (root[len - 1] == '/') {
+		fullpath = alloca(len);
+		len = snprintf(fullpath, len, "%s", root);
 	/* Direct mount name is absolute path so don't use root */
-	} else if (*name == '/')
-		rlen = 0;
-	else
-		rlen = strlen(root);
-
-	fullpath = alloca(rlen + name_len + 2);
-	if (!fullpath) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
-		free_host_list(&hosts);
-		return 1;
-	}
-
-	if (name_len) {
-		if (rlen)
-			len = sprintf(fullpath, "%s/%s", root, name);
-		else
-			len = sprintf(fullpath, "%s", name);
-	} else
+	} else if (*name == '/') {
+		fullpath = alloca(len + 1);
 		len = sprintf(fullpath, "%s", root);
+	} else {
+		fullpath = alloca(len + name_len + 2);
+		len = sprintf(fullpath, "%s/%s", root, name);
+	}
 	fullpath[len] = '\0';
 
 	debug(ap->logopt, MODPREFIX "calling mkdir_path %s", fullpath);
