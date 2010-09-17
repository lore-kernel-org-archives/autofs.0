From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/12] BKL: Remove BKL from autofs4
Date: Fri, 17 Sep 2010 09:33:11 +0800
Message-ID: <1284687191.3083.8.camel@localhost>
References: <1284659185-8942-1-git-send-email-arnd@arndb.de>
	 <1284659185-8942-5-git-send-email-arnd@arndb.de>
	 <4C9258C1.3060906@zytor.com>  <201009161955.48854.arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=qKgYZYqt49fq4BdQSRw3cy2BkM8=; b=i+IgJZO7cWdFlecL4AaLIvQT0TvuP8YyMVszfEMBk6N9zZouW+1J7BK12oPolZpWzsvXmQknYhChJh0bWC/UU3p/vAdl5vKK6BT4f9zHuUy1YKr4evCtHbivmsFZA/NTZjgO2bO7YJJdi0z25bv53/Tk+HfFbMsg6EVHPO2eS/w=
In-Reply-To: <201009161955.48854.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, autofs@linux.kernel.org

On Thu, 2010-09-16 at 19:55 +0200, Arnd Bergmann wrote:
> On Thursday 16 September 2010 19:49:53 H. Peter Anvin wrote:
> > On 09/16/2010 10:46 AM, Arnd Bergmann wrote:
> > > autofs4 uses the BKL only to guard its ioctl operations.
> > > This can be trivially converted to use a mutex, as we have
> > > done with most device drivers before.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > ---
> > >  fs/autofs4/root.c |   12 +++++++-----
> > >  1 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > You may want to Cc: the maintainer, Ian Kent.
> 
> Ah, sorry about this. I looked at the wrong MAINTAINERS entry.
> 
> I also forgot to Cc you about autofs3, adding more to the confusion. ;)
> 
> Do you think the time has come to move autofs3 to drivers/staging
> as we deprecate the BKL?

Umm ... what's this process, the drivers/staging?

> 
> 	Arnd

