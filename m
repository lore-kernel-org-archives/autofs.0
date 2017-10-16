From: Ian Kent <raven@themaw.net>
Subject: [PATCH 19/35] autofs-5.1.3 - also check flag file exe name
Date: Mon, 16 Oct 2017 13:07:55 +0800
Message-ID: <150813047531.25695.7074710238580737551.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

automount(8) uses a flag file if it needs to check for multiple
invocations of itself at startup.

The check to see if a flag file is owned by an existing automount(8)
process can return a false positive because it doesn't also check the
name of the executable of the given pid.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Doron Cohen <doron@weka.io>
---
 CHANGELOG     |    1 +
 daemon/flag.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index af8b099c..1b5c69ee 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -17,6 +17,7 @@ xx/xx/2017 autofs-5.1.4
 - add some more debug logging to get_nfs_info().
 - add some more debug logging to get_supported_ver_and_cost().
 - fix ipv6 proto option handling.
+- also check flag file exe name.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/flag.c b/daemon/flag.c
index db9a4bde..99f26847 100644
--- a/daemon/flag.c
+++ b/daemon/flag.c
@@ -33,12 +33,43 @@
 #define MAX_PIDSIZE	20
 #define FLAG_FILE	AUTOFS_FLAG_DIR "/autofs-running"
 
+#define EXE_SELF	"/proc/self/exe"
+#define EXE_PID		"/proc/%u/exe"
+
 /* Flag for already existing flag file. */
 static int we_created_flagfile = 0;
 
 /* file descriptor of flag file */
 static int fd = -1;
 
+static int check_pid_exe_name(pid_t pid)
+{
+	char self_name[PATH_MAX + 1];
+	char pid_name[PATH_MAX + 1];
+	char exe_pid[MAX_PIDSIZE + 1];
+	int len, ret = 0;
+
+	len = readlink(EXE_SELF, self_name, PATH_MAX);
+	if (len == -1 || len == PATH_MAX)
+		goto out;
+	else
+		self_name[len] = 0;
+
+	len = snprintf(exe_pid, MAX_PIDSIZE, EXE_PID, pid);
+	if (len >= MAX_PIDSIZE)
+		goto out;
+
+	len = readlink(exe_pid, pid_name, PATH_MAX);
+	if (len == -1 || len == PATH_MAX)
+		goto out;
+	else
+		pid_name[len] = 0;
+
+	ret = !strcmp(self_name, pid_name);
+out:
+	return ret;
+}
+
 static int flag_is_owned(int fd)
 {
 	int pid = 0, tries = 3;
@@ -83,6 +114,10 @@ static int flag_is_owned(int fd)
 		 */
 		if (ret == -1 && errno == ESRCH)
 			return 0;
+
+		/* If there is a process check if it is automount */
+		if (!check_pid_exe_name(pid))
+			return 0;
 	} else {
 		/*
 		 * Odd, no pid in file - so what should we do?

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
