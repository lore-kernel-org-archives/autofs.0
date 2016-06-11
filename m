From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: Fix endless loop in autofs4_write
Date: Sat, 11 Jun 2016 09:49:13 +0800
Message-ID: <1465609753.3152.19.camel@themaw.net>
References: <1465578459-8624-1-git-send-email-ldufour@linux.vnet.ibm.com>
	 <1465607376.3152.15.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=jOe1qWYRxSMDy3Z+Bx70jz6W/+M=; b=P3IVer
	4PFBYg9+aHxdEe/FjlCdagdPURqGBfPyDHFkbsx6hh1575EKR1wYXbNpPYesDsuI
	upT13Lq08rDHJN0e/3RW1K3L+40KPJxQ5pwRPJ88yzUSCqqsuKdtSjPutB3Q8SgV
	G4M8SmZQ6K23CTjfbGXTHgDat5KonFc8RZTqM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=jOe1qWYRxSMDy3Z
	+Bx70jz6W/+M=; b=p3aMcjGVXMkKDB1HsIds+zxiNgpqVFvwl0NVxEyg0HLvnbq
	K0oYWNGoZy/coOa5K3KUoqlyxpys/ymWJozhbX1b2HfUlsOVaFgNAcpjuFc68ZWg
	alflWNQfufgURu17GdDYK+T4kqXmTq5CHsccqLljwaOheU0fmDlP5a2akZHQ=
In-Reply-To: <1465607376.3152.15.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sat, 2016-06-11 at 09:09 +0800, Ian Kent wrote:
> On Fri, 2016-06-10 at 19:07 +0200, Laurent Dufour wrote:
> > The 'commit e9a7c2f1a548 ("autofs4: coding style fixes")' removed the
> > check done on the __vfs_write()'s returned value in autofs4_write().
> > This may lead to a spinning process which can't catch any signal.
> 
> Yeah, sorry my bad.

Actually Andrei Vagin has already sent this patch to me some time ago and I'm
working to send it to Andrew Morton (along with several others).

There have been a couple of hold ups on this, sorry about that.

> 
> > 
> > Call stack showed in xmon could be :
> > [c0000003a76c7500] c00000000030df74 __vfs_write+0x134/0x1c0
> > (unreliable)
> > [c0000003a76c75a0] d0000000052a35d4 autofs4_notify_daemon+0x174/0x3f0
> > [autofs4]
> > [c0000003a76c7780] d0000000052a3fa0 autofs4_wait+0x750/0xa10 [autofs4]
> > [c0000003a76c78b0] d0000000052a24d8 autofs4_mount_wait+0x78/0x140
> > [autofs4]
> > [c0000003a76c7930] d0000000052a2f48 autofs4_d_automount+0x1d8/0x370
> > [autofs4]
> > [c0000003a76c79c0] c0000000003221e4 follow_managed+0x204/0x3a0
> > [c0000003a76c7a20] c000000000322c10 lookup_fast+0x220/0x420
> > [c0000003a76c7a90] c00000000032324c walk_component+0x5c/0x3e0
> > [c0000003a76c7b00] c000000000323794 link_path_walk+0x1c4/0x5f0
> > [c0000003a76c7b90] c000000000324b00 path_openat+0xf0/0x1620
> > [c0000003a76c7c90] c000000000327f6c do_filp_open+0xfc/0x170
> > [c0000003a76c7dc0] c00000000030d06c do_sys_open+0x1bc/0x2e0
> > [c0000003a76c7e30] c000000000009260 system_call+0x38/0x108
> > --- Exception: c01 (System Call) at 00003fffa38a0988
> > 
> > Cc: Ian Kent <raven@themaw.net>
> > Cc: autofs@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > Fixes: e9a7c2f1a548 ("autofs4: coding style fixes")
> > ---
> >  fs/autofs4/waitq.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> > index 0146d911f468..106d94139281 100644
> > --- a/fs/autofs4/waitq.c
> > +++ b/fs/autofs4/waitq.c
> > @@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info *sbi,
> >  	set_fs(KERNEL_DS);
> >  
> >  	mutex_lock(&sbi->pipe_mutex);
> > -	wr = __vfs_write(file, data, bytes, &file->f_pos);
> > -	while (bytes && wr) {
> 
> Right but why not just wr >= 0 here.
> 
> I guess this patch probably saves a few bytes.
> 
> I'll add it to the series.
>  
> > +	while (bytes) {
> > +		wr = __vfs_write(file, data, bytes, &file->f_pos);
> > +		if (wr < 0)
> > +			break;
> >  		data += wr;
> >  		bytes -= wr;
> > -		wr = __vfs_write(file, data, bytes, &file->f_pos);
> >  	}
> >  	mutex_unlock(&sbi->pipe_mutex);
> >  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
