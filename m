From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] Treat multimount entries with duplicate keys as
	invalid
Date: Fri, 29 Apr 2005 17:14:34 -0400
Message-ID: <17010.41914.911954.730506@segfault.boston.redhat.com>
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

Again, from the connectathon automount test suite, this map entry is listed
in the invalid bin:

b3          \
        /s1                             segfault.boston.redhat.com:/export/automount/export1 \
        /s1                             segfault.boston.redhat.com:/export/automount/export1

The attached patch checks for duplicate keys, and returns failure from
multi_add_list if there is one.  The test case passes with this patch.

-Jeff

--- autofs-4.1.4/modules/parse_sun.c.orig	2005-04-29 17:02:07.581358160 -0400
+++ autofs-4.1.4/modules/parse_sun.c	2005-04-29 17:09:47.947371888 -0400
@@ -697,6 +697,18 @@ static int sun_mount(const char *root, c
 	return rv;
 }
 
+static int key_exists(struct multi_mnt *list, char *path, int pathlen)
+{
+	struct multi_mnt *mmptr = list;
+
+	while (mmptr && pathlen == strlen(mmptr->path)) {
+		if (!strncmp(mmptr->path, path, pathlen))
+			return 1;
+		mmptr = mmptr->next;
+	}
+	return 0;
+}
+
 /*
  * Build list of mounts in shortest -> longest order.
  * Pass in list head and return list head.
@@ -727,6 +739,12 @@ struct multi_mnt *multi_add_list(struct 
 		mmptr = mmptr->next;
 	}
 
+	/* if a multimount entry has duplicate keys, it is invalid */
+	if (key_exists(mmptr, path, plen)) {
+		free(new);
+		return NULL;
+	}
+
 	if (old)
 		old->next = new;
 	new->next = mmptr;
