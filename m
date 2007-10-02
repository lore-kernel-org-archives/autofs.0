From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Tue, 02 Oct 2007 16:40:17 +0200
Message-ID: <1191336017.19265.28.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191332917.26331.171.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Am Dienstag, den 02.10.2007, 21:48 +0800 schrieb Ian Kent:
> On Tue, 2007-10-02 at 12:30 +0200, Lukas Kolbe wrote:
> > Hi Ian!
> > 
> > > Can you post a debug log of this failure please.
> > > Instructions to get what we need can be found at
> > > http://people.redhat.com/jmoyer.
> > 
> > Here's the daemon.log (sorry for it being so big):
> > 
> > You see in 12:16:42 that it tries to mount the
> > not-yet-existant /vol/eclipse-3.1/bin to /vol/eclipse/bin. The patch
> > from august last year doesnt apply anymore :(
> 
> Yep, it's already been applied in what you're using here.

Ah, okay, that would explain it :)

> snip ...

> The mount command looks fine to me but mount(8) is failing.
> I'm not sure what's in the kernel your running, checking that would
> probably be a good idea, where can I find the source for it?

That specific mount comes from the ubuntu archives; 2.12r-17ubuntu2 in 
http://archive.ubuntu.com/ubuntu/pool/main/u/util-linux/

> The other thing is that it looks like the bind mount isn't triggering
> the dependent mount which implies that the "--disable-mount-locking"
> isn't being used with configure.
> 
> I've just looked at the Debian 5.0.2-2 package which I had lying around
> and I see that it doesn't use this configure option. This can't work at
> all if that configure option isn't given.

Ok, thanks, I'll try that. The current source for it is in 
http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-4.diff.gz
http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2.orig.tar.gz

> The other thing is that the Debian build uses both
> --enable-force-shutdown and --enable-ignore-busy which I don't
> recommend. One or the other should really be used and I recommend
> --enable-ignore-busy as the better choice.

Okaydokay, I'll update the packages and try again. Thanks alot!

> Ian

-- 
Lukas
