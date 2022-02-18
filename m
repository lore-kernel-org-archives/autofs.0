From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Fri, 18 Feb 2022 12:47:37 +0800
Message-ID: <480248c2fdd2a098fd016aea832f297d711dfdff.camel@themaw.net>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
        , <164444398868.27779.4643380819577932837@noble.neil.brown.name>
        , <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
         <164506664650.10228.15450975168088794628@noble.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=MAx0LbiRQY2/4y
        fvblXz5g/u+zDEUYP5tuDrUJ8qmwQ=; b=I7ZRQ1BmgnsxTccEzquz5498MFjt54
        0dJYI+ugMMV8NaSvSuz2sbYtS5IYKRAgu6jR1lQ0Y7Gv/2F8L+ZJHdo0TrYxnNqR
        GZkfW2HosNfWFjLrcLNbttXIKNOyc5xjL0DbS/I3WJ19aOwaQZ3r2Sv9Ftlrg+SK
        h+ohCUMKkH9RJQ/AGwPg4SA9prbbV2zQavd6h5YbiRGJ0mTTUe9YCmdWD+xEPQ9A
        RxSIvFQsG8WVTYhst2AqnUgNweB0wmVr7cF2uEwMGKrCrq4ig1hcsGlDfPyJ6SUZ
        0oVzXob/M7eQHESEy2LTyFL79o7R4UZwbq0Km7dYjaBrV5D2BAGnFolg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=MAx0LbiRQY2/4yfvblXz5g/u+zDEUYP5tuDrUJ8qm
        wQ=; b=KAUf4Dx8X7/lwkY78oioZj07RZWfgPCG54ojKLPgb3qHP51tvq/Z/fX34
        +tCzRQ/vq3J5KJrjqoX1B9vyY/a7C950qWZKZFvjt3Bze2iiZ5K7IitiODqX1/bp
        ZIz8k6vzor19SGtrTXNZ6F4Zl9QD++ZRMAZmRhrKjk7xCjHEvqZnYbjwKM/tcbis
        NG0JBvwn62H2WSJNascgg1o2wodJMWlA5RvogzYKElOJ45GawtWgGHPU0AEG71M+
        iduFCShz2qkyak82rYpq41v5jBmvnWMbsweuLGx8jVnvzF21/bLvW7Kb03rYXkPN
        B9gE0RpInvEKqrPvrBTk3jjZ7inyg==
In-Reply-To: <164506664650.10228.15450975168088794628@noble.neil.brown.name>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>, Stanislav Levin <slev@altlinux.org>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 13:57 +1100, NeilBrown wrote:
> On Tue, 15 Feb 2022, Stanislav Levin wrote:
> > 
> > 
> > This seems duplicate of
> > https://www.spinics.net/lists/autofs/msg02389.html
> > 
> 
> Yes it is - thanks for the link.
> I wonder why the proposed fix isn't in git ....

I think we are refering to commits:
fc4c067b53f7 autofs-5.1.7 - make NFS version check flags consistent
26fb6b5408be autofs-5.1.7 - refactor get_nfs_info()
606795ecfaa1 autofs-5.1.7 - also require TCP_REQUESTED when setting NFS
port

> 
> Also, I cannot see that the new NS4_ONLY_REQUESTED is different from
> the
> existing NFS4_VERS_MASK.
> They are both set/cleared at exactly the same places.

Yes they are at the moment.

The aim there is, at some point, to have two seperate cases for NFSv4
mounts, one that may use rpcbind and one that does not such as when
traversing a firewall. Although I'm not clear on it myself the RFC
says, more or less, should (although that might have been must) not
need to use other than the NFS port, so no rpcbind should need to be
used.

Clearly the case seperation hasn't happened yet but I'm pretty sure
the current code did avoid the rpcbind usage for fstype=nfs4 which
is what was asked for at the time and what had been broken somewhere
along the line.

Ian
