From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Remaining BKL users, what to do
Date: Mon, 20 Sep 2010 09:25:02 +0800
Message-ID: <1284945902.3095.4.camel@localhost>
References: <201009161632.59210.arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=M05GkC692pZStA3yuZ0tcokjVno=; b=SYiIoqkw1XgnzYrBMn8797DmdNmehJlAQ31jnbMMzVav5QmyMYeZCtV+JXR4dNK/USkQCN7ly+ssp1YpLfZhjPU7+3eMTXa6BBYOm7mBZRkwwDSwsm4M4o8uRL1JE9941xBo8SSDtW7m4h51ylHDH/2vTMBMELQ2iw4oO0QZqkM=
In-Reply-To: <201009161632.59210.arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: codalist@TELEMANN.coda.cs.cmu.edu, autofs@linux.kernel.org, Samuel Ortiz <samuel@sortiz.org>, Jan Kara <jack@suse.cz>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, netdev@vger.kernel.org, Anders Larsen <al@alarsen.net>, Trond Myklebust <Trond.Myklebust@netapp.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, linux-fsdevel@vger.kernel.org, Evgeniy Dushistov <dushistov@mail.ru>, Ingo Molnar <mingo@elte.hu>, Andrew Hendry <andrew.hendry@gmail.com>, linux-media@vger.kernel.org

On Thu, 2010-09-16 at 16:32 +0200, Arnd Bergmann wrote:
> The big kernel lock is gone from almost all code in linux-next, this is
> the status of what I think will happen to the remaining users:
> 

...

> fs/autofs:
> 	Pretty much dead, replaced by autofs4. I'd suggest moving this
> 	to drivers/staging in 2.6.37 and letting it die there.

Not sure that's what we need.
What actually needs to happen is that autofs4 needs to be renamed to
autofs.

Ian



