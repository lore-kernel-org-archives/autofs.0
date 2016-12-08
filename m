From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Thu, 08 Dec 2016 11:29:50 +0800
Message-ID: <1481167790.3924.3.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161203051322.GA24765@ZenIV.linux.org.uk>
         <1481017056.4589.21.camel@themaw.net> <8737hzv34f.fsf@xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=1QLQlmIgKxpFftE
        RBC9dKEkubCY=; b=gEP+ZvaOvJS45AhBtP0gv4ld2Ud7yqn6ENgB6XRb+k0bKIh
        YH86xILVbhS/7utA1BhO8N6IBB2RBFTKe7zAj0R/gVJCcoV6L/CskJPJMotXgtEK
        lPwgG1OajAvMxfZvoYMWWUQba9Yt3V+HcS8uEtkr9qtiHr+zEGtypP/bSMnk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=1QLQlmIgKxpFftERBC9dKEkubCY=; b=Pe+2OEJR3K7Q23nyKf9d
        UU2wk2qmcbGVuDawiZn+kDVGd0T6M1eVllrwZ1Ki4V3wJjMQE776OLgfrrXUv296
        fkmzqNk6hWS+fDYLXBP2l7wgKaMiToWQatyfYBnf8JF1ZAhzFB2IRan8KvSvd/C+
        eVOYW14gUSpjPIU6v+0N1Jo=
In-Reply-To: <8737hzv34f.fsf@xmission.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-12-08 at 10:30 +1300, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Sat, 2016-12-03 at 05:13 +0000, Al Viro wrote:
> > > 	FWIW, I've folded that pile into vfs.git#work.autofs.
> > > 
> > > Problems:
> > 
> > snip ...
> > 
> > > 	* the last one (propagation-related) is too ugly to live - at the
> > > very least, its pieces should live in fs/pnode.c; exposing
> > > propagate_next()
> > > is simply wrong.  I hadn't picked that one at all, and I would suggest
> > > coordinating anything in that area with ebiederman - he has some work
> > > around fs/pnode.c and you risk stepping on his toes.
> > 
> > The earlier patches seem to be ok now so how about we talk a little about
> > this
> > last one.
> > 
> > Eric, Al mentioned that you are working with fs/pnode.c and recommended I
> > co-
> > ordinate with you.
> > 
> > So is my working on this this (which is most likely going to live in pnode.c
> > if
> > I can can get something acceptable) going to cause complications for you?
> > Is what your doing at a point were it would be worth doing as Al
> > suggests?
> > 
> > Anyway, the problem that this patch is supposed to solve is to check if any
> > of
> > the list of mnt_mounts or any of the mounts propagated from each are in use.
> > 
> > One obvious problem with it is the propagation could be very large.
> > 
> > But now I look at it again there's no reason to have to every tree because
> > if
> > one tree is busy then the the set of trees is busy. But every tree would be
> > visited if the not busy so it's perhaps still a problem.
> > 
> > The difficult thing is working out if a tree is busy, more so because there
> > could be a struct path holding references within any the trees so I don't
> > know
> > of a simpler, more efficient way to check for this.
> 
> So coordination seems to be in order.  Not so much because of your
> current implementation (which won't tell you what you want to know)

Umm ... ok I've missed something then because the patch I posted does appear to
get the calculation right. Perhaps I've missed a case where it gets it wrong
....

But now I'm looking deeper into it I'm beginning to wonder why it worked for one
of the cases. Maybe I need to do some more tests with even more printks. 

> but because an implementation that tells you what you are looking for
> has really bad > O(N^2) complexity walking the propagation tree in
> the worst case.

Yes it is bad indeed.

> 
> To be correct you code would need to use next_mnt and walk the tree and
> on each mount use propagate_mnt_busy to see if that entry can be
> unmounted.  Possibly with small variations to match your case.  Mounts
> in one part of the tree may propagate to places that mounts in other
> parts of the tree will not.

Right, the point there being use propagate_mnt_busy() for the check.

I tried to use that when I started this but had trouble, I'll have another look
at using it.

I thought the reason I couldn't use propagate_mnt_busy() is because it will see
any mount with submounts as busy and that's not what's need. It's mounts below
each of mounts having submounts that make them busy in my case.

You probably don't want to read about this but, unfortunately, an example is
possibly the best way to describe what I need to achieve.

A simple example for is the autofs direct mount map entry (a so called autofs
multi-mount):

/absolute/path/to/direct/mount-point \
    /offset/path/one      server:/export/path/one \
    /offset2/path/two     server2:/export/path/other

The path /absolute/path/to/direct/mount-point is an autofs direct mount trigger
and is essentially an autofs mount.

When the mount is triggered each of the offsets, /offset/path/one and
/offset2/path/two offset trigger mounts are mounted so they can trigger mounts
independently.

When the direct mount /absolute/path/to/direct/mount-point is expired the two
offsets need to be umounted if they are not busy so
/absolute/path/to/direct/mount-point having submounts doesn't necessarily make
it unable to be umounted.

But this is (supposed) to be for only to one level of mounts, for example if I
had:

/absolute/path/to/direct/mount-point \
    /offset/path/one        server:/export/path/one \
    /offset2/path/two       server2:/export/path/other \
    /offset/path/one/nested server3:/export/path3/nested

then the the offsets below the nesting point /offset/path/one make it busy and
need to be expired first.

So why would I even need to do this?

It's functionality of Sun autofs maps and that's the primary map format autofs
supports but that's why it's needed and not why I do it this way.

Another example of one these multi-mounts is:

/absolute/path/to/direct/mount-point \
    /                     servern:/another/export \
    /offset/path/one      server:/export/path/one \
    /offset2/path/two     server2:/export/path/other

where an NFS mount is done on the root of the offset tree (similar to the case
where nesting is present in the example map entry above).

Once that happens autofs can't get a callback to mount offsets unless there are
offset triggers mounted to trigger the mounts.

> 
> I am assuming you are not worried about MNT_DETACH, as that case would
> not need may_umount_tree at all.

I'm not. 

> 
> I am researching how to make walking propagation for multiple mounts
> efficient but it is a non-trivial problem.

Sure is.

> 
> > Anyone have any suggestions at all?
> 
> In the short term I recommend just not doing this, but if you want to
> see if you can find an efficient algorithm with me, I am happy to bring
> you up to speed on all of the gory details.

I need to do this to make autofs play better in the presence of namespaces and
that's a problem now and is long overdue to be resolved.

So I'm happy to do whatever I can to work toward that.

I could leave this part of the implementation until later because the false
positive this solves leads to an expire fail and that is (must be) handled
properly by the user space daemon.

But when I first noticed the false positive the expire failure was handled ok by
the daemon (AFAICS) but there was what looked like a reference counting problem
(but not quite that either, odd) which I was going to return to later.

Maybe I've stumbled onto a subtle propagation bug that really needs fixing ....

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
