From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Missing spin_lock(&dcache_lock)
Date: Mon, 11 Jan 2010 09:52:57 -0200
Message-ID: <20100111115257.GA3211@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=ziQSSL2b//1/UZVX/56x8oq0rG6GvpNQmk44I1EbEj8=;
	b=MMU/yTrocr20jtVpSjyea7riYHuD8FswIQ0eBB4wWWixlPUhJaQY0IIT4oCMP93rWu
	t3fkcLKiTz+qMaARBKSIHZLGShXIi8Y8+p8v57J9PS57XW9Ws4X9XAQVvqJAH5AHKxv+
	t5QPsGs+qgz2qQ4ZRg+VipIkNIKYRKohccaMY=
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello,

If I compare the 2.6.18 and 2.6.20 kernel trees after applying,
respectively, autofs4-2.6.18-v5-update-20090903.patch and
autofs4-2.6.20-v5-update-20090903.patch, I can understand most of the
differences, but this specific chunk seems strange to me:

diff -Nurp linux-2.6.18.8/fs/autofs4/root.c linux-2.6.20.21/fs/autofs4/root.c
--- linux-2.6.18.8/fs/autofs4/root.c	2010-01-08 13:34:35.000000000 -0200
+++ linux-2.6.20.21/fs/autofs4/root.c	2010-01-11 09:00:28.000000000 -0200
@@ -91,6 +91,7 @@ static int autofs4_dir_open(struct inode
 	 * autofs file system so just let the libfs routines handle
 	 * it.
 	 */
+	spin_lock(&dcache_lock);
 	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
 		spin_unlock(&dcache_lock);
 		return -ENOENT;

Was this line left out by mistake? If yes, can you please consider the patch
below?

Thanks,
Leonardo

Index: autofs/patches/autofs4-2.6.18-v5-update-20090903.patch
===================================================================
--- autofs.orig/patches/autofs4-2.6.18-v5-update-20090903.patch
+++ autofs/patches/autofs4-2.6.18-v5-update-20090903.patch
@@ -103,6 +103,7 @@
 +	 * autofs file system so just let the libfs routines handle
 +	 * it.
 +	 */
++	spin_lock(&dcache_lock);
 +	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
  		spin_unlock(&dcache_lock);
 -
Index: autofs/patches/autofs4-2.6.19-v5-update-20090903.patch
===================================================================
--- autofs.orig/patches/autofs4-2.6.19-v5-update-20090903.patch
+++ autofs/patches/autofs4-2.6.19-v5-update-20090903.patch
@@ -1041,6 +1041,7 @@
 +	 * autofs file system so just let the libfs routines handle
 +	 * it.
 +	 */
++	spin_lock(&dcache_lock);
 +	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
  		spin_unlock(&dcache_lock);
 -
