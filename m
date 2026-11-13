Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544667;
	b=sB32cJ0eaZV66UY4xlBjhtTRAOoAUxosKpUTrdzAucWZMML5f4eEVgwx1uUX9xCuJKUg
	 kmTJyxJa3EyP9ejyk7YqfrGWnORdgmEpRLcHmF6JEe2dIbtHE92gQt186Ky3znkngGw1f
	 H34rWo7BCoilzh4BqNCprPuUFsbqM31qydm3mbZWY1eZ/TkIM9yJFYREFZhWd9g/yYLIR
	 tTIk4rQy4TW+Hj05BOZM5QkSop8e4OWGVqnJJkjqRgzOQnLYAenka3LWjxzj6Kq2PgFzB
	 cmF991Ve4ifFV7XJGI5ITkhj8POk58q+yQsUiy/yLMWFXEEVNvxTOUzVMFERHCXcQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=b8cZDULnnut0YgUDOfKIz649ejcWX8XcWTXN/d1ITA8=;
	b=Z1VMQ+q+XzWdBMgxnTJhLrRG+XTBlCkMhZICqvwj/R6J8dRKPd/Fk4fnGmAkzPlKk7pZ
	 VEHk1IpDPSV5qv4e6E1Vij0w/hAkekUnYAHBHhZ0hBEqm0V1oK0FJztbfZyeRto2ohlYc
	 RClBPv62FjXY34BARngeftcguOkS6JJ2c8IAwuJ86qnT9bvbvUUhbV/DikAT39BCuu3iI
	 7wolgZuNO0q0aclO3Jg9QCHPqLUaHI8XxwogbClWjyA3QwUB0UkbuFKIf/MeoSOKPjdcr
	 OVS3ujKnf63/peBjlabuR36toD2oqwtrTG4gct6UBsX37JHm+JpP5dRNUraYMnSvvMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpdGXJXs;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CCB606A321
	for <autofs@vger.kernel.org>; Fri, 13 Nov 2026 04:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CCB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpdGXJXs
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37600b0db49so1449893eec.1
        for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 20:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544666; x=1795149466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8cZDULnnut0YgUDOfKIz649ejcWX8XcWTXN/d1ITA8=;
        b=YpdGXJXs37VQkTpwQVTK2wjKoiZmsXq2azAlx82XEohOPhoMvGl2/PTWV/89LIDaO+
         CVWbmNTQi9SYvl9RLqhv88n/wno+9oH6pC3EwrGCVnn9DznZAemvpljjb3GakL0vWcXh
         SBznkEx1VnUsgBZHgXe8cAOkOu48gK8qgCanSoxa2RXuJSo7MS/7UpaXAKAZE4SnHC1Z
         Mcw0PSQLO5XNM7TMlZfbvCXM5seoJNWkbBWkcBHiIG3mtOVUqfLqd+s3XdFvdcFxqsKd
         qGV0b2oGTdc0BJCOiw7p2kCCo+M6HgBbMuycEu0yDVgeyQScdMY17xbD4Z55o/m6UZI6
         2cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544666; x=1795149466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8cZDULnnut0YgUDOfKIz649ejcWX8XcWTXN/d1ITA8=;
        b=Bo/8o6k1gnDZBCTqso6gkjFXRTqdXHMACZG2t+nXoiZQSiUovVlq/fTcl4etkTYZ4g
         sUiADWhxPcaadxHF/OOPhRIo+sUzDvecUViWxp6O0fEH5C1FL9y+gio5u59O+JuyJ/EJ
         rthvzAM39tdUAtrbiUg3SAgmGfsqwgAqOFDQWrz8VWFJtSIp6ol68X+pHdoM3k9WfS4q
         P7MVaa9re2S0vMkwhXwcqI4e5w2B3D12mmvPW99L078Yo8GGhhgL+GgNHeyLk9SQWC70
         lrTQaUSYLtnBN7czgCyrN76vneTYze2QHoIoAs7AMquGdcNI5g7lxYYaIxd393jrTxYl
         PqNA==
X-Gm-Message-State: APuU4Z/iRVKG7vGZu+VWqwbWlDhH3TLnQ7TDsVv3+lfQeN7yCNCXDo/A
	dvPHoNT7PhaEec9PPn1zKSy/gzSRhuEzvbQnJikfuXhGLlnZ85TLaTxsGL8SQBzjvcKfYg==
X-Gm-Gg: AYBFou1kSaQBAG/oQm8A7zNEhhvTGATG1l5GOCUUDYlnOYG0HsvJowX4svdlCP6oOEA
	aGBiqh1+Lz5kvSW5cNr6GWq2zbBVmyYUxm50zCGIhzDVutNga5IJWA67O7QVqZ0E36maPrjQmCr
	tYcjN4x7qQFx6iIfeQbVUap05l0YK9w+Ur5ikCf3mAMR36Q//E3Y02LUd4x1EvMPuRGJPy8WmoV
	cAUlkb75HSU1rh1PQxdkAFNZAL+zngZV/KkWm3togGaoYeuEDFN9/ok4vg/xvHTt73cfhkSj5g5
	xMbFUbZoJB0q/ADvk7n8j/ITVkhVdv3MEytq2D/wZFkWubUaVp2hJQBkYsZoRPImSdsCbg6IazN
	hJ+JWsqA4MNmsv2c1ODL2C12U0Fw8RQQqFVq6fZqSLSnufkZxL0CUFNwrdukB132XLZGxLJFxBS
	y7dcHXwISgE4YSv9b6tqSnrRFSEd6H/sf5faQBYRSZQVK3ikAwk2Gt2pgepOMhA6Y36/JfnhYf5
	/V6fg2ZGDnZ4hFp04hOziRv6EU1Vtgm3hVvp/WKxuCwYELM+Y6oxnamauSLXV3cgvtS4VqByA0J
	uF9KsGuVqD9rAJxFJ8ogYxxQ33Z4pSXRIo6Zza+JUahVHgH4QXNCIpPXIchFZdS9BoMlyMIa4Yr
	1kWnK1bMj2SE4MhfWEw2vQwl9Oq9bvCo8SjpG6qDKB3wou2OopuXRI1pNSLkIcAdpLgTtVEGMi6
	ZPeQS/Rs5qQU80FZRkjm1I3S1d4lzt/DlbPLMXHP+0sVqXOolkhjzjjqQ1fbkLaDH3OY9ljLjvO
	Q8eu24qVGsP4Wt4BDH1h4oODkBi7eLewiFiyA/TWZLIhBJ81JV7qMLkoHppVpfXziP6NqM=
X-Received: by 2002:a05:7300:7fa6:b0:36d:38e0:79f3 with SMTP id 5a478bee46e88-377e1af812emr5642122eec.25.1794544666413;
        Thu, 12 Nov 2026 20:37:46 -0800 (PST)
Received: from apollo.tail3ccdd3.ts.net ([147.160.63.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3303419eec.14.2026.11.12.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:37:45 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] autofs-5.2.0 - fix build with non-glibc C libraries in lib/misc.c
Date: Thu, 12 Nov 2026 20:37:43 -0800
Message-ID: <20261113043743.2721837-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The open/close on exec functions moved to lib/misc.c expect the GNU
strerror_r() that returns a char pointer. Unlike the rest of autofs,
misc.c does not include automount.h, which maps strerror_r() to
autofs_strerror_r() when not building with glibc, so the build fails with
musl:

  misc.c:96:8: error: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]

Do the same mapping in misc.c.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/misc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/misc.c b/lib/misc.c
index 453d713..7b285be 100644
--- a/lib/misc.c
+++ b/lib/misc.c
@@ -30,6 +30,11 @@
 #include "log.h"
 #include "misc.h"
 
+#ifndef __GLIBC__
+# define strerror_r(N,B,S) autofs_strerror_r(N,B,S)
+char *autofs_strerror_r(int errnum, char *buf, size_t buflen);  /* GNU */
+#endif
+
 #define MAX_ERR_BUF	128
 
 static pthread_mutex_t open_mutex = PTHREAD_MUTEX_INITIALIZER;
