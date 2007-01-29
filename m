From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Tue, 30 Jan 2007 01:55:28 +0900
Message-ID: <1170089728.3404.18.camel@raven.themaw.net>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-01-29 at 16:19 +0100, Lukas Kolbe wrote:
> Am Montag, den 29.01.2007, 15:33 +0100 schrieb Lukas Kolbe:
> 
> > That patch contains a typo (we_created_lock_file vs.
> > we_created_lockfile), but otherwise seems to work. I'm running another
> > stress test currently with the modified mount(8), starting with about
> > 30000 mails in the queue of which 5000 are delivered now and the race
> > hasn't happend yet (I set the timemout of autofs to 5 seconds to trigger
> > that bug faster).
> 
> The system is now through more than 25000 mails, and hasn't hit the bug
> yet.
> When it finished delivering, I'll setup another mailbomb and stress it
> over the night, let's cross fingers that it works. I'll then file a bug
> with the debian util-linux package and attach the patch to it.
> Not close()ing the "we_created_lockfile" in unlock_mtab() seems like a
> bug to me, anyway ;)

Ya, but it gets closed at exit anyway.

Ian
