From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Race condition in autofs 4.1.4
Date: Mon, 29 Jan 2007 16:09:09 -0500
Message-ID: <x49zm81czgq.fsf@segfault.boston.devel.redhat.com>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170089728.3404.18.camel@raven.themaw.net>
	<1170104185.6774.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170104185.6774.11.camel@localhost> (Lukas Kolbe's message of
	"Mon, 29 Jan 2007 21:56:25 +0100")
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Mon, 29 Jan 2007 21:56:25 +0100, Lukas Kolbe <lukas@einfachkaffee.de> said:

Lukas> On Di, 2007-01-30 at 01:55 +0900, Ian Kent wrote: > > The
Lukas> system is now through more than 25000 mails, and hasn't hit the
Lukas> bug > > yet.  > > When it finished delivering, I'll setup
Lukas> another mailbomb and stress it > > over the night, let's cross
Lukas> fingers that it works. I'll then file a bug > > with the debian
Lukas> util-linux package and attach the patch to it.  > > Not
Lukas> close()ing the "we_created_lockfile" in unlock_mtab() seems
Lukas> like a > > bug to me, anyway ;)
Lukas> > 
Lukas> > Ya, but it gets closed at exit anyway.

Lukas> Ah, of course!

Lukas> I sent a mail earlier today, but it didn't come through to the
Lukas> list, dunno why, hence the Cc: on you.

Lukas> The bug/race hit again when the system delivered about 95% of
Lukas> the mail, with a few directories in /homes/ and /nfs4homes/
Lukas> that belonged to root and were empty, with an error in syslog
Lukas> that said "/homes/musrXXX already mounted" (I don't have the
Lukas> exact messages here, can post them tomorrow when I'm in the
Lukas> office).

Lukas> This was with the patch minus the typo applied. It seems that
Lukas> the patch helps the situation, as it happens not that fast, but
Lukas> once it happens, the directories in question cannot be mounted
Lukas> anymore by the automounter.

Lukas> Are there any other patches for mount floating around that I
Lukas> can try? I only have tomorrow for that because we're now going
Lukas> to implement our fallback configuration - a patched amd that
Lukas> understands our hesiod maps and just symlinks the home
Lukas> directories in place. But that feels rather not very correct
Lukas> ... and I'd much like to see mount fixed, because that locking
Lukas> code really scares me (I'm not really a C developer, though).

I don't mean to muddy the waters, but you might try adding the patch
below to autofs.  I posted it a while back, but Ian's been busy with
v5 development.  This is from my git tree, so I'm not sure if it
applies to current v4 as is.

-Jeff

commit 76b606ec00c3682971697b95c1af054742c704c5
Author: Jeff Moyer <jmoyer@segfault.boston.devel.redhat.com>
Date:   Wed Nov 8 22:04:44 2006 -0500

    Here is a patch to consult /proc/mounts instead of /etc/mtab when
    deciding if a path has already been mounted.  The problem with using
    /etc/mtab, as you know, is that it sometimes does not get updated.  We
    know that /proc/mounts will always be right, so why not use it?
    
    The patch will determine if /proc/mounts is available at run-time, and
    so will continue to work in the event that proc isn't available.

diff --git a/daemon/automount.c b/daemon/automount.c
index c09eaf6..766c472 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -333,7 +333,7 @@ static int umount_multi(const char *path
 
 	debug("umount_multi: path=%s incl=%d\n", path, incl);
 
-	mntlist = get_mnt_list(_PATH_MOUNTED, path, incl);
+	mntlist = get_mnt_list(path_mounted, path, incl);
 
 	if (!mntlist) {
 		warn("umount_multi: no mounts found under %s", path);
@@ -445,7 +445,7 @@ static int mount_autofs(char *path)
 	struct stat st;
 	int len;
 
-	if ((ap.state != ST_INIT) || is_mounted(_PATH_MOUNTED, path)) {
+	if ((ap.state != ST_INIT) || is_mounted(path_mounted, path)) {
 		/* This can happen if an autofs process is already running*/
 		error("mount_autofs: already mounted");
 		return -1;
@@ -1844,6 +1844,16 @@ int handle_mounts(char *path)
 	return 0;
 }
 
+void init_path_mounted(void)
+{
+	struct stat st;
+
+	if (stat(PROC_MOUNTS, &st) == 0)
+		path_mounted = PROC_MOUNTS;
+	else
+		path_mounted = _PATH_MOUNTED;
+}
+
 int main(int argc, char *argv[])
 {
 	char *path, *map, *mapfmt;
@@ -1928,6 +1938,8 @@ int main(int argc, char *argv[])
 	if (!dumpmap)
 		become_daemon();
 
+	init_path_mounted();
+
 	path = argv[0];
 	map = argv[1];
 	mapargv = (const char **) &argv[2];
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 53887f9..b7e1511 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -119,7 +119,7 @@ void discard_pending(int sig)
  */
 int signal_children(int sig)
 {
-	struct mnt_list *mnts = get_mnt_list(_PATH_MOUNTED, "/", 0);
+	struct mnt_list *mnts = get_mnt_list(path_mounted, "/", 0);
 	struct mnt_list *next;
 	pid_t pgrp = getpgrp();
 	int ret = -1;
diff --git a/include/automount.h b/include/automount.h
index 14ec07b..c5f4707 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -40,6 +40,7 @@ #endif
 #define AUTOFS_SUPER_MAGIC 0x00000187L
 
 #define DEFAULT_TIMEOUT (5*60)			/* 5 minutes */
+#define PROC_MOUNTS	"/proc/mounts"
 #define AUTOFS_LOCK	"/var/lock/autofs"	/* To serialize access to mount */
 #define MOUNTED_LOCK	_PATH_MOUNTED "~"	/* mounts' lock file */
 #define MTAB_NOTUPDATED 0x1000			/* mtab succeded but not updated */
@@ -121,6 +122,7 @@ struct autofs_point {
 };
 
 extern struct autofs_point ap; 
+const char *path_mounted;
 
 /* Standard function used by daemon or modules */
 
diff --git a/lib/cache.c b/lib/cache.c
index 0f71fe2..c774dc0 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -268,7 +268,7 @@ int cache_delete(const char *root, const
 	if (!path)
 		return CHE_FAIL;
 
-	if (is_mounted(_PATH_MOUNTED, path)) {
+	if (is_mounted(path_mounted, path)) {
 		free(path);
 		return CHE_FAIL;
 	}
@@ -439,7 +439,7 @@ int cache_ghost(const char *root, int gh
 				break;
 
 			case LKP_MOUNT:
-				if (!is_mounted(_PATH_MOUNTED, gc.direct_base)) {
+				if (!is_mounted(path_mounted, gc.direct_base)) {
 					debug("cache_ghost: attempting to mount map, "
 					      "key %s",
 					      gc.direct_base);
diff --git a/lib/mounts.c b/lib/mounts.c
index 1e40fc1..1dacf14 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -294,7 +294,7 @@ int contained_in_local_fs(const char *pa
 	if (!path || !pathlen || pathlen > PATH_MAX)
 		return 0;
 
-	mnts = get_mnt_list(_PATH_MOUNTED, "/", 1);
+	mnts = get_mnt_list(path_mounted, "/", 1);
 	if (!mnts)
 		return 0;
 
@@ -309,13 +309,15 @@ int contained_in_local_fs(const char *pa
 			rv = statfs(this->path, &fs);
 			if (rv != -1 && fs.f_type == AUTOFS_SUPER_MAGIC)
 				ret = 1;
+			/* What is the below testing?  --JEM */
 			else if (this->fs_name[0] == '/') {
 				if (strlen(this->fs_name) > 1) {
 					if (this->fs_name[1] != '/')
 						ret = 1;
 				} else
 					ret = 1;
-			}
+			} else if (!strncmp(this->fs_name, "rootfs", 6))
+				ret = 1;
 			break;
 		}
 	}
@@ -357,7 +359,7 @@ int allow_owner_mount(const char *path)
 	struct mntent ent;
 	int ret = 0;
 
-	if (getuid() || is_mounted(_PATH_MOUNTED, path))
+	if (getuid() || is_mounted(path_mounted, path))
 		return 0;
 
 	if (find_mntent(_PATH_MNTTAB, path, &ent)) {
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index f0edb0a..08ae5f1 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -71,7 +71,7 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "fullpath=%s what=%s options=%s",
 		  fullpath, what, options);
 
-	if (is_mounted(_PATH_MOUNTED, fullpath)) {
+	if (is_mounted(path_mounted, fullpath)) {
 		error(MODPREFIX 
 		 "warning: about to mount over %s, continuing", fullpath);
 		return 0;
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 20ab7bf..fbf1546 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -121,7 +121,7 @@ int mount_mount(const char *root, const 
 		if (!status)
 			existed = 0;
 
-		if (is_mounted(_PATH_MOUNTED, fullpath)) {
+		if (is_mounted(path_mounted, fullpath)) {
 			error(MODPREFIX 
 			  "warning: %s is already mounted", fullpath);
 			return 0;
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index 38d67bf..b2efb96 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -69,7 +69,7 @@ int mount_mount(const char *root, const 
 	if (!status)
 		existed = 0;
 
-	if (is_mounted(_PATH_MOUNTED, fullpath)) {
+	if (is_mounted(path_mounted, fullpath)) {
 		error(MODPREFIX 
 		  "warning: %s is already mounted", fullpath);
 		return 0;
diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index b3179d6..0fe6a3d 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -68,7 +68,7 @@ int mount_mount(const char *root, const 
 	if (!status)
 		existed = 0;
 
-	if (is_mounted(_PATH_MOUNTED, fullpath)) {
+	if (is_mounted(path_mounted, fullpath)) {
 		error(MODPREFIX "warning: %s is already mounted", fullpath);
 		return 0;
 	}
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 3f9de50..c0546b9 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -596,7 +596,7 @@ #endif
 	if (!status)
 		existed = 0;
 
-	if (is_mounted(_PATH_MOUNTED, fullpath)) {
+	if (is_mounted(path_mounted, fullpath)) {
 		error(MODPREFIX 
 		      "warning: %s is already mounted", fullpath);
 		return 0;
