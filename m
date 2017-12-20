From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 20 Dec 2017 15:30:07 +0800
Message-ID: <ef2e6b80-f14b-1c5d-1ee6-853ebd1b3216@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
 <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=OSmuz4CA0bUSdIAQjM5/Njz6S/4L8
        4WL6S1f+TtNHpk=; b=aRbd4+mcKtQ7b1Va3ODW/lMI/woUlkUeNhksNX4qcqXKw
        GWJac9v+bkc9ayTYjsRHGLHllgrZvABbR/CLE+7OiQFR/grK1aj0QoN/oXOl8n1j
        qryCEEyBBid6b0HHiLqVkTz1U5DFFBe+Ta2nRnrloresX4baWQzOhLMPD1b6NdTo
        55yeYbVG++e0eyWM2US7t6S0+SmqPwcyVBsrciznnzI6ckTn0MdWypQewcWlhvaG
        HoDu6ZxgWFJFfz+s9F/HyAL+yAGeLqHBkT0/6GU2Tpy5v0m7Fkz/dCrv8R32fDPb
        fuV4AvIa6oU0PFfApWCBAFcFrk7pd0JX222DHt1+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OSmuz4
        CA0bUSdIAQjM5/Njz6S/4L84WL6S1f+TtNHpk=; b=r9oPGnYHbrwcAcxXj/VC/H
        Iolx2FGCVcEWcPcAI+0bjCR2Bxoj3qB5YvCPmfLzaalkUGJuBaVQ2vbWM7T7cXOY
        lr1Uh/Ah8oWDzQAEKwyDzaxEbtns3oyc5uISpD4/1GOKuN2ujOsfim56ZPC6pioa
        5MvDXLSnuRe39hhgKa5nC81cUrjFgf0TMlB9MpXxg5luyHhaw6h1jAQXUMGagmMq
        Om2MzP87BqwnuXlMXBtDOIETga81TY9ia+FASf+NvnWiLdDUucytaxBBrVrt3xc/
        fT+rFwME6nq93w3G8jBghCoDDNPJ1rSORePqTuiklzWlav0wLOynA6Xsq4xQ9ykg
        ==
In-Reply-To: <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/12/17 13:52, Ian Kent wrote:
> On 20/12/17 11:29, NeilBrown wrote:
>>
>> Hi Ian,
>>  I've been looking at:
>>
>>> - add configuration option to use fqdn in mounts.
>>
>> (commit 9aeef772604) because using this new option causes a regression.
>> If you are using the "replicated server" functionality, then
>>   use_hostname_for_mounts = yes
>> completely disables it.
> 
> Yes, that's not quite right.
> 
> It disables the probe and proximity check for each distinct host
> name used.
> 
> Each of the entries in the list of hosts should still be
> attempted and given that NFS ping is also now used in the NFS
> mount module what's lost is the preferred ordering of the hosts
> list.

Mmm .... that's also not right.

An NFS ping is only done on failed local bind mount to check
the NFS server is running on the local machine.

So that availability check needs to be done at mount time if
the proximity check is not done ....

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
