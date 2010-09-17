From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/12] BKL: Remove BKL from autofs4
Date: Fri, 17 Sep 2010 09:17:29 +0200
Message-ID: <201009170917.29522.arnd@arndb.de>
References: <1284659185-8942-1-git-send-email-arnd@arndb.de> <201009161955.48854.arnd@arndb.de> <1284687191.3083.8.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284687191.3083.8.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, autofs@linux.kernel.org, Greg KH <greg@kroah.com>

On Friday 17 September 2010 03:33:11 Ian Kent wrote:
> On Thu, 2010-09-16 at 19:55 +0200, Arnd Bergmann wrote:
> > Ah, sorry about this. I looked at the wrong MAINTAINERS entry.
> > 
> > I also forgot to Cc you about autofs3, adding more to the confusion. ;)
> > 
> > Do you think the time has come to move autofs3 to drivers/staging
> > as we deprecate the BKL?
> 
> Umm ... what's this process, the drivers/staging?

We use drivers/staging now both for getting code into the kernel
and for getting it out of there. Moving autofs3 to drivers/staging/autofs/
would serve as a last warning to everyone using it, but users could
still use it while it's there. If anyone is interested, they can submit
fixes (BKL removal and whatever else is needed) to get it back into
the mainline. If it doesn't happen, Greg would finally remove it two
kernel releases later.

My hope is that we can move all modules that still use the BKL after
2.6.37 to drivers/staging, unless we have someone already working
on the patches.

	Arnd
