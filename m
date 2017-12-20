From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 20 Dec 2017 13:52:58 +0800
Message-ID: <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=ZjSBGUw13pabdIAKNDIkwWz5e6Ike
        t2z7iww2QvTNO0=; b=C0UbLQSqGGJ3zVoGFoOCA1nQ664gb5qYDv92lXF93AXGO
        eTxvdP3hFaSoqlY3vpdsuLoidsHmK2I2Ta4Jg61mBFu4/mKbZEqiG3qv2TvFnkMz
        KQaaJaEzZq9P2eoig4cPGYPDpyNzeyIbZsVh9l/++sPecdga4rQu5bBZ1/XV+t1k
        Myx8TuDRXKUUdnlEteHi6OI6b8rwEMjtonX+dPfsJ4IAAI2YCXF67Z4MnOihnwil
        AQ1v+FPMX9q+R2bEmqw1HT4gdkozbG/if/6Z9P9XxI6rSLQMHqq4dOjKid6tLdiC
        hPifOxyT7bXPuTn3Jx/VIIbATq9kAfRCa+gVgwACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZjSBGU
        w13pabdIAKNDIkwWz5e6Iket2z7iww2QvTNO0=; b=cL7du1J8PAmNoQ+C1fytiN
        IrRAoA+FEd5BU+Coos1Zr/3dIG1Ze+8cmyz2GwTu151Daei1ztVngl/L5NK3iAnl
        9trgZcbzOKMzPCPukMqR5aJdh5LyDSx/CkKNInKT9aXFL/bG4k8DAkBrV6IdVCJD
        OO0J2DbLJGFGeqdYpFWhRV9jQiqOFUNscUJfjW6WBfClENJovgL0lHTlIFruLHJp
        Qq13HRlZgDdrc2mTYJpdJNmRQ8J3n+wYOvi2lOT2iBBnOQxhGEDmI1RU9VEPKrWE
        MACB0lVk4T+bPRF5Yq3QNIaX4SJHbTZrytwNAAuuw1ZvHR5lRwfMbs1F4XVnJdjg
        ==
In-Reply-To: <876092krew.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/12/17 11:29, NeilBrown wrote:
> 
> Hi Ian,
>  I've been looking at:
> 
>> - add configuration option to use fqdn in mounts.
> 
> (commit 9aeef772604) because using this new option causes a regression.
> If you are using the "replicated server" functionality, then
>   use_hostname_for_mounts = yes
> completely disables it.

Yes, that's not quite right.

It disables the probe and proximity check for each distinct host
name used.

Each of the entries in the list of hosts should still be
attempted and given that NFS ping is also now used in the NFS
mount module what's lost is the preferred ordering of the hosts
list.

> 
> This is caused by:
> 
> diff --git a/modules/replicated.c b/modules/replicated.c
> index 32860d5fe245..8437f5f3d5b2 100644
> --- a/modules/replicated.c
> +++ b/modules/replicated.c
> @@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host **list,
>         if (!*list)
>                 return 0;
>  
> +       /* If we're using the host name then there's no point probing
> +        * avialability and respose time.
> +        */
> +       if (defaults_use_hostname_for_mounts())
> +               return 1;
> +
>         /* Use closest hosts to choose NFS version */
> 
> My question is: why what this particular change made.

It was a while ago but there were complains about using the IP
address for mounts. It was requested to provide a way to prevent
that and force the use of the host name in mounts.

> Why can't prune_host_list() be allowed to do it's thing
> when use_hostname_for_mounts is set.

We could if each host name resolved to a single IP address.

I'd need to check that use_hostname_for_mounts doesn't get
in the road but the host struct should have ->rr set to true
if it has multiple addresses so changing it to work the way
your recommending shouldn't be hard. I think there's a couple
of places that would need to be checked.

If the host does resolve to multiple addresses the situation
is different. There's no way to stop the actual mount from
trying an IP address that's not responding and proximity
doesn't make sense either again because every time a lookup
is done on the host name (eg. at mount time) the next address
in its list will be returned which can and usually is different
from what would have been checked.

> I understand that it would be pointless choosing between
> the different interfaces of a multi-homed host, but there is still value
> in choosing between multiple distinct hosts.
> 
> What, if anything, might go wrong if I simply reverse this chunk of the
> patch?

You'll get IP addresses in the logs in certain cases but that
should be all.

It would probably be better to ensure that the checks are done
if the host name resolves to a single IP address.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
