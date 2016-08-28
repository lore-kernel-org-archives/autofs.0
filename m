From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 1/3] autofs: remove possibly misleading /* #define DEBUG */
Date: Sun, 28 Aug 2016 13:05:57 +0900
Message-ID: <1472357159-1871-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BqyycUcBfXZPVrQFXZcJ6lp1TBH7E0fS7ELSe9OXnEE=;
        b=nep5F2+0pgrVLY2T7Gx+Qa2zLUPC+xJhDDvaxoW/DgkCcOTCH1fLMdJCzslkUImHYS
         3/WGDWGw2aBGRHK5W5nE4NdAXFnFFIl3BAsZClqb/FAHfLs4rYoZbUTRvdfiom8hJFOm
         sRnoWlWyQaErj1DneFI3+p3mo+O6vnp6wGojnrPjM0JfFpb9iB1PYK9lDi3YXGT+cSD4
         agXCPfmObkZH6JMEZ9v5kQ0qOBPao0gEu+HjnLhEauzzDt/IpKcHQBqsW46m0y5DMTPX
         RZepmRqkWDb1jIZBT8yKBz/Gep2wiaE3KBOF0LWxiILQz8n3Y2XFdsEaG0yinTja5wVV
         dfTA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Having this in autofs_i.h gives illusion that uncommenting this
enables pr_debug(), but it doesn't enable all the pr_debug() in
autofs because inclusion order matters.

XFS has the same DEBUG macro in its core header fs/xfs/xfs.h,
however XFS seems to have a rule to include this prior to other
XFS headers as well as kernel headers. This is not the case with
autofs, and DEBUG could be enabled via Makefile, so autofs should
just get rid of this comment to make the code less confusing.
It's a comment, so there is literally no functional difference.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index dd71bd4..4404a22 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -34,8 +34,6 @@
 #include <asm/current.h>
 #include <linux/uaccess.h>
 
-/* #define DEBUG */
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
