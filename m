From: raven@themaw.net
Subject: Re: automount and nsswitch.conf
Date: Thu, 15 Jul 2004 22:50:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407152239190.1393@donald.themaw.net>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
	<Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
	<40F3DD67.8000200@sun.com><40F3FAA0.9010204@sun.com>
	<16628.1468.732296.549859@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0407142207350.1633@donald.themaw.net>
	<16629.20270.25570.71771@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16629.20270.25570.71771@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>, Mike Waychison <Michael.Waychison@Sun.COM>

On Wed, 14 Jul 2004, Jeff Moyer wrote:

> ==> Regarding Re: automount and nsswitch.conf; raven@themaw.net adds:
> 
> raven> On Tue, 13 Jul 2004, Jeff Moyer wrote:
> >> [snip]
> >> 
> Michael.Waychison> I'm just really against putting this in libc ;).  With a
> Michael.Waychison> single consumer and no defined interface to 'copy',
> Michael.Waychison> what's the point?
> >> >> What's the point?  The point is to leverage existing code.  As it >>
> >> stands, my feeling on the matter is that an entry should never have been
> >> >> added to nsswitch.conf.  It should have been in an automounter >>
> >> configuration file, since the semantics are worse than completely >>
> >> different, they're slightly different!
> >> 
> Michael.Waychison> I pondered this over coffee this morning, and thought to
> Michael.Waychison> myself:
> >>
> Michael.Waychison> "If we added this functionality to nss/, then we'd be
> Michael.Waychison> abstracting out the nsswitch.conf parser.  This is a
> Michael.Waychison> benefit because we don't have to worry about the
> Michael.Waychison> status->action semantics and would allow us to change
> Michael.Waychison> the nsswitch.conf interface"
> >> I don't entirely understand your pre-coffee nss pontification.  Might I
> >> suggest a few more sips?  ;)
> >> 
> >> If we add support to nss, then we define the interface and the semantics
> >> of that interface.  We could have one function return the result of a
> >> map lookup, and another a key lookup.  They key lookup would take two
> >> arguments, one being the source, the other being the key.  For ghosting,
> >> you'd need an iterative function to enumerate the keys.  Hmm, what would
> >> the functions be?
> >> 
> >> struct automapent *getautomapent(const char *mapname); /* provide null
> >> key for iteration */ struct automntent *getautomntent(struct automapent
> >> *, const char *key); void endautomntent(struct automapent *);
> >> 
> >> Now, before I go any further, Ian K's point stands.  Putting the parser
> >> logic entirely in libc would require a significant structural change to
> >> the code base.  I'm not an advocate of that, certainly not before we get
> >> things a bit more stable.
> 
> raven> I think there is a long way to go to merge this function into
> raven> libc/nss.
> 
> raven> We need to merge this into autofs now.
> 
> Sure.  I'm not keen on requiring a new libc to upgrade autofs, and I
> believe this is the sentiment I conveyed.
> 
> >> SUMMARY
> >> 
> >> The current Linux automounter does not properly handle nsswitch.conf.
> >> It is desirable to leverage the nss library within libc to implement
> >> this functionality, though it is infeasible to do so in the near future.
> >> Thus, we need to implement our own nsswitch.conf parser within the
> >> automount code.  I believe future implementations should move toward the
> >> libc approach.
> 
> raven> To early to really discuss whether it would actually be benifical to
> raven> leverage the libc code. Developing with a eye to this end should
> raven> show us what oppertunities or shortcommings exist with this
> raven> approach.
> 
> I'm not so sure.  Writing parsers is prone to errors.  The parser within
> glibc gets quite a bit of testing.  Now, re-writing all of the parse/lookup
> modules using internal libc functions, that sounds like a pain.
> 
> >> In either approach, we need to move parsing logic out of the init
> >> script.  We can do this by making the new parsing code into a sort of
> >> library which can be accessed by a helper program that the init script
> >> can run.  It is insane to try to write this code in two languages,
> >> especially when one of them is shell.
> 
> raven> My thoughts were a seperate module but maybe not a seperate
> raven> utility. I haven't done any experimentation with this specifically
> raven> yet.
> 
> Not a separate utility.  My point was that the code should be modular
> enough that it can be linked into a utility used by the init script.  That
> doesn't mean it should be a shared object or anything, just a separate .o
> that a simple main.c can link in.

My bad description. Seems we are saying the same thing.

> 
> raven> One thing to keep in mind is that we already have a fair bit of
> raven> useful code in the lookup modules to talk to different map
> raven> sources. Perhaps the lookup module interface should be extended to
> raven> read master maps a well as entries. This is consistent with the
> raven> current design. Comments?
> 
> Well, we sort of do this already for fstype=autofs, right?  I'd have to
> think more about specifics for auto.master, but I imagine that wouldn't
> come into play until we have a single automounter binary for all mount
> points.[1]

Not sure I understand.

This is essentially just another fs type.

> 
> 
> -Jeff
> 
> 
> [1]  BTW, for a separate discussion, I'm not convinced you need to go
> to a threaded design.  There's no reason a single process can't manage
> multiple mount points.

Yes. I've thought about it some but have no definite preference either 
way. One process to manage all would achieve the same goal.

My plan for the direct mount rework will use one process for the entire 
map. I think the best way to do it is similar to the method Mike will be 
using but with the existing infrastructure. If all goes as expected it 
should be a natural progression to indirect mounts. If the master map 
processing can be included as well that would be great.

Ian
