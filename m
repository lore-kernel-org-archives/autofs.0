From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Race condition in autofs 4.1.4
Date: Mon, 29 Jan 2007 15:33:14 +0100
Message-ID: <1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1169861439.3595.11.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

Am Samstag, den 27.01.2007, 10:30 +0900 schrieb Ian Kent:

> No and yes.
> 
> This issue has come up fairly often over the last 3-5 years.

> It may be worthwhile looking at
> http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configureable-locking.patch.

That patch contains a typo (we_created_lock_file vs.
we_created_lockfile), but otherwise seems to work. I'm running another
stress test currently with the modified mount(8), starting with about
30000 mails in the queue of which 5000 are delivered now and the race
hasn't happend yet (I set the timemout of autofs to 5 seconds to trigger
that bug faster).

> Ian

-- 
Lukas
