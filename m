From: Ian Kent <raven@themaw.net>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a
 packetized pipe
Date: Mon, 30 Apr 2012 14:55:06 +0800
Message-ID: <1335768906.2281.16.camel@perseus.themaw.net>
References: <20120429205429.63CCD7C0064@ra.kernel.org>
	 <4F9DD994.70202@zytor.com> <4F9E30BF.4030704@msgid.tls.msk.ru>
	 <4F9E3474.2050405@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=R8i6sikiTEgjQ27aJ35uzfn5n/g=; b=GBFn5xwPbDQIQhD8U/yICPMDCgsm
	8YFkJojbhNitZENDC2F4ukT8qomuj4Ia0FgoM4Pw24Qlm4b2KapE7o8Ok3f+1Ysb
	Xrh13nA1GDjq6rHdJmbU/XDC6C6CZgk7tW2StOr5c3DDmj5EK/XmM1xgJHVysuJN
	d+pVvndg4L5+LnE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=R8i6sikiTEgjQ27aJ35uzfn5n/g=; b=SJC
	ibtExqw6ZHAi6nhfrbPUsBHrX7L3ftKwP2Z2wQR/CxRNjyX57k3V6AvzP+ggZ97X
	UgSPeeMp14BjQIyueDFiaHnLMWSr7Qwo/610GXwZtd0JFWCmD99eyYuvxN9AcxE3
	Z0gUZdj8tiQ0rNIqDu8xxNK0Y7Zhp3o8x0Y2USno=
In-Reply-To: <4F9E3474.2050405@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Mon, 2012-04-30 at 10:43 +0400, Michael Tokarev wrote:
> On 30.04.2012 10:27, Michael Tokarev wrote:
> >> On 04/29/2012 01:54 PM, Linux Kernel Mailing List wrote:
> >>>     However, a prettier solution exists now thanks to the packetized pipe
> >>>     mode.  By marking the communication pipe as being packetized (by simply
> >>>     setting the O_DIRECT flag), we can always just write the bigger packet
> >>>     size, and if user-space does a smaller read, it will just get that
> >>>     partial end result and the extra alignment padding will simply be thrown
> >>>     away.
> > 
> >> +static inline int autofs_prepare_pipe(struct file *pipe)
> >> +{
> >> +	if (!pipe->f_op || !pipe->f_op->write)
> >> +		return -EINVAL;
> >> +	if (!S_ISFIFO(pipe->f_dentry->d_inode->i_mode))
> >> +		return -EINVAL;
> >> +	/* We want a packet pipe */
> >> +	pipe->f_flags |= O_DIRECT;
> >> +	return 0;
> >> +}
> >> +
> > 
> > @@ -376,7 +376,7 @@ static int autofs_dev_ioctl_setpipefd(st
> >  			err = -EBADF;
> >  			goto out;
> >  		}
> > -		if (!pipe->f_op || !pipe->f_op->write) {
> > +		if (autofs_prepare_pipe(pipe) < 0) {
> >  			err = -EPIPE;
> >  			fput(pipe);
> >  			goto out;
> > 
> > I've one more concern.  I'm not sure but I think there's some
> > risk still.  This packetizing gets applied to all VERSIONS of
> > the autofs PROTOCOL.  Which means it will be applied to the
> > lowest supported version (3) TOO, but did that version read
> > whole packets too?
> 
> I think this is a false alarm.  I checked autofs v3 and v4
> userspace code (found on  http://www.kernel.org/pub/linux/daemons/autofs )
> and they both read whole packet at once, not piece-wise.
> 
> I didn't test if any of these actually work with any current
> kernel, however ;)

Yep, all the autofs releases use a sizeof() the relevant structure when
reading the kernel pipe, so that should be ok.

Ian

