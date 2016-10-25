From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/37] autofs-5.1.2 - Fix fgets(3) size argument (another
 one)
Date: Tue, 25 Oct 2016 09:18:29 +0800
Message-ID: <20161025011829.7778.27892.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=xmcUgn7sCIPna2gk5zDKAn1TQEA=; b=YzCl9rKQTUAbOb8VXM
        n34FjonuRhXnNCxUX0nchmfWHojWRYC7PurebWkwymYMZSsXyAGlyiTEivSue2LO
        7AAvPdekwdYUxsRFjA5T3QF7hC9JeTlO8gsPKy78lRIhFKRUbwuIjb/tbYU3RUpX
        jiiYeaXy8Dalu+Ebi98rCyxRg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=xmcUgn7sCIPna2gk5zDKAn
        1TQEA=; b=C74TOCXYrD/wFitvZpQQOeQMqvtIOm8+/U83HpIMzGSqqr7EWTmIYs
        c3luHRaDqoazN4ZW18iwgacB4IqUmAETZWQxRjDIQBAKCQ7UDiI2vhYzMXNJCJWU
        wwHBfps5xIqR5vvZEDX1ZaZcItH8h6C/GylkPQJk5qbM1lvfUX/Ok=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

1. fgets(3) reads at most 1 less then the size argument.
2. Each line of /proc/filesystem isn't a filesystem path.

So it doesn't really matter if the size argument is PATH_MAX-1
or PATH_MAX (=sizeof(buf)) as long as the buffer is large enough.
We can just use sizeof(buf).

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 daemon/module.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index a0a2c46..28e857f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -11,6 +11,7 @@ xx/xx/2016 autofs-5.1.3
 - fix file map changed check.
 - Remove unused local 2KB buffer.
 - Fix typos in error messages.
+- Fix fgets(3) size argument (another one).
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/module.c b/daemon/module.c
index db01db8..8879b64 100644
--- a/daemon/module.c
+++ b/daemon/module.c
@@ -38,7 +38,7 @@ int load_autofs4_module(void)
 		return 0;
 	}
 
-	while (fgets(buf, PATH_MAX - 1, fp)) {
+	while (fgets(buf, sizeof(buf), fp)) {
 		if (strstr(buf, "autofs")) {
 			fclose(fp);
 			return 1;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
