From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Wed, 16 Aug 2017 17:43:12 +0800
Message-ID: <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
 <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
 <afeda808-2e60-5194-70d8-fb1d503d416b@themaw.net>
 <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=FuwQgpqkTB/MjrX1U6
        9IbCtQT4qGKpA6rCKtAjlOmHE=; b=LZfp50s9/Kyt04rN9Hcxmdk+3k/gKudhV0
        hz4x6EfUEb+JfgQkGG6QdccHJmxTNwyk5udL86IocLFk/X0fHBq/WLc0c8InuxLP
        c0O091icSQD2iaoi33oikd2YrkefC69J8GdfyNyH763wkcx1BIk3PgBVgaapI56p
        hJf51OpZOsREsATJNiJDsvWAUn2qc+1188w1j8A692ZDAqJpwQMAzPBhd4jv9sEf
        gwxjjUnz7kiSAIMUQk2AyI054fC7j+KN50pe25P9nS+rzQ+kP/tMSmUKEYZTAd1D
        BAb+dC9B2EVuJ1/LlewlS4b6CFyZ+grq3cdejEgJVg0atNM7dlYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=FuwQgpqkTB/MjrX1U69IbCtQT4qGKpA6rCKtAjlOmHE=; b=bue0cQ+a
        tDtzqdMi8XSmwBKjg30vknIUyZFZeADjYc9PYNHIuTscq8yQ/dph+a2l3TZyiBkm
        EtgQlkNt+rv0JdKzRGoXDLMbUET9b+1hCTJGXuxEMZYOxYh9Sm2oGs6ulFHkRJBL
        63TW3wcaTBEVUV+EVq3eYMcoppZQgxkwgXu92Mv5/vhWufsN+McMfKKumWyRTI11
        HLO2jZ52JyL5vR+VW+xQHODqh91BS3dSgKdFRq+PsWBEH7U2CCBn+qg35zGLKqK7
        cEeH5fCPiBjF9v0R6Oiq0W+bbcgzc2KMyZl/o3cg6iRpKa/0XxkQ3nNOFi0wqHXn
        y9zBEYqGrq46Iw==
In-Reply-To: <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org

On 16/08/17 17:39, Ian Kent wrote:
> 
> Could you have a look at:
> autofs-5.1.2-wait-for-master-map-available-at-start.patch
> autofs-5.1.2-add-master-read-wait-option.patch
> autofs-5.1.2-work-around-sss-startup-delay.patch
> autofs-5.1.2-add-sss-master-map-wait-config-option.patch
> autofs-5.1.2-fix-included-master-map-not-found-return.patch
> autofs-5.1.2-dont-fail-on-master-map-read-fail-timeout.patch
> autofs-5.1.2-set-sane-default-master-read-wait-timeout.patch
> autofs-5.1.2-dont-return-until-after-master-map-retry-read.patch
> autofs-5.1.2-make-lookup_nss_read_master-return-nss-status.patch
> 
> found at https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.

I think there might have been a couple of other patches that went in
quite a while ago (during a false start on this) but I can't remember
what they were now.

I'll look around further if you do decide to work with the patch series.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
