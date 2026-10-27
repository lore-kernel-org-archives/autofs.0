Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063215;
	b=n5K9Bzey8wyKlto0beG18h9TCrIiLLpf9XEC8fc/58xjEP5UXHXx6mwkszfm7ki0dZMV
	 zt+RCWOOmJ4+3iZZ16TGwPc4WW/tztENzXZtRa+aCI6BHYJxxi4eaXenRWvuHY+t8NxZt
	 hG1d9U4Bt2zesfApyaqD2vH6TWGfxZW3z/N16vAq434RRgDgiRcbKRZmk7ZSHimbhyree
	 RqChrN6fkmFIn7mQUlRjIWQhH1dpNBcnOTHmoANXo9tdq6F0/s6ThvQgWfUdyDs0nu2/x
	 GmnZg+qqECojtzJCXJDeN5MA9DXdknVN8on6fFtjH4xfEepoO486f94zWS6255iF/ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
	b=3481r8tzLXB4O2FLrA3BKjuLVV2QbPZnMmuFsZSubFvvt5y39VJjSfKGGzMvN1Bj2KUa
	 1XWE1AnOV0kVI9xQPn+EWO+9abx/04jZDlRwiPXvpKEoYa0qAbmU/b4R2Nqtakp1/WAJ9
	 QVPTQ3chnhSh27H/YqHGKdTE1IXbU0/CtQrTrwNFu43sOgPpuGmoVD2yxHt+LcUKMCL/z
	 vv/8neub57JmVJfygCHRdFg7Io1cZpXbuRlscl2hTmmWcJo6wilo/Q7V1CLaim4ZZT8uS
	 E2Pzo30MTDvgdPQm71l6HTsiyS75WlKlTseGK12WuPpY6+rdeJf9ZzJFR119rCyo81g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LTXvgnV0;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D9606A31F
	for <autofs@vger.kernel.org>; Tue, 27 Oct 2026 01:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0D9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LTXvgnV0
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c46822eefb6so471224566b.2
        for <autofs@vger.kernel.org>; Mon, 26 Oct 2026 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793063209; x=1793668009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
        b=LTXvgnV0kKaKCac/NWTDNj/xLVRA12SXR8oBYGVw7hB46ZT57gB4fZwYtR5nCCblkS
         peP+RjAszOk0dm1T6N+uNlAtD5zw0eE2lahff023hj5G//C919I++TvXOZ3DarXuZCiY
         CdA2bEl2sIvMMKXBmf+rpvs6JbfEPu5km1R+tIVnkFUnKRVdcKmH+9TFh7Z3Gp5SZGks
         0xu37F04qrnh8fsQxonydlDd+TPd3e3MYXPMIg4lN2SvnxV9ntsb1E0EcMW00ZocSO6d
         tuaikwD10/VduwJNndzh735UGS98Jmu+qk9VwbMuzMXhmtJEuPN81j0LyK1pZmjCEjSj
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793063209; x=1793668009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
        b=dHiTaKKmOZzYYTRfH0mXeenXbXpi3sorGimQNJUOsv9paiLWi66kCklPh2MBhOz5Lt
         3jGdeS08VxWNe4iQuTxslNFKLs1RMPGPL+AagsPt16oZ22EJTQi8/zW8R/tcZrt/d1b+
         g5PLbj1XKLgYpTjik6NsZFOaYlIAX2+yxxtd8mZQPvZdunk3B0nvpluxOHrF3A//r3oV
         iw4JuaPfqAIC8UBM6oWd1boUF6AfYRf6R0tm9LOjXEgDG7zYM0Bw5qFd+3kSoV8QnSbQ
         8WCT77UNKtK60A6PrxrNnuXvSVyu6+YwLQ+zhzqr/Vph/0Ml3/TYgoiePyL0WolDJps9
         bH2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlRUawZ4HYuOsY0QUYT8i84kfWQTNfa1e+qZGibr707Un3ZLbuMTHtSFY+yb7gpk3ePi5teGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAfG8K8Dde18LMzfojLf4vRCmboUPBa1b2npWFFKegoJulxsCK
	/p0jQk6B1G2hdwhH8n9gWDTeQfKo9S9cM4HD4TS/biybr9Qv+mkmO7oX
X-Gm-Gg: AYBFou1KM1WFocsIMwAvHzCe8LsJsHjTEtYEPGVrUmbfDhVMdzvvAYaaMDFE9/8Qm1l
	TGeqe45iB8eJuRZW19pNsYcuO28Ub5wtZhxF3U7lfnWuu1wUUovFsFMLqDa0CO4jw85/dqKRT9o
	nhp0IUGxTCQOFd+KEsJz4f0Al0JOMEx2esA+lm7nBb1gS4AvMI75svEA7Xi5GaqNh8IT/pxVDTR
	lZ3rzv0Kv87mfVepYGQugSQpOz7zbsgdJVuRpK6tztFhr2+yzSTtXSj01OSMsh7mX53knmzSjBU
	0c/rYmRIG5TIunQj9CN+dFhOGedr4Z0Oxq9tnrWoaACdpJ+Iym8H4/dHiE2mOpx3w4RztfY4Th2
	Dej6FIWqyAaq6wA9niTOnIh8U4GtpXjCBdiVK1dbFYh6UaokWqTdlMpDuptDw27p/7P7RFOeD4y
	wAiRoMD85/fWQUgkU6yQmUgl6OYyMHJkIjZR2OpHR+aerGf2R6nHw2i5bZThtwOLnPLQS4mNy7F
	a5b9WodmB5V4p4W8sptik+Ddx7hTh7xrTOGeyqztVR9zX2n5/Bt8hXv9mwqlhkyP1+fxs9Ry2qn
	938cd0nG+LRTm5EAmBwJ4Fk4Hvn47b8Ex0Jgv4OKd/XnuA/Y1r8UfL/UR+HRKRGowRzZ7meFGsx
	mh1hW1H+hy+3YG59MDQuCQOSO9KDJ9SyiaXMZxw6XjOPLMlypEPp1LnppVDh0kuS0lpXBD9kjbk
	UcutqMd3Iku0lrBHE=
X-Received: by 2002:a17:907:160b:b0:c46:6a50:40b7 with SMTP id a640c23a62f3a-c46bdd690d3mr894395066b.10.1793063208643;
        Mon, 26 Oct 2026 18:06:48 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e7c94sm373434066b.27.2026.10.26.18.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 18:06:48 -0700 (PDT)
Message-ID: <7c8d96bf-368d-4272-8cd1-94740a2e4a84@gmail.com>
Date: Tue, 27 Oct 2026 02:06:47 +0100
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

One additional detail I missed in my previous reply. I reproduced the
warning on the unmodified kernel at commit:

        93f51579e7df248780214094418f205253383cc5

Exact kernel version:

        7.3.0-rc4-g93f51579e7df #1

I ran it under QEMU TCG using the configuration supplied by syzbot.
Both the unmodified C reproducer and the original syz reproducer
reported the same lockdep cycle.

Thanks,
Krystian
