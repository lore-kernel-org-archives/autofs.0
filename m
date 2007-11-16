From: "=?ISO-8859-1?Q?Sonni_N=F8rl=F8v?=" <sonni.norlov@gmail.com>
Subject: patch: unable to mount a nested path on a readonly
	exported path
Date: Fri, 16 Nov 2007 23:01:35 +0100
Message-ID: <b103bf540711161401x6691a9c3g1fff7ec93c597728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Hi,

Having nested exports like:

/export (ro)
/export/data/share (rw)

and running autofs 4.1.3, on gentoo 4.1.3.-r7 with Xen kernel 2.6.20
the automounter manages to mount /export but fails when mounting
/export/data/share with an error like "Read-only filesystem" during
its mkdir_path call.

To fix this the mkdir_path must accept that when a directory exist
read-only or not on the server it is still an existing directory.
Below is the patch for this.

Another note: why does mkdir_path return errno and not just a single
return code stating yes or no ?

regards

Sonni


--- autofs-4.1.3/daemon/automount.c.org 2007-11-16 21:54:25.000000000 +0100
+++ autofs-4.1.3/daemon/automount.c     2007-11-16 21:55:38.000000000 +0100
@@ -94,12 +94,13 @@
                        *bp = '\0';
                        if (mkdir(buf, mode) == -1) {
                                /* If it already exists, make sure
it's a directory */
-                               if (errno == EEXIST) {
+                               if (errno == EEXIST || errno == EROFS) {
                                        struct stat st;

                                        if (stat(buf, &st) == 0 &&
!S_ISDIR(st.st_mode))
                                                errno = ENOTDIR;
                                        else {
+                                               errno = EEXIST;
                                                /* last component, return -1 */
                                                if (*cp != '\0')
                                                        continue;
