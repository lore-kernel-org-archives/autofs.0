From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] autofs4 - fix comms packet struct size
Date: Mon, 20 Feb 2006 16:00:54 +0000
Message-ID: <20060220160054.GA31797@infradead.org>
References: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net> <20060219141517.GA7942@infradead.org> <Pine.LNX.4.64.0602200856300.2355@eagle.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602200856300.2355@eagle.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Mon, Feb 20, 2006 at 09:05:59AM +0800, Ian Kent wrote:
> > >  	autofs_wqt_t wait_queue_token;
> > 
> > Hiding types in user visible structures behind typedefs is bad.
> > What type is behind this?  If this is not an __u32 you have
> > a padding issue.
> 
> This has been an occassion problem for a long time.
> Since it dates back to way before version 4 I have always been reluctant 
> to change it. I'd rather leave it as is unless you really can't accept it.

So is this an __u32? ;-)

> OK. But will they be 32 bit for the life of this struct?

If we'd ever bump pid_t or uid_t to 64bits tons of kernel interface
would need to change.  And no one guarantees it'd be come an u64
then.  So __u32 is the safest choice.

