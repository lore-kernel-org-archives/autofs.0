Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717872;
	b=i+dfCV2FFQ3thc+eDoZzlCnM9XQ6XQBIT+87CV9oWuXdqzN0O5hbQ8eVy8NohYMxZ7Vz
	 vpiLqCoL3fBVIQKfyg5wlTQpxFSBrUMrse2+ugxyz8eihH1ru2JyDdUhJ+XYzmjyYrdwr
	 s39enaIjjkWK+h/efuvn7qECQTdXZamUefPGHwA23Wm/aXs40PQRT5ek7EkTa48dXDmWO
	 HCnGnEn9dl5Yy5w76v5AcspJ4A4j8MrvE/CryNuvXqj+mOvlri3EJ8VvEH1124+UT1D3z
	 4zLmCc7nHkYyDjObPzk7qcbc5IROdTReQ3waEAbXO3pIXWDrIiF4e8HbxKL6t74T5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
	b=b7rmL2u7/HqiVI4s+FB944CkWIAnKUzyqppZz9pVlMRd6Omz28pifJCPfh82KwdHMVi6
	 xizvgaWeXSA49trCelEtMpWWrBJrQAdlO3m2YQUjRUZN7Q5bxysf1i0uvuxH3K8RnGQLz
	 rUU2hLK704gH6XWLYBqlJJAbJSmHKhnkRnPempoXQa+hJJCvFTXGW8pYUuYR/L5Yi1SUJ
	 VOuGiuyEO15qAtNR8ZeskKWJ+kq/E+iFjGLxkYNk153TuTdCEUaMfjVsfkQt8N398e3hr
	 s8/1cKFJ0oJYMg+mONTo+PPs0WAA3jpct5lp84Ec0LwwrAMIB2wx3XJKvBGk49x5tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F0606B25A
	for <autofs@vger.kernel.org>; Tue,  3 Nov 2026 14:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275F0606B25A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso599548566b.2
        for <autofs@vger.kernel.org>; Tue, 03 Nov 2026 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717870; x=1794322670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=p6WV1j5xXG874wk7PArFP5ZRw4LM9P09fLU8fWNlvZNYsq6XeAmVW+axCc7BtE334Q
         OLYWFYNZHOeXzV42UcwdRCoa87g2vb1tbBgTpbUGK1GyzD1MzRv7By7b4ET93hkze+1X
         hWaAArnpALLpnihpMF53D8I7MR/Gu4mzaE5FgnJp2nfTWuRwTk0O7VE2qa6vTu/WR0ep
         kM5s/s1XbhhW4QrB6/NsxlZGJYoJdhye6EzfYDEd8hAMBHrJgLXLdMkhwSU2OPQgdpZ8
         RG2FvIWbDQmPS2kP2Vj52O9VhjSuNSZ1mpbotFjn6Kw9g1RdCaXFrdGOjAQzwfMGqo0L
         WA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717870; x=1794322670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=MH5oZXfjBV7aBGrtnpR/MrtVUfPbzz4xnOcHiIz3IeKpcjvfraH0uP8xmO1AMXe8k6
         89n8p86WlQGXqdsbbNBjc0rd7ThgFBpBPdIFuNpPys+eL9TlFhNTC7005sQmEq8d0NUV
         JMk+6tIuIl0jcStqYqzKh+Q6KUXxk+R/r01o4a48E/iCaWrOUkyr8ZjhNrU46vA3A9uV
         vwP/hxIPbfjaWOJ+uYsR41Zj9RM9kbxsMv682teLSnmlcvfeqOqRNDE6xWqV8mub5XLi
         LjAlQzJ0M2nIJYI+dmELbsPpF2Zvn7LwyxPW18UREAeubzDn094WigdSd7MVBPB+5w8Q
         CUsw==
X-Forwarded-Encrypted: i=1; AKwUvBxNvaU9+DsXBi6ksIMsSFekSXvZOdo6yCWbv3X9YUpQ3pTC0m1mrHmnZuF9hJweG3s4BGp4SAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ED+XEQnKDBKfqyOUykHrFHTN6DIYnw0dyeS3ZcJQalo24BwcP
	JsaeRW30FcA1bMz8fCe1KG8/IRJ9FjRG6vq6DC7HEPfNuNeIeWybzyEi
X-Gm-Gg: AYBFou3L7IyO82i5q83ziVquWYdckF2sIQ7jpiwiCcj82Xqdv1MGBr+9LkTsVYszV5r
	eg9gu54SRr4JdBJ3tEqu9G36As2tuC3j72yxywCEVvtIG6rZmonbCvW+Tw6ip08i4qEbB3TLEmm
	HoYFN90dLUU9Kg6jypeY07I5kd/5gJhLlhncbssddRsIu+RRBRbFEwHgrGLa+UbDNRTPAlmaZyP
	c3zOvJJWZpqd00VK5TscqNmsR9WgM4wHHwzLyQkk7ShbIrdt+VL3ogS9zV8vZrwHmab5pN9Vjo/
	1ctjQA0KS+wrsQgdxQmycsNdL2MIMRdNz3YMCDaA9Mih1x6WkjDeSlna+1UDrGOmfdR7yW+JSrM
	1U4gLsU/qMincAIgdOkj6EhKsWpIInX9V4qa0/2RphmM1Q+KD+dSHaNfClSCO4EVsOgOD5xu1GE
	aQa3gWtvAfk95kwiyNJ28xF59XdEvuM0uiXqqNq/b1cpbvBL1BL89c1jg9jFhDoS9wFyAelRSCu
	mK4GuG6urtAu7uCozMkdfvQzHv96Hl5rHDwQBT7C2+VmUtPHCroNvEiIuGgkE+kYV+muYiPJTEO
	FFdMIzU9wnEj2Qjo9Mw4hr8hFokvvILTWiO0tDqWQnXDPfTBIKl8cuwFf4PKQOvLSULFtY2hWFw
	QMacGOnjPfJGc2jLyIPAC9onXluKEsd7/vRFHXspPygIKiUgxd3NtoipfeenpRWfxApon8qjhwB
	JD2E3NU2VAdvp/rnFrSX5s2t8+T/IkMTiuCF6/j0gOQcuueFp93g==
X-Received: by 2002:a17:907:7f90:b0:c49:bc1f:fe2d with SMTP id a640c23a62f3a-c4ca7a858f3mr1272502166b.28.1793717870207;
        Tue, 03 Nov 2026 06:57:50 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:49 -0800 (PST)
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
Subject: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:41 +0100
Message-ID: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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

Hi Tejun, Ian,

This is a narrow replacement for the earlier kernfs serialization and
autofs changes. It follows the suggestion to refuse splice only on files
whose write callback can look up arbitrary paths and to give those opens
separate lockdep classes.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A normal
write to /sys/power/resume records of->mutex before the autofs pipe locks
when resume_store() resolves a relative path.

Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
marked file refuse both splice directions. Their of->mutex and seq_file lock
use separate classes. Read-only opens retain splice support.

The new property cannot be combined with mmap or preallocated buffers.
Kernfs rejects those combinations for direct callers, and sysfs rejects
SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
Binary attributes do not support SYSFS_LOOKUP and reject it at creation.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs.

Other stores also look up paths. They remain outside this minimal series and
can be marked in follow-up patches after the interface is accepted.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: refuse splice on writable files that look up paths
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 54 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 29 +++++++++++++++++++++
 fs/sysfs/group.c         | 12 +++++++--
 include/linux/kernfs.h   | 10 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 118 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

