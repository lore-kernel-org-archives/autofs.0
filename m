Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492397;
	b=e+Fd+gVjBCfjcC8E6YzZDcluAACCfulTijkEJ4PUhyuph9NBPTR1sx2kWF7rJ+16FY5A
	 mzuZj3bwSSab7lfSOKIlPgwb26MIXIyHtRltDg94ITdrqo4zlD3WoGaYRDr/H9a68DDUP
	 9hoHXRFZ8KqSSNOjgreYrHbVrqsLd2EU1zwyW8EY0/rPaPqK9w2rQfYT68h3vCIjuoK/5
	 sZYQmQs1QGjjB0BWBz6oR1kkRCWgpfJdKkGu8D52UZXRNdvI3/z+mkOsApc02Qiw0M9tc
	 1w/qGopyBHVQAbPeepGbKaPwpg1OHWzLTgw6GeAlg1lvwlwQWgVejmCOSGLiokCQSnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
	b=LkAi2twuxfl5Dbzc26JkIBvd5gCcJez+Gdh8xeqsMnLRv07zUWDfxS7aQyrZumucMvJP
	 s65v1WxkEgw0xwaXosJTq5QrdHitbWPgEdS0cQx+y6exHFnK8XOEps+1w4k++jbQBGHSg
	 QgWIqZfquhO8eo/U8+O8APSBLSd3687exTxqRvD/UK1DwAWhrqAUSdodEHK1zEPrbGPqE
	 niSMfvLlepbRIAuB4pA5PBtKuh65nG+/FSQR/2u9676s+SCkKrElob7LPdz7ASMweeLv3
	 flyJCbc7VF1rfcIjWuNYiSn/rIaeBnFnyFSzYDnoaRZ6b6BX28U6L2we5F+GH5zzVCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249F60A2629
	for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3249F60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c506094fd93so411398566b.1
        for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492396; x=1795097196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=iJ0O8ptUFgqzUF0HS2nnVTaNoVhPcmUF74R8wDy41neP7vq8HMRXJc7K5zqFIyWN50
         OQ2Kui+CINP4jSWel6CZfma+s5yUJ+g0EH99NZ3Zvfld8OwRHv88d2jr1L/vA3RSM74J
         HPRGuwMFgZ4DHsxcYpPV1O/i31el9yT2KWGfyqtInfS9sidP7NwZ60CxiXUOCROqoaka
         Dbs35OKCAs+OEVnFzQb2wsESoXa2IW/ATT6rBkW+P+HhV76RoMgrIgmiMR5kdb1KUQN+
         fmR3iGk+RPAT7sBQAKFNlKkqseCiRLmBwx64KRd2OABz+/XaX/jJSLMVvxItD5VFNZyW
         6qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492396; x=1795097196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=S3v5lx8QDjKrVv1dGB9WkG9kI8HHrw9cqpx9EjxwptjqPhZrVvmWz9ZlZajkn2oUMi
         H+dcpgcJDQfvXzwnaLMh36g2EIH3DTB9/178+g6AFQ6vESzb7tFTDhXO3MZCCeY77KJq
         H7ofFvC6UFm3zAtw8zgAslojOMmatFNj1Vd9hZixQw7xsXb99SV7eUSTtGeCtjj3ny8h
         cdlEGNOrh7yJN1b4fT9hyqNvP5PbtLtIMfT/3ApH2n649E+2kcJFmDwyALD4thkvhRg7
         MYCAEYnvYKpqtVSkDbhdlWSbtQLEkaSKilsmCZINva5an0GDvbq6I7/yVvZy6p13hdii
         vcsw==
X-Forwarded-Encrypted: i=1; AL+hErEf7uPh/RqRHOHal0hpJ+K4jRT0VhdPBM20GewoEq3XzNToov9Hyn83etnpM7o9twOiMqFr5rs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8th2b5y1s3OjIItAOF4yn4mZBa/QP12yOuH6Co00qT8j2jdt6g
	vl+BF5/VT2cn2S/xqb8QGfFlGatpWh1zMdzAU6KxyH4FX/oCiPxaVbVp
X-Gm-Gg: AYBFou0XZol4RZ9pu63Fxe628UMeDtdnai+aFyRJ12ikTKuLP6uoPaG/b2ouUbKfoad
	UtR1oV3HZXIOuadnW3wHQxu6JLckTHnSqDXEJ/or4vsmiXXsUKOPhw0qyt1TEiABz5husgy76MJ
	TRBasNWUyVwipfYBFqCKmW+w/wp+ZQvKYCvKLMi1W58RFFlwkC3UEa8Et3FbHFYVF6sNczHfzI+
	dGsQNoQHu9e0TT3v8f8gFvQ22VkiEi1ATzx9m+FCIERS1QUS0LEMPz6Db+6yv2rMB7iVAAAo9vO
	VtypkYMnZQwgYCDHonxkuFPnCbH/5iHQ7ikL88tKRbUsL6t3Zle4jeDIQq5grhR8iMSVg0JSX7M
	ebDmy4tqSazNswtTiMbDDgqZyNXTa3hj472gcylEq3Z1p5lo+FK1cgDoSxS0fjqNdt/zIjkGxwu
	oDw51Ao/HvN/JyAK/WTQXIvx+D7QoJEnCEKPUsOhzD2d1SMHfYzR1nzPIk3xrtAzZx0/XZVxPve
	o11xIaLDYFlNdwtwjIeEBKt0e04f5NGHsuO2/mRAtayxuJedmKSSrCknS4ZVLXmo4Gv5KFbY1tt
	/k5xlv+ZfSAor/32z6162BSfH/taa8xMvBwG/7y+v/VL2C/22Hq9kM/lkITm4m/Bwapbir2YxEf
	o7JCGSjSfSN+8SpO7ctvEcFYX5w3FOvvfYPD60Xcf3Kjsz149dH71jwNkUNcH9DzG+M9dzXXr0O
	V1lSxgnONEqfHqDkJ6aco8XQz39A2ygRS5vdMPAaiiHeEJrDEzJDTcGSMqqgVRioZJ/IZgpEvOF
	IirfjfwaFJYrw==
X-Received: by 2002:a17:907:1b1d:b0:c4d:31c5:e30 with SMTP id a640c23a62f3a-c5066d3db13mr442488966b.49.1794492395421;
        Thu, 12 Nov 2026 06:06:35 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593b5esm363017266b.34.2026.11.12.06.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:06:34 -0800 (PST)
Message-ID: <c1af6845-bfa6-480d-a240-7b918331234f@gmail.com>
Date: Thu, 12 Nov 2026 15:06:33 +0100
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
Subject: Re: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
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
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
 <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 16:51, Tejun Heo wrote:
> Hello, Krystian.
> 
> On Tue, Nov 03, 2026 at 03:57:41PM +0100, Krystian Kaniewski wrote:
>> Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
>> marked file refuse both splice directions. Their of->mutex and seq_file lock
>> use separate classes. Read-only opens retain splice support.
> 
> Can we be explicit and name the flag after what it does, e.g.
> SYSFS_NO_SPLICE and kernfs_ops->no_splice?
> 

Yes, that is clearer. I renamed the flag to SYSFS_NO_SPLICE and the
kernfs_ops member to no_splice in v3.

>> The new property cannot be combined with mmap or preallocated buffers.
>> Kernfs rejects those combinations for direct callers, and sysfs rejects
>> SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
>> Binary attributes do not support SYSFS_LOOKUP and reject it at creation.
> 
> Can we keep the rest minimal? With /sys/power/resume the only user, I don't
> think things like the mmap and prealloc combination checks or the binary
> attribute rejections are needed.
> 
> Thanks.
> 
> --
> tejun

Agreed. I dropped the mmap and prealloc combination checks and the binary
attribute rejections. /sys/power/resume remains the only user.

I'll send v3 shortly with these changes.

Thanks,
-- 
Krystian Kaniewski
