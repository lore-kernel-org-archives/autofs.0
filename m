From: Jeff Moyer <jmoyer@redhat.com>
Subject: direct map documentation
Date: Tue, 30 Mar 2004 13:01:53 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16489.46609.75114.782585@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

Here is a small clarification on the direct map functionality.  Users
assume that direct maps will operate exactly as they do on Solaris.
Unfortunately, this isn't true.  Hopefully this little blurb could save
some time, both for users and the list.  Comments welcome.

-Jeff

--- autofs-4.1.1/README.direct.orig	2004-03-30 12:58:21.000000000 -0500
+++ autofs-4.1.1/README.direct	2004-03-30 12:58:00.000000000 -0500
@@ -33,3 +33,7 @@
 WARNING: don't mount one direct mount within another. This does
   not work properly at the moment.
 
+NOTE: Due to current design limitations, direct maps will take over an
+  entire directory hierarchy.  What this means is, if your direct map key
+  is /usr/share/bilbo, then /usr will become an automount mount point,
+  mounting over the existing /usr.
