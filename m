From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Fri, 18 Aug 2017 15:54:07 +0800
Message-ID: <f0d8cc7e-ed84-ca04-1b09-9d51468acf36@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
 <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
 <afeda808-2e60-5194-70d8-fb1d503d416b@themaw.net>
 <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
 <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
 <7502a0e9-6288-ed45-8225-706944a65d7c@themaw.net>
 <cd8f1b58-e8e5-84d0-f7ef-43df2a49cb31@suse.com>
 <301dc10b-dcf7-af3b-a1e1-d9008f8e7e76@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=geR3WJ5nWJwEcCD+o9
        rxD4stDQ0oiMLYQkPNW/bzgII=; b=i3boIJx3p7uZWtkakxExC0qTsOhH8j/qje
        Bo+CBPTdeON5NvM8UxslCfGaBe8tp2RJyPvMfgj+Q97SFWp3aL4ZWSRI6adQfXig
        FkVI09FdePpvvqvQAC4F18xw9ZZ8Kewa4/T4AZBhc+fPfl6EeFsjG1B/7hvtY6w3
        Yqb7LKn7k7YwJinJidJeOQvTaLT4e8X/9vcA9wqyXnrNZCA6d02sK6IrNM0fdqqm
        NdeIDdGV3okoDJdRa/uzyx9om4UjUZ2urJ9ICe44PVt/u/nlRfd+GI0wVWjoPxky
        4pHu6zma7HoMjICtiibltFWWTQVO+8m54a5IYpmIFs44RKBlVtJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=geR3WJ5nWJwEcCD+o9rxD4stDQ0oiMLYQkPNW/bzgII=; b=jj1ksG1j
        lK3kTuIP5xAb7PBqUXHEbBql5XKrl0bIMudnh19aD8bDaAYTx4XN2C2lqLSxmBHa
        u25xZOrAzFcemKUQpthUEHZE6Ryt3EDELCJ6qAbXYTDwM1csVIpzvau2XQBAzbti
        kBGLt4yUoAVmedhBcq6bLmxNcIsS8sjngrkpF5aT4CzUsL2Y799GPZCh50WeeoNe
        4/so3BSqklfczvl9wACnKl4dJi8wvytbdFB2B4juMfoeymWl6Wd73Lhu17Mm8ZSM
        y6qNft84l27YHO9pYZawGZtiJ5Pxn07ZvWV5eZXFtC6daiO98V5FfJvaDljxnuwZ
        r+3gSOzejysvxQ==
In-Reply-To: <301dc10b-dcf7-af3b-a1e1-d9008f8e7e76@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org

On 18/08/17 15:35, Ian Kent wrote:
> On 17/08/17 17:48, Oscar Salvador wrote:
>>
>>
>> On 08/16/2017 12:00 PM, Ian Kent wrote:
>>> On 16/08/17 17:43, Ian Kent wrote:
>>>> On 16/08/17 17:39, Ian Kent wrote:
>>>>>
>>>>> Could you have a look at:
>>>>> autofs-5.1.2-wait-for-master-map-available-at-start.patch
>>>>> autofs-5.1.2-add-master-read-wait-option.patch
>>>>> autofs-5.1.2-work-around-sss-startup-delay.patch
>>>>> autofs-5.1.2-add-sss-master-map-wait-config-option.patch
>>>>> autofs-5.1.2-fix-included-master-map-not-found-return.patch
>>>>> autofs-5.1.2-dont-fail-on-master-map-read-fail-timeout.patch
>>>>> autofs-5.1.2-set-sane-default-master-read-wait-timeout.patch
>>>>> autofs-5.1.2-dont-return-until-after-master-map-retry-read.patch
>>>>> autofs-5.1.2-make-lookup_nss_read_master-return-nss-status.patch
>>>>>
>>>>> found at https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.
>>>
>>> And there's this one too.
>>> autofs-5.1.2-fix-work-around-sss-startup-delay.patch
>>
>>
>> I can reproduce this with the latest version of autofs from git.
> 
> Sounds like my understanding of the problem is not right.
> 
> But it could also be I didn't actually use LDAP, I used NIS, I'll have to
> try harder to replicate it.

Success, I have now been able to reproduce this, give me some time
to work out what's going on.

> 
>>
>> My setup is quite simple:
>>
>> # git clone https://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
>> # ./configure && make && make install
>>
>> # vim /etc/auto.master
>> /- auto.host
>> +auto.master
>>
>> # vim /etc/auto.host
>> /data1  xx.xx.xx.xx:/mnt/export1
>> /data2  xx.xx.xx.xx:/mnt/export2
>> /data3    xx.xx.xx.xx:/mnt/export3
>>
>> # grep autom /etc/nsswitch.conf
>> automount:    files ldap
>>
>>
>> # automount -d -v -f
>>
>> # output of mounts (other terminal)
>> auto.host on /data3 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
>> auto.host on /data2 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
>> auto.host on /data1 type autofs (rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
>>
>>
>> # comment one mount in /etc/auto.host
>> # kill -HUP $(pidof automount)
>>
>>
>> Outcome:
>>
>>
>> do_hup_signal() -> do_read_master()[readall = 1] -> master_read_master()
> 
> I've only looked at it up to this point because I thought update meant removed
> mount entry not being umounted but I think your actually saying subsequent map
> not being re-read and so not being updated.
> 
> Is that what you mean?
> 
> Ian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
