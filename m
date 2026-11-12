Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493028;
	b=s0uTMwJeCx5a0twFHq+DtOyrDqkVBAIt/1bNamGynBO1QiQ7RMKcSW60fOhb0sN5enh4
	 Un/pEb7aat581QKsxKVuQC5uK/l4pB+cjIRoP1pMmnpZruQ5bWFvbne3ij0/YOOBCtZPa
	 QGp12BgSenOM4QiinCD5fqIP13Zb4C24vCTWSGVsMqRQso/bzRgjv/vYWoyYCgHA1JDcj
	 fC4mSjwr0Cy/DvGKCIDjk1+KkIZjiUeFouBWwwHvfPuvsYpoE+ZkUsS4M/Mz2oR9dCLgN
	 lmA2y1etY6TYZUZjTyNjS52u+2PsT/8RjDJg7CVTFOqJ/BzMkjmO+VpOIIKF/0bv6Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
	b=gK4GzGVEqtJZ1cj3UP9lbSlMhIfcLBZNAzB/Ber3kTgxbzOBOpRVaW9WaXxnCJTcJOLD
	 XQKel4r8hDl2rkmnFd0SZ7RYIiTzx1vCmt8tQ1ICMPnZpYJhMQah6SBiBfrVWEKrqu4fe
	 aJE0tFKUcVzTru7uzHq1L/qvkZk1BSbMa2RJSegFa5pYW2WxaOCpDOftDW/d42YhMXNYS
	 F4koP35FfBVoRhJvDnRGaSxjtylHh1Ulm2e5N6dKlb150muTGlkWLrb1Txl+JY1FrFZXZ
	 kDSgHEH/zj/eWtLQPvCbewbKxuGK/JGsUniLi/5vLkWqn8maNUd0Oq4jMLVEDfOyaTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BUc/oAiX";
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE0606A336
	for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DE0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUc/oAiX
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4d21051042so676308666b.0
        for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493026; x=1795097826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=BUc/oAiX8fnhkktLnZFvgLNatm2C/o2PyMn9TAlcNkOqWquh+iDGcpCDApB4TUPIJe
         szU1ye7M0VlqedHpuHo/UjjBFRdDNznR8n86L+9cZfulBPjCPrQtsGj7cS9Jew+uiz/j
         BPM2QVXwGTts7clvGUtG+K8M67nUK8uC0Cy7JTV+R5igmEOwF9B6Ay83mcEKDbgyCzU8
         0ba3S1RFeRz9kOPxUzfcbou1wF6kupEGcm1Essy2qdmZWVGY/Xt6wD9LDnb1R/zYFUWf
         G+vAbannvJsIZA29ZLhmQMtaQPfFA7Irx7D2rAaAr+v3W5Di5r++BfmcU77pSyYkI8e7
         hmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493026; x=1795097826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=vrBGOBKunzu1brT2QPN78fpSxzcRS7am+M7Gv5bTN6rL8yEwwETAIfLPaQ7OGgNcNH
         yqfvJCsmigyt6w7aVgGJMp7WmXZ4iwNxv7pIyXHvETtfu88EhnPndk3u6VRWxry96D7y
         YaOozV9QJpmh5klzON/oxsXElW2hHUodktjiQikIFW5fyAaiy/tz+n3d/6S3/XQ/sXfT
         UltwSWq0mePE+gw0b3BF3YvwFlurEJGWGwSPUlQoOOoncuBbBZOX49BIHo+UmETpLfHg
         J/dhRiL5NyEOcPo7VpK4H1w3lQbcHaad/18VHbkOsIuU+jKNRR5u+yyifPCm2qNv/EBU
         kDBQ==
X-Forwarded-Encrypted: i=1; AL+hErHm7aLFHR4e5R4jhizlUgW5kN5dNUo3bViKATT0NpwJqL7+1V/th+zL4ZeQGwy5jjoZBovYsjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/742OoKdnd+p5Dr8TB4dWUCxrOKVYNJDayK+zu+dAFYH1Z3XJb
	GYoKhQt58KNN3a9WgBEF95dZSc64BxWyZQ2s6w+8mLcRiIJph7l8IN0A
X-Gm-Gg: AYBFou3MWIyzlwpMtObT/fqVAN3xfRH3MGNpV6iwzRGsXExgCfX0LJKRmn4KILCg2De
	PZTngMQlaocEKEvnuB7a3RgrW9/Y22bpte9PYBM8loKkL/XjVp1OoYptvsiC2F0usALUi9w4TRo
	ks5lshyuHBmygiHi8rlbZ4swpL+bDxJ8+3ELp31yFfmRDVDaoNybXQ/ON2okuQBqC9yS9fsHdqq
	6XPswR9UniFokxFaOh3M7/oXfdQ+iQw/XAJ8tPQXAajhemjt7qJc8O7zoEUPsAOq+S4A8YR3S3z
	tlap2E0QmiO5oDU5gB1AW5wbqai829fsFQKUU50GAlzU/02Est6q5Gz4uiN1ZoGPcKOyvD1i4m4
	Z5RG1WnQ5wQp0NG1g9dg4BebDOXDCr5VskfX3kYdZrPkh7XBML3t14BepPywJuWIXvTA6Sgz/vz
	3js2fK8LUKwEkQTSvjow6g+o/P7avvhsX/2h1lT8IFW4rAzD7xpFJDc+kPDhetUXPvt3IO8J19e
	tFTuArvtsyw5loq0uZ4At3SFfcJE3Ll/khF/ABt0ngTbahP7f665WZUYw/0PBdXJqaqRpHYoDB/
	pGh4cC97QmLpvMfxK9rhz3IT3M7qohX9YqwaoFg1KILE3p/7u00Jn4wgxJBgo1ySC4UFKnEHU0t
	tVj/o5WVhPCR2uLj8Ypqwwp5s4l6FLB1ujHib0YeYcHEb6+rZ3Cr94FJ+0/qDo/4+X/1/asfsDm
	XUrsslDceTZ47lMmwWtw1UBQdM2tdHYIbOVeFNTu6B7v3UtK2q9w==
X-Received: by 2002:a17:906:9fc4:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c5066cf82b8mr489669866b.41.1794493026263;
        Thu, 12 Nov 2026 06:17:06 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:05 -0800 (PST)
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
Subject: [PATCH v3 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:00 +0100
Message-ID: <cover.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series refuses splice on writable opens of /sys/power/resume and
gives those opens separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Writable opens
of a marked file refuse both splice directions. Their of->mutex and
seq_file lock use separate classes. Read-only opens retain splice
support.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).
- Add Rafael's Acked-by to patch 2.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 46 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 18 ++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++++------
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 90 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

