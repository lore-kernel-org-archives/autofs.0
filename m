Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587120;
	b=2FC3hplbgcOSAGKD+PQtn6uhOnDMKDifdCHNjPAAp7FIGFn7MyzsZcGBi+bf0hbeQAOC
	 TsqwXJwko13suDCyPik/4saXr29yRPPVMjvdyMuHEkqKXXb+LkZrWUdHGCqpEkbz0WRp3
	 Q9tZBoxpoy7WyH9P9ZwSOIGwIWw1FhgYb5X/SS5AyXgf43nZG/bLfoPEuT2pPl7g3JgWj
	 61kMez2i0yjrfjCDJvnJp3UcWhlvFXz518MJo3x27ItlqNjXvlY+9f9j98KRAzfAy8jfr
	 U8cuZU/8EwMOyXzM05BCtoNoR6o+BXrKZb5VN7UUChdAQFRQZJZniU+VPp4UujpAQFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
	b=RNP9S6GIxKOobcJGALVnoaIp4Ii/CE44IMGgOGmYjrFhOIIvSQMC4ZuDTbYp2nLBtk2y
	 Ry7/ZHUSSxIu0OsrLDHCww6W7E6J6SJpMOqcdWN7sC40obkZj5nf9HjjejM95HRQeQggB
	 J35Bo97/ad9lYchaw0MWchEtuIQ4BCW+97RCaMX4T+vDirv/Az3cRG11M0+9pI53KMvIL
	 cX0tE8Bs4EDUuDgAYBXABQqSAEDJEg17EUaKZrDTnTA1EnXYMMj79kDR7mWS1IREIbFxS
	 y7vipOGwQ+qWPc3p4+eB/HwEcnJOhRWNtYEdtZA3R3RfhNX8Z+JY1Hz+AIBMDJl32dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cG6uo9BE;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD329606A32F
	for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 12:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD329606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cG6uo9BE
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c45551fa84eso91469866b.3
        for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587118; x=1793191918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
        b=cG6uo9BEELzaoqgbe11mFN6vTx1fa06/lNMCeAqI5ThvD52TIVBlyPaI/QS/zP5cj9
         rsEWQebXUX6m4fBiYDoZXhb2PcgNDZwixWaus0ieF8GTUvVLCDg9TlrxbZcqTLasiCpt
         xRFmwOAWYI4+lyJwIc1+qQGi50PtAnu2ULaE3nAfQndJz4auQmhDUR4otzAcBUfy+QDE
         sVDyW8oHUOWXSvsswUPm+og9ZzPpUqrcZqfABBeI502ZA6bSjCaDu89akza/TTmRfWTs
         GxKiz9C1DD4Gz08F4B8JAEvvVVY0Msvpi+eP8y1e7PteaV6i6MRasSpEKoW96ykirHED
         ZOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587118; x=1793191918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
        b=iSr88XpZLLgPjjO2YQATEMI4tRjfhAdRCgA5s+XV26dfwOs0OItM3+SvRn3fpdIMrb
         dvQyKEFMKb3UNKkRy+HT80PIS9CoopSENIubaBP8+RDsN6vSHgU5Nb6x4pbH7LLiLBeb
         Nt8H9yqMMdaweAcX4HJdXg0OpIYy4Evp0OOykdv+iAuwbPN5Y1zdVpfFd35kUo94v0bq
         goqDGc85FUcueGUTZLaLEzwUJ3uyQSK3sEbcbitJwSrgq/aUEEdVTwcS6c8qsEgzv6rc
         WQoZaqf4YjTnmXTqP210R/F8WEF+AZ4npnCLgtG1hFWAm8GolGoq+V8r0hg8cwbhiOI8
         M6eg==
X-Forwarded-Encrypted: i=1; AKwUvByttnv9boYCLPS2GP6Q7G1tWNB5yfFtCWFQyBnpRyUaUha1I+R71TCdYBxOnmGPW+RPr9GnhYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhi/BHN1Q/dG3h9SlkYFarFN2wesgt64Um+FzK7TL6xmlTM7pK
	z0Xcsm3AiZzSRBRQ6XQNA1hjTtZI21eY3QRvLOBIZud16OTtlyYMTXBp
X-Gm-Gg: AYBFou3j7lFGQ2Ke51ZcH48VwajbD4yDvP29YuZ3ji9s1GgHb8PFrZHELbaojp3Qo0B
	Nd4atWlb2xmcv98a6AN5Ir97iyuvRc8Jbj2k3KkXUq2/jqgRJ/mqYqMDCH98HS9d+9IPEXGi6FI
	oup9RCImsHrzagwwzIHgrLZCdIXUugVDeOFCNwdCU257AbcbQI4JLycHiZwUYyVxwZFQ96yPA0D
	uHdWAMilO4IMIybjFAzJrY7//LCYXBbefuKytfVZl7gS1jiz837uZX4qFkHh1fnfXyrPIziRfeq
	/P61JXBhkjcdgoVylMOXGPQIRFEdH87gYBExmmGGwba8o6VZ0rkirjw3LnAR3PfIhefRYFnTOsS
	i3al5+2gbXFdthtMFBKvmYhn1UBcWiZBLaw6eypUvoTDbb1E8yXYJY8Ss+dCY9GAABpuzS5I8DN
	ewZeesvxyDn1kVXOhqePds2MK9uemIJfHHajstczBYhPni6TEvDeNsg77dqZnEDuI92UhUGEy6O
	OppK4JKWmqEYasZZTWvTNr+yOkenetW2Q+ENZsJReApFl3sUxNfcR9GmvkJEQeWy7GX+bMhy90R
	ixZIw/vfWUhSXj7zL2jCG886Ld5cerAjrMSrKxo6hUBlPlyuhGoaZZ4A+YrXNi+FsRtMgr4qmjw
	nUpVdpV6QBCTgAMOZnggMLshYyj6T2cRW3exCH5UJIBDx7lUDJ4WzbBTweJZVptDti4GA0LhXWI
	GFSnnz65CEDsGYq2ppLCmnY5jp
X-Received: by 2002:a17:906:99ca:b0:c40:9839:c892 with SMTP id a640c23a62f3a-c4679594c9bmr175067366b.19.1792587118009;
        Wed, 21 Oct 2026 05:51:58 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679004464sm73128366b.67.2026.10.21.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:51:56 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Kent <raven@themaw.net>
Cc: Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	driver-core@lists.linux.dev,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs stores
Date: Wed, 21 Oct 2026 14:51:48 +0200
Message-ID: <cover.1792577179.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
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

syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
&sbi->pipe_mutex. splice holds a pipe mutex while it calls the write or
read handler of a kernfs file, kernfs takes of->mutex there, and a write
to /sys/power/resume looks up a path that can make autofs write a request
into its daemon pipe and wait for the daemon.

Patch 1 stops holding of->mutex around the ->store() callback of regular
sysfs attributes, which do not get the open file and already run
concurrently for separate opens.

Patch 2 handles the case that patch 1 leaves. A store called from splice
still runs with the pipe locked. autofs no longer sends or waits for a
request in that context and returns -EAGAIN instead. A new mount is
refused before it is marked pending, so no other lookup sends the request
in its place. This also removes a deadlock in which the spliced pipe is
the autofs daemon pipe itself.

Patch 2 changes behavior for one narrow case. A lookup from a splice
callback that needs an automount fails with -EAGAIN instead of waiting.

The series was tested in QEMU with lockdep using the original C and syz
reproducers and focused splice and autofs cases. The target reports were
not reproduced with the series applied, and the paired functional cases
matched the unpatched baseline.

Krystian Kaniewski (2):
  kernfs: do not hold of->mutex across sysfs ->store()
  autofs: do not wait for the daemon while splice holds a pipe

 fs/autofs/expire.c     |  6 +++++
 fs/autofs/root.c       | 28 +++++++++++++++++++++--
 fs/kernfs/file.c       | 52 +++++++++++++++++++++++++++---------------
 fs/splice.c            | 13 ++++++++++-
 fs/sysfs/file.c        | 18 ++++++++++++++-
 include/linux/kernfs.h | 11 +++++++++
 include/linux/sched.h  |  2 ++
 kernel/fork.c          |  1 +
 8 files changed, 109 insertions(+), 22 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

