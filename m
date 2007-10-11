From: Ian Kent <raven@themaw.net>
Subject: Re: Success! (was: Re:  nested automounts: bind and nfs)
Date: Thu, 11 Oct 2007 22:36:39 +0800
Message-ID: <1192113399.17161.40.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
	<1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192034852.3151.21.camel@raven.themaw.net>
	<1192035764.20253.5.camel@localhost>
	<1192092341.3114.38.camel@raven.themaw.net>
	<1192099764.18125.3.camel@localhost>
	<1192102986.17161.18.camel@raven.themaw.net>
	<1192110232.27076.57.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192110232.27076.57.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

On Thu, 2007-10-11 at 15:43 +0200, Lukas Kolbe wrote:
> Hi Ian!
> Hi Mathias! Please see below why I think this might be important for you
> as well.
>  
> > > I *think* I understand what you describe there. If I were more
> > > knowledgeable about the internals of Linux and autofs I could be of more
> > > help :(
> > 
> > No matter, the point was only that this unexpected case needed to be
> > caught so I could send a mount request to the daemon. The VFS is quite a
> > complicated beast and I'm certainly no expert but have become familiar
> > with much of it, to some small extent, through working on autofs.
> 
> Must have bean painful ;)

Hahahah! but fun in itself. ;)

> 
>  
> > > Looks fairly simple - shall I test it even with your warning in the
> > > other mail?
> > 
> > Think so.
> 
> It didn't apply cleanly to 2.6.20 so I changed it manually. I just
> tested with only rebuilding the autofs4.ko-module and my kernel now
> thinks it's tainted (wtf...), BUT it works! I can't believe it! A
> one-liner, or, actually, a one-bitter ;)!

Odd, but no big problem.

> 
> I'm currently rebuilding the whole kernel so that I have a new .deb that
> I can roll out and test in a broader environment, but the exact use case
> of a recursive automount now seems to work perfectly well.
> Congratulations and thank you!

Keep an eye on expiration as well, make sure everything continues to
expire correctly, often times autofs will continue to work ok even when
it isn't quite expiring properly.

> 
> After testing, I'll push this forward to Ubuntu, but I don't have high
> hopes of it to be included in any update. It should definitly go into
> 2.6.24, I'll report back if it breaks anything else.

Ok, great, I'll keep testing myself and post it on LKML provided we
don't have any further problems.

> 
> If I understand this correctly, would this be the fix needed for the
> 'nested mounts with loop'-problem Mathias Koenig sees, as the problem
> seems to be quite a similar one as ours ...

Similar but not the same.

That particular issue takes a different path through the daemon and the
patch Mathias posted does fix the problem. I'll be committing something
very similar to the autofs repo and putting the patch on kernel.org
soonish.

Ian
