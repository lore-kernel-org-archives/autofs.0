Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493030;
	b=I7LMQSSfqMErdulxha0dm/zFAZnlUMQ3Rh0ZikcxUD1WZSSlT0zRhBO0AknNN+OQkCTA
	 YsNxrp78ekWFNSBTj3o9vt3yufmSwYUZ9zLFCw0FfbOd75hNazt02PWrIBSzRsaKrf8OI
	 oUic4SYUXpuBfEtvkUH6SF+OyYPwZPz3X5Ez61fSmkGxZoAqWNAS/9bjPLLe+DsDratrK
	 D4/52s903p7a2cdoWwiHeD2Yn83cEh7Qj1AsRr8YxBXpsTQbwHp12u/TYYrHZ0yciXvZ5
	 ickOsRjG8SvHbMzZwHD+TF06teu/BfecVoziuC/WWYcvuBNfSmYJNuVJspGkwVYNZDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
	b=EbiA2QjDd4LyfwYwqZuBLHYAD2aonCKaBml3skzg7k3L5RMUzyPamLEINJKFtB89EecY
	 DCT8yAjFsfMhQ/j9KmzjlV8XP2s2PgUmpZGYB5IF0ODIavWtenWduafwLUJfata8JJzlC
	 TGw8uDflAY0JAdGL6oWXkfzTj+Y77F/iZ45XaEGe3JBDzMMuwaAgEg/lXlvEaAqOoou4U
	 0Yn8AQWjPjuWu3b9uOEsyGVqa9D8egg+l5xsHORrK/5sG4accWvHUgMCjLgqHVwJ2oTL9
	 8SNdRQoVRTn0ucyP1AUvtYe2GSAjBfvAWM2fI8AJtFxFLHanqOnm7S6zGYTbV4lCmQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1660A3815
	for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA1660A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4c9abc1824so613239866b.1
        for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493029; x=1795097829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=FBbUcmC3TkNMVh+tg9wiyedlSSvXNi3Z9406WpBziBrpIKlDlj5NNHzZZb1XcwSYkF
         x7+ZTkVfFCUyXjZoWOHRfjpzVtW6WtERVZegkoyX+BBhtCtHf6LctV6VsNgCgGV0Dh25
         bFus9i1wmGquJjtQiDSmWBBR4EvByqHrRHxYbuubocgxgGuB/V/akZFJ2MsZtV334UEe
         u5tmhEk4ZC+S10MzkDJXenSEKFawwFu0DPyRD1pp99MCJasPPMJ7cAmcj+NYoxwpxxca
         Xxlmv7CIj6qklZGD/w57xn370NWyL4vrjhTqvhBUvkfnPoXmRS1R1yOz+snKU5dVDUKS
         v9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493029; x=1795097829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=xU0qRiijwqzbvCh1PEzX8OMkHq1mqKc5hn6SfY+vwTD4XFGuUGkGHKkXsvSesSEm5P
         BbtQXe09Q6HtuVoaWedWhT3JL/Vo/OgBaW6OqaZn/FN5sL3txD/LU2DpCs4p2VfL0ZJi
         V2ET6ZhrCUPhIiQ6C7HOOO/YfW4I7IQvYfVP375FnlHnjdhyn0YRrYp36vKUJzLLnxIp
         WXJrs5o5ImqaC6igVBDczRvjXr5TKBwS8GI8NZdSWKYV3yruGtdCgBSNHuvyWlgaqBh4
         inlUHWKfAW9pqb3SjD40ayzP/l7BY0f/qgplEIUA3ImkaXbHDewQgbCxdrBKujy/lZfl
         1l1A==
X-Forwarded-Encrypted: i=1; AL+hErHdMbGfwkmxeypWY0+QnIhx2rKl0j2inICG4DwPnCj+ATqjFm8kR88sgCfxAvqAGkmd+A3+zsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3sHFQbyBBJXMmA9FWo7wg5tmdtEXZKt2g+XKtW3o1g4BoKLUg
	cK7IK250+I/qOpgHx7lwFB/SIOCeBREzFYn4v/M6W2YvpXJy7NvazSdl
X-Gm-Gg: AYBFou3D2LuD78i0cgpc+e4vuYsKThWWfTkDxOHNRoNqfHjAR61fXU06lllwTwpwXSu
	DEuF8xd2vm1bkdnWf2ulvUPGBshg+h6OQ6sSrQS4t2m4qPwsJvghJxst61MeLAHCE15t1hsuwjk
	jANMMme0/m+5xF5MXnCat/akf2BM3y5ei4HaPzwcvvQciBhlfqEZ4PrSudu3JY99zw0FaXx4FWD
	RZ2Di7Vf1igaTe3wIo+ICZGqhbc8qG38vf3roQpeHjsPKlOHuVQbZGZYjDyAmsYyAmla32Vh76g
	QI+mH2e5ukzcbQg5AFIjv7b5S1bsWskpLifmUaNObmr50djSiliYkLiLv9f1kiBTwN2jgDblvsU
	fpkLTSQHff8Pg11+7HfoaR1+uDr6UU5xh0ZTlIPojU6ALoKciRDKbOhNCMAgb4udqbKD6WFGA1b
	M2VwiiBdw+YKxA4+FO0sL7jSB4eKCA3FWwcoZI3y4leFpB/19nPRAWcqH/INh1GPLlp2TLRx1/D
	rTBPstOUz6SuliQtt7Prr/y8RmXTNVOpvhDEKySyjb0seCqxyuDBgEtwryu54vVNKRhVGGRPuov
	JtiZeq7U2SbIV8ljRmvpAcSlwiifY3jQ1a9lXl9xdqby6qPiW8SyvzgS7t6SjsTJjbK5kIL4t0A
	lFPjZih7XfvBLZ8l7vI8fuxVpu7v/fAeztzEtph0y2bgX8B/8y7Y5TengxD6+PMhetAtZIu7bgo
	3FmruBpwjeuAUov+Y3OLdpZYaR3SYa19kmuTaCBwJEmM1r7p2OEay0ljIPSnWyZu1oR7QoO9Q=
X-Received: by 2002:a17:907:3f24:b0:c2e:4292:d27e with SMTP id a640c23a62f3a-c5066ae263fmr504242866b.22.1794493028760;
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
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
Subject: [PATCH v3 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:02 +0100
Message-ID: <aae0f774a25c8e2048c09919d3b6b841e2b1c1dc.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
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
SYSFS_NO_SPLICE so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by is kept.

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

