From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/12] BKL: Remove BKL from autofs4
Date: Fri, 17 Sep 2010 09:31:19 +0800
Message-ID: <1284687079.3083.7.camel@localhost>
References: <1284659185-8942-1-git-send-email-arnd@arndb.de>
	 <1284659185-8942-5-git-send-email-arnd@arndb.de>
	 <4C9258C1.3060906@zytor.com> <201009161955.48854.arnd@arndb.de>
	 <4C926DFC.1090600@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=7EJ9IxycKAhPABoDwnl+Ov9djnY=; b=ZrawSwEebWYuDxGRzXC4WeI1rtkBqnbooQiftETG3XAjgXVcIJm1iG+9jaUrZsyYbw9b7l2hcyiIHlBdTo/u5Tzpqb0KkWkKwEcOXDhW+ddJ/jPwIV9AqjDwu7RP9zY08QALOb7oLjmaOY3SoDnJGemInqY4KRYq3oacfocBjyk=
In-Reply-To: <4C926DFC.1090600@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, autofs@linux.kernel.org

On Thu, 2010-09-16 at 12:20 -0700, H. Peter Anvin wrote:
> On 09/16/2010 10:55 AM, Arnd Bergmann wrote:
> > On Thursday 16 September 2010 19:49:53 H. Peter Anvin wrote:
> >> On 09/16/2010 10:46 AM, Arnd Bergmann wrote:
> >>> autofs4 uses the BKL only to guard its ioctl operations.
> >>> This can be trivially converted to use a mutex, as we have
> >>> done with most device drivers before.
> >>>
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>> ---
> >>>  fs/autofs4/root.c |   12 +++++++-----
> >>>  1 files changed, 7 insertions(+), 5 deletions(-)
> >>
> >> You may want to Cc: the maintainer, Ian Kent.
> > 
> > Ah, sorry about this. I looked at the wrong MAINTAINERS entry.
> > 
> > I also forgot to Cc you about autofs3, adding more to the confusion. ;)
> > 
> > Do you think the time has come to move autofs3 to drivers/staging
> > as we deprecate the BKL?
> > 
> 
> I'm leaving that up to Ian.  I have offered for years to just plain kill
> off autofs3.

Yeah, my bad, again.
Now I want to wait for David Howells VFS automount series, which we're
working on now, since that will be a significant change.

> 
> 	-hpa

