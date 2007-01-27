From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Sat, 27 Jan 2007 11:18:25 +0900
Message-ID: <1169864306.3595.17.camel@raven.themaw.net>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Sat, 2007-01-27 at 10:30 +0900, Ian Kent wrote:
> On Fri, 2007-01-26 at 19:10 +0100, Lukas Kolbe wrote:
> > On Sa, 2007-01-27 at 02:12 +0900, Ian Kent wrote:
> > 
> > > > In syslog I get random messages like this:
> > > > Jan 26 16:39:29 demon automount[16757]: mount(generic): warning: /homes/musr657 is already mounted
> > > > Jan 26 16:39:42 demon automount[17062]: mount(generic): warning: /nfs4homes/musr946 is already mounted
> > > > for exactly the mountpoints that belong to root afterwards.
> > > 
> > > Your mtab locking is broken.
> > > Get a mount(8) that's not broken and then re-evaluate.
> > 
> > Thanks for the pointer. I found a discussion you were involved in in the
> > util-linux-ng mailinglist at the beginning of january, is that the
> > locking you talk about (see
> > http://www.mail-archive.com/util-linux-ng@vger.kernel.org/msg00005.html)?
> > 
> > I'll have a look at it on monday and see if I can patch our mount and if
> > it makes a difference!
> 
> No and yes.
> 
> This issue has come up fairly often over the last 3-5 years.
> 
> What I expect when posting a comment like this is that the relevant
> distribution maintainer speak up and justify that mount(8) in their
> distribution has been patched to fix this issue.
> 
> That of course doesn't mean that it isn't still broken but indicates
> that the right people are aware of the problem, have attempted to fix
> it, and will help out if needed.
> 
> All distributions should have something included to fix this by now but
> it seems that may not be the case.
> 
> It may be worthwhile looking at
> http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configureable-locking.patch.
> 

Having checked this to the extent that I can, as I'm not very familiar
with Debian, it looks like the above patch has been included in Debian
testing but mount(8) locking in util-linux is broken in spite of the
"warnings" given "every time" this comes up.

Ian
