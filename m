From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Wed, 12 Jan 2005 18:01:47 -0500
Message-ID: <16869.44123.559108.373989@segfault.boston.redhat.com>
References: <Pine.LNX.4.61.0501122158560.8199@donald.themaw.net>
	<200501122222.j0CMMeMl011886@jetcar.spd.analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200501122222.j0CMMeMl011886@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

==> Regarding Re: [autofs] BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port  usage problems; David Meleedy <david.meleedy@analog.com> adds:

david.meleedy> Answers to questions below:

>> > Initially we started using the following software (Redhat Enterprise 3
>> update
>> > 3)
>> > autofs 4.1.3-12 > kernel 2.4.21-20 > nfs-utils 1.0.6-31EL
>> 
>> I don't have access to these kernel sources.  That will be a problem as
>> I don't know what autofs4 patches have been applied. Jeff?

These sources should be up to date with all of your patches except the
autofs4_lookup fixes that you made for the map update functionality.


david.meleedy> Well, I have also tried autofs 4.1.3-67 : Here is a complete
david.meleedy> list of the patches installed on that version of autofs:

david.meleedy> Patch30: autofs-4.1.3-large-program-map.patch

I am concerned about the autofs-4.1.3-large-program-map.patch.  There was a
bug in that, and I want to ensure you have the most recent version,
especially since you're using /net.  (the -67 rpm you have has the buggy
version).

I've attached the correct version of the patch.

-Jeff

--- autofs-4.1.3/modules/lookup_program.c.orig	2004-12-20 10:05:12.272654616 -0500
+++ autofs-4.1.3/modules/lookup_program.c	2004-12-20 10:04:21.336398104 -0500
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
@@ -177,21 +185,44 @@ int lookup_mount(const char *root, const
 				if (!quoted && ch == '\n') {
 					*mapp = '\0';
 					state = st_done;
-				} else if (mapp - mapent < MAPENT_MAX_LEN - 1) {
-					/* 
-					 * Eat \ quoting \n, otherwise pass it
-					 * through for the parser
+					break;
+				}
+
+				/* We overwrite up to 3 characters, so we
+				 * need to make sure we have enough room
+				 * in the buffer for this. */
+				/* else */
+				if (mapp - mapent > 
+				    ((MAPENT_MAX_LEN+1) * alloci) - 3) {
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
@@ -233,18 +264,20 @@ int lookup_mount(const char *root, const
 
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
