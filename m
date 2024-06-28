Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41D17F7
	for <autofs@vger.kernel.org>; Fri, 28 Jun 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534461; cv=none; b=W9uEHDciFGPXakLzJVhAyqr0yKzkrKI5pgHBk4X9HhY2lIe8sgGK24AjbTWKlamTKg709AlU5OZ/HicX5TpyVj+jPPXlF0WanjdfiowJohbQiKha2CfUZOEM2SmxkAGgewovG5ojpU27b+5Yy/fyF9wTv3r90GNIG3sKTvrBeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534461; c=relaxed/simple;
	bh=6cKqtCpH8bqxXYQecoEwGzK0ITdWxgDV+Gl1s1fVe9Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZJD4SshVLye0ALxXRsLmcYYpWs7TjAkWrnOUyvRmhxNEPOa7lR9E2F8DNGSbAOvulE+x8b0MOtPrg87izRh1+f/0/LgCcnxxJ4HSIzOrcDeQ7zJ2Fu12Np4pjENIi8sBpRBlnmMWRZHSUMDhVss5+fCQox46wURwOa5SLV6JbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjmzNFOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjmzNFOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAKbKmRLSwctjf83mRn6yEmbgLL+aa60ltLEMmxDMiQ=;
	b=bjmzNFOionEgm/L0ZvB/aGA4j4qcbISLLxa+NszeUcUJaQjD2OvcVxsCH+XslUBe5XTlx1
	rvOlz5R+39f+65W7rp7gGivi4Jfu/H3PjhcvwzeizFvh/UtMg7ZJQdNYmmup09u15UpGLB
	7QmNoWZwPHvgYoBsrMm9HZ/HjCp6R+I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-9ugSVjrtPlGr9P2tSSJfCg-1; Thu, 27 Jun 2024 20:27:37 -0400
X-MC-Unique: 9ugSVjrtPlGr9P2tSSJfCg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3cb65d1bbso7370439f.1
        for <autofs@vger.kernel.org>; Thu, 27 Jun 2024 17:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534456; x=1720139256;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAKbKmRLSwctjf83mRn6yEmbgLL+aa60ltLEMmxDMiQ=;
        b=TP6tNVIUr0lK2CawJ6YdY652fDy0LjVCx51AeI4DdV289MmfnryQ+PYajmbU7sgwjE
         BHynkZd1ebh/222/TqHPT6iLnYzg6W25thuCoE2XDvcb4OV0VD58vKeGCEe9QnlYDvC6
         GF++hl92HE8dN01MnVyUoK8CJyVsj7LcumAZFvXW8WGZ2mK8h6iI4lqTBIsaPSgHVPFb
         wlz0Yc92NaVbnkyniBfOpt1jToMvoQa/bgkQpRnYY6CQ+WuU8v+EX5FxE5CGFV6Qc+4U
         Xd1CX6j51/onob/OdQI+qFPFrc0ecMEya8uu93Qz80D5ZEs5/GJ0mAlPvF6Dr3g06UmA
         dN6A==
X-Gm-Message-State: AOJu0YypYDOU39KEjafUJrhvbdSpc/NoC/BupW5sGNIwiMY3ft7wKyu/
	unXlkiuzUdQwXoe1wsf3OIbiiBjq+evN43SK18vCZqp3GggviCtKpqKPfUku54ypy8n2A3jLYv1
	kY9cShW6fCxz54ieHvEDNd5xW/jsTzJhSl3RjAv7Acbas9TbVN4M70w==
X-Received: by 2002:a6b:5018:0:b0:7eb:71bb:6f6b with SMTP id ca18e2360f4ac-7f61f4c37b1mr7866339f.3.1719534456513;
        Thu, 27 Jun 2024 17:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx110DNHxTSreLctRcWiK2JHDrIX02c4cFkG8VQlm/XKUsIS+lOqf2FRUbQYTrkIFM5D53jg==
X-Received: by 2002:a6b:5018:0:b0:7eb:71bb:6f6b with SMTP id ca18e2360f4ac-7f61f4c37b1mr7865439f.3.1719534456175;
        Thu, 27 Jun 2024 17:27:36 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1774sm214540173.160.2024.06.27.17.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:27:35 -0700 (PDT)
Message-ID: <faccdd51-07d6-413f-aa55-41bb0e7660df@redhat.com>
Date: Thu, 27 Jun 2024 19:27:35 -0500
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/14] autofs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---
 fs/autofs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 1f5db6863663..cf792d4de4f1 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -126,7 +126,7 @@ enum {
 const struct fs_parameter_spec autofs_param_specs[] = {
 	fsparam_flag	("direct",		Opt_direct),
 	fsparam_fd	("fd",			Opt_fd),
-	fsparam_u32	("gid",			Opt_gid),
+	fsparam_gid	("gid",			Opt_gid),
 	fsparam_flag	("ignore",		Opt_ignore),
 	fsparam_flag	("indirect",		Opt_indirect),
 	fsparam_u32	("maxproto",		Opt_maxproto),
@@ -134,7 +134,7 @@ const struct fs_parameter_spec autofs_param_specs[] = {
 	fsparam_flag	("offset",		Opt_offset),
 	fsparam_u32	("pgrp",		Opt_pgrp),
 	fsparam_flag	("strictexpire",	Opt_strictexpire),
-	fsparam_u32	("uid",			Opt_uid),
+	fsparam_uid	("uid",			Opt_uid),
 	{}
 };
 
@@ -193,8 +193,6 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct autofs_fs_context *ctx = fc->fs_private;
 	struct autofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, autofs_param_specs, param, &result);
@@ -205,16 +203,10 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_fd:
 		return autofs_parse_fd(fc, sbi, param, &result);
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalfc(fc, "Invalid uid");
-		ctx->uid = uid;
+		ctx->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalfc(fc, "Invalid gid");
-		ctx->gid = gid;
+		ctx->gid = result.gid;
 		break;
 	case Opt_pgrp:
 		ctx->pgrp = result.uint_32;
-- 
2.45.2

