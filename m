From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Wed, 16 Aug 2017 18:00:21 +0800
Message-ID: <7502a0e9-6288-ed45-8225-706944a65d7c@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
 <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
 <afeda808-2e60-5194-70d8-fb1d503d416b@themaw.net>
 <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
 <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Kh+qGzmI8H6R4aPOC5
        hzJNYnaZiSTR1TeVv8ji6M2Tw=; b=g9TKQRSmr+LGdpqMxU/3ZBHoOuQaQIVAq4
        2Xxsia+eOz9NJBed2F7NIX0tG35LVfBIFzdaXB5kJNUZ20PsqzJAs+g7d/qP76xk
        vwE85vOVzMKrL2Z52tF9yQvxV50wE615/odRkgPYVDg7XjYepdb8ih10aL39DrN6
        fhwIFRKNhhwYRAE3TPWwKUOfVyztXXvq4Z/2P8Irao9HmmOSwyEJ0uy9IObTqeGB
        AzkhG8A4kcdifOuySoT1bppZac2i86ELZJ6mMExWj/hM/1o2LatZHBGPBrFiirk/
        Bo4nrp/uYI5UxiRigx7EYLnWdl0T6kxNr4/wHLJDRmDGsJAok05Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Kh+qGzmI8H6R4aPOC5hzJNYnaZiSTR1TeVv8ji6M2Tw=; b=CktmGq3b
        b1VciAfLK9sp8rObimHymmvVkuDyyhPgV8i58Ok0/QHvGYvDAJvq4fO+eFsPuxxm
        jXHICxxu1edjd3ec2JlSZjZP48F09cqV3cj8URRWP/gAkNSc1fYi2uJR4ZHslyVb
        MtOQHmWH/esFjNzJqNTo8tQoWZb9w4HtuSUN7AkSHISVmCb40maHNk+s5BkKOesr
        WpDFV6Ti7wsa9qCHc56N8uylfBoXKg1gzhf6XHhWUHFqkOF2ygJoSFdxiP72Ax43
        MWkojZg7IPrjqC3X21O4WkiENO+yOfwrcVaPhbR8d08Ie0gDQF44RTvnt0QMYR6z
        EO0P9JTydMVNHw==
In-Reply-To: <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org

On 16/08/17 17:43, Ian Kent wrote:
> On 16/08/17 17:39, Ian Kent wrote:
>>
>> Could you have a look at:
>> autofs-5.1.2-wait-for-master-map-available-at-start.patch
>> autofs-5.1.2-add-master-read-wait-option.patch
>> autofs-5.1.2-work-around-sss-startup-delay.patch
>> autofs-5.1.2-add-sss-master-map-wait-config-option.patch
>> autofs-5.1.2-fix-included-master-map-not-found-return.patch
>> autofs-5.1.2-dont-fail-on-master-map-read-fail-timeout.patch
>> autofs-5.1.2-set-sane-default-master-read-wait-timeout.patch
>> autofs-5.1.2-dont-return-until-after-master-map-retry-read.patch
>> autofs-5.1.2-make-lookup_nss_read_master-return-nss-status.patch
>>
>> found at https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.

And there's this one too.
autofs-5.1.2-fix-work-around-sss-startup-delay.patch

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
