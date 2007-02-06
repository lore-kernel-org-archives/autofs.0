From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Tue, 06 Feb 2007 11:04:42 +0900
Message-ID: <1170727482.3378.30.camel@raven.themaw.net>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170084830.2817.19.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170084830.2817.19.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

On Mon, 2007-01-29 at 16:33 +0100, Lukas Kolbe wrote:
> Am Montag, den 29.01.2007, 16:19 +0100 schrieb Lukas Kolbe:
> 
> > The system is now through more than 25000 mails, and hasn't hit the bug
> > yet.
> > When it finished delivering, I'll setup another mailbomb and stress it
> > over the night, let's cross fingers that it works. I'll then file a bug
> > with the debian util-linux package and attach the patch to it.
> > Not close()ing the "we_created_lockfile" in unlock_mtab() seems like a
> > bug to me, anyway ;)
> 
> Okay, the race hit again. Damnit!
> 
> Out of about 30000 mails, 8(!!!) didn't get delivered because:

Life is so hard, isn't it.

I've just remembered that there are a number of patches for 4.1.4
(mostly from Jeff Moyer) that I need to review and merge but I haven't
got to it get.

One of them changes autofs to use /proc/mounts instead of /etc/mtab
which may be more appealing than using the symlink approach.

We could try this patch but I don't have a Debian install to check if
the patch applies to it. It would be out of order as well so may be a
bit of work to merge. I'm also not sure what patches are included in the
Debian package. I could just make it apply to 4.1.4 on top of the
patches on kernel.org and see how it goes for you.

What do you think?

Another thing, would you be interested in running your test with rc3 of
autofs version 5 (add all the patches in the distribution directory)?
The main reason I'd like to try this out is that it still
uses /etc/mtab, mainly because of possible performance impact
using /proc/mounts with large direct mount maps. So, if you have the
same problem with it then I really need to find a way to
use /proc/mounts in v5.

Ian
