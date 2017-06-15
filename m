From: Ian Kent <raven@themaw.net>
Subject: Re: expected behaviour for replicated servers
Date: Thu, 15 Jun 2017 18:45:00 +0800
Message-ID: <1497523500.2650.3.camel@themaw.net>
References: <20170615021949.GM10434@mayhem.atnf.CSIRO.AU>
         <1497520371.2650.1.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Sl2qBQ4DIgXtNbzJqm
        cURCM+gyQjcbloan9ilDlm6Ew=; b=B566OLScubd/H7g/hLNf0fLrxGnJ3Ph1Yi
        rbJ0gUETFlUnfVdOVo2peifSN5OWQLy4n5tmQN+R2JbFnXr+fWMoteSyw/PHNNZs
        uDqW50LBIadHgU1nuOpnl/qgDzdg3vLZht5j39bprvyFvfm4jCj6dxVGoVwhvzSJ
        wWu1emHjAvZq3Yeu4scF4dT4u1QHWfxYryFJhaXqsBv3hXvizZnTr/8fJsmDuo3P
        qSUyf9Fyk//tKCiatzSpeJBWcNoi0qtcd/Lht8+Xt9sAtP1XDJVNsUtaOhhzkm+H
        6J77whh0zUUgFSTF0vAeV0uxdQVVJyV+0h/gB/gbf4fnn9xuVJGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Sl2qBQ4DIgXtNbzJqmcURCM+gyQjcbloan9ilDlm6Ew=; b=jBbqkugv
        L2f/xfQVRhK3uBco2JWJDdzeT90RWzH7IJffoSYocNyNeLOKu9D6ojzOgT8rpbsb
        5LUM8y3W8BxQakwfvKA/G389lEh133CB0raA/DXcGeEfm1vXj5vE+nUNBu1t7EZ5
        PsluWGlVFNNKd0q9r991yM3e3aJb5O/YSLHsV/S11iXbCS/0ajn8uZ2IVia3lovQ
        L0cSAeqquLDZG4X7set1aIsfUU1X9tOEzSK0/OID7WI60uoxx89fGS/yOWWjL7v2
        Jn8t7rB8RrvjdWAzaqD27EMirXhxFuGgJHecwrU7bjEaYANBL9I5vVRAWa8vVHOo
        DsvRyB7Yw/Bj5g==
In-Reply-To: <1497520371.2650.1.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>, autofs@vger.kernel.org

On Thu, 2017-06-15 at 17:52 +0800, Ian Kent wrote:
> On Thu, 2017-06-15 at 12:19 +1000, Vincent McIntyre wrote:
> > Hello
> > 
> > I can't see this in the manpages or README.replicated-server,
> > perhaps I can provide a patch...
> > 
> > I have this setup:
> > 
> > $ grep autofs /etc/nsswitch.conf
> > autofs: files nis
> > 
> > $ cat /etc/auto.master
> > /nfs  auto.nfs  -rw,hard,intr,vers=3
> > $ ypcat -k auto.nfs
> > foo  -ro,hard  boxa,boxb:/export/foo
> > 
> > 
> > Question:
> > 
> > If boxa has the NFS server running (so autofs ping works)
> > but does not export /export/foo,
> > what is the expected behaviour?
> 
> I haven't looked, so just I'll say what I think should happen.
> 
> > 
> > boxa and boxb are in different subnets, the client is in
> > the same subnet as boxa.
> 
> If the network proximity code is working properly boxb probably won't make it
> to
> the list of servers to try because it should look like it's further away.
> 
> > 
> > What I am seeing is that the automount fails completely
> > upon trying boxa. boxb is never tried (no request logged on boxb).
> > Looking at the autofs debug log, I can see
> > get_nfs_info called for boxa, twice in fact.
> > For boxb, only get_supported_ver_and_cost is called,
> > after which the daemon tries to mount the share from boxa.
> 
> That's likely expected as I'm pretty sure I construct the list of servers that
> have the selected characteristics including proximity.
> 
> For proximity it will check network address against local interfaces to work
> that out so you probably shouldn't see an NFS ping at all as that's used to
> establish best response amongst the list of selected servers.
> 
> I'd need to have a look at the code.
> 
> > 
> > 
> > What I was hoping to see is that the client also tries boxb
> > before giving up.
> > 
> > I tried fiddling with:
> >  the order (boxb,boxa:/export/foo)
> >  weights (boxb(3),boxa:/export/foo),
> > but none of this made any difference.
> 
> If I'm right then boxb won't get onto the list of servers to try so there's
> probably not much you can do about it, (again if I am right) possibly it
> should
> change to include the further away servers .... that might not be a straight
> forward change ...

Actually it looks more like boxb should be added to the end of the list of
servers to try.

I see a bug in there but I don't think it's triggering.
It's more likely there's been a problem connecting to boxb for some reason.

The debug log might be useful but I'd probably still need to add some more debug
log messages to work out what's going on.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
