From: Ian Kent <raven@themaw.net>
Subject: [PATCH 27/37] autofs-5.1.2 - fix typos in README.amd-maps
Date: Tue, 25 Oct 2016 09:19:49 +0800
Message-ID: <20161025011948.7778.73991.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=q8Vr4APam8uW72ZbyOY+r0slOj4=; b=ysLmAvZP4p0/p8OAbb
        lfWHugFuIRitI3kmtkINuXxccQVSs1yhaUMWXpzAr+xzr70KHSUPxn3Wtqi/YNBi
        3OkAOcteaaroWWyJoBD0azas6AM5541A4CQCgI5eGW+mpX6vsSEBataCFwC32UQW
        5mAyzkkzRalNyZnuOSsPaWlK4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=q8Vr4APam8uW72ZbyOY+r0
        slOj4=; b=frLJ/6pNXCR36urbO5KyOk+tZQ0Gzp6pu2bBWApy99BX9inMjtFqKq
        oOpUcP4vkHo0qJcqkHeIRUgsBs6NscjmsNtOlZkmPgLv22qpAW/5+3JisJu6hNzo
        dgk2YkJ+Vtu9jdlSUewsUX7bfxWcLfM3Rfr9kQsU7djoiSY7XjZ4A=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs mailing list <autofs@vger.kernel.org>

Fix a few typos and try and clearify some statements in the README.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 README.amd-maps |   15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index e89086b..6b097ff 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -24,6 +24,7 @@ xx/xx/2016 autofs-5.1.3
 - add master read wait option.
 - work around sss startup delay.
 - add sss master map wait config option.
+- fix typos in README.amd-maps.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/README.amd-maps b/README.amd-maps
index b31a7db..e79f521 100644
--- a/README.amd-maps
+++ b/README.amd-maps
@@ -7,7 +7,8 @@ The ability to parse amd format maps has been added to autofs.
 How to use amd maps in autofs
 -----------------------------
 
-To add amd map parsing to autofs new "format" module has been added.
+To add amd map parsing to autofs a new "format" module has been added.
+
 To use this new map format module the existing master map syntax is
 used as described below.
 
@@ -20,7 +21,7 @@ For amd format maps this becomes:
 /amd/mp   file,amd:amd.mp
 
 which will use file as the map source and the amd format parser for
-the map. But see the section below on configuration below for how to
+the map. But see the section below on configuration for how to
 eliminate the need to specify "map-type,format" in the master map.
 
 Configuration sub-system changes
@@ -42,18 +43,18 @@ All that's needed to add an existing amd configuration to autofs is to
 add it below the autofs configuration. Apart from changing the amd
 "[ global ]" section name to "[ amd ]" nothing else should need to be
 changed. However, quite a few amd configuration options don't have
-meaning within autofs. When these options are seen it should be logged.
+meaning within autofs. When these options are seen they are logged.
 
 Be aware that, if the an old configuration exists and the configuration
 hasn't been updated after the installation, changes to the the old
 configuration will override changes to the new configuration because
 backward compatibility takes priority over the new implementation.
 
-The amd per-map sections have two functions, to allow per-mount
+The amd per-mount sections have two functions, to allow per-mount
 configuration, as it does in amd, and to allow master map entries to
 avoid the need to specify the "type,format" part of the master map
-entry so they can use the nsswitch map source functionality in the
-same way autofs master map entries do.
+entry. This allows them to use the nsswitch map source functionality
+in the same way autofs master map entries do.
 
 If a section for an amd mount is added below the global amd section
 using the mount point path (as is done in amd.conf) then autofs will
@@ -63,7 +64,7 @@ be given in the master map entry the map_name option is not mandatory
 as it is in amd and will no be used.
 
 If a mount point is present in the master map and the source of the
-map is nis then it should be sufficient to use (for example):
+map is nis then it is sufficient to use (for example):
 
 /amd/mp           amd.mp
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
