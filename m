From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Fri, 18 Aug 2017 15:35:50 +0800
Message-ID: <301dc10b-dcf7-af3b-a1e1-d9008f8e7e76@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
 <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
 <afeda808-2e60-5194-70d8-fb1d503d416b@themaw.net>
 <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
 <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
 <7502a0e9-6288-ed45-8225-706944a65d7c@themaw.net>
 <cd8f1b58-e8e5-84d0-f7ef-43df2a49cb31@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=OzyR3M+fQ4qoJmmiPb
        OJ6eOGA6DSUeogxC+wRs11uRw=; b=HBOeQhnhuj/E3srU08BXLvi40IZ1GlfDEo
        hoioIHnrYO1qxx1UYhIGNDxCETU8RnsaSu6mCOjUPzITO/EVG/hjLmfnqxAkOmU4
        y7uIY0blPXGVIVigyj3+6gpkhMEyMdVSAi4bAfTgIXBH/+jxQMFYC81r2nzlYPMk
        W2bTkzVyfJ7rTY+ZVBJoLZ3gr9iZtShkatOR19h+rkfcdHeEHjuXhVSNagwldR0/
        uObtdAh8JniS/VKRQmVpdIFcTxK/o619OnnKPkk0aGz/I5Xp1ZENRtT7pbL3BfY0
        +7o9dRQbaN0x15S1jrr+yQ0U21dGYnYbOlxdneomhZre8Ofafm6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=OzyR3M+fQ4qoJmmiPbOJ6eOGA6DSUeogxC+wRs11uRw=; b=CXv0aLVc
        AMaVJ69o7PASwpm8fPn4mKERm3kUQgibbHdPZyETWRLk4KKu9khVsIATNSVRyOmb
        +bszm/vvhPo/ACqmKCMAIB93VN1v/60TPdf7XjoHvNHtm4n+fYC/jzC0nvpkCH3R
        rX15dHqa9HlgFXL3kI1T8hZ/jR3lqFgYFXpEWeUSc0wFF4vS2wjbdnI0QbacBRHU
        Qy7AXyW1RqO1AiaU9Im64PXNhjy5gGz/9zyvnvbAXewuRh7UTtGAffX2nQ0o/CKA
        WkVRYK8l3ysdPJpn/r8WEfZdy64Om7FTmnb+3/FHnfW09OedGGoB/FCPlUBDi6i/
        KC/uzqLtkkMo5g==
In-Reply-To: <cd8f1b58-e8e5-84d0-f7ef-43df2a49cb31@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org

On 17/08/17 17:48, Oscar Salvador wrote:
> 
> 
> On 08/16/2017 12:00 PM, Ian Kent wrote:
>> On 16/08/17 17:43, Ian Kent wrote:
>>> On 16/08/17 17:39, Ian Kent wrote:
>>>>
>>>> Could you have a look at:
>>>> autofs-5.1.2-wait-for-master-map-available-at-start.patch
>>>> autofs-5.1.2-add-master-read-wait-option.patch
>>>> autofs-5.1.2-work-around-sss-startup-delay.patch
>>>> autofs-5.1.2-add-sss-master-map-wait-config-option.patch
>>>> autofs-5.1.2-fix-included-master-map-not-found-return.patch
>>>> autofs-5.1.2-dont-fail-on-master-map-read-fail-timeout.patch
>>>> autofs-5.1.2-set-sane-default-master-read-wait-timeout.patch
>>>> autofs-5.1.2-dont-return-until-after-master-map-retry-read.patch
>>>> autofs-5.1.2-make-lookup_nss_read_master-return-nss-status.patch
>>>>
>>>> found at https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.
>>
>> And there's this one too.
>> autofs-5.1.2-fix-work-around-sss-startup-delay.patch
> 
> 
> I can reproduce this with the latest version of autofs from git.

Sounds like my understanding of the problem is not right.

But it could also be I didn't actually use LDAP, I used NIS, I'll have to
try harder to replicate it.

> 
> My setup is quite simple:
> 
> # git clone https://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
> # ./configure && make && make install
> 
> # vim /etc/auto.master
> /- auto.host
> +auto.master
> 
> # vim /etc/auto.host
> /data1  xx.xx.xx.xx:/mnt/export1
> /data2  xx.xx.xx.xx:/mnt/export2
> /data3    xx.xx.xx.xx:/mnt/export3
> 
> # grep autom /etc/nsswitch.conf
> automount:    files ldap
> 
> 
> # automount -d -v -f
> 
> # output of mounts (other terminal)
> auto.host on /data3 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
> auto.host on /data2 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
> auto.host on /data1 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
> 
> 
> # comment one mount in /etc/auto.host
> # kill -HUP $(pidof automount)
> 
> 
> Outcome:
> 
> 
> do_hup_signal() -> do_read_master()[readall = 1] -> master_read_master()

I've only looked at it up to this point because I thought update meant removed
mount entry not being umounted but I think your actually saying subsequent map
not being re-read and so not being updated.

Is that what you mean?

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
