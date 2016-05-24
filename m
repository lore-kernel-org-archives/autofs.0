From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an
 error
Date: Tue, 24 May 2016 09:34:24 +0800
Message-ID: <1464053664.3108.21.camel@themaw.net>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
	 <1459496266.2974.1.camel@themaw.net>
	 <CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=/zzTDB1b57kQVQcrYPZ24T4QRAc=; b=Euid2f
	7tGKoJi4Yokxf20v4OXpxRyl0I2/E+WTSAGQAK14B02qLb8e1tB6DQNeAtoLZAQ7
	SgdlBOKMZcG/fVNTYGWuDMlHAQjgEpdp16cqKLWabof/Ir0s7Dlv/xCkToKcJ+Rq
	9S2kavUrf2yASm+azugPPTgbhrgrGpadV84zE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/zzTDB1b57kQVQc
	rYPZ24T4QRAc=; b=WfEOkqQnd0x8llipXbydSlJD+Wfs5SkCQKAZ71iP2rJQpkJ
	eTcp82P4REsdak15MhOb+uLz4dHLql8Loz6hIogFpw3lrmYJFECpn6AJLXsB53ys
	UFRtmVzB1muHXDExLktSP8VQR1XBiKgCkvOI6R3kmsE2gb93KGhKUjNpSNA4=
In-Reply-To: <CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Vagin <avagin@gmail.com>
Cc: autofs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org

On Mon, 2016-05-23 at 14:50 -0700, Andrei Vagin wrote:
> Hi Ian,
> 
> When are you going to apply this patch? We can't test linux-next without it.

I though I sent this with the last series but I can't see that I have.

I have the rest of that series to send over to Andrew which I was planning to do
after the current merge window closes (which is about now I guess).

I'll include it in that series.
Sorry for the hold up, ;)

Ian

> 
> Thanks,
> Andrew
> 
> 
> On Fri, Apr 1, 2016 at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2016-03-31 at 22:12 -0700, Andrey Vagin wrote:
> > > From: Andrey Vagin <avagin@openvz.org>
> > > 
> > > __vfs_write() returns a negative value in a error case.
> > 
> > Ha, right, I'll send this along to Andrew with my next series which
> > should be soon.
> > 
> > > 
> > > Cc: Ian Kent <raven@themaw.net>
> > > Signed-off-by: Andrey Vagin <avagin@openvz.org>
> > > ---
> > >  fs/autofs4/waitq.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> > > index 0146d91..631f155 100644
> > > --- a/fs/autofs4/waitq.c
> > > +++ b/fs/autofs4/waitq.c
> > > @@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info
> > > *sbi,
> > >       set_fs(KERNEL_DS);
> > > 
> > >       mutex_lock(&sbi->pipe_mutex);
> > > -     wr = __vfs_write(file, data, bytes, &file->f_pos);
> > > -     while (bytes && wr) {
> > > +     while (bytes) {
> > > +             wr = __vfs_write(file, data, bytes, &file->f_pos);
> > > +             if (wr <= 0)
> > > +                     break;
> > >               data += wr;
> > >               bytes -= wr;
> > > -             wr = __vfs_write(file, data, bytes, &file->f_pos);
> > >       }
> > >       mutex_unlock(&sbi->pipe_mutex);
> > > 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
