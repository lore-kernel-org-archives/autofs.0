From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - fix comms packet struct size
Date: Mon, 20 Feb 2006 09:05:59 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0602200856300.2355@eagle.themaw.net>
References: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net>
 <20060219141517.GA7942@infradead.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060219141517.GA7942@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Sun, 19 Feb 2006, Christoph Hellwig wrote:

> On Sun, Feb 19, 2006 at 10:11:31PM +0800, Ian Kent wrote:
> > 
> > Set userspace communication struct fields to fixed size.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > 
> > --- linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h.fix-v5-packet-size	2006-02-17 19:15:49.000000000 +0800
> > +++ linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h	2006-02-17 19:12:09.000000000 +0800
> > @@ -65,10 +65,10 @@ struct autofs_v5_packet {
> >  	autofs_wqt_t wait_queue_token;
> 
> Hiding types in user visible structures behind typedefs is bad.
> What type is behind this?  If this is not an __u32 you have
> a padding issue.

This has been an occassion problem for a long time.
Since it dates back to way before version 4 I have always been reluctant 
to change it. I'd rather leave it as is unless you really can't accept it.

> 
> >  	__u32 dev;
> >  	__u64 ino;
> > -	uid_t uid;
> > -	gid_t gid;
> > -	pid_t pid;
> > -	pid_t tgid;
> > +	__u64 uid;
> > +	__u64 gid;
> > +	__u64 pid;
> > +	__u64 tgid;
> 
> These should be 32bit values.

OK. But will they be 32 bit for the life of this struct?

Once userspace programs are using this it can't ever change.

> 
> >  	int len;
> 
> this should become a fixed-size type aswell.

OK. That shouldn't cause a problem. I'll change that also.

> 
> >  	char name[NAME_MAX+1];
> >  };
> > --- linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h.fix-v5-packet-size	2006-02-17 19:17:03.000000000 +0800
> > +++ linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h	2006-02-17 19:17:25.000000000 +0800
> > @@ -79,10 +79,10 @@ struct autofs_wait_queue {
> >  	char *name;
> >  	u32 dev;
> >  	u64 ino;
> > -	uid_t uid;
> > -	gid_t gid;
> > -	pid_t pid;
> > -	pid_t tgid;
> > +	u64 uid;
> > +	u64 gid;
> > +	u64 pid;
> > +	u64 tgid;
> >  	/* This is for status reporting upon return */
> >  	int status;
> >  	atomic_t notified;
> 
> This is an in-kernel structure, isn't it?  No need to use u64 here.

Yes, I was thinking the same thing when I did it.
I'll fix that.

Thanks Christoph.

Ian

