From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount and nsswitch.conf
Date: Tue, 13 Jul 2004 11:54:36 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16628.1468.732296.549859@segfault.boston.redhat.com>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
	<Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
	<16627.53979.532064.36562@segfault.boston.redhat.com>
	<40F3DD67.8000200@sun.com>
	<16627.62280.129793.903146@segfault.boston.redhat.com>
	<40F3FAA0.9010204@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40F3FAA0.9010204@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org, Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>, raven@themaw.net

==> Regarding Re: automount and nsswitch.conf; Mike Waychison <Michael.Waychison@Sun.COM> adds:

[snip]

>> Ok, my only beef here is that we are not at all honoring the semantics
>> of nsswitch.conf.  I attest that this is a design flaw, but given the
>> Sun automounter legacy, I see now ay around it.  We'll adhere to what is
>> done by all other automounters, even though it's wrong and poorly
>> documented.
>> 
>> So, can I make the assumption that Suns's automounter does not then
>> honor the "reaction on lookup result", ala [NOTFOUND=return]?  If so,
>> then
Michael.Waychison> our job
>> is a bit easier, though we are _still_ duplicating a parser, which I
>> despise.  (I'll do it, I just won't like it ;)
>> 

Michael.Waychison> I don't know if Sun's automounter does, I'd have to do a
Michael.Waychison> bit of testing, although I don't see why it wouldn't
Michael.Waychison> support status -> action predicates.

ugh.

[snip]

>> And we don't support the '+' notation, correct?  Should we?  Since
Michael.Waychison> we're in
>> the code, it may make sense.
>> 

Michael.Waychison> Last I looked, '+' was only supported in the master map,
Michael.Waychison> handled by a clause in the init script.  Ian K?

from the init script:
        cat /etc/auto.master | grep -v '^\+' | sed -e '/^#/d' -e '/^$/d'

Yup, it's "handled" all right!

[snip]


Michael.Waychison> I don't know where the Linuxisms came from originally,
Michael.Waychison> but they really do smell of lazyness to not implement
Michael.Waychison> nsswitch.conf logic.  All other Unix do the right thing
Michael.Waychison> in a not so incompatible way.
>> ziiing!  call us lazy, will ya.  ;)

Michael.Waychison> Nah. I just have a beef against the file: / program: /
Michael.Waychison> yp: / ldap: /
nisplus> / hesiod: prefixes.  They make the map language context
Michael.Waychison> dependent.  Consider these entries:

Michael.Waychison> mikew file:/some/path jeffm -fstype=autofs
Michael.Waychison> file:/some/path

Michael.Waychison> My homedir would be an nfs mount coming from server
Michael.Waychison> 'file', but yours would be an indirect mount defined by
Michael.Waychison> the map in flat file /some/path.  It just makes writing
Michael.Waychison> a *comprehensive* parser more difficult :\.  It's also
Michael.Waychison> completely incompatible with everything else out there,
Michael.Waychison> which is probably what prompted Ian M to write his patch
Michael.Waychison> in the first place.

heh.  That's a good example.  Unfortunately, we may have legacy issues at
this point.

[snip]

Michael.Waychison> I'm just really against putting this in libc ;).  With a
Michael.Waychison> single consumer and no defined interface to 'copy',
Michael.Waychison> what's the point?
>> What's the point?  The point is to leverage existing code.  As it
>> stands, my feeling on the matter is that an entry should never have been
>> added to nsswitch.conf.  It should have been in an automounter
>> configuration file, since the semantics are worse than completely
>> different, they're slightly different!

Michael.Waychison> I pondered this over coffee this morning, and thought to
Michael.Waychison> myself:

Michael.Waychison> "If we added this functionality to nss/, then we'd be
Michael.Waychison> abstracting out the nsswitch.conf parser.  This is a
Michael.Waychison> benefit because we don't have to worry about the
Michael.Waychison> status->action semantics and would allow us to change
Michael.Waychison> the nsswitch.conf interface"

I don't entirely understand your pre-coffee nss pontification.  Might I
suggest a few more sips?  ;)

If we add support to nss, then we define the interface and the semantics of
that interface.  We could have one function return the result of a map
lookup, and another a key lookup.  They key lookup would take two
arguments, one being the source, the other being the key.  For ghosting,
you'd need an iterative function to enumerate the keys.  Hmm, what would
the functions be?

struct automapent *getautomapent(const char *mapname);
/* provide null key for iteration */
struct automntent *getautomntent(struct automapent *, const char *key);
void endautomntent(struct automapent *);

Now, before I go any further, Ian K's point stands.  Putting the parser
logic entirely in libc would require a significant structural change to the
code base.  I'm not an advocate of that, certainly not before we get things
a bit more stable.

SUMMARY

The current Linux automounter does not properly handle nsswitch.conf.  It
is desirable to leverage the nss library within libc to implement this
functionality, though it is infeasible to do so in the near future.  Thus,
we need to implement our own nsswitch.conf parser within the automount
code.  I believe future implementations should move toward the libc
approach.

In either approach, we need to move parsing logic out of the init script.
We can do this by making the new parsing code into a sort of library which
can be accessed by a helper program that the init script can run.  It is
insane to try to write this code in two languages, especially when one of
them is shell.

The current parsing of auto.master is flawed, but can be fixed with the
approach described in the immediately preceeding paragraph.  We definitely
do not want to source _all_ potential auto.master maps.

[NOTE] Ian Kent has, "making the automounter a threaded app," on his todo
list.  I believe this is partly motivated by the need to move logic out of
the init script and into the c code.  Thus, you would start one automounter
process, and it would spawn threads for each mount.  As such, the helper
program approach may only be an interim solution.

We need to think about the impact of removing the maptype:mapname grammar
from the map file formats, per example provided by Mike W.  A phasing out
of this seems like a reasonable approach, perhaps starting out with simple
warning messages early on and good documentation on how to get the proper
semantics with the tools available.  Of course, this requires that we
implement the nsswitch.conf parsing logic, first.

Handling of the '+' inclusion directive should also be implemented.


Ok, have I missed anything?  Does anyone want to contend any of these
points?

-Jeff

p.s. what a can of worms...  did anyone see the lid lying around?  ;)
