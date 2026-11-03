Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717875;
	b=LwruQTw6MPYT8/2Bdx7CjQrWgVH1kXfzte9cSYVfJrzKwdccBXTsAQkRmUKjz9Z+S7gP
	 4HYZRoLQ0r3pq5D9HlJcasb5mD3ptSF/afl44bzPez6W/c5Z7xMdtftZMJKJXHCKWSWA1
	 lsdGKDKMKbkVa4rcMQpRr30JmcBpZDbLQ9HHEzcbgOpCnE/gZ4IJANdla2zlmJmNf340s
	 vQtwBPnzLqPwUIM66bK3NFx1Q5fDHNsnUspC8GZWtnmP/k5kZp7S7ptdB+1gDuSy9lHWq
	 JUZR8m0hvkxwkr8jmywt7bZLmVU5ZPx94ENbGw8kH7Mai8wXKQlPQBbRZBVkeisZmwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
	b=kK04HPh7UI1eebtKt6LormGJY4XewzQ61UGbN8bbDYhrB3mgqsAum6ugTare08Che/kj
	 JZVd28XHx/VM3ahOF7o5fs59oe6axV2VmZaXpvP82Nz/vgyc1W2B1vU6yHTB0lPM+XgsX
	 uJJMkij/qrt0CD6C9vkReAxnO6wXNmyg4hKeHKdpFCs2JNpv3imtXXtEGOfDm6z79yb5T
	 JY3LwuoMgDziqlqXm/G676oMcCuoHA2BCzR91Fi6iCVV0cmLwiarLq7ksQEhy2uAfZg3e
	 1CwGMNYzgLLALy0Z9eS0/rOuOxg3N9DYBaJWiKMw6sTq2K1hh1U02o1wPboVmvI0hxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F2606D817
	for <autofs@vger.kernel.org>; Tue,  3 Nov 2026 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94F2606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c34bff61551so706761366b.2
        for <autofs@vger.kernel.org>; Tue, 03 Nov 2026 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717873; x=1794322673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=x8qJF61GmIRGyteW7Ikwi8CKb/NK5DCUXyBgHHKcZ9Gg67wv4grBJd98VKSg/ccWyI
         tU/TkQ4qY0FCqSouDzu7zFw6uf3g95H/xnRd3xZ8Z5sf8LEBwdsVpp/hIb+2EJzZK5PM
         xl3wrZSJsE8a1bZDV6mHsUX5AeSuNdHpqmUQz7NEnrGVozt8jPe8z8vgrmjgQtmd8xC0
         sRboqJzqDy1lfFBXt86jCWJuO9orRilnngG802t6xXp/jv+fJQAjvHqoo3FcSz38vhZC
         PdZ/6YQScplUxkWykUKNqwClN6LjZl8Crj2zoFUyS5yz9oheRQ1ovk7r+UJl+hB7m2K8
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717873; x=1794322673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=z/XaJQkkd+QbA87/EwYVS/CqqL4DWEXQxYMoXNmMBZj16PTKDslBXrbULlj6NrElnN
         VQoVAdqG8BbyjSEdFqar66r1V5PVDlcMoWoP2za6/LZza1bQFZy1DCpSpoqKaYMuGJ7t
         YJuoSTFKwvE+Tmuo8yghmwqvLLb2MjGdtrWHQoQHYp+T4DXS5N9RW5mvRS5D9FfKIjEj
         5ySNfeXPtshl6HBFzjmZyiosyB5Zj/vZVXfrCmq7+ij5+FOIbhgX81d56WYrgxOO1IBo
         9kA7cKHPiBWhkKo9lbaNBtyZRVZ8vQQ9qF0KxNFzsvNZOKrUmLzAxa91R7YsNfvaYWq0
         X42Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIB+FlX3i+Tw1BI7g+1k1fO/PxXih5aujpkwM3H6tZSMWziHmRJRBVe4foriEzDZ+bB4qxlak=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yv0GM9ot+Dgh0FNE8blqNKl2zhokGyRrvKTiq/RT/9mRZZSA5
	zCkOIyRmBOVBBLRRvBx1bvRtHcf0AwkkOgIQTPUTuPpWWDKX393WYZa6
X-Gm-Gg: AYBFou0jbQyWdYwKief0RkKKwqtkwKPW5JqwKquASVZA4yyR3Of8V1yrb/983BL2VQi
	enWcBeAP+9KFYLNwY2Uhfg3pnihTsXsu7/ttLthlwp2nUCAVtCRgy0SlQS6DzzTuumL1kaGazEC
	DzbPotpCIe6XQJcPJ64omWoJPz/YgJd5Hbi2TcwhbKv+KA/OFhx90u8Kx8yQk4UwBbdI/48ZAf9
	E+9jMdDvAMLPlnAo4QJZToogeF8bq/M6aG75H1jcwmViABTz8cgSUUfM0fHR1WzOQDc6tVQl6kj
	E3OJJc/Zlwd0CmadI/1ska+CVAa7pUBaRln+zjx4Zbr7mLUPRo4hDfuLSwauJ/RLOkmHviOcIzh
	Ih3gL3Nn5LNWhltuiK+v7kZYQ8KItGPEvXBzxlJx15A3lff/bHUWyqjJQR9rA0iZHyYbXpta8tT
	SfUtHKXfT43GMzi4gJUHlCw/QQzEhFgOmqflIP5KhywHMKNmmKeGBzdkMutIjkScs4L9cXjl9kR
	9lFiURTlu3y+8X1a7IYVQy7QGBJfTifhsIqj7ZnkECieB0J8pyOPlkspGGjVpOCwzonGFXYbsKM
	qpCtPcpZCv2zWMIu8p9er2eoaGQwMCmtppZq+F0pjranY2rs02+HV6MGx8t49AQ3fKPTTc7Yk2q
	OT/Xe5OdOSQP7YrG4StnyWW6vnHfy+F3efkpbcwBTkTXMJWa7cYt3nGzTn18rma2Wio8/lShVjW
	BhT1MnY+G0fYaHNlfIp37qKvK9F4rfjq5DSzDbwbqwePtwDICCXdPmF299qyT59qYtR6bu4WY=
X-Received: by 2002:a17:907:c23:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c4ca7ad10edmr1125964766b.41.1793717873240;
        Tue, 03 Nov 2026 06:57:53 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:52 -0800 (PST)
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
Subject: [PATCH v2 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:43 +0100
Message-ID: <417c773d1719006cc85a3468dc393f5e754bf855.1793715774.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793715774.git.krystianmkaniewski@gmail.com>
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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
SYSFS_LOOKUP so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd5299..9dc5a27f674fa0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_LOOKUP(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

