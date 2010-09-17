From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Remaining BKL users, what to do
Date: Fri, 17 Sep 2010 16:56:56 +0200
Message-ID: <201009171656.56615.arnd@arndb.de>
References: <201009161632.59210.arnd@arndb.de> <201009171550.49282.arnd@arndb.de> <20100917140219.GA9454@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100917140219.GA9454@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Christoph Hellwig <hch@infradead.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jan Kara <jack@suse.cz>, codalist@coda.cs.cmu.edu, autofs@linux.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Trond Myklebust <Trond.Myklebust@netapp.com>, Petr Vandrovec <vandrove@vc.cvut.cz>, Anders Larsen <al@alarsen.net>, Evgeniy Dushistov <dushistov@mail.ru>, Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>

On Friday 17 September 2010, Christoph Hellwig wrote:
> 
> Just add a per-sb mutex inside the filesystem.  Given that lock_super
> isn't used by the VFS anymore that's actually equivalent.

Ok, thanks for the hint. I'll fix that for isofs.

	Arnd
