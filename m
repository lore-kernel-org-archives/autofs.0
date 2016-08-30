From: Ian Kent <raven@themaw.net>
Subject: Re: 4.8-rc4 spews "BUG: sleeping function called from invalid
 context at fs/dcache.c:757"
Date: Tue, 30 Aug 2016 09:37:11 +0800
Message-ID: <1472521031.29532.4.camel@themaw.net>
References: <s5ha8fv4p8d.wl-tiwai@suse.de>
         <20160829151855.GH2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=hyomEgtTUj6aUL53wHun0abCb3U=; b=jhjtzU
        etfasqj5EYOO0bHUOplsrIGFRz/eD0GCpIbv24SjneDTFvpK1ad+6+OeOT9F4uyZ
        dZupBAKVSImY8xZI/P3RD+8CmG5LTz/m8qJrq21bip6HEG5MaRzNGl76euisFk+h
        T2bCKu6AdOMnfULYbIWw/Sn9jtehJyEiZ71pE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hyomEgtTUj6aUL5
        3wHun0abCb3U=; b=GdaOjOSWJ3CT97sy07nuAJ9Wv6pTcnUOkelvabyqiVCr2nz
        TX/Nw62dQY6YITQRw8IRZu7vIgsbePG2xGz8/lviZ55CSz7/U/H5X4OpVK4bolTW
        0NHP0NOaPM0nQ3QAAFs2r6OW3Bh/Jhaj3x58PEEEjFZ7Ijht7opnTAJh2RIY=
In-Reply-To: <20160829151855.GH2356@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2016-08-29 at 16:18 +0100, Al Viro wrote:
> On Mon, Aug 29, 2016 at 04:35:46PM +0200, Takashi Iwai wrote:
> 
> >   [<ffffffff81260b26>] dput+0x46/0x400
> 	... which should not be called in atomic contexts
> >   [<ffffffff8124ff67>] follow_down_one+0x27/0x60
> 	... and neither should this
> >   [<ffffffff81344da2>] autofs4_mount_busy+0x32/0x110
> 	... nor that (for fsck sake, there's full-blown path_put() in it!)
> >   [<ffffffff81345081>] should_expire+0x51/0x3d0
> 	... so that would better not be called in atomic either (incidentally,
> it also calls dput() directly)
> >   [<ffffffff81345790>] autofs4_expire_indirect+0x190/0x2d0
> 	... while here it is called under sbi->fs_lock.
> 
> > I don't remember of a similar stack trace in the past, so if any, it
> > can be a regression in 4.8 kernel.  But I cannot say it in 100%, as
> > this looks spontaneous, nor I would be able to reproduce it at the
> > next boot...
> 
> It's old; the race is narrow, but it's been there for quite a while, by
> the look of it.

Right, I missed that when the rcu-walk concurrency changes went in, mmm ....

