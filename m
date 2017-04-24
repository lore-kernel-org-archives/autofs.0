From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/34] autofs-5.1.2 - add function conf_amd_get_map_options()
Date: Mon, 24 Apr 2017 09:01:40 +0800
Message-ID: <149299570063.23475.9623751606923760923.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=T1lCqgnIu8XxB5QY8E
        VkeAK69JoN8ruglHf63+qex1M=; b=LFG9R2VbIGr/IVbUmYoPfEX1hV7wKSETSm
        /NXCnEqxnIkIMT/jwr8490kvDtvLQeygnuKLG4Lwziao3GR4VqVrWZKgDshmlSKg
        44ESbRtfF1tscJgSzHR+4hhTB5/ndpPfj2rMpHcgAOSAmJe1d2h2Db8dzr18Mfzi
        vGz4X9Ax3ftbT0iG0LmhudczksW5VRicQ32WcCgHYvxRH5D6XGOlhBVV+zYuYH59
        k7BC1XhWiXNZivka3VJIoMSjoexO09tOFDp5W4Qb2jp1wb54AAlO9nRXwveKJ4nL
        XGVsAdRD8LMOiWApHz51P5HnmmTLTasEex5utMmFLwU+wrw53VQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=T1lCqgnIu8XxB5QY8EVkeAK69JoN8ruglHf63+qex1M=; b=Q1vjvhd8
        8ieAwoh6cqtdsui6Btu7SO3bLMnNxwkrT7TB1bXN6luEysgu5BwlmYjl9+UBPiYj
        LqY/FL+iIy47nUR7sKYHEmiIoqsmFh8s72qoT8ytUo7i4lknACRN5CsydRClT2LQ
        on+NjBGRFLx1i3utLSZchTOPi9Ujz7QwcOeuMMp4p6/NP4V5328lDvGGpA1YLcz9
        mSkg8L4aYVxyyTRyzF2x0FEy6W+sqzFAnQGy+R5MOeO4FvqmiaURLmE8mpp/dCe2
        QvmemqNB0NqxGnu9WxpQZr0hZFtfOACTU0tXJcWSTwd5ZZXeJB7L1ZCq40pI3b+P
        KQGQArx48CHA9g==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add configuration function to get the map_options option from
an amd mount configuration section.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 include/defaults.h |    1 +
 lib/defaults.c     |   14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 3615de7..115afdb 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -43,6 +43,7 @@ xx/xx/2016 autofs-5.1.3
 - add function conf_amd_get_mount_paths().
 - include amd mount sections mounts in master mounts list.
 - check for conflicting amd section mounts.
+- add function conf_get_map_options().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index 7766196..7f0129b 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -196,6 +196,7 @@ char *conf_amd_get_nis_domain(void);
 unsigned int conf_amd_set_nis_domain(const char *);
 char *conf_amd_get_map_defaults(const char *);
 char *conf_amd_get_map_name(const char *);
+char *conf_amd_get_map_options(const char *);
 char *conf_amd_get_map_type(const char *);
 char *conf_amd_get_search_path(const char *);
 unsigned int conf_amd_get_dismount_interval(const char *);
diff --git a/lib/defaults.c b/lib/defaults.c
index 102eda5..4a14367 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -501,6 +501,11 @@ static int conf_load_amd_defaults(void)
 	if (ret == CFG_FAIL)
 		goto error;
 
+	ret = conf_update(sec, NAME_AMD_MAP_OPTIONS,
+			  DEFAULT_AMD_MAP_OPTIONS, CONF_NONE);
+	if (ret == CFG_FAIL)
+		goto error;
+
 	ret = conf_update(sec, NAME_AMD_MAP_TYPE,
 			  DEFAULT_AMD_MAP_TYPE, CONF_NONE);
 	if (ret == CFG_FAIL)
@@ -2024,6 +2029,15 @@ char *conf_amd_get_map_name(const char *section)
 	return tmp;
 }
 
+char *conf_amd_get_map_options(const char *section)
+{
+	char *tmp = NULL;
+	if (section)
+		tmp = conf_get_string(section, NAME_AMD_MAP_OPTIONS);
+
+	return tmp;
+}
+
 char *conf_amd_get_map_type(const char *section)
 {
 	char *tmp = NULL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
