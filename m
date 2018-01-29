From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/3] Assorted autofs fixes
Date: Mon, 29 Jan 2018 17:27:25 +0800
Message-ID: <4401f2a3-5a0b-17d8-6a31-ecc566c4a595@themaw.net>
References: <151721021295.27355.1968703903360394469.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=qVIzfyQppIPAz4UWw9Hk02NMyhyaO
        SkCLCgT5Hn4L48=; b=o1xFX2zFyVXW+7lJKvSov98cnWN5Du0D43Z0bt+BcSEcb
        6VmL3B1M+z4faCUHAoxqXWDllCZCPmSDV4HfcIq/hqjBBkppw2abc3jueDDbJ/FD
        rnYF9JV33ZsP4dGaMiE5W6VfsLnLa2Sg2qLI6hDKAd3vu3dEqy6WJZRO/+RQrdDe
        8Yt4U1au+is35krcBllD1sW0ZLqFv0676E5kefBLvemVUMmYpertz2VCwfhU3RkD
        I5129vEblFHjK2UrNEY/e5eXGYBb5xGCOMtSSVl3c2iC5ZoTCY27bn3hHOwn2JMW
        URH87+EfDScOhiakjc3nmE6NH8utj/JBZZSgoeERQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qVIzfy
        QppIPAz4UWw9Hk02NMyhyaOSkCLCgT5Hn4L48=; b=JhEiEDTkNCgbDtSY6Gtvat
        SxZRclUJa9EUpRf2V7dreoYf96oLPXux+tVOVcnFSYGI/KVjJ3vpcfM6z/ePuaO8
        U54jKEVD2qqUzIadkycoQ7+lWfCaCIEQjaomgzjchznBJgx4yOYtuV79ziD0yCSW
        3GtOyhSNpC74JjJn+LV2vUs0LEBSFACMB9FI3Iuarfvso3EDA10Ue3hJKJtD4Soe
        3zGeAc8d81V0mRN29LmrONyI1SuOaa3V99wPesVii7VykIBXCVashzhvrDnyv5eG
        rLA3YMK9ZTNSCeo8zC1iaHs5MWj9OqlOqKhquW5FjqBgdElwcFvU7xFR6Ej5k0ig
        ==
In-Reply-To: <151721021295.27355.1968703903360394469.stgit@noble>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>
Cc: autofs@vger.kernel.org

On 29/01/18 15:19, NeilBrown wrote:
> Hi Ian,
>  following are three fixes for the autofs patches.
>  The first is a revised version of a patch were have been
>  discussing that relates to use_hostname_for_mounts.
>  Rather than comparing weight and path and hostname etc to see
>  if two 'struct host' came from the same config-file entry,
>  I thought it would be best to record and index number and
>  just compare that.  Hopefully that makes it more obvious
>  what is happening.

Right, as I say, this was somewhat broken and what you're
recommending is an improvement although I think it doesn't
quite fix the possible problems either.

It's worth applying when it finally arrives.
  
> 
>  The second fixes that monotonic_elapsed() problem we discussed at
>  LCA.  Customer has confirmed that this fixes the problem.

Applied, it's in the queue.

> 
>  The third fixes a small Makefile bug

Yeah, the config files should be backed up but two installs
will cause problems.

Most distribution packaging will want to do that step separately
so it does look like a sensible thing to do.

This is also in my patch queue.

I'm going to need to post the patches for RFC and commit them
fairly soon and possibly another release, there's a deadlock
with the "automount -m" command that needs fixing in 5.1.4.

Thanks Neil.

> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (3):
>       use_hostname_for_mounts shouldn't prevent selection among replicas
>       Fix monotonic_elapsed.
>       Makefiles.rules: remove 'samples' from SUBDIRS
> 
> 
>  Makefile.rules       |    2 +-
>  include/replicated.h |    3 ++-
>  lib/rpc_subs.c       |    4 ++--
>  modules/mount_nfs.c  |    2 +-
>  modules/replicated.c |   35 ++++++++++++++++++++---------------
>  5 files changed, 26 insertions(+), 20 deletions(-)
> 
> --
> Signature
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
