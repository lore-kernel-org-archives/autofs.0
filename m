From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 20 Dec 2017 14:10:12 +0800
Message-ID: <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
 <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=SiH/KRlH6CfkUTgpCm+UFrYBDEu+V
        HIpVJYkFSgDwyk=; b=E1ah3OeRkHTEwNk+TMKuGLnyG7gIfCBscr1f2LBhnn/Hn
        jEW7b5ih4ldgRLmhqw3vFTEyT0/comepLUmuW52YPXo/2vpokJMnvMjrE8p3vq7O
        2SPuR91pLtPSH66LMpvqzyzy5seX6Dfh8+/CzIdW3RHSscKDtFLaQjOXPSfmWB/6
        jr0V5Hdn+tyWiWensS8QQQCsTNk9Qlk/03psOpqZpTyTd4Ttqv0yqZnKcXi4LZi9
        vNM6IY/qs8DBJ5pW753CF7Uh8TlW2p11Hbl0yMXauM+65puWmENrSIMwcT1NoHP4
        yX2qoquI6v1nAnClSrpxVqC0lMw3IMe9apFR5klbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SiH/KR
        lH6CfkUTgpCm+UFrYBDEu+VHIpVJYkFSgDwyk=; b=l4ZS4YxFJj98UpN/55YtUb
        XtFsOs5oafkiG/9in+jKXufGtZ07JRGiMXbZI2TZQ3VpO2Ne6Af+WLHL9llETb/A
        3B552MNjfWmjs2KSQ5gXt9u4JtiFaN43vyc9SMsu0SuBKsTdf8rf5sMMakHkLHfs
        On1pm+odE7Bp905qturRt5mRwSVa2RsTsUl8SE2Ppc8PQ7PRfnGv2uM0YSdtz8ei
        9ZdjhgoOmB2Wg9GmEt0jt2LexpfpKAWA6l7A0en2VqHkyjfxbitPUQHAzbcyQWSZ
        C60LTADKWQFWVANJA93o+Iq/PRH5MFleEypuklFJpQVNdJP6fdqnw750GBTfk+Bw
        ==
In-Reply-To: <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
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
> 
>>
>> This is caused by:
>>
>> diff --git a/modules/replicated.c b/modules/replicated.c
>> index 32860d5fe245..8437f5f3d5b2 100644
>> --- a/modules/replicated.c
>> +++ b/modules/replicated.c
>> @@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host **list,
>>         if (!*list)
>>                 return 0;
>>  
>> +       /* If we're using the host name then there's no point probing
>> +        * avialability and respose time.
>> +        */
>> +       if (defaults_use_hostname_for_mounts())
>> +               return 1;
>> +
>>         /* Use closest hosts to choose NFS version */
>>
>> My question is: why what this particular change made.
> 
> It was a while ago but there were complains about using the IP
> address for mounts. It was requested to provide a way to prevent
> that and force the use of the host name in mounts.
> 
>> Why can't prune_host_list() be allowed to do it's thing
>> when use_hostname_for_mounts is set.
> 
> We could if each host name resolved to a single IP address.
> 
> I'd need to check that use_hostname_for_mounts doesn't get
> in the road but the host struct should have ->rr set to true
> if it has multiple addresses so changing it to work the way
> your recommending shouldn't be hard. I think there's a couple
> of places that would need to be checked.
> 
> If the host does resolve to multiple addresses the situation
> is different. There's no way to stop the actual mount from
> trying an IP address that's not responding and proximity
> doesn't make sense either again because every time a lookup
> is done on the host name (eg. at mount time) the next address
> in its list will be returned which can and usually is different
> from what would have been checked.
> 
>> I understand that it would be pointless choosing between
>> the different interfaces of a multi-homed host, but there is still value
>> in choosing between multiple distinct hosts.
>>
>> What, if anything, might go wrong if I simply reverse this chunk of the
>> patch?
> 
> You'll get IP addresses in the logs in certain cases but that
> should be all.
> 
> It would probably be better to ensure that the checks are done
> if the host name resolves to a single IP address.

I think that should be "if the host names in the list each resolve
to a single IP address", otherwise the round robin behavior would
probably still get in the road.

Ian
