From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] Catch malformed entries in parse_sun
Date: Fri, 29 Apr 2005 16:40:56 -0400
Message-ID: <17010.39896.999699.205561@segfault.boston.redhat.com>
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

Here is another trivial patch.  The connectathon test sweet does some
negative testing.  Here is a malformed entry that we will attempt to mount:

b1c                             /server.example.com

It turns out that we think this is a multimount entry, and the what string
is actually NULL!  The attached patch catches this before handing off to
the mount module.  This was the least intrusive fix I could think of, but
this could warrant further debate as to where in the parse code this should
be handled.

-Jeff

--- autofs-4.1.4/modules/parse_sun.c.orig	2005-04-29 16:34:40.133808256 -0400
+++ autofs-4.1.4/modules/parse_sun.c	2005-04-29 16:36:27.975413840 -0400
@@ -678,6 +678,10 @@ static int sun_mount(const char *root, c
 	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s\n",
 	    root, mountpoint, what, fstype, options);
 
+	/* A malformed entry of the form key /xyz will trigger this case */
+	if (!what || *what == '\0')
+		return 1;
+
 	if (!strcmp(fstype, "nfs")) {
 		rv = mount_nfs->mount_mount(root, mountpoint, strlen(mountpoint),
 					    what, fstype, options, mount_nfs->context);
