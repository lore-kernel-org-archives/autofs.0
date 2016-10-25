From: Ian Kent <raven@themaw.net>
Subject: [PATCH 35/37] autofs-5.1.2 - capture cache option and its settings
 during parsing
Date: Tue, 25 Oct 2016 09:20:32 +0800
Message-ID: <20161025012032.7778.64736.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=hIX1g6E4TfwIWPfXne96IVd6WWM=; b=P0mS6rm72K1YtoJvhf
        DDi0lYEVWSIrlQBOMz+Bclk3irAQVP3VcJOlbcJVQr6whwrVM6eCINQuAhrUb9t8
        bK1s5M9NLKBDwfTOYkJZBv+yEly2QNKta6KHUZJDYvUb744axVQ2IMDVR4k5x24u
        DNf+8B86dp3+qFSRxURHg4yX0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=hIX1g6E4TfwIWPfXne96IV
        d6WWM=; b=PsK0eIGnQLazcptNx9hyuaLmtmmd11ryxtHmhRwxbJEa2r2aE8bjsy
        Ctycscb6/mYViBjp3OrdNsMlhpnLWxlO6xUFwkGx5D0SR9N9rRa7Ukdx3bBzv0Nw
        1CS0Ty9PGi6tIgrHjH3OJLkkZ+W+YrHmV4VKqlxyOYYEMDaXn+gi0=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
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
index 32452de..ec184b4 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -32,6 +32,7 @@ xx/xx/2016 autofs-5.1.3
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
