From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/20] autofs-5.1.4 - fix flag file permission
Date: Wed, 14 Feb 2018 14:42:57 +0800
Message-ID: <151859057773.8026.6719354511090927498.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The flag file used to check if automount(8) is running was being
created with mode 0 which caused unnecessary dac_override AVC
failures.

There's no reason to protect this file so just use 0644 as the
file permission.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG     |    3 +++
 daemon/flag.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 246279ae..d07d88ce 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,6 @@
+xx/xx/2018 autofs-5.1.5
+- fix flag file permission.
+
 19/12/2017 autofs-5.1.4
 - fix spec file url.
 - fix unset tsd group name handling.
diff --git a/daemon/flag.c b/daemon/flag.c
index 99f26847..ff9858c8 100644
--- a/daemon/flag.c
+++ b/daemon/flag.c
@@ -164,7 +164,7 @@ int aquire_flag_file(void)
 	while (!we_created_flagfile) {
 		int errsv, i, j;
 
-		i = open_fd_mode(linkf, O_WRONLY|O_CREAT, 0);
+		i = open_fd_mode(linkf, O_WRONLY|O_CREAT, 0644);
 		if (i < 0) {
 			release_flag_file();
 			return 0;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
