Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836351;
	b=lIgLZignTza+LHlhGs3oPDGVCLL6INOtSJ46lhZkfD3OlbZk/KSTdyI/goGQgzMYJZBj
	 Y9l6Sj/xbo3paVBOCTx2+W+vECev2jWsbUgLn/4sqANyCVy/b5uC1LD7aCn6uO/LH9Dnf
	 4EclD3je922kU0ppydxR72wt2h1rcFDFKH7NAPYriXiRkcxPvr2u3HYtU7wH2D9/Qr7fu
	 kvFV+7RVEiOFFqoImT1lLnKR9M83bAqNrxgwYxWJcokCluUwPTgKZxhQ79b+HMo9W/vnT
	 HEAmXgn84G3R1uTtZu/pWgp3KSvgF+zzfnButg3iYpMOQDVt2EcQdObQ9QhM8aHX9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
	b=2zPtnE8jqTCPq1UXcm4LVmNKEUbOh5+eH/25EsFdm6JCeTAuWREx5dqsRk4P6T3qa4Kt
	 hWy4Dv0gdU1qrWPlORvuMGY4KI15x9UBGusxGfsTPh8qDGxkpyisDkbFo31JV4IBBjfb6
	 2kBfQIFfMolSy+prj/v9fz1K0AGHlr0x+JhNZRXOCkKDqk/YVTIcAMxLR4ULAmjSu0Jcu
	 pz6s7MAByM/cdTnSTliA863MJmsaFzIxHq5ny7bskiAI/M3XlVhlA4PJ2qw+9Nw9meQ7e
	 2uSp+cQvje/zSNSmS60pHTEd+zMPoZiE8bqUzDTTDeL+eTOyPi3/yY8UZbn0XyJc7qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BB606A89A
	for <autofs@vger.kernel.org>; Mon, 16 Nov 2026 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270BB606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d21051042so91617666b.0
        for <autofs@vger.kernel.org>; Mon, 16 Nov 2026 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836349; x=1795441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=tuyte0XHN9vejcqK4l0//VkSntgcv4oWwWa0+sUtmOsAc0uHuCz+B4sf8XJCEQ6lHt
         F6yBmnGoSO4NP/5dfth7qg0DEgKkhdqXx18qjFXlQY91q9VNCaUQewRO+y8vhGd2cj2c
         vjmZB+Pyqu7ss+Z5WvUDDHZMlwoLK1q3FS2dJkkPUlsYs6LBLt10f0raz9lgtflmdL4I
         ALvIZLXPWkEifTnl46MvaDyQMGiuvjHlty1EKX+42GDpiPRYqkKuFKOcceVEWJzmA0tw
         P/4dGFSBL0fP+wJAZlzcN+HfOW7BoGOwZXy7urGRN1aJV8LeLPVi37aepSTtD+UVcVOH
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836349; x=1795441149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=J4xS5D5OwkjOTd7yHE38B16yFh2kjR2IuyepI24RVejVZZynRNRGOzE9wjrbDWCSBx
         tk0Ks1Lk2mJODmslRuJd3junsjX/dKFoHaJoockVweGT6MyKOCTAp6T8P2u1ouIqLtWz
         TQb1w+Z4pua+U7bfEXpUDclKEkMwgG4KTfvZN4vjjQvBYNX7tyFue9pHtmqYs3AipLLN
         1vGAhqSaOW16tGmxV6Q+LPZdwATUULylOQRA1kQxrokT/9ET9V83CNtjiOyOzLsX1V/U
         F5MczdQeIy1m5p01jcBnDMlpkI6occ5vDkKhqmcW6/NcQfzbzkZYpvVuAy1iWahbPt/y
         +rDA==
X-Forwarded-Encrypted: i=1; AL+hErFRR5WvDMWcvuzVwWCC5ziotDxr69w4Z9A2pa6ItfGgLJY7P/Hee50pxrmueAO8r8agn84Js8s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9XhsRKFrO3K/dQeoPasxF4/fJXPzdg2xdCNm6/uzeOvZ3S57h
	6le+GvhUfVyjBQnj6J3RQ7OMADF+mHuB5BZiREiGhX0zylYbojd+rkX1
X-Gm-Gg: AYBFou1y0hFHqzRg0k1HjV7aabS8g7rmPxFk3QFb9kAgSQbhN2aVqwtK736HvjQbj8u
	djtUC6IRVcMoAt0uzd4u4s4G4m8Xj/z0ACJtvXuHj2vKNGTx2DOO9GL9j9Wbm6YItLk8ISx1nXA
	rnolkkId/gkRZwG5RIpTSMUl6nKQWBse/nankuyyrvEjeXaTmKVStIC0Swg6iI0sE2OtVZf7Okf
	SZiwyCiMu8J2CmshusJJOIHsnwNjmtpIlFgIVz8kiWD4jyNXSDsjiXUKg0xoP2Cxw5x10oCaNYi
	6GyJhgnxjO5ohk9LwCJ2zXnNDkebF1fvJU8Okj8TADOtKXeJG+rb/fDwGaqPNYMfxnsP1NslyNr
	2cNEpG7fI3hRrjcJ5RzYei1Pve1gfkcEGK0j//7NqswFcPjNbST/biWAN4gBPRFRoTV/JyHVlv0
	yCLBlHd9O9ddMFu7o7Y5Ut8qVE/ScLhrTbOY9Q/Pczj6r5K8Ofv8LS6Hke9n/ZneCuKWRnCMwyp
	391706nv1H9WOA2+r5vIptRNQ2H5y6fGim9prZ1jsnAfHc5EdtUnoBjTOr/Tb88HKls7Hjmmspl
	e6cV7dvHo8yOwUPt10KPlyATC6E8aMSzthivdzpgmIDS0Hgk5P2aDorkLUJJF1dPM+ERCW9C1gN
	cTpf6wQxWvny/hm17Gn3uQKtXqMKxD74Y728ArkKnA7z7kYvidYEe7LycTqDyx855DXrP9+tU/f
	dJEzWlf9lUfybaPDnLCrdxGqMb/9NeZhRrLEJ2QjTMjIGjApz2sViWkmaHIY0JBzpFGGztwlWNr
	g==
X-Received: by 2002:a17:907:2d1e:b0:c4d:28c7:eb21 with SMTP id a640c23a62f3a-c50963967fcmr876042966b.29.1794836349492;
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v4 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:03 +0100
Message-ID: <20261116133903.400202-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
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

resume_store() passes the written string to lookup_bdev() before it
tries to parse it as a device number, so the string is resolved as a
path relative to the current directory of the writer. The syzbot
reproducer writes a relative name from the root of an indirect autofs
mount. Autofs writes a mount request to its daemon pipe while kernfs
holds of->mutex. Together with a splice into a writable kernfs file,
which takes of->mutex inside a pipe mutex, lockdep reports

  Chain exists of:
    &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

A splice from the daemon pipe into /sys/power/resume deadlocks when
the written path triggers a mount request. Mark the attribute with
SYSFS_NO_SPLICE so that its opens refuse splice. Writable opens also
use lockdep classes of their own. Plain read() and write() keep their
behavior.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v4:
- Update the description for splice refusal on read-only opens.
- The code is unchanged, so Rafael's Acked-by is kept. With patch 1,
  read-only opens of the file now refuse splice as well.

v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by was kept.

v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..da5590ffe6cb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_NO_SPLICE(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

