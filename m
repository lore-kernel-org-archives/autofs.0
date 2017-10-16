From: Ian Kent <raven@themaw.net>
Subject: [PATCH 26/35] autofs-5.1.3 - document ghost option in auto.master
 man page
Date: Mon, 16 Oct 2017 13:08:42 +0800
Message-ID: <150813052207.25695.16615651390055095096.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The --ghost pseudo option has been depricated for quite a while now
in favour of the browse option as descibed in auto.master(5).

However it isn't noted in the description of the browse option that
the --ghost option is the same as the browse option.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 man/auto.master.5.in |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6a18fd15..7457e620 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -24,6 +24,7 @@ xx/xx/2017 autofs-5.1.4
 - fix autofs_use_lofs description.
 - fix amd parser error buffer size.
 - make spawn_bind_mount() use mount_wait as well.
+- document ghost option in auto.master man page.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index c87fb7f4..4475186a 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -168,7 +168,8 @@ can cause performance problem if the indirect map is large so it should
 be used with caution. The internal program default is to enable browse
 mode for indirect mounts but the default installed configuration overrides
 this by setting BROWSE_MODE to "no" because of the potential performance
-problem.
+problem. This option does the same as the depricated --ghost option, the
+browse option is preferred because it is used by other autofs implementations.
 .TP
 .I "nobind"
 This is an autofs specific option that is a pseudo mount option and

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
