From: Ian Kent <raven@themaw.net>
Subject: Re: 4.8-rc4 spews "BUG: sleeping function called from invalid
 context at fs/dcache.c:757"
Date: Tue, 30 Aug 2016 09:55:28 +0800
Message-ID: <1472522128.29532.5.camel@themaw.net>
References: <s5ha8fv4p8d.wl-tiwai@suse.de>
         <20160829151855.GH2356@ZenIV.linux.org.uk>
         <1472521031.29532.4.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=E4PzfLJjmYoIhop6+p1yPctswEE=; b=RDm8IK
        6X7zrQGDLjaakKf7TTh8k/APVGKp/UBO5ZbnNcYBS6oTmyyyrGEv3TJl7codWGP1
        GaIwvXwla4tRphWMPRQoi5vlKMSXtXc/GYwxrfTb6SKz7xWj2CULcltzkhYJUchW
        L6T5p6Cv9QZErh+HtSk5zl8Zgg2jrjotWiLwQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=E4PzfLJjmYoIhop
        6+p1yPctswEE=; b=D3a4vARgmOvKBSs3GHBEFprrdYWMwXnPN7v154clEQG8bSP
        IjjcHN0JBcG13puGNiYXxz2qzYYLK3JoBAC0GMmC+5iBHpcljLdj73FKUjPFIHQX
        VYcH345xgdSBiPRm/BXvUA2nXXZBmsCxKw4zsEiiXjuXG5JNJVPUtkyo+oQ0=
In-Reply-To: <1472521031.29532.4.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2016-08-30 at 09:37 +0800, Ian Kent wrote:
> On Mon, 2016-08-29 at 16:18 +0100, Al Viro wrote:
> > On Mon, Aug 29, 2016 at 04:35:46PM +0200, Takashi Iwai wrote:
> > 
> > >   [<ffffffff81260b26>] dput+0x46/0x400
> > 	... which should not be called in atomic contexts
> > >   [<ffffffff8124ff67>] follow_down_one+0x27/0x60
> > 	... and neither should this
> > >   [<ffffffff81344da2>] autofs4_mount_busy+0x32/0x110
> > 	... nor that (for fsck sake, there's full-blown path_put() in it!)
> > >   [<ffffffff81345081>] should_expire+0x51/0x3d0
> > 	... so that would better not be called in atomic either (incidentally,
> > it also calls dput() directly)
> > >   [<ffffffff81345790>] autofs4_expire_indirect+0x190/0x2d0
> > 	... while here it is called under sbi->fs_lock.
> > 
> > > I don't remember of a similar stack trace in the past, so if any, it
> > > can be a regression in 4.8 kernel.  But I cannot say it in 100%, as
> > > this looks spontaneous, nor I would be able to reproduce it at the
> > > next boot...
> > 
> > It's old; the race is narrow, but it's been there for quite a while, by
> > the look of it.
> 
> Right, I missed that when the rcu-walk concurrency changes went in, mmm ....

Umm ... no, the problem has been there much longer than that ...
