From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Mon, 14 Feb 2022 13:34:46 +0800
Message-ID: <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
         <164444398868.27779.4643380819577932837@noble.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=FwpXgRHkKOnxGk
        gH2V9GHUXNJiCu/ssAJnUnC7PmQaI=; b=BC798HSJ7e7u3jkh9OrLq5my9B4tLn
        tXgji4leFe0NI/Dw9Vj8wzpQko66NYAq0ikQM/jyo1WJtxpPVdCu2nx7DJYMcocK
        WlTyLnn6kIt2cNyUc2Zs4v9GkZpNHMT7OrDeOc0M4ErnLa6VD65DAb2T7QQCr6br
        LZMiYbZbeLU7iCeRcZDJfnOEZUd1BPyHA/iy2qHU+552006Jf7p6gnY4G94EwpLH
        ZZ2GkQ7sCPgLmNIcXyhIENpmhYZ2RX4OR/+qTfETKIeqZkE5nj2mVVt0Nv0sGKvA
        hfTNvXikYZFaygCeRdbyd8ufh3+td53Jdr/4qjArpw35k5qek54EEOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=FwpXgRHkKOnxGkgH2V9GHUXNJiCu/ssAJnUnC7PmQ
        aI=; b=m3oOoN5bGKTNrL7MiWfJ/tln8VgqzV7RT4TlMO/dory7wzYWzBIylZi4y
        IXpzOS5pw/3SQPbstTRd5I7VwS29ol1cngkBfDqhZRjofsNsZQpV2w6+JUo5ZWIN
        uYemA2UA4S0becx2E+imXzw1MMcvGC3znqMb2qFlcRVhvyxKjoG3uE2NE1VjQQZW
        O0iN3ep99eN92Dge23nRDGh+/2MW0MGb7sO3gTwexByuId7SFjvezq1KZW3Gl2VS
        tOXttx5Czrt94V+pJlEzPQcwxLm6GYF3R0c/OM9lLyxIYyUwCdnYQ3DtBepcB2t+
        Wrbpii2+km2KeDkuuq5sQnLEjxlkw==
In-Reply-To: <164444398868.27779.4643380819577932837@noble.neil.brown.name>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2022-02-10 at 08:59 +1100, NeilBrown wrote:
> On Tue, 19 Oct 2021, Ian Kent wrote:
> > Hi all,
> > 
> > It's time for a release, autofs-5.1.8.
> > 
> ...
> > - also require TCP_REQUESTED when setting NFS port.
> 
> Unfortunately that last patch is buggy.  TCP_REQUESTED is masked out
> in
> the caller.

Mmm ... sounds like I've made a mistake there.
I'll need to sort that out, thanks for pointing it out.

> 
> Maybe the following is best.
> 
> NeilBrown
> 
> From: NeilBrown <neilb@suse.de>
> Subject: [PATCH] Test TCP request correctly in nfs_get_info()
> 
> The TCP_REQUESTED flag is masked out by the caller, so it never gets
> to
> nfs_get_info().

That wasn't my intent, I'll need to look at it again.
The case I'm trying to cover is fairly specific so I will need to
look at it again.

Ian

> We can test if TCP was requested by examining the 'proto' parameter.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> diff --git a/modules/replicated.c b/modules/replicated.c
> index 09075dd0c1b4..3ac7ee432e73 100644
> --- a/modules/replicated.c
> +++ b/modules/replicated.c
> @@ -291,7 +291,7 @@ static unsigned int get_nfs_info(unsigned logopt,
> struct host *host,
>  
>         rpc_info->proto = proto;
>         if (port < 0) {
> -               if ((version & NFS4_REQUESTED) && (version &
> TCP_REQUESTED))
> +               if ((version & NFS4_REQUESTED) && (proto ==
> IPPROTO_TCP))
>                         rpc_info->port = NFS_PORT;
>                 else
>                         port = 0;
> 

