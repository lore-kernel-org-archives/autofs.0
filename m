From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 04/12] auto-fs: rename d_count field of dentry to d_refcount
Date: Thu, 4 Jul 2013 10:53:09 -0700
Message-ID: <CA+55aFwNS+QSngRg4SQ_1o3GsGKqVXENaTsD0jB_8HwBP+kSUg@mail.gmail.com>
References: <1372908808-33304-1-git-send-email-Waiman.Long@hp.com>
	<CA+55aFzKfPG=CH+vZBUQMNd32qsuxPF1D3c3DB2Dm8w1QCb1+w@mail.gmail.com>
	<51D58B0E.8090206@hp.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eA6WsL1ta2nkdxvUwQpcBOhbHl3gJAKFMkotCDGHTg4=;
        b=QEpth4i9961hba4hofV2jJSOTTEDmb6CoF7vQJuHSKwQj3MpsRf08PQkKxP7M3vOcy
         nGvMq96qjA8tliVTGKSwoj0LwzZE6MT2Q5dktXMNu0XguNYGZD0AAYGrCEceGhhdiKEr
         M788+Nx/v/YRrjjw4XTTJ3NPMLjhxs6ZT3Y+H05XFM0WCi5/zNhiGyGDAwYnLEniBvXE
         3tLrZ0sRNKzMJ5Uy584N+Nuz27p2Bck57Hpf2n7VO5gBhM+mGSvnL3XoGyCAVUGana1E
         thWwjoVww6B6wBDC4Je3MiauDYj0fRjxasEfEe96nHUzSroAXtHqpTYeCPuBL5zcjYzT
         d9cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eA6WsL1ta2nkdxvUwQpcBOhbHl3gJAKFMkotCDGHTg4=;
        b=ZSBhILXqsossCSLFW+yALjKyshH3wVSpqyHDJMHVed7xyHjWTwDj+xLFBPk/XCa8Eg
         8jjSdBZi3ZL3i1hijWis/KPuRJKE4QGM+sh1Rm0VQqnNN6FijvW0/7PxVLwHktV6Tfkj
         JtsoBR0ep98NBk+5ZxAuDqC4yZOKdDooYVJuo=
In-Reply-To: <51D58B0E.8090206@hp.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <waiman.long@hp.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <andi@firstfloor.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>

On Thu, Jul 4, 2013 at 7:47 AM, Waiman Long <waiman.long@hp.com> wrote:
>
> I could change patch 3 so that I keep the d_count name, but #define
> d_refcount to d_count. In that way, I can do piece-meal changes without
> breaking the build. Alternatively, I could collapse patches 3-11 into a
> single big patch which will be harder to review.

Since there are many fewer d_count users than there are d_lock users,
I think collapsing things is the right thing to do.

That said, I think Al is right that for all those filesystem uses, we
might actually be much better off with a helper function looking at
d_count, with no macros etc, since they are purely about reading the
count.

So maybe the right thing to do is to add a

   static inline int d_count(struct dentry *dentry) { return dentry->d_count; }

helper function *first*, and just say "filesystems should never access
d_count directly", and make the few filesystem users use this helper
function first. That way we can do that as independent commits to
prepare for the switch-over.

Then when the switch-over happens, we just change "d_count" in that
helper function, and it has no filesystem impact at all.

But fs/dcache.c and fs/namei.c that actually really know about and
modify d_count would not use that helper function. It would purely be
about isolating filesystems from these kinds of internal
implementation issues: fs/cache.c and fs/namei.c are all *about* those
internal issues, so they shouldn't be isolated..

           Linus
