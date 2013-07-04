From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v4 04/12] auto-fs: rename d_count field of dentry to d_refcount
Date: Thu, 04 Jul 2013 10:47:42 -0400
Message-ID: <51D58B0E.8090206@hp.com>
References: <1372908808-33304-1-git-send-email-Waiman.Long@hp.com> <CA+55aFzKfPG=CH+vZBUQMNd32qsuxPF1D3c3DB2Dm8w1QCb1+w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzKfPG=CH+vZBUQMNd32qsuxPF1D3c3DB2Dm8w1QCb1+w@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <andi@firstfloor.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>

On 07/03/2013 11:50 PM, Linus Torvalds wrote:
> On Wed, Jul 3, 2013 at 8:33 PM, Waiman Long<Waiman.Long@hp.com>  wrote:
>> Because of the d_count name change made in dcache.h, all references
>> to d_count have to be changed to d_refcount.  There is no change in
>> logic and everything should just work.
> These filesystem patches need to be just joined into the same patch
> that does the d_count ->  d_refcount change.
>
> Otherwise the kernel won't build in lots of configurations for some
> commits, which makes things like bisecting much more painful than it
> should be.
>
> So we can't do piece-meal changes that break the build for parts of the tree.
>
>                Linus

I could change patch 3 so that I keep the d_count name, but #define 
d_refcount to d_count. In that way, I can do piece-meal changes without 
breaking the build. Alternatively, I could collapse patches 3-11 into a 
single big patch which will be harder to review.

Regards,
Longman
