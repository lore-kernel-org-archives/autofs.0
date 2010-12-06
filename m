From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - remove ioctl mutex
Date: Sun, 5 Dec 2010 19:55:17 -0800
Message-ID: <AANLkTinaxtTZzWymJfXv2=HBgya2MJ3m21myjMZQ_rxT@mail.gmail.com>
References: <20101206035123.28966.79954.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101206035123.28966.79954.stgit@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, autofs mailing list <autofs@linux.kernel.org>

On Sun, Dec 5, 2010 at 7:51 PM, Ian Kent <raven@themaw.net> wrote:
> With the recent changes to remove the BKL a mutex was added to the
> ioctl entry point for calls to the old ioctl interface. This mutex
> needs to be removed because of the need for the expire ioctl to call
> back to the daemon to perform a umount and receive a completion
> status (via another ioctl).
>
> This should be fine as the new ioctl interface uses much of the same
> code and it has been used without a mutex for around a year without
> issue, as was the original intention.

Sign-off?

                   Linus
