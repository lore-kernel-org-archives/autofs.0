From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Date: Wed, 30 Jan 2019 13:20:20 +0800
Message-ID: <ee605bb8f5abfa7778211f9f4e9b22934f5870a4.camel@themaw.net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
         <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
         <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        ASSUAlGLWVfPvTu/6Z9HIj9oRBODvHzzY4xOjv2wILg=; b=A1z/aYvnMQ9BDaJY
        l3FlrRo3gpS7J3zkDE9zktvvYiPfggFkvX4LfxEZXSSIXBYZcKUaRe0bHWePasTN
        sZAhHFbbT7IkpsovaM7Gj4BA8hqmbUpAg8DtXGguw/AsRcAEwmt4BrJZ77pW2XTA
        dILB+3HS6CwIaCobi6b4v4dq1JUqeTPc2zhsnPn4atJEmVxk+GDT6CZ+t8iK8gUs
        fvN5FeBUbpN35WmsYbirFy/jD3o7vv8/yP3K+e1IMKz8PY8fwLwy1aRiPzELwEFh
        FyyWyLf+QNgAyP6NbvFkws9rOvSEiUadyXuigJcQPjcvgImYUt8bvsSHxWN55kDT
        QEXXSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ASSUAlGLWVfPvTu/6Z9HIj9oRBODvHzzY4xOjv2wI
        Lg=; b=hLXEBPUbbSbd8HysRH8R6e0OeGHHE6SDOkmIK0KffR6hPOSQect2YO4on
        2UMmT0C3yyAwhLnZZwAEL1fb2qjf2i1ygQiQoIk49uZnsCNYisI0TO+XPIIWf8Yt
        xGLYl6Mk3kUNK5SPn8vXc7SB+wiGEMnv3djH1yhQ9t04lBOE7eqbxshJjpBdkcjh
        jipx0bJt6v/U2JAymViJuiZUtm0+/Uj7++AMPKEU8mHA+gxYP0h7AZ/99ermg+Ee
        Cw4X4asl78wlK022nSRNAUBK9HQ/H6G2aoLRzGtl7aK3FPwrzZf46tLUW6q59GCl
        UkNDOrPiyFvBFqexZ2uRqE5ZWw3/w==
In-Reply-To: <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

On Tue, 2019-01-29 at 20:58 -0800, Andrew Morton wrote:
> On Wed, 30 Jan 2019 10:07:15 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> > > On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> > > 
> > > > Add an autofs file system mount option that can be used to provide
> > > > a generic indicator to applications that the mount entry should be
> > > > ignored when displaying mount information.
> > > 
> > > What is the reason for adding this feature?
> > 
> > In other OSes that provide autofs and that provide a mount list
> > to user space based on the kernel mount list a no-op mount option
> > ("ignore" is the one use on the most common OS) is allowed so that
> > autofs file system users can optionally use it.
> > 
> > The idea is that it be used by user space programs to exclude
> > autofs mounts from consideration when reading the mounts list.
> > 
> > Prior to the change to link /etc/mtab to /proc/self/mounts all
> > I needed to do to achieve this was to use mount(2) and not update
> > the mtab but now that no longer works.
> > 
> > I know the symlinking happened a long time ago and I considered
> > doing this then but, at the time I couldn't remember the commonly
> > used option name and thought persuading the various utility
> > maintainers would be too hard.
> > 
> > But now I have a RHEL request to do this for compatibility for a
> > widely used product so I want to go ahead with it and try and
> > enlist the help of some utility package maintainers.
> > 
> > Clearly, without the option nothing can be done so it's at least
> > a start.
> 
> OK.  I guess I can just paste the above into the changelog.

I thought this description would be too long but, by all means,
replace or add it to the changelog.

Or, if you prefer, I could try and come up with something more
succinct, the above explanation probably goes into more detail
than is really needed to get the message across.

> 
> Also, Documentation/filesystems/autofs*.txt are owed an update?

Yes, I think so, I'll have a look at it and get onto it, thanks
for the reminder.

Ian

