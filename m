From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/37] autofs-5.1.2 - fix _strncmp() usage
Date: Tue, 25 Oct 2016 09:19:11 +0800
Message-ID: <20161025011911.7778.15436.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=EMhjbtzjde+L+wVxzmvQ+qxVuCg=; b=a9KRUGsyefDkmxpxiX
        6XrIirNZET0E1OIj/OD/CViE3XI4U1QaV/KDdUQ2xh/xqbmu4uCITMKlWT7hGjp3
        qWyziUqiB7XlBU3/WQ5OKer4j3YGJkkl6rMKAWQsHAmis6+V+Rgpzifo0+wM/ZlT
        7FswrgNyEBhWreadzznuHiFKA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=EMhjbtzjde+L+wVxzmvQ+q
        xVuCg=; b=tLWwowde54qapiGxgE5qRnuuyqv/tyP62x+GRm8+1kqD0bH+b13WAg
        BDvlhe8Wq5KRzJOBAAWX1Mi55bs6eOi+zcQnofO+4lq3zxklkAMe5/t07RmcYSeo
        bvPVQ9IbtlId9twyV8p04sIFmm1Q5sZ4swoQK9imsosIa0imcFjhs=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

A change to fix nfs mount options changed to using a custom strncmp()
function.

While the usage of the function is correct in the nfs and bind mount
modules it isn't correct in the autofs and ext2 mount modules.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 modules/mount_autofs.c |   12 ++++++------
 modules/mount_ext2.c   |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index f46428c..940c6ba 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -17,6 +17,7 @@ xx/xx/2016 autofs-5.1.3
 - configure: add cache variable for Linux proc filesystem check.
 - Avoid local variable name shadowing another.
 - fix argc off by one in mount_autofs.c.
+- fix _strncmp() usage.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 65c0a06..0476a09 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -121,17 +121,17 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			while (*comma != '\0' && *comma != ',')
 				comma++;
 
-			if (_strncmp(cp, "nobrowse", 8) == 0)
+			if (_strncmp("nobrowse", cp, 8) == 0)
 				ghost = 0;
-			else if (_strncmp(cp, "nobind", 6) == 0)
+			else if (_strncmp("nobind", cp, 6) == 0)
 				nobind = 1;
-			else if (_strncmp(cp, "browse", 6) == 0)
+			else if (_strncmp("browse", cp, 6) == 0)
 				ghost = 1;
-			else if (_strncmp(cp, "symlink", 7) == 0)
+			else if (_strncmp("symlink", cp, 7) == 0)
 				symlnk = 1;
-			else if (_strncmp(cp, "hosts", 5) == 0)
+			else if (_strncmp("hosts", cp, 5) == 0)
 				hosts = 1;
-			else if (_strncmp(cp, "timeout=", 8) == 0) {
+			else if (_strncmp("timeout=", cp, 8) == 0) {
 				char *val = strchr(cp, '=');
 				unsigned tout;
 				if (val) {
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index c00e3d5..90fc087 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -82,7 +82,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 	if (options && options[0]) {
 		for (p = options; (p1 = strchr(p, ',')); p = p1)
-			if (!_strncmp(p, "ro", p1 - p) && ++p1 - p == sizeof("ro"))
+			if (!_strncmp("ro", p, p1 - p) && ++p1 - p == sizeof("ro"))
 				ro = 1;
 		if (!strcmp(p, "ro"))
 			ro = 1;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
