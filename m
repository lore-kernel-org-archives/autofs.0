From: Ian Kent <raven@themaw.net>
Subject: [PATCH 16/37] autofs-5.1.2 - Avoid local variable name shadowing
 another
Date: Tue, 25 Oct 2016 09:18:50 +0800
Message-ID: <20161025011850.7778.3154.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=q5jvYG+eJDD7HXXpjIj3wZEmf0I=; b=HPAxtbFgg+iFBQxpgO
        Ex4c0cNVweYyURPzPFWgH559iEKY+l4mdenk1hTK8IpcHISc8t+bWpJIPnPRE1nL
        YsQUezUXFGx6yhkerKM0eDuVUBhmCirpzYdw7g9ROyMzSOwAupitlrtqKch/kQj5
        iv2eeY/tKnotvp9TUGKXf6LzM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=q5jvYG+eJDD7HXXpjIj3wZ
        Emf0I=; b=BP7p5/qlSCf4GIb+v7pkpC35OuofIbpObgn3/QBDnUwGLmbxEEDMNR
        ZgOLC780Ga1WYKRxeVQkHHp282ztZeaaN9WZp+8QtgM7v3tUYGd7flKPUf0cdoKC
        WAleygi3cvELk837lMaNm0I8dTAgYuzQVeTLLHIyZa/V1RVrC2j4A=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

There are two local variabls int ret, and the one in the
inner scope doesn't need to be named as int ret.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index ec1812a..853d40c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -15,6 +15,7 @@ xx/xx/2016 autofs-5.1.3
 - fix short memory allocation in lookup_amd_instance().
 - fix count_mounts() function.
 - configure: add cache variable for Linux proc filesystem check.
+- Avoid local variable name shadowing another.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 8d98054..9d4c2b7 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -310,17 +310,13 @@ static int walk_tree(const char *base, int (*fn) (struct autofs_point *ap,
 				return -1;
 
 			while (n--) {
-				int ret, size;
-
 				if (strcmp(de[n]->d_name, ".") == 0 ||
 				    strcmp(de[n]->d_name, "..") == 0) {
 					free(de[n]);
 					continue;
 				}
 
-				size = sizeof(buf);
-				ret = cat_path(buf, size, base, de[n]->d_name);
-				if (!ret) {
+				if (!cat_path(buf, sizeof(buf), base, de[n]->d_name)) {
 					do {
 						free(de[n]);
 					} while (n--);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
