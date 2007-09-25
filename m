From: Matthias Koenig <mkoenig@suse.de>
Subject: [PATCH] nested mounts with loop
Date: Tue, 25 Sep 2007 18:21:19 +0200
Message-ID: <n7xir5ybts0.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>

Hi,

we noticed a problem concerning loop mounts on locations that 
have to be mounted before. E.g. consider the following situation,
a NFS server exporting a cd image, which we want to loop mount
locally to get access to the content:

auto.master:
/cdimage        auto.cdimage
/cdcontent      auto.cdcontent

auto.cdimage:
foo             nfsserver:/cdimage/foo.img

auto.cdcontent:
foo             -fstype=auto,loop       :/cdimage/foo/foo.img

The access to /cdcontent/foo will fail, when /cdimage/foo is not 
mounted before, because spawn_mount does not use SPAWN_OPT_ACCESS
in this case.
The patch below fixes this problem.

Matthias

Index: autofs-git20070924/daemon/spawn.c
===================================================================
--- autofs-git20070924.orig/daemon/spawn.c
+++ autofs-git20070924/daemon/spawn.c
@@ -293,6 +293,13 @@ int spawn_mount(logger *log, ...)
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
+#ifndef ENABLE_MOUNT_LOCKING
+	/* validate loop mounts as they could be on some location to be
+	 * mounted first */
+	if (!strcmp(argv[4], "-o") && strstr(argv[5], "loop"))
+		options = SPAWN_OPT_ACCESS;
+#endif
+
 	while (retries--) {
 		ret = do_spawn(log, options, prog, (const char **) argv);
 		if (ret & MTAB_NOTUPDATED)
