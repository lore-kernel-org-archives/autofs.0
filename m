From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 0/2] autofs: fix autofs_v5_packet dlivery in compat
 mode
Date: Thu, 14 Sep 2017 08:32:43 +0800
Message-ID: <bc3ada96-1f10-7d5b-6711-50f1cc8ce898@themaw.net>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=xlnZZ+kGwrkbGNkxD8
        NJ4YZzFKVPiKGUr5S2E+r7YXQ=; b=YYyboxoxyN7EtRpyBOzZ6m2+VEorzvQQGy
        GyD6EXM+7bJ7WzEdtV3/Ph6HhWZtvIJmReQwF49VpDA88/g3f/uzpMfROVrJUwnM
        DORS03iY7Ejzm4MetwyaOG0ujo8b3RJ3q+4SUudhTZ3mIvFuDDQUYY2iG+uNodnm
        u/crGEdmSsHgllwsNJnKS1A7bV/8T9lhas/HwRH9GmjL0i3VUWCJfyfxD4GiQQvR
        23rl+Bqs1Y/mXj7hzNPYx4NYvGxBLnUe+l9VaPPoLB0C3ZQMxt6zGmDKydcw191c
        Jx6UDksVTQVQz6VB1SqyVbp2YR6Wmh8XCxVwW6lHZBuxRc4jI6Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=xlnZZ+kGwrkbGNkxD8NJ4YZzFKVPiKGUr5S2E+r7YXQ=; b=CKuS1R2I
        KN/bxJtdbY1KZ4nmkYXT0iYNYeT5I4n09rtn1hDJWY3uKU96Yyl/jFrxeyxza0Oh
        rXyy0CO6/g0RQckzBQx1480Lpk4ryT3ub3+CASfdzZli7F1KCk15dnfAnp3TGMHh
        79OegyoRX8vCmulec8D31K+ePc8n0bb4FM7AlxeLjirMaYjUBWbOXgfRfPxCN/KS
        Y04Kw28IA+/df8mZrlaqkWLADZbmleTNCGiIBoDEmEfw+SZYIK1I+N7SuH6OVWLA
        r0XlDinwyosgr9MgFp2hKEO8mehm48S+uK5kPnmxNUqaCncP/AMCeORmIg2XC5rs
        OqdWMDxm+776BA==
In-Reply-To: <20170901110906.2669.1577.stgit@localhost.localdomain>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

On 01/09/17 19:21, Stanislav Kinsburskiy wrote:
> The problem is that in compat mode struct autofs_v5_packet has to have different size
> (i.e. 4 bytes less).

I regret (several times over) my original decision to not make v5 packets
packed ....

I have to say the description of the problem is not all that good.

> 
> This is RFC because:
> 1) This issue is hidden, because autofs pipe has O_DIRECT and the rest of the
> epacket is truncated when read.
> 2) X86 arch doesn't have is_compat_task() helper
> 3) It's now clear, what to do if "pgrp" option is specified.

I don't understand what the "pgrp" option has to do with this?

> 
> The following series implements...
> 
> ---
> 
> Stanislav Kinsburskiy (2):
>       autofs: set compat flag on sbi when daemon uses 32bit addressation
>       autofs: sent 32-bit sized packet for 32-bit process
> 
> 
>  fs/autofs4/autofs_i.h  |    3 +++
>  fs/autofs4/dev-ioctl.c |    3 +++
>  fs/autofs4/inode.c     |    4 +++-
>  fs/autofs4/waitq.c     |    5 +++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
