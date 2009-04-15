From: Ian Kent <raven@themaw.net>
Subject: Re: Strange behavior of autofs with reiserfs on expire
Date: Wed, 15 Apr 2009 16:15:25 +0800
Message-ID: <20090415081524.GA7194@zeus.themaw.net>
References: <gs2khi$f5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <gs2khi$f5$1@ger.gmane.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Sergei Zhirikov <sfzhi@yahoo.com>
Cc: autofs@linux.kernel.org

On Tue, Apr 14, 2009 at 08:26:57PM +0200, Sergei Zhirikov wrote:
> 
> Can anyone, please, try to reproduce the problem?

Yep, did that.

How stupid of me to assume all file systems would set the super block
magic number to a non-zero value. Or maybe it isn't me who has done
something stupid this time, ;)

The patch below seems to fix this.
The CHANGELOG hunk won't apply of course but the other hunks should
be OK.

Ian

autofs-5.0.4 - zero s_magic is valid

From: Ian Kent <raven@themaw.net>

When checking the super magic using the mount control ioctl
re-implementation an incorrect assumption is made that s_magic
field in the super block will not be zero.
---

 CHANGELOG           |    1 +
 lib/dev-ioctl-lib.c |   10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index 50bfca8..8254eb5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -38,6 +38,7 @@
 - fix memory leak reading master map.
 - fix st_remove_tasks() locking.
 - reset flex scanner when setting buffer.
+- zero s_magic is valid.
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/lib/dev-ioctl-lib.c b/lib/dev-ioctl-lib.c
index 7c8c433..a034a3d 100644
--- a/lib/dev-ioctl-lib.c
+++ b/lib/dev-ioctl-lib.c
@@ -764,12 +764,10 @@ static int dev_ioctl_ismountpoint(unsigned int logopt,
 	if (err) {
 		*mountpoint = DEV_IOCTL_IS_MOUNTED;
 
-		if (param->ismountpoint.out.magic) {
-			if (param->ismountpoint.out.magic == AUTOFS_SUPER_MAGIC)
-				*mountpoint |= DEV_IOCTL_IS_AUTOFS;
-			else
-				*mountpoint |= DEV_IOCTL_IS_OTHER;
-		}
+		if (param->ismountpoint.out.magic == AUTOFS_SUPER_MAGIC)
+			*mountpoint |= DEV_IOCTL_IS_AUTOFS;
+		else
+			*mountpoint |= DEV_IOCTL_IS_OTHER;
 	}
 
 	free_dev_ioctl_path(param);
