From: David Miller <davem@davemloft.net>
Subject: Re: Remaining BKL users, what to do
Date: Thu, 16 Sep 2010 13:08:09 -0700 (PDT)
Message-ID: <20100916.130809.176654647.davem@davemloft.net>
References: <201009161632.59210.arnd@arndb.de>
	<1284656277.2962.0.camel@sortiz-mobl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1284656277.2962.0.camel@sortiz-mobl>
Sender: netdev-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: samuel@sortiz.org
Cc: arnd@arndb.de, codalist@coda.cs.cmu.edu, autofs@linux.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@infradead.org, mikulas@artax.karlin.mff.cuni.cz, Trond.Myklebust@netapp.com, vandrove@vc.cvut.cz, al@alarsen.net, jack@suse.cz, dushistov@mail.ru, mingo@elte.hu, netdev@vger.kernel.org, acme@ghostprotocols.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, andrew.hendry@gmail.com

From: Samuel Ortiz <samuel@sortiz.org>
Date: Thu, 16 Sep 2010 18:57:56 +0200

> On Thu, 2010-09-16 at 16:32 +0200, Arnd Bergmann wrote:
>> net/appletalk:
>> net/ipx/af_ipx.c:
>> net/irda/af_irda.c:
>> 	Can probably be saved from retirement in drivers/staging if the
>> 	maintainers still care.
> I'll take care of the IrDA part.

Thanks a lot Sam.
