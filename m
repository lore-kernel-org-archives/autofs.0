From: Ian Kent <raven@themaw.net>
Subject: [PATCH 15/19] autofs-5.1.3 - fix some man page problems
Date: Wed, 02 Aug 2017 10:18:26 +0800
Message-ID: <150164030657.6106.8226480917775670191.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix a few problems with the autofs man pages:
- autofs(8) missing "autofs -" in NAME string.
- punctuation marks in some SEE ALSO sections.
- change NAME string to include key word "autofs" in auto.master(5).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 man/auto.master.5.in           |    4 ++--
 man/autofs.5                   |    4 ++--
 man/autofs.8.in                |    8 ++++----
 man/autofs.conf.5.in           |    2 +-
 man/autofs_ldap_auth.conf.5.in |    2 +-
 man/automount.8                |    4 ++--
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index d5dca873..c6423ce8 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -13,6 +13,7 @@ xx/xx/2017 autofs-5.1.4
 - fix a couple of compiler warnings.
 - set systemd KillMode to process.
 - fix mount.nfs blocks on first mount.
+- fix some man page problems.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index ba28494e..c87fb7f4 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -1,7 +1,7 @@
 .\" t
 .TH AUTO.MASTER 5 "11 Apr 2006"
 .SH NAME
-auto.master \- Master Map for automounter
+auto.master \- Master Map for automounter consulted by autofs
 .SH "DESCRIPTION"
 The
 .B auto.master
@@ -367,7 +367,7 @@ configuration will be used to locate the source of the map
 .BR autofs (5),
 .BR autofs (8),
 .BR autofs.conf (5),
-.BR autofs_ldap_auth.conf (5)
+.BR autofs_ldap_auth.conf (5).
 .SH AUTHOR
 This manual page was written by Christoph Lameter <chris@waterf.org>,
 for the Debian GNU/Linux system.  Edited by <hpa@transmeta.com> and
diff --git a/man/autofs.5 b/man/autofs.5
index 0063fbea..c2421272 100644
--- a/man/autofs.5
+++ b/man/autofs.5
@@ -602,8 +602,8 @@ depricated so this is not likely to change.
 .BR auto.master (5),
 .BR autofs (8),
 .BR autofs.conf (5),
-.BR mount (8).
-.BR autofs_ldap_auth.conf (5)
+.BR mount (8),
+.BR autofs_ldap_auth.conf (5).
 .SH AUTHOR
 This manual page was written by Christoph Lameter <chris@waterf.org>,
 for the Debian GNU/Linux system.  Edited by H. Peter Avian
diff --git a/man/autofs.8.in b/man/autofs.8.in
index b2b757bb..9f03eada 100644
--- a/man/autofs.8.in
+++ b/man/autofs.8.in
@@ -1,6 +1,6 @@
 .TH AUTOFS 8 "9 Sep 1997"
 .SH NAME
-Service control for the automounter
+autofs \- Service control for the automounter
 .SH SYNOPSIS
 If a SysV init script system is being used:
 .br
@@ -72,9 +72,9 @@ for more information.
 .BR automount (8),
 .BR autofs (5),
 .BR autofs.conf (5),
-.BR auto.master (5).
-.BR autofs_ldap_auth.conf (5)
-.BR systemctl(1)
+.BR auto.master (5),
+.BR autofs_ldap_auth.conf (5),
+.BR systemctl(1).
 .SH AUTHOR
 This manual page was written by Christoph Lameter <chris@waterf.org>,
 for the Debian GNU/Linux system.  Edited by H. Peter Anvin
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 0efe0d4f..ec2d4bb3 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -513,6 +513,6 @@ map_type = file
 .SH "SEE ALSO"
 .BR automount (8),
 .BR auto.master (5),
-.BR autofs_ldap_auth.conf (5)
+.BR autofs_ldap_auth.conf (5).
 .SH AUTHOR
 This manual page was written by Ian Kent <raven@themaw.net>.
diff --git a/man/autofs_ldap_auth.conf.5.in b/man/autofs_ldap_auth.conf.5.in
index fe5077dd..e035ebe5 100644
--- a/man/autofs_ldap_auth.conf.5.in
+++ b/man/autofs_ldap_auth.conf.5.in
@@ -113,6 +113,6 @@ externally configured credential cache that is used during authentication.
 By default, autofs will setup a memory based credential cache.
 .SH "SEE ALSO"
 .BR auto.master (5),
-.BR autofs.conf (5),
+.BR autofs.conf (5).
 .SH AUTHOR
 This manual page was written by Ian Kent <raven@themaw.net>.
diff --git a/man/automount.8 b/man/automount.8
index 601c18c8..8e0551e9 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -178,8 +178,8 @@ constructed has been detached from the mount tree.
 .BR autofs (8),
 .BR autofs.conf (5),
 .BR auto.master (5),
-.BR mount (8).
-.BR autofs_ldap_auth.conf (5)
+.BR mount (8),
+.BR autofs_ldap_auth.conf (5).
 .SH BUGS
 Don't know, I've fixed everything I know about.
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
