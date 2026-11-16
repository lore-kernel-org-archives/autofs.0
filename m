Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836349;
	b=Div+lSRyBwT5Iiox8297EWtFku3DR6Z4VDfZqo49BG31lpEoI7dHc1d9KQep/ID9HrCj
	 Z7wKim910i65IerfuQjoizqASwSBDK+9YKSRgEXcaCxAcMRFfIfiSuZld47/0a+2K+cZT
	 yZRQog/iaKRPQUYdCD6w8PIS18wVg36nChPnTkgkdyStwLtxSaeLYeAtQjzAnQmYqUOb5
	 tCNHjxMaAIh8R0mPXxGhU3HHBvfGezBKM62t4chmDEtdbNJRvRNTfQRNUMrWOaDuiSgZj
	 hIhSSwQDnwhNpNsA4LFI8hO+dgCAkgW1a5B4x5PZdF2WVwOHjpZJJnsTbEnau+YtomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
	b=TxdCogAeVow1XuQcy1MIWnq1fd4VfXs86yc78kZqvgJ3/53k/FG9gHJNLluabq421i+Z
	 o5a1sC7oq2nTZnoamoRg3AWqbfEvWKY8a5PfEe869FpNJZmYW7qzqefap7+jkyt8ycIlI
	 gecnYIiCip6JsoOhRG+tyiEU4tGRyKw+h1CTnv64skuicYJU2waX6tibSJ4rgSOAkfT30
	 tgyCAywPRZqSI3FhlR+W6un2jzPAQmMeTaT1qxA5BeKGIuUKxqDHVmaE9vnReAscsdlBW
	 gdaGHcnIG3o0iAdUqeh2HCOtoZEfQR9zgOUOhLiwZWChcKAE/7D62ywzpu06d1JDn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42F606A330
	for <autofs@vger.kernel.org>; Mon, 16 Nov 2026 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC42F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5075fa7ed0so578069366b.2
        for <autofs@vger.kernel.org>; Mon, 16 Nov 2026 05:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836347; x=1795441147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=fQVNaGWYmeClC+iZ5aQrT2xu4pWQ7xor+FJzP7Vz2OIGAYwCe67gtufjbbImSINN3n
         UO2jkZ0DKhUwCsCd6coLqb1Gx+xCqWEmzecVe4PczqQzaQ7wPLknCr9JLQDRw6xeG3uV
         eboCkLF6AGb4CQORCOgxrK42uN+sd05JmMv1vySKwmu/TTu3Y1k4xAf7gaT6mlVRO74I
         nhqQJOqydmzv32StJKgB98cKraU4xkfgTz9FLErM5Yad2WAfzVeegpVRb2Q2xvmzvAR5
         cz7rmKlTQCyfCvBBicYeyMcX1rNWfvRmVZsMdxx4c8NcLD5x7IbT55qvjnX4NmBQgj7h
         RBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836347; x=1795441147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=kmXyq0Iy+BxhAjmBnqVsxhplhCAPtdI8TqQOtAXK/WZtR+M9JqZaUHBnTE5LjdbBs3
         Lfo/xx7tOmLzXAucIMOpW3Ue9Ep3+L0U9CIOZ580CMZnF3GW64wu+M7uP59hWmnxzFiT
         tNsuA9QTFu8VKtZJ0nxZN+AlEdOjrosC/n42Bn7OUR+jUY4awtCkSh1033qeTLLHg65F
         zs69s44D6OGqpjjxU7em/tnmUM0EkT7VCwk2AiWuJ8pbiz+3rY7qWayxfYXMzVkz6W63
         eACSeTgHXcceqA1GMqzcICRGqkfqNCBEzxlZkSTBqfgsD2VhhiKMv/AHxXExilNYZVmJ
         PG9A==
X-Forwarded-Encrypted: i=1; AL+hErF6pwk4GlOISR6pFvDu+U2n7OngMfI1lJHpIIYQ63Em991tu75bAlr2fuUp4thbE7LurCg0XdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+34qlSVamI+dDlRTGJylwRJQ48fE1HZtJ5F/Bc76P9JuNSpp6
	Lox26tZQ19RQZEb4IGsUBhHuP9VIfh4I8CJ8qbsDQ8gdT4aLNg0OhGf9
X-Gm-Gg: AYBFou1Hozbxc8ge2BkMXVSVT1s0ElLojw+4MdNn3xfmbx44Ap4b3B/CrLu0ycrANO+
	ZTB4JoqFCjWf+LPTXeRKZFw3+jsqPG37qaE/sbtha8uialnsWSDNM6INp3+D2GLcWKkn8S3srN3
	W4ihPnaE1EbWXkMiY3HRTbbpnpNe3eGSth12H+rLw6f5faej4zs0c7zcaQWl5ga4WT/tKD2pQeV
	/SxWHp9KLjKu8CF21KfQdIRqC0ZIhA/fvJpPr4jqipge36PJQfGeUv2SVFdyrfnjLPfBVz7Kqo9
	1N4Cedo2tV/8U5h7GfSctR+123rAXLHxP4ufMDtcvL2mi969XlbNn4CpkfVHUlV8yl503HgL/QS
	Wl/sip2XFx5hL4Gh1HUBgk2TE16XeZPR2p9qboS3a1Z2nQmyWphGARxVMYxOjngzjmWgwV7K7c0
	r8h9q+FZE+B03MEBUiTOXz5VDFIAcffSJrgAS7Xn/DBkET0w3pTrXleJvILCHyJzNqNh5cSTluV
	ke0ABb4msxQqwSMM1WNuUPUFsCtWkeMgFi6U/c2aEEkGT2KPp3qByH5LI3CKmvg+765I7oswZiy
	kZFihVn3NhPn7JgEZOCNh/31C3e4QfYXNLOX3fEWQsF/9MlDTwpkcAmKYBSxh8fERV0v/8Unlv/
	dxiaW8YkbHPU13ciPlc7ZsrQzTDmf3l+9X26Z3PDRmfXYuI3VhdFrGSPlRhHdVZ/HyrxB4lc5Uc
	dc4J2xS1pw6SE/tF1Ly6hC78dJvVjHBybRoR//fO4WHx+b/CRh4vGA9FYL5D5vesSfwENarKAYu
	w==
X-Received: by 2002:a17:907:1c8f:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c5096313a83mr870027766b.21.1794836346930;
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
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
Subject: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:01 +0100
Message-ID: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
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

This series refuses splice on /sys/power/resume and gives writable
opens of that file separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Every open of a
marked file refuses splice. Only writable opens use separate of->mutex
and seq_file lock classes, because only they can reach the store
callback which creates the reverse dependency.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 with fresh builds of the exact base and the patched
tree. The original C and syz reproducers report the lockdep cycle on the
base and run without a lockdep report with the series. Splice and
sendfile from an O_RDONLY open of /sys/power/resume return EINVAL with
the series, while read() still works. All 33 QEMU cases booted and
completed in both phases. The builds, W=1 checks and Coccinelle checks
introduced no warning or report.

v4:
- Refuse splice for all opens of marked files (Tejun).
- Keep separate lockdep classes limited to writable opens.
- Add no-splice operations for read-only regular sysfs attributes.
- Keep Rafael's Acked-by on patch 2, whose code is unchanged.

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

v3: https://lore.kernel.org/r/cover.1794479968.git.krystianmkaniewski@gmail.com
v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 51 ++++++++++++++++++++++++++++++++++++----
 fs/sysfs/file.c          | 23 ++++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 +++++++
 include/linux/sysfs.h    | 22 ++++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 99 insertions(+), 13 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

