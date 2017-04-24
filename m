From: Ian Kent <raven@themaw.net>
Subject: [PATCH 18/34] autofs-5.1.2 - capture cache option and its settings
 during parsing
Date: Mon, 24 Apr 2017 09:01:45 +0800
Message-ID: <149299570575.23475.11254269068717255139.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=9A/lCnJF359IRa+y6o
        1cMzxVTNS5c8NVf2bkyab9qTM=; b=dgKZYFsZNxO1zeKlIWt0dVMGDoj44FTCU7
        7gKfwRVR6OxVeNIkki5//Pimv/XMC2F36lPsARz4wA3SBr+IMhZNquT6Mxooj3xP
        sRtWkDb95W9sJ80NqtjkDtVrbO//9zdbBCtf/2abBG75PKVaoXurYTrJ/hJpPVEu
        cGQhvRAf5P7v16pdXIjNH54/TwnXmmyX3M5EPcJQb+lvKkIEtDUSb9EcFWUwC6td
        9MJfCoT56MPVKA02CfyPLf4aMXdUsDFyNUMshhUlXIaEKghUwkzVXRFBZW3rqyGn
        NxPmXDhEb83ypLQ/bXoQD15RS/xMgzPZEUIZxQjGhsfmTjYtpiRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=9A/lCnJF359IRa+y6o1cMzxVTNS5c8NVf2bkyab9qTM=; b=LzETVtRB
        qcec9icNKyTNoz43tXkGriLt6+BALwQzrAVxtlCqFMSF+skQ8MtvfCfFxFvE+BkB
        Qz+SXNTrMYbjyr3oAdHNK2tQna/qaQYv2rMRBLudJb779UO/eu5fjOvruTPdIZpF
        R3Xs0NKbycYADllTo3s7kk1GIii3NNQb8oKGYymwfTANPz+bPk8I8TuPx69c6ITR
        WGOjKER+ILZI8+mZYMSxV5KxegVJoRGH3YNseWVgK3sgUiE8lthTvxiKaBcxR3vd
        NYNyLfKB6fuJ3IOGSjcw1y1q2y171DBedDicXqRWj7acx3ryntvw4iJxaHKlfeYu
        LyPIsWkABjY6Jw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The amd map format parser was not aware of the optional sync
parameter of the cache option.

Make the parser aware of the sync option and capture the cache
option and its settings during map parsing.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 include/parse_amd.h |    7 +++++++
 modules/amd_parse.y |   12 +++++++++---
 modules/amd_tok.l   |    2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 115afdb..3999298 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -44,6 +44,7 @@ xx/xx/2016 autofs-5.1.3
 - include amd mount sections mounts in master mounts list.
 - check for conflicting amd section mounts.
 - add function conf_get_map_options().
+- capture cache option and its settings during parsing.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/parse_amd.h b/include/parse_amd.h
index 313edd5..1664947 100644
--- a/include/parse_amd.h
+++ b/include/parse_amd.h
@@ -39,9 +39,16 @@
 #define AMD_DEFAULTS_RESET	0x02000000
 #define AMD_DEFAULTS_MASK	0xff000000
 
+#define AMD_CACHE_OPTION_NONE	0x0000
+#define AMD_CACHE_OPTION_INC	0x0001
+#define AMD_CACHE_OPTION_ALL	0x0002
+#define AMD_CACHE_OPTION_REGEXP	0x0004
+#define AMD_CACHE_OPTION_SYNC	0x8000
+
 struct amd_entry {
 	char *path;
 	unsigned long flags;
+	unsigned int cache_opts;
 	char *type;
 	char *map_type;
 	char *pref;
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index b33250a..e99820b 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -425,9 +425,14 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	}
 	| MAP_OPTION OPTION_ASSIGN CACHE_OPTION
 	{
-		sprintf(msg_buf, "option %s is not used, autofs "
-				 "default caching is always used", $1);
-		amd_info(msg_buf);
+		if (strncmp($3, "inc", 3))
+			entry.cache_opts = AMD_CACHE_OPTION_INC;
+		else if (strncmp($3, "all", 3))
+			entry.cache_opts = AMD_CACHE_OPTION_ALL;
+		else if (strncmp($3, "re", 2))
+			entry.cache_opts = AMD_CACHE_OPTION_REGEXP;
+		if (strstr($3, "sync"))
+			entry.cache_opts |= AMD_CACHE_OPTION_SYNC;
 	}
 	;
 
@@ -535,6 +540,7 @@ static int amd_msg(const char *s)
 static void local_init_vars(void)
 {
 	memset(&entry, 0, sizeof(entry));
+	entry.cache_opts = AMD_CACHE_OPTION_NONE;
 	memset(opts, 0, sizeof(opts));
 }
 
diff --git a/modules/amd_tok.l b/modules/amd_tok.l
index 03e716f..2eac5cb 100644
--- a/modules/amd_tok.l
+++ b/modules/amd_tok.l
@@ -101,7 +101,7 @@ NOPT		({SSTR}|(({IP4ADDR}(\/{V4MASK})?)|({IP6ADDR}(\/{V6MASK})?)))
 MAPOPT		(fs|type|maptype|pref|sublink|cache)
 MNTOPT		(opts|addopts|remopts)
 FSOPTS		(rhost|rfs|dev|cachedir|mount|unmount|umount|delay)
-CHEOPT		(mapdefault|none|inc|re|regexp|all)
+CHEOPT		((mapdefault|none|inc|re|regexp|all)(,sync)?)
 MAPTYPE		(file|nis|nisplus|ldap|hesiod|exec|ndbm|passwd|union)
 FSTYPE_LOCAL	(link|linkx|lofs|ufs|ext2|ext3|ext4|xfs|jfs|cdfs|cachefs)
 FSTYPE_NET	(nfs|nfsx|nfsl|host)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
