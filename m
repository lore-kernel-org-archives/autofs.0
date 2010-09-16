From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: Remaining BKL users, what to do
Date: Thu, 16 Sep 2010 20:32:36 +0200
Message-ID: <4C9262C4.9050006@fusionio.com>
References: <201009161632.59210.arnd@arndb.de> <1284648549.23787.26.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1284648549.23787.26.camel@gandalf.stny.rr.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>, "autofs@linux.kernel.org" <autofs@linux.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Trond Myklebust <Trond.Myklebust@netapp.com>, Petr Vandrovec <vandrove@vc.cvut.cz>, Anders Larsen <al@alarsen.net>, Jan Kara <jack@suse.cz>, Evgeniy Dushistov <dushistov@mail.ru>, Ingo Molnar <mingo@elte.hu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Samuel Ortiz <samuel@sortiz.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>

On 2010-09-16 16:49, Steven Rostedt wrote:
> On Thu, 2010-09-16 at 16:32 +0200, Arnd Bergmann wrote:
>> The big kernel lock is gone from almost all code in linux-next, this is
>> the status of what I think will happen to the remaining users:
> 
>> kernel/trace/blktrace.c:
>> 	Should be easy. Ingo? Steven?
>>
> 
> Jens,
> 
> Git blame shows this to be your code (copied from block/blktrace.c from
> years past).
> 
> Is the lock_kernel() needed here? (although Arnd did add it in 62c2a7d9)

It isn't, it can be removed.

-- 
Jens Axboe


Confidentiality Notice: This e-mail message, its contents and any attachments to it are confidential to the intended recipient, and may contain information that is privileged and/or exempt from disclosure under applicable law. If you are not the intended recipient, please immediately notify the sender and destroy the original e-mail message and any attachments (and any copies that may have been made) from your system or otherwise. Any unauthorized use, copying, disclosure or distribution of this information is strictly prohibited.
