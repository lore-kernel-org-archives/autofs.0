From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/20] autofs-5.1.4 - dont allow trailing slash in master
 map mount points
Date: Wed, 14 Feb 2018 14:44:10 +0800
Message-ID: <151859065065.8026.6740815327574732259.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If a master map mount point path has a trailing '/' this can cause
problems so remove them at parse time.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 lib/master_parse.y |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 1e5ec15b..a7bb89dc 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -12,6 +12,7 @@ xx/xx/2018 autofs-5.1.5
 - use_hostname_for_mounts shouldn't prevent selection among replicas.
 - fix monotonic_elapsed.
 - Makefiles.rules: remove 'samples' from SUBDIRS.
+- dont allow trailing slash in master map mount points.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/lib/master_parse.y b/lib/master_parse.y
index 42e03c2d..761ade9b 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -749,6 +749,7 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 	struct map_source *source;
 	unsigned int logopt = logging;
 	unsigned int m_logopt = master->logopt;
+	size_t mp_len;
 	int ret;
 
 	local_init_vars();
@@ -763,6 +764,10 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 		return 0;
 	}
 
+	mp_len = strlen(path);
+	while (mp_len && path[--mp_len] == '/')
+		path[mp_len] = 0;
+
 	nc = master->nc;
 
 	/* Add null map entries to the null map cache */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
