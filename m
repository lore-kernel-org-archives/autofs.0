From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/34] autofs-5.1.2 - fix typos in README.amd-maps
Date: Mon, 24 Apr 2017 09:01:04 +0800
Message-ID: <149299566467.23475.3901809281648712357.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=tf+qnUY5tpqB9qzZ1v
        ejcNgephKgT3dJ9IAqI8+Uib0=; b=domiJ7EPyiE4XFh/u9w28mRowfTkYPE+M8
        8L6yl031UjP18xuBZnY1SnfK3MSLEfVuKQj8rIV3rmw1UwG+FPpXSocNZyUItPya
        d4OdNEnBgGsyKNo+rBiBhoWXgm6I37MRahlYtmPvK9yOkELd73TEXU/GlW9aZa82
        0SFWcNTNIjDjsjqkC2K9bSBSWwHEiAVb4PurBDiR0o7GFlqu226upASdd+vBYchj
        4qaU6aRYmqIQtb6q6rZlgbCMWjD2nOuIaQGDnfsDwAodARu+9Pb59zJPwn84N0Ja
        Jk7eoYFTnVeO1bl0Ml6YEUZ7FR6L5OKHPgutDaE05XzVXAhzxn3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=tf+qnUY5tpqB9qzZ1vejcNgephKgT3dJ9IAqI8+Uib0=; b=ewJBvuN0
        Yxt9QP1JfFLYrfOyN+n3aUAgdV0pkKA+CoORsqgy2aP2f4eDw0YTF5oTmwzH7GEL
        4V2HawLOKxiopybTGAZL82a7qqzy6ktjrA5qd9+UNAREwNfuaZ0MXKRbWWVrtuXR
        L3nmLttZhT1MgVwah3RgiNI+fENm2pO2zWxmufaYBqw8d8+pbscS5cU1FRP6dZCp
        cbipN7EMWYj3J9k7G2/muzDqw9zO520Tzd7UCTihjCkmtibem/75b7vwjetU8LpC
        rVpMNrHqlE8m1kCLDjN4PtvGg93c84A0fenDdBnQWpvHK3tIPUH7DyD/Zz7RA1aw
        hyDLDc37+zE7AQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
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
index f841eaa..c347fcb 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -36,6 +36,7 @@ xx/xx/2016 autofs-5.1.3
 - make set_direct_mount_catatonic() more general.
 - set autofs mounts catatonic at exit.
 - honor last rw in mount options when doing a bind mount.
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
