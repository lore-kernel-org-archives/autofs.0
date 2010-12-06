From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - remove ioctl mutex
Date: Mon, 06 Dec 2010 12:05:46 +0800
Message-ID: <1291608346.9376.7.camel@perseus>
References: <20101206035123.28966.79954.stgit@localhost6.localdomain6>
	 <AANLkTinaxtTZzWymJfXv2=HBgya2MJ3m21myjMZQ_rxT@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinaxtTZzWymJfXv2=HBgya2MJ3m21myjMZQ_rxT@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, autofs mailing list <autofs@linux.kernel.org>

On Sun, 2010-12-05 at 19:55 -0800, Linus Torvalds wrote:
> On Sun, Dec 5, 2010 at 7:51 PM, Ian Kent <raven@themaw.net> wrote:
> > With the recent changes to remove the BKL a mutex was added to the
> > ioctl entry point for calls to the old ioctl interface. This mutex
> > needs to be removed because of the need for the expire ioctl to call
> > back to the daemon to perform a umount and receive a completion
> > status (via another ioctl).
> >
> > This should be fine as the new ioctl interface uses much of the same
> > code and it has been used without a mutex for around a year without
> > issue, as was the original intention.
> 
> Sign-off?

Oops, sorry.
Would you like me to re-send after asking those concerned if I can add
their sign-off, and adding mine of course?

Ian

