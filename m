Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062683;
	b=Jrm53782+d1rq/SwNNKDoreC4p3lNTCzDr/3TJTk+Mp8OfCIiV3kTRxxVQJEOLYplTfT
	 1Y75TKoTTt/wZWQzaNvn5ByoB56/8aKpYTsCVi/ER7OkPdKyyOI0NrEV940o/xidO8Jvs
	 sEbdOZNoM9SsJ66j6FjMsCHP6s+k71nCdHnzA/gmqnPZR3uD3TWf/Gj6QPMdbxTYTqdBI
	 4aU+DjLu5pT7QyZy7zAEplWdHSgGyXnOaVpiHe9kgDAYXRy8RCqWfefP3AGKFFJNO4c1b
	 S9JFcLQLU5O0EAc943t1ON4kAHxLDB4XgB2SIbW64TVrY71+cXTtGC3MlAJB2a2jORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
	b=c+0orKKVdrsUj1wsnzUFDNhTYfYUdflgQxBPr/YD8LpxqTkHB0PBZBnYKukGC/EoyC8c
	 09YiNGf7Orl4lvMeGns/X/wgc/6UEQhJ4D4UfaIKlyE7FRX4opLZVvSiU+UONzZijjD6u
	 WGBtzYsn5XMp1cckKN+fRf5Oay3JAYiAKBkSZE2rf4JiqBQiJdWu0EYXWERfwTvqvSSi8
	 fOwhLlmjYlP4yWsqnbyWp8oZhcn7z4//UWu3vEt4l2Ff2DFyT+aeUt4Og/fHuA21MPV2F
	 BxvgkXY+ieys6K1BHfeFcW3JP+w8g/hefvaPQaWnRfP4dvzB20lxdK0YmLW07+g1KQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+JD2N5+;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4A606A31B
	for <autofs@vger.kernel.org>; Tue, 27 Oct 2026 00:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+JD2N5+
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so533778166b.0
        for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793062677; x=1793667477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
        b=b+JD2N5+rYVooj8Ej/IvUFc1dN/wiaOUFruTy9kN63mrAIfXTfvhO71wV9X5nkq2PD
         wRjFzdbP1cL2mMyjlvzi7fQlP0tbFg82kYFbI00W6Q8xvpbRXz1boe0eAKHHfpEs07Hw
         TLSFRbETHdW7qxLZHEaTl0E6zFQed0As0r6q/xXozeJkVNdjH5M5ADoRsfD8xFB6jH3w
         zafLdnnkjqoYX9fTPaC6r2U1J1AW+bS4Fbt3cCsbY7EeivWpGTkNjNFqy90Gmec7L7+K
         nakS23YW4EcihM5dz8PR4wy3mHfkMFPrqKhRq7o7C+2k0BLyT64M2cju3d09MUD2c7yE
         6mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062677; x=1793667477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
        b=luCgSdY8Ox+lyVGcPYeWUdxKO7WU9N++gTvKQWG6btwXZ6gfwWyuZk57ArQCBx3fqd
         e5CCtL/5mtCmJEFydoha+Av/mK4ajpLXdkHPcSAB2VZH2QPj4BiWSt0BJQiUPU3070N+
         rUe2imVVJEzPs5ZpwmuwOHGfH1vWQqCL064xpDFomXwP2oJizBGFkpgWi6T9TiOeM4s6
         yIHz90pIxtQDfso2Opgup3oa4kqxeg2zA5qZjVkFo+ImCiAyKM19kDvAmN5CcdX5AmNL
         iMSDqmccEDJAtTpZKadP32WOCfbDLQ3fLMFKRLejdKHWaSPJE2HZPeQhSrOoHhDnMkwO
         QhUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTOnDGA1imBfXfIfzAXJ6opDhPK17QW1idCpKAdTF00O2Nm1cWLfFpnOuJ7PMQHi23Tex+6zQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuFhsgw5puBzNWIIyEVtlhjjsxYB+Psj8FzHcPcV5G1EvoVxdv
	uurcGAeI1q9p3+8X3M961Svw+4lC6OWfwbC73uMemCLsKqejbD/5p6IN
X-Gm-Gg: AYBFou3Z7FhSb6ePcAlglVLGvOB2uTewUR5MEgEyF+Cu8UoZMMdFtoTYkAh3AqpG0Ch
	+pUEGPBJHlEtSSkYnILBZYM1jpedLqaFxqDCC/L6sgGpRF7BSp2FmqY73ked+jnyClNXsFRKup8
	6lLWHKYb4TIyuc+NIrt0cJXyRzPAzq9GqWtOEsAmCU788Fx9QWV34UI+o3/KR39/njc8v9uBMu8
	n/FmIX8Afz+fTmyTusCXIQWk1hEreZHHEqfK6fQSYJYazXDthg1iLu5OesNiNxj3CyXKLnHlmo0
	+kMbOSrG3AaCUJq9CpWEqkNHL4V6H8RuWLzQRjCTtzC1bmuWu2ZFWW2clhLoPgWKtT3SyuR3Jvv
	8IPk0rP9kHw0IGa6cKgjbjWMf2q6HsT5hdWMLOzg6MNuWI8WE7+oDAiPFG8zV32G7WksL/j5VHU
	jOrSpR8I5l+AONBjSQfx+wKhz0ietz0YQPK6DRcfWlBL0/EAo4ZxRjOa0mli9wsEjj3mOOtb8dc
	649YWp8F2CTCX0xoCEtU+A/lW258Rw9EMThew0V4/aN3ta87rJ08gz6RvWjqHPwm3hCO7TWN7z5
	WuJ1RKvd1SFjBL7NsmnQsFFc6x2hjQBkyvNlMQGbeL+I8MTO6CE+81DUyNoGeuDyyP+yY8LuPlE
	2btBYIQRJbgphMJB095AsSeUZUbb6W7YFvRYMx7eRb0tpPGNx2xsLiuR2gUUnQjhIEcjDE3ZgrK
	DW2PV9gwsuACSfHvw=
X-Received: by 2002:a17:906:f593:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c46bddf6451mr917653766b.15.1793062676398;
        Mon, 26 Oct 2026 17:57:56 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595df8fsm4283637a12.11.2026.10.26.17.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 17:57:56 -0700 (PDT)
Message-ID: <083c2bb0-85b6-480e-afcb-bd2f386f2ddd@gmail.com>
Date: Tue, 27 Oct 2026 01:57:54 +0100
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
To: Ian Kent <raven@themaw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
 <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
 <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

On Tue, 2026-10-27 at 07:11 +0800, Ian Kent wrote:
> Commit 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev
> in resume_store") looks like it's been around for a while so I
> assume the reproducer should work on 7.2.12?

Yes. That commit entered v6.5-rc1, so 7.2.12 contains the relevant
code.

I used the unmodified C reproducer linked from the syzbot report:

https://syzkaller.appspot.com/text?tag=ReproC&x=11c0f4c9580000

I also used the configuration provided with the report:

https://syzkaller.appspot.com/text?tag=KernelConfig&x=7d012d9c67977ee4

> What should I expect, a hang, it doesn't.

A permanent hang is not expected. The result to look for is this
lockdep warning in dmesg:

        WARNING: possible circular locking dependency detected
        ...
        &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

The reproducer records the first dependency by splicing into the
cgroup v1 devices.deny file. It records the opposite dependencies
through a normal write to /sys/power/resume. These operations use
different lock instances, so the exact reproducer reports a possible
cycle rather than deadlocking.

The write waits for an autofs daemon that never replies, but the C
wrapper kills the blocked child after five seconds and starts another
iteration. In my test the warning appeared in the first iteration.

The test needs lockdep and CONFIG_PROVE_LOCKING, the cgroup v1 devices
controller, autofs, and working hibernation support. It must also run
as root. Without lockdep, the program can appear to do nothing useful.

> Also it looks to me like the reproducer is trying exploit an
> invalid request similar to what I described earlier

Whether the string identifies a usable resume device is separate from
the autofs request. resume_store() first passes it to lookup_bdev(),
which performs a pathname lookup before the numeric fallback.

The reproducer changes its current directory to the root of a detached
indirect autofs mount. It then opens /sys/power/resume using an
absolute path and writes the relative name
"0x0000000004000921".

The resulting lookup is therefore:

        <autofs root>/0x0000000004000921

For autofs, this is an ordinary lookup of a new immediate child of the
indirect mount root, so it is a normal mount trigger. There is no
autofs mount under /sys/power.

In parallel, I am preparing a revised patch following Tejun's
suggestion. It disables splice for writable opens of
/sys/power/resume and gives its of->mutex a separate lockdep class.

If you send your autofs change, I can run the same reproducer against
it and check both the request and the lockdep warning.

Thanks,
Krystian
