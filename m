From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 03/12] autofs: Fix AUTOFS_DEV_IOCTL_IOC_COUNT value
Date: Thu, 21 Jul 2016 10:02:49 +0800
Message-ID: <1469066569.18422.45.camel@themaw.net>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1468138073-4870-3-git-send-email-kusumi.tomohiro@gmail.com>
	 <1468892055.5120.29.camel@themaw.net>
	 <CAHndrBmcKOk+YMxfNcBOX8jJj1H96=WpQNw1bMzL0sRhRP4Tdg@mail.gmail.com>
	 <1468975629.3102.29.camel@themaw.net>
	 <CAHndrBkdx1HJOqrPUzRy24_U=NQ6qfD9YTaAC9j0s68hnrkWCA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=nRDKSZsiWuWggsFUgtzhUFBn6hA=; b=ewx9+q
	Mt9u3YtMtMo3eyjGqPcVK4jWFdUsif7FZJq2f1IojArrzmEH5/w3jnnFsT25xqqu
	aj3eSn83kaky3ajMNGD5NU+Xj1RbIeatCLYkaE3+FkTrjHnEZjedQHxXgxYtb6Cc
	iiAsAzppGNsxGcvwezOLEaFt9ZAXpOUnp6dqk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nRDKSZsiWuWggsF
	UgtzhUFBn6hA=; b=FMfw4i1TCxZQJqU77tREjFCiarOb3eRlnbpZVCvBEvNPWfo
	+m/gp0XgSogpzFODIpIW8VqWNTvkpyjtaTcXNdoq9PiZG9cVDfynTJkb9wXhKwJu
	4Rn5TTN+smCAxznUODTYfU/bgo0XU8r0qAJBH9VHKolpLhr5dRI89yiwvKbo=
In-Reply-To: <CAHndrBkdx1HJOqrPUzRy24_U=NQ6qfD9YTaAC9j0s68hnrkWCA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Thu, 2016-07-21 at 02:53 +0900, Tomohiro Kusumi wrote:
> > So I think the problem with the miscellaneous device ioctl number check
> > you've
> > pointed out does need to be fixed and if you could update the patch to do
> > that
> > it would be much appreciated.
> 
> OK, I'll take a look at it again based on your explanation,
> and see if I can fix it, plus make things a bit more clear if possible.
> 
> > Don't forget that the miscellaneous device ioctls are a newer set of ioctls
> > with
> > added functionality to the older ioctls, hence the duplication you see with
> > the
> > functions provided with each set, and the check for that specific range is
> > relevant to the later ones only.
> > 
> > Also, only one or the other set of ioctls can be used and the miscellaneous
> > device ioctls can only be used with version 5 and above of user space
> > autofs.
> 
> Yes, I was wondering why they're implemented to both fs root and /dev/autofs
> when I first looked at ioctl and userspace code.
> 
> > 
> > I'd like to try (again) to re-implement this with netlink and add readdir
> > and
> > asynchronous expire functionality but I don't know when I'll get time to do
> > it s
> > ince it is a lot of work in kernel and user space, but I digress.
> 
> Is there a publicly available list of TODO for autofs (kernel and userspace) ?
> 
> According to some of your recent posts to this mailing list,
> you seem to have lots of patches that haven't been merged to upstream,
> and also things yet to be implemented.

There isn't.

The truth is there haven't been other developers that have stuck with it so I've
pretty much done everything in isolation.

That's not too good because that means there isn't discussion about how things
should be done and there's very little review of changes too, since there's no
-one to review them.

If there were others, such as yourself, I would start doing things quite
differently, but clearly that would take time to start happening.

I detest writing and maintaining web presences so there is no wiki which is
another problem, and is the sort of place where a TODO list would reside.

As far as patches that are either not finished, did not solve a problem, or are
in progress, yes I have plenty of those and they have accumulated over many
years.

That's not uncommon when you work with something for a long time but they are not useful until you return to a problem they may be related too, so mostly not useful to others.

For example, I tried to implement the control interface using the netlink
mechanism, a long time ago now, and failed but I keep the work that I did in
case I can use it at some time is the future, that's my nature.

A netlink interface would be better than using ioctls, it would be more flexible
in the long run but, at the time, I was unwilling to fundamentally change the
way automount(8) works and there were other difficulties with asynchronous
expires so I failed to get it working and implemented the anonymous device ioctl
interface instead.

So these patches are not useful at all and are just a consequence of things I
have tried to do in the past.

But there is still the question of how to better deal with listing of
directories (using certain options) that can cause everything within the
directory to mount.

Over the years I've thought about it many times and at times I think a kernel
readdir implementation would be better and (often after thinking more about it)
I come back to there being no advantage over the existing pre-creation of mount
point directories.

If I was to, one day, believe that a kernel readdir implementation would make a
worthwhile difference then I think it would be better to implement that using
the netlink sub-system and the problems with that would need to be worked out to
do so.

So it ends up being little more than something for thought only, or possibly
discussion if there were others to take part in it, and what I have for this
would be extremely hard for anyone else to use as it is a mess of partially done
work.

For a long time now I accumulate patches and then commit and push those that
prove sound. And often it has been quite a while between pushes so there can end
up being quite a few, but that can change if there is reason to do so.

And generally all patches that are committed and pushed are also available on
kernel.org grouped by release. I've been trying my best to ensure they is as
accurate as possible so it is clear what has gone into each release.

Also, at times I have tried to put together a TODO list of longer term things
that I'd like to do for myself but haven't been very successful, ;)

> 
> 
> 2016-07-20 9:47 GMT+09:00 Ian Kent <raven@themaw.net>:
> > On Wed, 2016-07-20 at 04:29 +0900, Tomohiro Kusumi wrote:
> > > Thanks for your review,
> > > 
> > > Yes, yours apparently works and that's exactly the right test based on
> > > currently existing ioctl cmds.
> > > I first thought about changing it like you did, but thought about
> > > meaning of AUTOFS_IOC_COUNT which is 32.
> > 
> > I think the meaning of this is taken from Documentation/ioctl/ioctl
> > -number.txt.
> > 
> > The define isn't actually used though, which is what I was saying.
> > 
> > > 
> > > I took this 32 as some sort of reserved range for autofs ioctl cmds,
> > > where the whole ioctl cmds are designed to be somewhere in 0x60-0x80
> > > range, and /dev/autofs ioctl cmds are in 0x71-0x80 range.
> > 
> > Yes, if ioctl numbers beyond 0x7e are to be used I think we need to update
> > the
> > above file.
> > 
> > It's been a while since I did this but the highest miscellaneous device
> > ioctl
> > number is 0x7e so if new ioctls were needed the usage registration file
> > would
> > need to be updated and posted as a patch.
> > 
> > > So in theory a potential ioctl cmd for /dev/autofs counting from the
> > > smallest cmd must be no larger than 32-0x11 (or 0x80-0x71).
> > > 
> > > I've no idea what this reservation/limitation up to 0x80 is supposed
> > > to mean though, as ioctl has 8 bits for nr part.
> > > If you say this 32 is meaningless, I'll resubmit it with your proposed
> > > change.
> > 
> > 
> > The AUTOFS_IOC_COUNT should stay purely because it documents the "claimed"
> > autofs range (from 0x60-0x7f). Maybe a comment is needed to clear this up.
> > 
> > But AUTOFS_DEV_IOCTL_IOC_COUNT is supposed to be used to check the passed in
> > miscellaneous device ioctl number is between 0x71-0x7f (or would if it was
> > correct).
> > 
> > So I think the problem with the miscellaneous device ioctl number check
> > you've
> > pointed out does need to be fixed and if you could update the patch to do
> > that
> > it would be much appreciated.
> > 
> > Don't forget that the miscellaneous device ioctls are a newer set of ioctls
> > with
> > added functionality to the older ioctls, hence the duplication you see with
> > the
> > functions provided with each set, and the check for that specific range is
> > relevant to the later ones only.
> > 
> > Also, only one or the other set of ioctls can be used and the miscellaneous
> > device ioctls can only be used with version 5 and above of user space
> > autofs.
> > 
> > I'd like to try (again) to re-implement this with netlink and add readdir
> > and
> > asynchronous expire functionality but I don't know when I'll get time to do
> > it s
> > ince it is a lot of work in kernel and user space, but I digress.
> > 
> > > 
> > > 
> > >      0x60               0x71            0x80
> > > -----+------------------+---------------+------------------> NR
> > >      <----------------------------------> AUTOFS_IOC_COUNT (32)
> > >                         <---------------> AUTOFS_DEV_IOCTL_IOC_COUNT
> > 
> > > 2016-07-19 10:34 GMT+09:00 Ian Kent <raven@themaw.net>:
> > > > On Sun, 2016-07-10 at 17:07 +0900, Tomohiro Kusumi wrote:
> > > > > According to include/uapi/linux/auto_fs.h,
> > > > > include/uapi/linux/auto_fs4.h,
> > > > > and include/linux/auto_dev-ioctl.h, nr part of
> > > > > AUTOFS_IOC_XXX starts off from 0x60 and
> > > > > AUTOFS_DEV_IOCTL_XXX starts off from 0x71 which is 0x60+0x11.
> > > > > 
> > > > > From the way above macros are defined, it seems
> > > > > AUTOFS_DEV_IOCTL_IOC_COUNT should be (0x20-0x11) instead of (0x20-11).
> > > > > (Otherwise it's hard to figure out where 11 comes from)
> > > > 
> > > > You're correct, this is wrong but I think this change is also wrong.
> > > > 
> > > > And so is the range check in dev-ioctl.c.
> > > > 
> > > > There's no check for an ioctl number greater than the range claimed by
> > > > autofs
> > > > and the check in dev-ioctl.c seeks to check the number used is within
> > > > the
> > > > range
> > > > used by the dev ioctls.
> > > > 
> > > > Essentially
> > > > 
> > > > AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD = 0xd
> > > > 
> > > > 14 ioctls ranging from 0x71 - 0x7e (inclusive).
> > > > 
> > > > The range check in dev-ioctl.c is:
> > > > 
> > > >         if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST)
> > > > ||
> > > >             cmd - cmd_first >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
> > > >                 return -ENOTTY;
> > > >         }
> > > > 
> > > > so I think AUTOFS_DEV_IOCTL_IOC_COUNT should be:
> > > > 
> > > > #define AUTOFS_DEV_IOCTL_IOC_COUNT \
> > > >         (AUTOFS_DEV_IOCTL_VERSION_CMD -
> > > > AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
> > > > 
> > > > and the check should be:
> > > > 
> > > >         if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST)
> > > > ||
> > > > 
> > > >       cmd_first - cmd >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
> > > >                 return
> > > > -ENOTTY;
> > > >         }
> > > > 
> > > > What do you think?
> > > > 
> > > > > 
> > > > > COUNT macros are being used to test distance of an ioctl command
> > > > > in question from the smallest one, so we don't want it to be
> > > > > larger than necessary.
> > > > > 
> > > > > Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> > > > > ---
> > > > >  fs/autofs4/autofs_i.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> > > > > index 73e3d38..7ef4d08 100644
> > > > > --- a/fs/autofs4/autofs_i.h
> > > > > +++ b/fs/autofs4/autofs_i.h
> > > > > @@ -20,7 +20,7 @@
> > > > >  #define AUTOFS_IOC_COUNT     32
> > > > > 
> > > > >  #define AUTOFS_DEV_IOCTL_IOC_FIRST   (AUTOFS_DEV_IOCTL_VERSION)
> > > > > -#define AUTOFS_DEV_IOCTL_IOC_COUNT   (AUTOFS_IOC_COUNT - 11)
> > > > > +#define AUTOFS_DEV_IOCTL_IOC_COUNT   (AUTOFS_IOC_COUNT - 0x11)
> > > > > 
> > > > >  #include <linux/kernel.h>
> > > > >  #include <linux/slab.h>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
