From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/35] autofs-5.1.3 - fix typos in autofs man pages
Date: Mon, 16 Oct 2017 13:06:47 +0800
Message-ID: <150813040767.25695.7487578644459651877.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add missing section in the title of the autofs.conf(5) man page
and fix a duplicated i in file system types description of autofs(5).

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Roland Hopferwieser <rhopfer@ica.jku.at>
---
 CHANGELOG            |    1 +
 man/autofs.5         |    2 +-
 man/autofs.conf.5.in |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 10ef5c47..257e3501 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -7,6 +7,7 @@ xx/xx/2017 autofs-5.1.4
 - dont probe NFSv2 by default.
 - add version parameter to rpc_ping().
 - fix typo in autofs config file comments.
+- fix typos in autofs man pages.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/autofs.5 b/man/autofs.5
index efde77ad..0063fbea 100644
--- a/man/autofs.5
+++ b/man/autofs.5
@@ -447,7 +447,7 @@ This is the mount filesystem \fBtype\fP.
 It can have a value of
 .BR auto ", " link ", " linkx ", " host ", " lofs ", " ext2-4 ", "
 .BR xfs ", " nfs ", " nfsl " or " cdfs "."
-Other types that are not yet implemented or are not available iin autofs are
+Other types that are not yet implemented or are not available in autofs are
 .BR nfsx ", " lustre ", " jfs ", " program ", " cachefs " and " direct "."
 .TP
 .B maptype
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index a777c581..0efe0d4f 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -1,5 +1,5 @@
 .\" t
-.TH AUTOFS.CONF "23 Jan 2014"
+.TH AUTOFS.CONF 5 "23 Jan 2014"
 .SH NAME
 autofs.conf \- autofs configuration
 .SH "DESCRIPTION"

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
