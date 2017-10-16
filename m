From: Ian Kent <raven@themaw.net>
Subject: [PATCH 25/35] autofs-5.1.3 - make spawn_bind_mount() use mount_wait
 as well
Date: Mon, 16 Oct 2017 13:08:36 +0800
Message-ID: <150813051597.25695.2637010152311337461.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The spawn_bind_mount() waits forever for mount completion regardless
of the configuration setting of mount_wait.

Make spawn_bind_mount() use the mount_wait setting in the same way
the spawn_mount() finction does.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/spawn.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 90d06d59..6a18fd15 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -23,6 +23,7 @@ xx/xx/2017 autofs-5.1.4
 - allow dot in OPTIONSTR value lexer pattern.
 - fix autofs_use_lofs description.
 - fix amd parser error buffer size.
+- make spawn_bind_mount() use mount_wait as well.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index b931d678..7c56ba7b 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -501,6 +501,7 @@ int spawn_bind_mount(unsigned logopt, ...)
 	unsigned int options;
 	unsigned int retries = MTAB_LOCK_RETRIES;
 	int update_mtab = 1, ret, printed = 0;
+	unsigned int wait = defaults_get_mount_wait();
 	char buf[PATH_MAX + 1];
 
 	/* If we use mount locking we can't validate the location */
@@ -547,7 +548,7 @@ int spawn_bind_mount(unsigned logopt, ...)
 	va_end(arg);
 
 	while (retries--) {
-		ret = do_spawn(logopt, -1, options, prog, (const char **) argv);
+		ret = do_spawn(logopt, wait, options, prog, (const char **) argv);
 		if (ret == MTAB_NOTUPDATED) {
 			struct timespec tm = {3, 0};
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
