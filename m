From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] autofs: use flexible array in ioctl structure
Date: Tue, 23 May 2023 10:19:35 +0200
Message-ID: <20230523081944.581710-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684829991;
        bh=A0k4JoNWJBA9S3JzueEEL26tq0QQWLvGW3XSCqvpSaY=;
        h=From:To:Cc:Subject:Date:From;
        b=svMPzrcZ6aqyEWn8O2IwjO0F19CyCKHU+2VvTS3vLA35lKrR1Rj7g1nOkSYQfqXkq
         AHZ4fk1U+MLZRJkaYM7Y1uisI2+9NMOQAS6psMa1n+zL3Fs/+HaJ/hAlyWwg3cHTEi
         0sqJZGXDmtmxte3YKS83p1nLC3lT3P8PM95nHBUlItFR99DoXSCfcEevj1Hi9/p/nT
         jK63u7aP3cky+U2AyDyqFB1KhcIL6E7S7M89yRrPifJJSwZxBj7dtHqY8MJLUeDuOw
         C4FBNhvGliAabn0RsZB3k/vVZC2n//vlhwxA19Zs+YpIZvSJeYEn75F+ag8Qy00wHm
         UtQ1L2X6SG4vw==
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") introduced a warning
for the autofs_dev_ioctl structure:

In function 'check_name',
    inlined from 'validate_dev_ioctl' at fs/autofs/dev-ioctl.c:131:9,
    inlined from '_autofs_dev_ioctl' at fs/autofs/dev-ioctl.c:624:8:
fs/autofs/dev-ioctl.c:33:14: error: 'strchr' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
   33 |         if (!strchr(name, '/'))
      |              ^~~~~~~~~~~~~~~~~
In file included from include/linux/auto_dev-ioctl.h:10,
                 from fs/autofs/autofs_i.h:10,
                 from fs/autofs/dev-ioctl.c:14:
include/uapi/linux/auto_dev-ioctl.h: In function '_autofs_dev_ioctl':
include/uapi/linux/auto_dev-ioctl.h:112:14: note: source object 'path' of size 0
  112 |         char path[0];
      |              ^~~~

This is easily fixed by changing the gnu 0-length array into a c99
flexible array. Since this is a uapi structure, we have to be careful
about possible regressions but this one should be fine as they are
equivalent here. While it would break building with ancient gcc versions
that predate c99, it helps building with --std=c99 and -Wpedantic builds
in user space, as well as non-gnu compilers. This means we probably
also want it fixed in stable kernels.

Cc: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/filesystems/autofs-mount-control.rst | 2 +-
 Documentation/filesystems/autofs.rst               | 2 +-
 include/uapi/linux/auto_dev-ioctl.h                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs-mount-control.rst b/Documentation/filesystems/autofs-mount-control.rst
index bf4b511cdbe8..b5a379d25c40 100644
--- a/Documentation/filesystems/autofs-mount-control.rst
+++ b/Documentation/filesystems/autofs-mount-control.rst
@@ -196,7 +196,7 @@ information and return operation results::
 		    struct args_ismountpoint	ismountpoint;
 	    };
 
-	    char path[0];
+	    char path[];
     };
 
 The ioctlfd field is a mount point file descriptor of an autofs mount
diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 4f490278d22f..3b6e38e646cd 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -467,7 +467,7 @@ Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure::
 			struct args_ismountpoint	ismountpoint;
 		};
 
-                char path[0];
+                char path[];
         };
 
 For the **OPEN_MOUNT** and **IS_MOUNTPOINT** commands, the target
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 62e625356dc8..08be539605fc 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -109,7 +109,7 @@ struct autofs_dev_ioctl {
 		struct args_ismountpoint	ismountpoint;
 	};
 
-	char path[0];
+	char path[];
 };
 
 static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
-- 
2.39.2

