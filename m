From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix wait name hash calculation in autofs_wait()
Date: Fri, 15 Oct 2021 08:08:22 +0800
Message-ID: <2449a6ad3ea38087d546279ac5a483e5c718a2b3.camel@themaw.net>
References: <163238121836.315941.18066358755443618960.stgit@mickey.themaw.net>
         <CAFxkdAraAe37_5bGLJtTtxZCaKTqgVPh4hTbcVC=08vRt-Zizg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        uQ2ph/m96pNwPz5SmsbAnB4GNfg56La5NKbKXh/rpLA=; b=XMPa/VHCYlUnmsVj
        5GsmfVZY2n/EPEunz6OzUle7J42fCHuZ975jpZN1JU0odZQs2SQoGXPXdiVJkmVV
        7wsG4p2xFeSO5+6ghcJVJl2WqS9tZB8Q2kjPByH4B59SntDJ4tyA8/NLsBshtKy3
        E/a9jbOs9lfOjNN/+i5kDwwcz4p+VRigwW5Muan/5VqDOkZC9goBFSjFn/gDzxri
        aPNTjVymH/pg6rl0ykcW7l8ZxL7p49mW88WTiqB5UQjxNmd0R46KLtcI3G6x+O1e
        oudSpxGvoW/Y2Xy68UlVr26HAJj0ZklGoEATkdo3BFjBZlmlilPrRM4M2voIQUBG
        2/vPdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=uQ2ph/m96pNwPz5SmsbAnB4GNfg56La5NKbKXh/rp
        LA=; b=n63/Cle+6WI0/ny4JTBshPoGk9cgWLf430Nyt0fE5BrIAPn75aubkKjcZ
        uqAVbIGi0EhtrlqXyofKtCWRaw01OAf5lLcw2V3ANf0EXRMF9B4iA3xWmeujwqXq
        px2/IKPZKZS+wWJfvZwcSWhTPizoW1NUx4QqzhAI9/alA1LEYCtgsWb7ciCn2VWV
        /MB5tY5fRqxcJ/qFzzM8IffogK9a0f92JMUg7mCEUiHfK9YwZL1nGm0faVy6aTTG
        jUZMyy/e1pXITMKhzqakoIglpaeyC54VKKjIcJA6MuqcpzJ5lVMhrxJGVhuO8XGH
        8fG1iMSwebiV9oZnXAV6d+f9Gd21w==
In-Reply-To: <CAFxkdAraAe37_5bGLJtTtxZCaKTqgVPh4hTbcVC=08vRt-Zizg@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Justin Forbes <jmforbes@linuxtx.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Thu, 2021-10-14 at 10:11 -0500, Justin Forbes wrote:
> On Thu, Sep 23, 2021 at 2:20 AM Ian Kent <raven@themaw.net> wrote:
> > 
> > There's a mistake in commit 2be7828c9fefc ("get rid of
> > autofs_getpath()")
> > that affects kernels from v5.13.0, basically missed because of me
> > not
> > fully testing the change for Al.
> > 
> > The problem is that the hash calculation for the wait name qstr
> > hasn't
> > been updated to account for the change to use dentry_path_raw().
> > This
> > prevents the correct matching an existing wait resulting in
> > multiple
> > notifications being sent to the daemon for the same mount which
> > must
> > not occur.
> > 
> > The problem wasn't discovered earlier because it only occurs when
> > multiple processes trigger a request for the same mount
> > concurrently
> > so it only shows up in more aggressive testing.
> 
> I suppose it shows up in more than just testing, as we have a bug
> where this is impacting a user doing regular desktop things.

Yes, but what the patch description is talking about is my not
discovering the problem when I tested the original change.

I have a similar Fedora bug too but that came in some time after
I discovered the problem when testing a new autofs release.

All it takes is multiple processes concurrently triggering an
autofs automount point. Because the qstr hash doesn't match
duplicate mount requests are sent to the daemon which is a
problem.

> 
> Justin
> 
> > Fixes: 2be7828c9fefc ("get rid of autofs_getpath()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/autofs/waitq.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> > index 16b5fca0626e..54c1f8b8b075 100644
> > --- a/fs/autofs/waitq.c
> > +++ b/fs/autofs/waitq.c
> > @@ -358,7 +358,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
> >                 qstr.len = strlen(p);
> >                 offset = p - name;
> >         }
> > -       qstr.hash = full_name_hash(dentry, name, qstr.len);
> > +       qstr.hash = full_name_hash(dentry, qstr.name, qstr.len);
> > 
> >         if (mutex_lock_interruptible(&sbi->wq_mutex)) {
> >                 kfree(name);
> > 
> > 


