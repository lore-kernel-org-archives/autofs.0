From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Tue, 15 Feb 2022 15:00:29 +0800
Message-ID: <922c4a440b455d158729abcc0c9f78dc3726c2c0.camel@themaw.net>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
        , <164444398868.27779.4643380819577932837@noble.neil.brown.name>
        , <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
         <164487880421.17471.502085345359040789@noble.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=CftVwxx6/enlw5
        nUGLeWOeBDLMuBox5q8DqIADZn4FY=; b=e8kSDf8ZDCqRLCV0QsDGHHRcvu1Chw
        fcgaeXX6QeveEMfOPXyBWGfCnSGnx3EAhxkjGUprfBv2YMBnF9Yus4n1PsS2HjQx
        ELq2gSv9UhnmLsADNr4bCLJshUulagaIOp6avn5r6H6pdMbDbt1lHVyWLu+d7k2h
        QCoQ9702HIyJ9OVVV2wgpMpX0T90N7B3EfkGNKjzfzVawqqSLgRDTOqOsBYWLpPU
        y0bD/ENEq85G4UVYmE7789IWZYwi4CZywEBBwInUvgwPpCQipo6X81FFGs71ZvsH
        ZfIFrYMIPBrrVlBjR5ytYxR/+GBHpthyWa97Pt31VVK8JDQsjS/FCbJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=CftVwxx6/enlw5nUGLeWOeBDLMuBox5q8DqIADZn4
        FY=; b=FzMue8TAWJU48bmfIFdZ3RcFORDHMvDcQaIBL/aOnNbhgciW3mpUnuk0z
        WEv25gaiYQr5/jYHCFhJRqapaq3mXNxxXQjIMl0UAER1/OvKkH+oCjdVUDi98YK1
        GSza6dkmLhbz4bSKhwWESYKokROn5myk7o2XqJqTM61RZF6VKXykGNTCVLVMLD1u
        M5rANMpQ7IzFPQ8H7gDghKBEykJ7CL6s8q4GzRTY4HnMAcqhjwekOfZxfn++//+f
        80u3hPjUwjUJiAbygXQ1XNmzXYwsiFskyGJNyIg1+YWHtASzUQNjvap0qA8Has4w
        cf+BtBMiQxB96Bph/go5FgTWJ2aYQ==
In-Reply-To: <164487880421.17471.502085345359040789@noble.neil.brown.name>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2022-02-15 at 09:46 +1100, NeilBrown wrote:
> On Mon, 14 Feb 2022, Ian Kent wrote:
> > On Thu, 2022-02-10 at 08:59 +1100, NeilBrown wrote:
> > > On Tue, 19 Oct 2021, Ian Kent wrote:
> > > > Hi all,
> > > > 
> > > > It's time for a release, autofs-5.1.8.
> > > > 
> > > ...
> > > > - also require TCP_REQUESTED when setting NFS port.
> > > 
> > > Unfortunately that last patch is buggy.  TCP_REQUESTED is masked
> > > out
> > > in
> > > the caller.
> > 
> > Mmm ... sounds like I've made a mistake there.
> > I'll need to sort that out, thanks for pointing it out.
> > 
> > > 
> > > Maybe the following is best.
> > > 
> > > NeilBrown
> > > 
> > > From: NeilBrown <neilb@suse.de>
> > > Subject: [PATCH] Test TCP request correctly in nfs_get_info()
> > > 
> > > The TCP_REQUESTED flag is masked out by the caller, so it never
> > > gets
> > > to
> > > nfs_get_info().
> > 
> > That wasn't my intent, I'll need to look at it again.
> > The case I'm trying to cover is fairly specific so I will need to
> > look at it again.
> > 
> 
> I'm curious: What was the case you were trying to solve??  I couldn't
> guess any justification for the change.

Somewhere along the way I broke NFSv4 mounts being able to be mounted
without the use of rpcbind.

I require the option fstype=nfs4 for this and if given the map entry
should be mountable without recall to any other services beside NFS.

So that option shouldn't be masked out since it allows automount
to identify (or should) this case.

Ian
