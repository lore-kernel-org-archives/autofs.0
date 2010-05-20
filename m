From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/8] autofs: Pushdown the bkl from ioctl
Date: Thu, 20 May 2010 19:35:45 +0800
Message-ID: <1274355346.2264.17.camel@localhost>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
	 <1274289855-10001-3-git-send-regression-fweisbec@gmail.com>
	 <4BF4279C.2000805@zytor.com> <20100519180832.GA9752@nowhere>
	 <4BF42A5E.6060503@zytor.com> <20100519190307.GC9752@nowhere>
	 <4BF4445F.9040104@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=l+V3LDf68FtSSWfKNEcZV099rjE=; b=hsP5BN7XH9NWJkTkUiXUzTl+otDRDqG9I7sgPLmewgxlMAcxuANaIGdHB54cIcSxd1qVNLadF1Aoz5s2EsZYu72qg5g9+0qlYUE7XwXm+Nec3AXUp83nv1TTsOIB0AtIUCLr+7vAmMg1x3cE2aGO2Zvc44YO0lz1pM0R2mZImxA=
In-Reply-To: <4BF4445F.9040104@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Autofs <autofs@linux.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>

On Wed, 2010-05-19 at 13:04 -0700, H. Peter Anvin wrote:
> On 05/19/2010 12:03 PM, Frederic Weisbecker wrote:
> >>
> >> But it's not ... it is locked at that point.  It's not lock*ing*, but it
> >> is not *unlocked*, either.  Furthermore, it is directly contradicting
> >> the naming scheme of the ops structure.
> >>
> > 
> > Would you prefer me to resend a patch?
> > 
> 
> Yes, that would be my preference.
> 
> We really need to set a date to kill off autofs3 completely -- I don't
> care if we rename anything or not -- and add it to feature-removal.txt.

Yes, my bad.
I have to get onto that, sorry.

Ian
