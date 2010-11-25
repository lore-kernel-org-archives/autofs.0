From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Thu, 25 Nov 2010 14:17:51 +0100
Message-ID: <201011251417.52010.arnd@arndb.de>
References: <4CDFDC2B.6040205@redhat.com> <201011150954.34289.arnd@arndb.de> <1290052468.2465.7.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290052468.2465.7.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Avi Kivity <avi@redhat.com>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Thursday 18 November 2010, Ian Kent wrote:
> But the important thing to notice is that the new ioctl interface (in
> fs/autofs4/dev-ioctl.c) used the unlocked_ioctl method since it was
> merged in 2.6.28 and that calls back into the core ioctl code for its
> major functionality. So the core function of the ioctl interface has
> been used without the BKL for quite a while now and has been heavily
> exercised in subsequent testing since the new ioctl interface has been
> in place.
> 
> I can't see any reason for keeping the autofs4_ioctl_mutex.

Ok. Are you submitting a patch to remove it? Your reasoning absolutely
makes sense and we need to fix this regression.

	Arnd
