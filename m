From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] allow for run-time setting of log priority
Date: Thu, 13 Sep 2007 17:42:51 -0400
Message-ID: <x49642ep7hg.fsf@segfault.boston.devel.redhat.com>
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
To: autofs@linux.kernel.org

Hi, Ian, list,

This patch allows one to set the logging priority of the automount
daemon at run-time.  The rationale behind this change is that
customers will somtimes run into problems after days or weeks of
runtime.  At this point, restarting the automounter to enable debug
logging will make the problem disappear (as we lose all run-time
state).  So, this patch implements a *very* simple ascii protocol for
enabling and disabling debug logging in the daemon, per mount-point.

I've included an update to the automount.8 man page which documents
the newly added parameter to the automount daemon.  To enable
debugging on /net, one can do the following:

automount --set-log-priority debug /net

If you want to enable it on several mount points, just list them all:

automount --set-log-priority debug /net /misc

If you suffer from repetitive stress injuries, try:

automount -l 7 /net /misc

it does the same thing.  Yep, I thought of everything!  (That
statement will come back to bite me!)

Happy hacking!

Jeff

diff --git a/daemon/automount.c b/daemon/automount.c
index 4b6584a..fe29cd0 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -650,18 +650,206 @@ static int fullread(int fd, void *ptr, size_t len)
 	return len;
 }
 
+static char *automount_path_to_fifo(const char *path)
+{
+	char *fifo_name, *p;
+	int  name_len = strlen(path) + strlen(AUTOFS_LOGPRI_FIFO) + 1;
+	int ret;
+
+	fifo_name = malloc(name_len);
+	if (!fifo_name)
+		return NULL;
+	ret = snprintf(fifo_name, name_len, "%s%s",
+		       AUTOFS_LOGPRI_FIFO, path);
+	if (ret >= name_len) {
+		warn(LOGOPT_NONE,
+		     "fifo path for \"%s\" truncated to \"%s\".  This may "
+		     "lead to --set-log-priority commands being sent to the "
+		     "wrong automount daemon.\n", path, fifo_name);
+	}
+
+	/*
+	 *  An automount path can be made up of subdirectories.  So, to
+	 *  create the fifo name, we will just replace instances of '/' with
+	 *  '-'. 
+	 */
+	p = fifo_name + strlen(AUTOFS_LOGPRI_FIFO);
+	while (*p != '\0') {
+		if (*p == '/')
+			*p = '-';
+		p++;
+	}
+
+	debug(LOGOPT_NONE, "%s: fifo name %s\n", __FUNCTION__, fifo_name);
+	return fifo_name;
+}
+
+static int create_logpri_fifo(struct autofs_point *ap)
+{
+	int ret = -1;
+	int fd;
+	char *fifo_name;
+
+	fifo_name = automount_path_to_fifo(ap->path);
+	if (!fifo_name) {
+		crit(ap->logopt, "%s: Failed to allocate memory!\n",
+		     __FUNCTION__);
+		goto out_free; /* free(NULL) is okay */
+	}
+
+	ret = unlink(fifo_name);
+	if (ret != 0 && errno != ENOENT) {
+		crit(ap->logopt,
+		     "%s: Failed to unlink FIFO.  Is the automount daemon "
+		     "already running?\n", __FUNCTION__);
+		goto out_free;
+	}
+
+	ret = mkfifo(fifo_name, S_IRUSR|S_IWUSR);
+	if (ret != 0) {
+		crit(ap->logopt, "%s: mkfifo for %s returned %d\n",
+		     __FUNCTION__, fifo_name, errno);
+		goto out_free;
+	}
+
+	fd = open(fifo_name, O_RDWR|O_NONBLOCK);
+	if (fd < 0) {
+		crit(ap->logopt, "%s: Failed to open %s, errno %d\n",
+		     __FUNCTION__, fifo_name, errno);
+		goto out_free;
+	}
+
+	ap->logpri_fifo = fd;
+
+out_free:
+	free(fifo_name);
+	return ret;
+}
+
+static void handle_fifo_message(struct autofs_point *ap, int fd)
+{
+	int ret;
+	char buffer[PIPE_BUF];
+	char *end;
+	long pri;
+
+	memset(buffer, 0, sizeof(buffer));
+	ret = read(fd, &buffer, sizeof(buffer));
+	if (ret < 0) {
+		warn(ap->logopt, "%s: read on fifo returned error %d\n",
+		     __FUNCTION__, errno);
+		return;
+	}
+
+	if (ret != 2) {
+		debug(ap->logopt, "%s: expected 2 bytes, received %d.\n",
+		      __FUNCTION__, ret);
+		return;
+	}
+
+	errno = 0;
+	pri = strtol(buffer, &end, 10);
+	if ((pri == LONG_MIN || pri == LONG_MAX) && errno == ERANGE) {
+		debug(ap->logopt, "%s: strtol reported an %s.  Failed to set "
+		      "log priority.\n", __FUNCTION__,
+		      pri == LONG_MIN ? "underflow" : "overflow");
+		return;
+	}
+	if ((pri == 0 && errno == EINVAL) || end == buffer) {
+		debug(ap->logopt, "%s: priority is expected to be an integer "
+		      "in the range 0-7 inclusive.\n", __FUNCTION__);
+		return;
+	}
+
+	if (pri > LOG_DEBUG || pri < LOG_EMERG) {
+		debug(ap->logopt, "%s: invalid log priority (%ld) received "
+		      "on fifo\n", __FUNCTION__, pri);
+		return;
+	}
+
+	/*
+	 * OK, the message passed all of the sanity checks.  The
+	 * automounter actually only supports two log priorities.
+	 * Everything at warning or above is only logged when
+	 * debugging is enabled.
+	 */
+	if (pri >= LOG_WARNING) {
+		ap->logopt = LOGOPT_ANY; /* enable debug and verbose */
+		info(ap->logopt, "Debug logging enabled.\n");
+	} else {
+		if (ap->logopt & LOGOPT_ANY)
+			crit(LOGOPT_ANY, "Debug logging disabled.\n");
+		ap->logopt &= LOGOPT_NONE;
+
+	}
+}
+
+static int set_log_priority(const char *path, int priority)
+{
+	int fd;
+	char *fifo_name;
+	char buf[2];
+
+	if (priority > LOG_DEBUG || priority < LOG_EMERG) {
+		fprintf(stderr, "Log priority %d is invalid.\n", priority);
+		fprintf(stderr, "Please spcify a number in the range 0-7.\n");
+		return -1;
+	}
+
+	/*
+	 * This is an ascii based protocol, so we want the string
+	 * representation of the integer log priority.
+	 */
+	snprintf(buf, sizeof(buf), "%d", priority);
+
+	fifo_name = automount_path_to_fifo(path);
+	if (!fifo_name) {
+		fprintf(stderr, "%s: Failed to allocate memory!\n",
+			__FUNCTION__);
+		return -1;
+	}
+
+	/*
+	 * Specify O_NONBLOCK so that the open will fail if there is no
+	 * daemon reading from the other side of the FIFO.
+	 */
+	fd = open(fifo_name, O_WRONLY|O_NONBLOCK);
+	if (fd < 0) {
+		fprintf(stderr, "%s: open of %s failed with %d\n",
+			__FUNCTION__, fifo_name, errno);
+		free(fifo_name);
+		return -1;
+	}
+
+	if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
+		fprintf(stderr, "Failed to change logging priority.  ");
+		fprintf(stderr, "write to fifo failed with errno %d.\n",
+			errno);
+		close(fd);
+		free(fifo_name);
+		return -1;
+	}
+	close(fd);
+	free(fifo_name);
+	fprintf(stdout, "Successfully set log priority.\n");
+
+	return 0;
+}
+
 static int get_pkt(struct autofs_point *ap, union autofs_packet_union *pkt)
 {
-	struct pollfd fds[2];
+	struct pollfd fds[3];
 	char buf[MAX_ERR_BUF];
 
 	fds[0].fd = ap->pipefd;
 	fds[0].events = POLLIN;
 	fds[1].fd = ap->state_pipe[0];
 	fds[1].events = POLLIN;
+	fds[2].fd = ap->logpri_fifo;
+	fds[2].events = POLLIN;
 
 	for (;;) {
-		if (poll(fds, 2, -1) == -1) {
+		if (poll(fds, 3, -1) == -1) {
 			char *estr;
 			if (errno == EINTR)
 				continue;
@@ -710,6 +898,11 @@ static int get_pkt(struct autofs_point *ap, union autofs_packet_union *pkt)
 
 		if (fds[0].revents & POLLIN)
 			return fullread(ap->pipefd, pkt, kpkt_len);
+
+		if (fds[2].revents & POLLIN) {
+			debug(LOGOPT_NONE, "message pending on control fifo.");
+			handle_fifo_message(ap, fds[2].fd);
+		}
 	}
 }
 
@@ -742,10 +935,81 @@ int do_expire(struct autofs_point *ap, const char *name, int namelen)
 	return ret;
 }
 
+static int autofs_init_ap(struct autofs_point *ap)
+{
+	int pipefd[2], cl_flags;
+
+	if ((ap->state != ST_INIT)) {
+		/* This can happen if an autofs process is already running*/
+		error(ap->logopt, "bad state %d", ap->state);
+		return -1;
+	}
+
+	ap->pipefd = ap->kpipefd = ap->ioctlfd = -1;
+
+	/* Pipe for kernel communications */
+	if (pipe(pipefd) < 0) {
+		crit(ap->logopt,
+		     "failed to create commumication pipe for autofs path %s",
+		     ap->path);
+		free(ap->path);
+		return -1;
+	}
+
+	ap->pipefd = pipefd[0];
+	ap->kpipefd = pipefd[1];
+
+	if ((cl_flags = fcntl(ap->pipefd, F_GETFD, 0)) != -1) {
+		cl_flags |= FD_CLOEXEC;
+		fcntl(ap->pipefd, F_SETFD, cl_flags);
+	}
+
+	if ((cl_flags = fcntl(ap->kpipefd, F_GETFD, 0)) != -1) {
+		cl_flags |= FD_CLOEXEC;
+		fcntl(ap->kpipefd, F_SETFD, cl_flags);
+	}
+
+	/* Pipe state changes from signal handler to main loop */
+	if (pipe(ap->state_pipe) < 0) {
+		crit(ap->logopt,
+		     "failed create state pipe for autofs path %s", ap->path);
+		close(ap->pipefd);
+		close(ap->kpipefd);	/* Close kernel pipe end */
+		free(ap->path);
+		return -1;
+	}
+
+	if ((cl_flags = fcntl(ap->state_pipe[0], F_GETFD, 0)) != -1) {
+		cl_flags |= FD_CLOEXEC;
+		fcntl(ap->state_pipe[0], F_SETFD, cl_flags);
+	}
+
+	if ((cl_flags = fcntl(ap->state_pipe[1], F_GETFD, 0)) != -1) {
+		cl_flags |= FD_CLOEXEC;
+		fcntl(ap->state_pipe[1], F_SETFD, cl_flags);
+	}
+
+	if (create_logpri_fifo(ap) < 0) {
+		crit(ap->logopt, "failed to create FIFO for path %s\n",
+		     ap->path);
+		close(ap->pipefd);
+		close(ap->kpipefd);
+		free(ap->path);
+		close(ap->state_pipe[0]);
+		close(ap->state_pipe[1]);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int mount_autofs(struct autofs_point *ap)
 {
 	int status = 0;
 
+	if (autofs_init_ap(ap) != 0)
+		return -1;
+
 	if (ap->type == LKP_DIRECT)
 		status = mount_autofs_direct(ap);
 	else
@@ -1456,9 +1720,45 @@ static void show_build_info(void)
 	return;
 }
 
+typedef struct _code {
+	char	*c_name;
+	int	c_val;
+} CODE;
+
+CODE prioritynames[] = {
+	{ "alert",	LOG_ALERT },
+	{ "crit",	LOG_CRIT },
+	{ "debug",	LOG_DEBUG },
+	{ "emerg",	LOG_EMERG },
+	{ "err",	LOG_ERR },
+	{ "error",	LOG_ERR },		/* DEPRECATED */
+	{ "info",	LOG_INFO },
+	{ "notice",	LOG_NOTICE },
+	{ "panic", 	LOG_EMERG },		/* DEPRECATED */
+	{ "warn",	LOG_WARNING },		/* DEPRECATED */
+	{ "warning",	LOG_WARNING },
+	{ NULL,		-1 },
+};
+
+static int convert_log_priority(char *priority_name)
+{
+	CODE *priority_mapping;
+
+	for (priority_mapping = prioritynames;
+	     priority_mapping->c_name != NULL;
+	     priority_mapping++) {
+
+		if (!strcasecmp(priority_name, priority_mapping->c_name))
+			return priority_mapping->c_val;
+	}
+
+	return -1;
+}
+
 int main(int argc, char *argv[])
 {
 	int res, opt, status;
+	int logpri = -1;
 	unsigned ghost, logging;
 	unsigned foreground, have_global_options;
 	time_t timeout;
@@ -1476,6 +1776,7 @@ int main(int argc, char *argv[])
 		{"random-multimount-selection", 0, 0, 'r'},
 		{"global-options", 1, 0, 'O'},
 		{"version", 0, 0, 'V'},
+		{"set-log-priority", 1, 0, 'l'},
 		{0, 0, 0, 0}
 	};
 
@@ -1496,7 +1797,7 @@ int main(int argc, char *argv[])
 	foreground = 0;
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdD:fVrO:", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdD:fVrO:l:", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1544,6 +1845,23 @@ int main(int argc, char *argv[])
 				program);
 			break;
 
+		case 'l':
+			if (isalpha(*optarg)) {
+				logpri = convert_log_priority(optarg);
+				if (logpri < 0) {
+					fprintf(stderr, "Invalid log priority:"
+						" %s\n", optarg);
+					exit(1);
+				}
+			} else if (isdigit(*optarg)) {
+				logpri = getnumopt(optarg, opt);
+			} else {
+				fprintf(stderr, "non-alphanumeric character "
+					"found in log priority.  Aborting.\n");
+				exit(1);
+			}
+			break;
+
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
@@ -1567,6 +1885,26 @@ int main(int argc, char *argv[])
 	argv += optind;
 	argc -= optind;
 
+	if (logpri >= 0) {
+		int exit_code = 0;
+		int i;
+
+		/*
+		 * The remaining argv elements are the paths for which
+		 * log priorities must be changed.
+		 */
+		for (i = 0; i < argc; i++) {
+			if (set_log_priority(argv[i], logpri) < 0)
+				exit_code = 1;
+		}
+		if (argc < 1) {
+			fprintf(stderr,
+				"--set-log-priority requires a path.\n");
+			exit_code = 1;
+		}
+		exit(exit_code);
+	}
+
 	if (is_automount_running() > 0) {
 		fprintf(stderr, "%s: program is already running.\n",
 			program);
diff --git a/daemon/direct.c b/daemon/direct.c
index 9a39a6f..1535518 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -86,61 +86,6 @@ static void mnts_cleanup(void *arg)
 	return;
 }
 
-static int autofs_init_direct(struct autofs_point *ap)
-{
-	int pipefd[2], cl_flags;
-
-	if ((ap->state != ST_INIT)) {
-		/* This can happen if an autofs process is already running*/
-		error(ap->logopt, "bad state %d", ap->state);
-		return -1;
-	}
-
-	ap->pipefd = ap->kpipefd = ap->ioctlfd = -1;
-
-	/* Pipe for kernel communications */
-	if (pipe(pipefd) < 0) {
-		crit(ap->logopt,
-		     "failed to create commumication pipe for autofs path %s",
-		     ap->path);
-		return -1;
-	}
-
-	ap->pipefd = pipefd[0];
-	ap->kpipefd = pipefd[1];
-
-	if ((cl_flags = fcntl(ap->pipefd, F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->pipefd, F_SETFD, cl_flags);
-	}
-
-	if ((cl_flags = fcntl(ap->kpipefd, F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->kpipefd, F_SETFD, cl_flags);
-	}
-
-	/* Pipe state changes from signal handler to main loop */
-	if (pipe(ap->state_pipe) < 0) {
-		crit(ap->logopt, "failed create state pipe for autofs path %s",
-		     ap->path);
-		close(ap->pipefd);
-		close(ap->kpipefd);
-		return -1;
-	}
-
-	if ((cl_flags = fcntl(ap->state_pipe[0], F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->state_pipe[0], F_SETFD, cl_flags);
-	}
-
-	if ((cl_flags = fcntl(ap->state_pipe[1], F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->state_pipe[1], F_SETFD, cl_flags);
-	}
-
-	return 0;
-}
-
 int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, struct mapent *me)
 {
 	char buf[MAX_ERR_BUF];
@@ -522,9 +467,6 @@ int mount_autofs_direct(struct autofs_point *ap)
 		return -1;
 	}
 
-	if (autofs_init_direct(ap))
-		return -1;
-
 	/* TODO: check map type */
 	if (lookup_nss_read_map(ap, NULL, now))
 		lookup_prune_cache(ap, now);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 02e7045..1fd00f9 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -43,63 +43,6 @@ extern pthread_attr_t thread_attr;
 static pthread_mutex_t ma_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t ea_mutex = PTHREAD_MUTEX_INITIALIZER;
 
-static int autofs_init_indirect(struct autofs_point *ap)
-{
-	int pipefd[2], cl_flags;
-
-	if ((ap->state != ST_INIT)) {
-		/* This can happen if an autofs process is already running*/
-		error(ap->logopt, "bad state %d", ap->state);
-		return -1;
-	}
-
-	ap->pipefd = ap->kpipefd = ap->ioctlfd = -1;
-
-	/* Pipe for kernel communications */
-	if (pipe(pipefd) < 0) {
-		crit(ap->logopt,
-		     "failed to create commumication pipe for autofs path %s",
-		     ap->path);
-		free(ap->path);
-		return -1;
-	}
-
-	ap->pipefd = pipefd[0];
-	ap->kpipefd = pipefd[1];
-
-	if ((cl_flags = fcntl(ap->pipefd, F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->pipefd, F_SETFD, cl_flags);
-	}
-
-	if ((cl_flags = fcntl(ap->kpipefd, F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->kpipefd, F_SETFD, cl_flags);
-	}
-
-	/* Pipe state changes from signal handler to main loop */
-	if (pipe(ap->state_pipe) < 0) {
-		crit(ap->logopt,
-		     "failed create state pipe for autofs path %s", ap->path);
-		close(ap->pipefd);
-		close(ap->kpipefd);	/* Close kernel pipe end */
-		free(ap->path);
-		return -1;
-	}
-
-	if ((cl_flags = fcntl(ap->state_pipe[0], F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->state_pipe[0], F_SETFD, cl_flags);
-	}
-
-	if ((cl_flags = fcntl(ap->state_pipe[1], F_GETFD, 0)) != -1) {
-		cl_flags |= FD_CLOEXEC;
-		fcntl(ap->state_pipe[1], F_SETFD, cl_flags);
-	}
-
-	return 0;
-}
-
 static int unlink_mount_tree(struct autofs_point *ap, struct mnt_list *mnts)
 {
 	struct mnt_list *this;
@@ -257,9 +200,6 @@ int mount_autofs_indirect(struct autofs_point *ap)
 	int status;
 	int map;
 
-        if (autofs_init_indirect(ap))
-		return -1;
-
 	/* TODO: read map, determine map type is OK */
 	if (lookup_nss_read_map(ap, NULL, now))
 		lookup_prune_cache(ap, now);
diff --git a/include/automount.h b/include/automount.h
index d55ba5c..7258010 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -222,6 +222,8 @@ int rmdir_path(struct autofs_point *ap, const char *path, dev_t dev);
 #define MAPENT_MAX_LEN 4095
 #define PARSE_MAX_BUF	KEY_MAX_LEN + MAPENT_MAX_LEN + 2
 
+#define AUTOFS_LOGPRI_FIFO "/tmp/autofs.fifo"
+
 int lookup_nss_read_master(struct master *master, time_t age);
 int lookup_nss_read_map(struct autofs_point *ap, struct map_source *source, time_t age);
 int lookup_enumerate(struct autofs_point *ap,
@@ -435,6 +437,7 @@ struct autofs_point {
 	int pipefd;			/* File descriptor for pipe */
 	int kpipefd;			/* Kernel end descriptor for pipe */
 	int ioctlfd;			/* File descriptor for ioctls */
+	int logpri_fifo;		/* FIFO used for changing log levels */
 	dev_t dev;			/* "Device" number assigned by kernel */
 	struct master_mapent *entry;	/* Master map entry for this mount */
 	unsigned int type;		/* Type of map direct or indirect */
diff --git a/man/automount.8 b/man/automount.8
index da67a5c..d14e72d 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -59,6 +59,12 @@ setting.
 .TP
 .I "\-V, \-\-version"
 Display the version number, then exit.
+.TP
+.I "\-l, \-\-set-log-priority priority path [path,...]"
+Set the daemon log priority to the specified value.  Valid values include
+the numbers 0-7, or the strings emerg, alert, crit, err, warning, notice,
+info, or debug.  The \fIpath\fP argument corresponds to the automounted
+path name as specified in the master map.
 .SH ARGUMENTS
 \fBautomount\fP takes one optional argument, the name of the master map to
 use.
