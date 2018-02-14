From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/20] autofs-5.1.4 - fix deadlock in dumpmaps
Date: Wed, 14 Feb 2018 14:43:14 +0800
Message-ID: <151859059427.8026.12144677606815148164.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Commit a223d11fa8e (autofs-5.1.3 - serialize calls to open_xxxx()
functions) introduces a deadlock when using the dumpmaps function.

In this case the open fd mutex needs to be unlocked in the forked
child process of the do_spawn() function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 daemon/spawn.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 2747327b..0f30596f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -2,6 +2,7 @@ xx/xx/2018 autofs-5.1.5
 - fix flag file permission.
 - fix directory create permission.
 - fix use after free in do_master_list_reset().
+- fix deadlock in dumpmaps.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/daemon/spawn.c b/daemon/spawn.c
index fabe577e..dbbca7fa 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -338,6 +338,7 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 		dup2(pipefd[1], STDOUT_FILENO);
 		dup2(pipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
+		open_mutex_unlock();
 
 		/* what to mount must always be second last */
 		while (*pargv++)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
