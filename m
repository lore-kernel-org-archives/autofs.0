Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583207;
	b=kjMCHCRiFFSH5flJICCmkEw1fvtxtGN1z5jk6UpBCDOTv1cTrHFo/UOWO8x7N29VOu5Z
	 botGLQjEG5rsDhE49TuZ5wKSdAiyolpwkgv7lhjXlobK0rSTvedhurnLoWn9q9ax5PsFM
	 FJUMV+wxeq7DuRct6i+K0BjaR+EbbKbEU8I/Ac2G/2ZB7ck2YmvIpWnK8InfXmYG/Qy1D
	 yGkca0wZgvBa33sXZMZqxD3yzccDDtMCW07PvQEuHIEnz0OIGQJZixyEcfc44Aw914nlb
	 DDUSAvLhqPS4iS2qOh7njq2cpOaa2fQmXeKdkbrG7hZblA3OQClT5F9leT10Ba38H0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
	b=0tAGYqCfptagppd5ccqZ/f93XmEgtGPPrPkZL3Um9GwxVi2v4njKmmL8Fyb4kkjHsGyM
	 GCAdkdxsVIhB1zpaMuvS+86DToX6q9f1vhzXXANDLZxacxsVDR66luC6NEU4R36ogkcxe
	 FIagnNbt70Acn0YpJgHn69dJDtUIsR30LavPEV/uIs0F3rxkrAUuEh8WBBg2Q18M8qFGE
	 b6djY610BnMIV9Cg9KHBzTCmtaRVKK7jQZYjKFSPSIZyqb05aWiXseWjzP8XY8cIu4wAv
	 RbSXmWzD4dqry4nBPzBRayYDDZc3FMcmKaYMaCKmkPaFIa6jdXB8bgn2Ce+2fxVz6PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74D606A33D
	for <autofs@vger.kernel.org>; Fri, 13 Nov 2026 15:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B74D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso15253625e9.3
        for <autofs@vger.kernel.org>; Fri, 13 Nov 2026 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794583205; x=1795188005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=sFcMT75ewHSGlHNFmaIaCzRv51RyA+AmoclO+Wvr0qj7IRgdft+YPwpD9jRP6WK6c/
         JYnz5nY7tp8rDhhxRl839jDRSaCdOFEO37y9omk6Y6bTMpvUdRVO3sHs40wFUzQoK49R
         KDfhcSnlxOwqISdXag2i2HeczyJwl3JciKS1IO4IueILgI43L1Jav1Ck2sEsLOvdW8YJ
         xsnD0k9f1YMungKWzdWfs/wgCnEVQku2SHGreep9hdKIBeljPxLy6tKl9GtdE53m1rK+
         tr1h/mPnq09YX6erwWu4ZIbwvv7uEDWKwAiALSZofPGlkAv/kiWcyL4UzspYLPPPopZN
         ldpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583205; x=1795188005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=i1D8mX7m4QZtFoAE8hkl3ApaRH9YE2N9b/5CvgRX+m804ZiE78qORYJoYcCIqj20oJ
         TVfqTDRrXOYFzyncPFAkl8IW6xHlvJZpdNDfKqrMExdXmG7Zp8F88CJNjA3dHpEqYmlJ
         J25Q0ZdZfde78y8wyZ1cGxaEtQQe8OQHUnla4G94b1HDJKWGR3/m1mgOThqFLBwf5C5J
         iGChkfuuIYnRMytGukNaeaw2CDzCdTs4inAEuqfm8kbz3q+7Ay9LDbHAlLVhh++Aep0d
         SXOcTyK7Pvz+FH/jwEANyaUOvSAIaAoPtuIAkar5tSQVSYUJKnTQb39mGNjQ5gFVvc1d
         AqkQ==
X-Forwarded-Encrypted: i=1; AL+hErHi+q9BmS5La9QOQpk7NwspmbmlTgavVKcHXEcl8q1fM0MK1nhimdutp2lWK/kYaGXHndB8LGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S3JzRYkl78JOo2PQ/4NyLzR5JVVKJ75pYn3pCmd5mwghzVUoI
	7Lnj0Lc1SpgNgtUD1FLm2xJAZIR0XzX3iQqK2qCqf2QJ3xRr2LXnkzeC
X-Gm-Gg: AYBFou1+jVMYxH5lGfqTS1NMm9qbAb0zgp5l91ZR8c5MhgAHV2fS4eNLOFDM7hpaj1J
	gwILJFKh7TdFFo9IxbcXzYEAJMTzoqUArb503K5VBloZSVcxIF0Y2qPzGpoz/gE8fSiSWV2/o0y
	6KIdPdTQ4QCL8xKMl567mph7H839Uthb4pdBvEYBgM4Jz87UJ43jnXphpnt4zwt7Xxghlwbs/WP
	PV037IbPO8LgUyL9r8xufBVO/S8ZWMeTxosrLS1BFOE9Z+sswRzvlNx0XR7Cdwx0i5endGRnunp
	I8GHn23i+Gfw//xGfPPI5fOrJX1QPd/28ivHNtYgt8k37mvljBjcBRmA1ftNowDsqJkfOKDWKl3
	gadGdzBz1faXtU7MCFvVptiLw2nZBTMbIC3lEaDZa0KXI0BZpyTMASjEI02FLZkb4dvlt8cssze
	UR/y9sqeZq5yCIMSpsWzAML+L99vEJFiZpllkRHlp7sWqC9eOyNgxmPAhN5x5R5RVDNc61TdkRu
	lxewwDBFrRgYUERJHMgKqZBt3mzF9I1JLc1as1Y6EVu3osmwr/xLYma7bIVzmErqlVm2Xco/3R5
	KZ89xXY9ZZlPvIUOctIncaL6C75Y3JVRNWuAbPBQV66nyDtw/LIZtAdlQPMz6F07S3+YyAopELA
	zajgFK4jCBgJZpGQhOyWd0wzF1rTMlduK2fDOvEo0bsaq93l9b89Ea+eHbYw5qQ+BEAA10EuAu+
	9BfIw6nVSFDgt6EKUrj7QcMjb6QZzZsmFMzRLlEMmAheXpLA4VMgpkLqT7LN89FdKm1b2VYHZA7
	2daZ48wP8t6uw==
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr67471255e9.20.1794583205214;
        Fri, 13 Nov 2026 07:20:05 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm159789845e9.15.2026.11.13.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:04 -0800 (PST)
Message-ID: <a0a6a72f-0ed5-4f1a-a93e-30bb99338045@gmail.com>
Date: Fri, 13 Nov 2026 16:20:02 +0100
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
Subject: Re: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse
 splice on writable opens
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
 <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
 <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 16:11, Tejun Heo wrote:

Hello Tejun,

> Hello, Krystian.
> 
> On Thu, Nov 12, 2026 at 03:17:01PM +0100, Krystian Kaniewski wrote:
>> Read-only opens keep splice support because they cannot reach
>> ->write().
> 
> The patch looks fine to me, but I'm not sure whether the read-only
> exemption is necessary. Is it addressing an actual problem? busybox, for
> example, just falls back to regular reads when sendfile() fails with
> -EINVAL, and refusing splice reads on read-write opens while allowing them
> on read-only ones seems more confusing than anything else. Would it be
> simpler to refuse splice for all opens of the file?
> 
> Thanks.
> 
> --
> tejun

The read-only exemption was only intended to minimize the behavior
change. It is not addressing a known user or regression.

I agree that refusing splice for all opens would be simpler and give
SYSFS_NO_SPLICE consistent semantics. I can make that change in v4.

Thanks,
-- 
Krystian Kaniewski
