From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Limit on return string from program map
Date: Fri, 17 Dec 2004 10:19:30 -0500
Message-ID: <16834.63746.614567.523947@segfault.boston.redhat.com>
References: <21502.1103178424@kao2.melbourne.sgi.com>
	<Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Keith Owens <kaos@ocs.com.au>

==> Regarding Re: [autofs] Limit on return string from program map; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 16 Dec 2004, Keith Owens wrote:
>> Kernel 2.6.9, autofs v4 as a module, autofs-4.1.3-28 (FC3).  I added
>> "/net /etc/auto.net" to /etc/auto.master and it works fine, up to a
>> point.  ps shows
>> 
>> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
>> 
>> If the target server has a lot of mounted filesystems then automount
>> will only mount the first few entries on the list.  Then it tries to run
>> mount with invalid input.  It looks like there is a hard coded limit on
>> the string that automount expects from a program map.  My virtual CD
>> server has lots of CD images mounted over loopback, each with its own
>> export entry, so the return string from auto.net is quite long.

raven> The buffer size for map entries is 4096.

I think I posted a patch here that would extend that?  I can't seem to find
it in the archives, so I'll repost.  This is the version of the patch that
is in our tree, so no guarantees about it applying to Ian's tree.  *sigh*
(patch originally done by from Neil Horman)

Ian, when is 4.1.4 coming out.  ;-)

-Jeff

--- autofs-4.1.3/modules/lookup_program.c~	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.3/modules/lookup_program.c	2004-11-15 19:03:06.860316496 -0500
@@ -84,7 +84,7 @@ int lookup_ghost(const char *root, int g
 int lookup_mount(const char *root, const char *name, int name_len, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	char mapent[MAPENT_MAX_LEN + 1], *mapp;
+	char *mapent, *mapp, *tmp;
 	char errbuf[1024], *errp;
 	char ch;
 	int pipefd[2], epipefd[2];
@@ -94,11 +94,19 @@ int lookup_mount(const char *root, const
 	fd_set readfds, ourfds;
 	enum state { st_space, st_map, st_done } state;
 	int quoted = 0;
-	int ret;
+	int ret = 1;
 	int max_fd;
+	int distance;
+	int alloci = 1;
 
 	debug(MODPREFIX "looking up %s", name);
 
+	mapent = (char *)malloc(MAPENT_MAX_LEN + 1);
+	if (!mapent) {
+		error(MODPREFIX "malloc: %s\n", strerror(errno));
+		return 1;
+	}
+
 	/*
 	 * We don't use popen because we don't want to run /bin/sh plus we
 	 * want to send stderr to the syslog, and we don't use spawnl()
@@ -107,12 +115,12 @@ int lookup_mount(const char *root, const
 
 	if (pipe(pipefd)) {
 		error(MODPREFIX "pipe: %m");
-		return 1;
+		goto out_free;
 	}
 	if (pipe(epipefd)) {
 		close(pipefd[0]);
 		close(pipefd[1]);
-		return 1;
+		goto out_free;
 	}
 
 	f = fork();
@@ -122,7 +130,7 @@ int lookup_mount(const char *root, const
 		close(epipefd[0]);
 		close(epipefd[1]);
 		error(MODPREFIX "fork: %m");
-		return 1;
+		goto out_free;
 	} else if (f == 0) {
 		reset_signals();
 		close(pipefd[0]);
@@ -177,21 +185,40 @@ int lookup_mount(const char *root, const
 				if (!quoted && ch == '\n') {
 					*mapp = '\0';
 					state = st_done;
-				} else if (mapp - mapent < MAPENT_MAX_LEN - 1) {
-					/* 
-					 * Eat \ quoting \n, otherwise pass it
-					 * through for the parser
+				/* We overwrite up to 3 characters, so we
+				 * need to make sure we have enough room
+				 * in the buffer for this. */
+				} else if (mapp - mapent > 
+					   ((MAPENT_MAX_LEN+1) * alloci) - 3) {
+					/*
+					 * Alloc another page for map entries.
 					 */
-					if (quoted) {
-						if (ch == '\n')
-							*mapp++ = ' ';
-						else {
-							*mapp++ = '\\';
-							*mapp++ = ch;
-						}
-					} else
-						*mapp++ = ch;
+					distance = mapp - mapent;
+					tmp = realloc(mapent,
+						      ((MAPENT_MAX_LEN + 1) * 
+						       ++alloci));
+					if (!tmp) {
+						alloci--;
+						error(MODPREFIX "realloc: %s\n",
+						      strerror(errno));
+						break;
+					}
+					mapent = tmp;
+					mapp = tmp + distance;
 				}
+				/* 
+				 * Eat \ quoting \n, otherwise pass it
+				 * through for the parser
+				 */
+				if (quoted) {
+					if (ch == '\n')
+						*mapp++ = ' ';
+					else {
+						*mapp++ = '\\';
+						*mapp++ = ch;
+					}
+				} else
+					*mapp++ = ch;
 				break;
 			case st_done:
 				/* Eat characters till there's no more output */
@@ -233,18 +260,20 @@ int lookup_mount(const char *root, const
 
 	if (waitpid(f, &status, 0) != f) {
 		error(MODPREFIX "waitpid: %m");
-		return 1;
+		goto out_free;
 	}
 
 	if (mapp == mapent || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
 		error(MODPREFIX "lookup for %s failed", name);
-		return 1;
+		goto out_free;
 	}
 
 	debug(MODPREFIX "%s -> %s", name, mapent);
 
 	ret = ctxt->parse->parse_mount(root, name, name_len,
 				       mapent, ctxt->parse->context);
+out_free:
+	free(mapent);
 	return ret;
 }
