From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] Fix buffer overflow with large key lengths in file
	maps
Date: Fri, 29 Apr 2005 11:31:12 -0400
Message-ID: <17010.21312.962838.364226@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi Ian,

I'm attempting to get the connectathon automount test suite running, and it
turned up this bug.  Basically, we never do any bounds checking on the key
array passed into read_one in lookup_file.c.   This patch fixes the problem
in my environment.

Thanks,

Jeff

--- autofs-4.1.4/modules/lookup_file.c.orig	2005-04-29 11:14:54.699437608 -0400
+++ autofs-4.1.4/modules/lookup_file.c	2005-04-29 11:21:16.004470432 -0400
@@ -157,6 +157,10 @@ static int read_one(FILE *f, char *key, 
 			break;
 
 		case st_compare:
+			if (kptr - key > KEY_MAX_LEN) {
+				state = st_badent;
+				break;
+			}
 			if (ch == '\n')
 				state = st_begin;
 			else if (isspace(ch) && !escape) {
