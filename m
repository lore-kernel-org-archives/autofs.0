From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: [PATCH] Fixes for samples/auto.master
Date: Thu, 27 Mar 2014 17:31:01 +1100
Message-ID: <20140327063059.GG19822@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=email;
  t=1395902468; x=1427438468;
  h=date:from:to:subject:message-id:mime-version;
  bh=rjGpcQUiXMVqfi3lMEvgs7qoF2OoJW919897USYQz4I=;
  b=Mu8HejnWCC1pVEMXBulOPE7bYP2SP2TrBL5DwjoFup4Q0ktc5+YemaRK
   IBolbqiGMeNPpmcOg927I3AxLSiBZA03LlnvM9bPnhDq8QHNOor7E2ZKH
   hUzgLlvc4pDo44a;
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

I noticed that the preamble in samples/auto.master seemed to be
referring to a regular autofs map, not a 'master' map.
Perhaps this patch would clear that up?

Kind regards,
Vince

Signed-off-by: <vincent.mcintyre@csiro.au>

  Vincent McIntyre (2):
---
  Replace description that described regular automount maps, not master
    maps.     Add a note about the format of included files.
  Clarify what happens to master map options not consumed by 'mount'.

 man/auto.master.5.in |    2 +-
 samples/auto.master  |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)


diff --git a/samples/auto.master b/samples/auto.master
index 72f086c..0f2c8ab 100644
--- a/samples/auto.master
+++ b/samples/auto.master
@@ -1,8 +1,8 @@
 #
 # Sample auto.master file
-# This is an automounter map and it has the following format
-# key [ -mount-options-separated-by-comma ] location
-# For details of the format look at autofs(5).
+# This is a 'master' automounter map and it has the following format:
+# mount-point [map-type[,format]:]map [options]
+# For details of the format look at auto.master(5).
 #
 /misc	/etc/auto.misc
 #
@@ -13,6 +13,7 @@
 /net	-hosts
 #
 # Include /etc/auto.master.d/*.autofs
+# The included files must conform to the format of this file.
 #
 +dir:/etc/auto.master.d
 #
-- 
1.7.2.5


diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 1d96d7e..1095406 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -139,7 +139,7 @@ the \fBdn\fP of an LDAP entry for maps of type \fBldap\fP.
 .br
 Any remaining command line arguments without leading dashes (\-) are
 taken as options (\fI\-o\fP) to \fBmount\fP.  Arguments with leading
-dashes are considered options for the maps.
+dashes are considered options for the maps and are passed to automount (8).
 .sp
 The \fBsun\fP format supports the following options:
 .RS
-- 
1.7.2.5

