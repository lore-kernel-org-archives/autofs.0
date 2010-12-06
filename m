From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] autofs4 - remove ioctl mutex
Date: Mon, 6 Dec 2010 09:41:25 +0100
Message-ID: <201012060941.25977.arnd@arndb.de>
References: <20101206035123.28966.79954.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101206035123.28966.79954.stgit@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Monday 06 December 2010 04:51:23 Ian Kent wrote:
> With the recent changes to remove the BKL a mutex was added to the
> ioctl entry point for calls to the old ioctl interface. This mutex
> needs to be removed because of the need for the expire ioctl to call
> back to the daemon to perform a umount and receive a completion
> status (via another ioctl).
> 
> This should be fine as the new ioctl interface uses much of the same
> code and it has been used without a mutex for around a year without
> issue, as was the original intention.

Acked-by: Arnd Bergmann <arnd@arndb.de>
