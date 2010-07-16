From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Fri, 16 Jul 2010 14:09:16 +0200
Message-ID: <20100716120915.GD5377@nowhere>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <AANLkTimVzSzCl2XfWBg5HauYtIT5znxkm6M0yo_1en2b@mail.gmail.com> <1279255230.2968.24.camel@localhost> <201007161305.31291.arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=dTAkxywnxWabtiEd0eOS6dT4R+ckLj/IAFo9LHu9jTM=;
        b=OE2vEZXeli6Z50lFWQ4Ou5TtpTtqFW5RbXZO0qv8S3vhm9vhEHJ9XA+Obi8dzgPvIA
         1Fs3GwyGBJvAft/SH4ZkfDOghpnWLzdXjy/G/T0HdY1j3OaBIRA5yVMJfmLqIKQMFc9F
         pvPmeDff9LAMnzJN/xW4LLVYPufp70BjLLUCY=
Content-Disposition: inline
In-Reply-To: <201007161305.31291.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Kent <raven@themaw.net>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, Jul 16, 2010 at 01:05:31PM +0200, Arnd Bergmann wrote:
> On Friday 16 July 2010, Ian Kent wrote:
> > On Fri, 2010-07-16 at 02:14 +0200, Frederic Weisbecker wrote:
> > > 2010/7/6 Ian Kent <raven@themaw.net>:
> > > In any case, can we let you handle this patch for 2.6.36 inclusion?
> > 
> > I think it makes more sense to keep these common patches together so
> > Arnd probably should keep it with his series.
> 
> I think that's fine. Takashi Iwai took the alsa patch, but the
> rest can probably be merged together.
> 
> Frederic, would you like to add the remaining ioctl removal series
> into your git tree and have Stephen pull that into linux-next?
> I believe he's still pulling your tree anyway, although it doesn't
> have much content at the moment.
> 
> 	Arnd


Sure, I'll do that next week.

Thanks.
