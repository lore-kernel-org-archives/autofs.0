From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more for
	me
Date: Sat, 9 Apr 2005 17:55:50 +0200
Message-ID: <20050409155550.GA14426@uio.no>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
	<ify8bsndz6.fsf@mago.linux-lounge.it.fh-worms.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <ify8bsndz6.fsf@mago.linux-lounge.it.fh-worms.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Ruppert <ruppert@Fh-Worms.de>
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org, ruppert@mago.linux-lounge.it.fh-worms.de

On Sat, Apr 09, 2005 at 05:53:33PM +0200, Martin Ruppert wrote:
> /mnt/auto               /etc/auto.misc
> /mnt/net                /etc/auto.net
> #/var/autofs/misc       /etc/auto.misc
> #/var/autofs/net        /etc/auto.net
> 
> is there something wrong with that?

No, that should be fine. If you had used the default autofs from woody, it
would now have been empty, so I wondered if that was the source of your
problems. (It's not, AFAICS.)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
