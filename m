From: Ian Kent <raven@themaw.net>
Subject: Re: expected behaviour for replicated servers
Date: Thu, 15 Jun 2017 17:52:51 +0800
Message-ID: <1497520371.2650.1.camel@themaw.net>
References: <20170615021949.GM10434@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=yIYdJ+0ysCliC+cPfz
        u6aE2V129fpw7sUg5I9s9h1Hs=; b=UwpWFxK422d6kS4B9ArOH5K3X9kANv/rjM
        0qm2/ffvAd9VozHRNCPAraemABqNtgzidJt+OHkZ43i9vuNrMmzC4MsLDVyYB8GT
        Vw1miltibUE19O+/HkwpmsKWJpbJxZS79DY3iiOkjCGxZc74/1sDtrMugkCDEdj/
        0ZnAWHcCRQmLJTDa6sqL5RjbXxg4g6QXJq/Br5c+/TKCpWlalYfT9rilJd353/j+
        3lcfUAgj7fUZ8PXSAEuHdzAPeqmo/DPSnpklgv0et27aygw3PhQ0LrMBvw41fz8X
        V6g06UxUo5AvZ0IKpON2Xz+4FCvFOJLV74yTvSx4N7CGLuKKkO/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=yIYdJ+0ysCliC+cPfzu6aE2V129fpw7sUg5I9s9h1Hs=; b=SeFr8lN+
        E37vqlDv8KUdbsBMcRVZMtFdb6XsI+3oRiG5RzfD75ygY35Ing7ZJFYw49Wpm4sl
        B0QNS+PZCKbTpfgG11ta0MMjnnF0JwLxcD5vlnOSf7ku5njp+ENR6se2GQzJncPI
        jxYct1mi57MA5fFsVuwOzLgpx8Yxwqv3OeW2q3AdZebcUJxuRbMkFXYdx4O6jtsc
        LAc4Bv0h6SJWgyUhkZ5R+BkB4yJKbeqvGRB/EbuIG6B5BQ7vGccXR1S9b+vrRmys
        1k3tPAfdxDlYN5aTZGRrfGtZs4159F7JmlFYzjZaLEvrLQVGs+6q3fUmFIv677uh
        IaxF+mHdVia+ZQ==
In-Reply-To: <20170615021949.GM10434@mayhem.atnf.CSIRO.AU>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>, autofs@vger.kernel.org

On Thu, 2017-06-15 at 12:19 +1000, Vincent McIntyre wrote:
> Hello
> 
> I can't see this in the manpages or README.replicated-server,
> perhaps I can provide a patch...
> 
> I have this setup:
> 
> $ grep autofs /etc/nsswitch.conf
> autofs: files nis
> 
> $ cat /etc/auto.master
> /nfs  auto.nfs  -rw,hard,intr,vers=3
> $ ypcat -k auto.nfs
> foo  -ro,hard  boxa,boxb:/export/foo
> 
> 
> Question:
> 
> If boxa has the NFS server running (so autofs ping works)
> but does not export /export/foo,
> what is the expected behaviour?

I haven't looked, so just I'll say what I think should happen.

> 
> boxa and boxb are in different subnets, the client is in
> the same subnet as boxa.

If the network proximity code is working properly boxb probably won't make it to
the list of servers to try because it should look like it's further away.

> 
> What I am seeing is that the automount fails completely
> upon trying boxa. boxb is never tried (no request logged on boxb).
> Looking at the autofs debug log, I can see
> get_nfs_info called for boxa, twice in fact.
> For boxb, only get_supported_ver_and_cost is called,
> after which the daemon tries to mount the share from boxa.

That's likely expected as I'm pretty sure I construct the list of servers that
have the selected characteristics including proximity.

For proximity it will check network address against local interfaces to work
that out so you probably shouldn't see an NFS ping at all as that's used to
establish best response amongst the list of selected servers.

I'd need to have a look at the code.

> 
> 
> What I was hoping to see is that the client also tries boxb
> before giving up.
> 
> I tried fiddling with:
>  the order (boxb,boxa:/export/foo)
>  weights (boxb(3),boxa:/export/foo),
> but none of this made any difference.

If I'm right then boxb won't get onto the list of servers to try so there's
probably not much you can do about it, (again if I am right) possibly it should
change to include the further away servers .... that might not be a straight
forward change ...

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
