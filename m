From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Tue, 6 Jul 2010 21:17:16 +0800
Message-ID: <202899B0-BADE-4CD0-B0E4-1A2FC99397D6@themaw.net>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <20100705195837.GF5240@nowhere> <1278378690.3070.6.camel@localhost> <201007061335.00264.arnd@arndb.de>
Mime-Version: 1.0 (iPad Mail 7B367)
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=references:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:cc; s=smtpout; bh=2QWn8IQxWE4NgqYyijGDC0hVeRg=; b=R59qT+RAVj847g5NkiXxYv92VaJcwUDcxLU8b2GR4qsoyA0m2X/llg46PrGQcNudEnFKtgvUaVeGKqA8VriUeNh+SGB0eV7DVysGXJe4r/Zo2SnN+xXui3Wbtz88f5BGOSMtKcNSAvK/0znTEu2P4wLgfK0GHOuTuRn+ibB1Ans=
In-Reply-To: <201007061335.00264.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "autofs@linux.kernel.org" <autofs@linux.kernel.org>



On 06/07/2010, at 7:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> 
> Well, the only use of the BKL in autofs4 is in the ioctl function. You
> can probably replace that trivially with a global mutex, but from a quick
> inspection, even that should not be needed: The only ioctl command in
> autofs4 that does not already seem to have adequate locking is
> autofs4_get_set_timeout, which is even easier to change and still harmless
> if you don't do it at all.

That's right of course.

Even this shouldn't be a problem as it is called by a single instance, per autofs mount, of the daemon only. A fair amount of effort has gone into trying to make the autofs4 module independent of the BKL over time. However I would still rather not do the change concurrently with the ioctl changes.

Ian
> 
