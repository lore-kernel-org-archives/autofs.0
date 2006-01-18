From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/13] autofs4 - increase module version
Date: Wed, 18 Jan 2006 15:24:40 +0800
Message-ID: <200601180724.k0I7OeCg006219@eagle.themaw.net>
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>

Update autofs4 version.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-rc1/include/linux/auto_fs4.h.version-bump	2005-12-10 13:56:03.000000000 +0800
+++ linux-2.6.15-rc1/include/linux/auto_fs4.h	2005-12-10 13:55:08.000000000 +0800
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	4
 
-#define AUTOFS_PROTO_SUBVERSION		7
+#define AUTOFS_PROTO_SUBVERSION		10
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
