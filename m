From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs and smb shares
Date: Sat, 3 Apr 2004 21:05:34 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404032101140.23951@raven.themaw.net>
References: <001601c41955$830a9580$51004701@mobylines.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <001601c41955$830a9580$51004701@mobylines.it>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Cc: autofs@linux.kernel.org

On Sat, 3 Apr 2004, Amodiovalerio [Hypo] Verde wrote:

> 
> I've solved the problem ( I hope ) just forcing the umount when the fstat
> fails cause of errno like EBADSLT ( that's what I got when the share is not
> more available ).

I don't see the EBADSLT here. I see an EIO.

> 
> Maybe it's safe to umount the dir without doing a fstat at all.

Don't like that much. The lstat probably causes smbfs to return EIO 
instead of EBADSLT.

If you are keen, please try this patch and let me know how you go.

Ian

diff -Nur autofs-4.1.1.orig/daemon/automount.c autofs-4.1.1/daemon/automount.c
--- autofs-4.1.1.orig/daemon/automount.c	2004-03-07 20:17:54.000000000 +0800
+++ autofs-4.1.1/daemon/automount.c	2004-04-03 20:54:10.503719408 +0800
@@ -135,21 +135,31 @@
 	return 0;
 }
 
-static int umount_ent(const char *root, const char *name)
+static int umount_ent(const char *root, const char *name, const char *type)
 {
 	char path_buf[PATH_MAX];
 	struct stat st;
+	int sav_errno;
+	int is_smbfs = (strcmp(type, "smbfs") == 0);
+	int status;
 	int rv = 0;
 
 	sprintf(path_buf, "%s/%s", root, name);
-	if (!lstat(path_buf, &st)) {
-		if (S_ISDIR(st.st_mode)) {
-			if (st.st_dev != ap.dev) {
-				wait_for_lock();
-				rv = spawnl(LOG_DEBUG, MOUNTED_LOCK, PATH_UMOUNT,
-					    PATH_UMOUNT, path_buf, NULL);
-				unlink(AUTOFS_LOCK);
-			}
+	status =  lstat(path_buf, &st);
+	sav_errno = errno;
+
+	/* EIO appears to correspond to an smb mount that has gone away */
+	if (!status || (is_smbfs && sav_errno == EIO)) {
+		int umount_ok = 0;
+
+		if (!status && (S_ISDIR(st.st_mode) && (st.st_dev != ap.dev)))
+			umount_ok = 1;
+
+		if (umount_ok || is_smbfs) {
+			wait_for_lock();
+			rv = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
+			unlink(AUTOFS_LOCK);
 		}
 	}
 	return rv;
@@ -234,6 +244,7 @@
 	FILE *mtab;
 	struct mntlist {
 		const char *path;
+		const char *fs_type;
 		struct mntlist *next;
 	} *mntlist = NULL, *mptr;
 	size_t pathlen = strlen(path);
@@ -268,9 +279,15 @@
 				break;
 
 		m = alloca(sizeof(*m));
+
 		p = alloca(len + 1);
 		strcpy(p, mnt->mnt_dir);
 		m->path = p;
+
+		p = alloca(strlen(mnt->mnt_type) + 1);
+		strcpy(p, mnt->mnt_type);
+		m->fs_type = p;
+		
 		m->next = *prev;
 		*prev = m;
 	}
@@ -281,7 +298,7 @@
 	left = 0;
 	for (mptr = mntlist; mptr != NULL; mptr = mptr->next) {
 		debug("umount_multi: unmounting dir=%s\n", mptr->path);
-		if (umount_ent("", mptr->path)) {
+		if (umount_ent("", mptr->path, mptr->fs_type)) {
 			left++;
 		}
 	}
