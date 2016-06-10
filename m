From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an
 error
Date: Fri, 10 Jun 2016 16:45:23 +0800
Message-ID: <1465548323.3174.2.camel@themaw.net>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
	 <1459496266.2974.1.camel@themaw.net>
	 <CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
	 <1464053664.3108.21.camel@themaw.net> <1464587527.3025.6.camel@themaw.net>
	 <1465435406.3154.4.camel@themaw.net>
	 <CANaxB-y93uqDzt2+VPSTBtw7bohSgM-OT_XYU1qC+N=Zu=ECDw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=cQpBc2h91y2SFk1kObHzEKbEksM=; b=ML6iNh
	2CZUpgk0hxKC5Oj0zZumFWuCRidPuPX+oUr/iTPCLQHORD6zVwGKcL3MyOsjainy
	VycaAV/ig2k7jY6tC0hKV4JHCc7Hcm1cQ2ZjNY0um6EwsqQaKsB7WqNTw+BlN86t
	m2l83XNPRAu1xjhqUpxUZdFfLbN1H99eWc534=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=cQpBc2h91y2SFk1
	kObHzEKbEksM=; b=NkemAVinBHkv1cECF/T4JmFtC5KRD4vGIHPAjsnSMik2vWR
	bpmmVA/Jsu3P0WUfAVtNOLovPG5dVi5wihB7SCleqaVPOAbcUs0MJbD6Z8dc7bn/
	DD8BLkLl2i9IV/IYP8WRU8rtVrEXkGCB8vO9/kE/kjjsln9PTe8AfiUkHuLY=
In-Reply-To: <CANaxB-y93uqDzt2+VPSTBtw7bohSgM-OT_XYU1qC+N=Zu=ECDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Vagin <avagin@gmail.com>
Cc: autofs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2016-06-09 at 10:27 -0700, Andrei Vagin wrote:
> On Wed, Jun 8, 2016 at 6:23 PM, Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2016-05-30 at 13:52 +0800, Ian Kent wrote:
> > > On Tue, 2016-05-24 at 09:34 +0800, Ian Kent wrote:
> > > > On Mon, 2016-05-23 at 14:50 -0700, Andrei Vagin wrote:
> > > > > Hi Ian,
> > > > > 
> > > > > When are you going to apply this patch? We can't test linux-next
> > > > > without
> > > > > it.
> > > > 
> > > > I though I sent this with the last series but I can't see that I have.
> > > > 
> > > > I have the rest of that series to send over to Andrew which I was
> > > > planning
> > > > to
> > > > do
> > > > after the current merge window closes (which is about now I guess).
> > > > 
> > > > I'll include it in that series.
> > > > Sorry for the hold up, ;)
> > > 
> > > Some bad news I'm afraid.
> > > 
> > > I was getting ready to send these over to Andrew and found that opendir(3)
> > > is
> > > failing on a number of tests (51 of 230, 9 fails are expected) with 4.6.0.
> > > 
> > > It's not the patches, yours or mine and it doesn't happen with 4.4.x
> > > kernels.
> > > 
> > > Looks like I'm going to have to bisect to work out what's going on and
> > > that
> > > will
> > > take a while.
> > 
> > The regression has been fixed now.
> > 
> > Al Viro sent a patch for it to Linus yesterday, it's commit e6ec03a25f1 in
> > the
> > Linux tree.
> 
> It's good!
> 
> > 
> > I can send my patches to Andrew (after re-testing) but any autofs related
> > testing of linux.next will need the above commit.
> > 
> > Andrew, surely this isn't the first time this type of problem has happened,
> > how
> > is it usually handled, what do I need to do to make this go smoothly?
> 
> In linux-next we catch two sorts of bugs.
> 
> 1. If bugs is triggered very often, we report it, when it isn't in
> Linus' tree. And such bugs are fixed very fast.
> 2. If bugs is triggered rarely. In this case we may detect this bug
> too late, when it's in Linus' tree. In this case we may need to
> workaraound it.
> 
> Here the problem belongs to the second type. It is triggered only when
> one or more tests failed and we try to kill all test processes.
> Actually it doesn't affect regular runs of tests, but it's annoying
> when we are investigating something.
> 
> Ian, I don't think that you need to do anything special. Thank you for
> handling this patch!

LOL, it's good that it was my standard (relatively simple) testing that exposed
it.

I'll wait a little longer in case Andrew has anything to add then send the patch
series to him.

> 
> Thanks,
> Andrew
> 
> > 
> > > 
> > > > 
> > > > Ian
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Andrew
> > > > > 
> > > > > 
> > > > > On Fri, Apr 1, 2016 at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
> > > > > > On Thu, 2016-03-31 at 22:12 -0700, Andrey Vagin wrote:
> > > > > > > From: Andrey Vagin <avagin@openvz.org>
> > > > > > > 
> > > > > > > __vfs_write() returns a negative value in a error case.
> > > > > > 
> > > > > > Ha, right, I'll send this along to Andrew with my next series which
> > > > > > should be soon.
> > > > > > 
> > > > > > > 
> > > > > > > Cc: Ian Kent <raven@themaw.net>
> > > > > > > Signed-off-by: Andrey Vagin <avagin@openvz.org>
> > > > > > > ---
> > > > > > >  fs/autofs4/waitq.c | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> > > > > > > index 0146d91..631f155 100644
> > > > > > > --- a/fs/autofs4/waitq.c
> > > > > > > +++ b/fs/autofs4/waitq.c
> > > > > > > @@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info
> > > > > > > *sbi,
> > > > > > >       set_fs(KERNEL_DS);
> > > > > > > 
> > > > > > >       mutex_lock(&sbi->pipe_mutex);
> > > > > > > -     wr = __vfs_write(file, data, bytes, &file->f_pos);
> > > > > > > -     while (bytes && wr) {
> > > > > > > +     while (bytes) {
> > > > > > > +             wr = __vfs_write(file, data, bytes, &file->f_pos);
> > > > > > > +             if (wr <= 0)
> > > > > > > +                     break;
> > > > > > >               data += wr;
> > > > > > >               bytes -= wr;
> > > > > > > -             wr = __vfs_write(file, data, bytes, &file->f_pos);
> > > > > > >       }
> > > > > > >       mutex_unlock(&sbi->pipe_mutex);
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe autofs" in
