From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: automount and nsswitch.conf
Date: Tue, 13 Jul 2004 11:07:12 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40F3FAA0.9010204@sun.com>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
 <Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
 <16627.53979.532064.36562@segfault.boston.redhat.com>
 <40F3DD67.8000200@sun.com>
 <16627.62280.129793.903146@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <16627.62280.129793.903146@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Moyer wrote:
>>==> Regarding Re: automount and nsswitch.conf; Michael Waychison adds:
>
> [snip]
>
>
>>>>>What I would like to see (and what I have quasi-implemented with some
>>>>>kludgey patches) is Linux behavior that matches (or at least is
>>>>>capable of matching) the Solaris behavior.  This has obvious benefits
>>>>>in heterogeneous environments.
>>>
> raven> This is the patch I have, yes?
>
> raven> And you would be wanting me to merge it for 4.1.4 or produce a
> raven> supported patch for 4.1.3, yes?
>
> raven> Have you done any additional work on it?
>
>>>The patch Ian M. came up with hard codes the lookup order to "files
>>>nis".  I've been trying to do additional work on it, but that requires
>>>getting a few things straight in my head, and then writing gobs of code,
>>>and then upgrading glibc, etc, etc.
>>>
>>>I think we can go with what Ian proposed for now, as it definitely
>>>solved a problem for him.
>
>
> Michael.Waychison> Ian M. is correct in that nsswitch.conf logic should be
> Michael.Waychison> observed when looking up a map.  I don't think it's
> Michael.Waychison> worth the hassle and kludgyness of trying to bring any
> Michael.Waychison> sort of API into glibc.  For the majority of Solaris
> Michael.Waychison> users, 'files nis' is 'good enough'.  This is slowly
> Michael.Waychison> changing to 'files ldap', so we do eventually need to
> Michael.Waychison> have this be a configurable option for things to work
> Michael.Waychison> properly..
>
> Ok, my only beef here is that we are not at all honoring the semantics of
> nsswitch.conf.  I attest that this is a design flaw, but given the Sun
> automounter legacy, I see now ay around it.  We'll adhere to what is done
> by all other automounters, even though it's wrong and poorly documented.
>
> So, can I make the assumption that Suns's automounter does not then honor
> the "reaction on lookup result", ala [NOTFOUND=return]?  If so, then
our job
> is a bit easier, though we are _still_ duplicating a parser, which I
> despise.  (I'll do it, I just won't like it ;)
>

I don't know if Sun's automounter does, I'd have to do a bit of testing,
although I don't see why it wouldn't support status -> action predicates.

>
>
>>>>>>As well as the map order there is missing functionality in the
>>>>>>current approach in that if a map key appears more than once, say in
>>>>>>a global
>>>>>
>>>>>map > and in a local file map, the two maps are not merged. They
>>>>>should be. This > needs to be catered for in handling nsswitch.conf
>>>>>map sources and even > multiple entries in the same map (master map
>>>>>that is).
>>>>>
>>>>>This does not match the Solaris behavior (at least, not based on tests
>>>>>that I've done on the Solaris infra here).  The only circumstance
>>>>>where the Solaris automounter will combine maps is if a file map
>>>>>contains "+" notation.  In this case, it will merge the NIS map into
>>>>>the file map.
>
>
> Michael.Waychison> Side note: If the included 'mapname' starts with a '/',
> Michael.Waychison> then only local databases in nsswitch.conf should be
> Michael.Waychison> checked.  If it doesn't, then only remote databases
> Michael.Waychison> should be checked.  This all happens in the order
> Michael.Waychison> specified.
>
> Michael.Waychison> This differs from lookup of maps in auto.master
however.
> Michael.Waychison> In the master map, lookup is done (regardless of the
> Michael.Waychison> first character) in the order specified by
> Michael.Waychison> nsswitch.conf, prepending '/etc/' for 'files' if
> Michael.Waychison> required.
>
> And we don't support the '+' notation, correct?  Should we?  Since
we're in
> the code, it may make sense.
>

Last I looked, '+' was only supported in the master map, handled by a
clause in the init script.  Ian K?

>>>>>If nothing else, it would be nice to have a "SOLARIS_COMPAT" flag that
>>>>>switches Linux autofs to the two behaviors described above.
>>>
> raven> I would rather move autofs toward the Solaris behaviour.
>
>>>Agreed.  If there was a compat flag, it would default to on in my
>
> Michael.Waychison> packages.
>
>
> Michael.Waychison> I don't know where the Linuxisms came from originally,
> Michael.Waychison> but they really do smell of lazyness to not implement
> Michael.Waychison> nsswitch.conf logic.  All other Unix do the right thing
> Michael.Waychison> in a not so incompatible way.
>
> ziiing!  call us lazy, will ya.  ;)

Nah. I just have a beef against the file: / program: / yp: / ldap:  /
nisplus: / hesiod: prefixes.  They make the map language context
dependent.  Consider these entries:

mikew	file:/some/path
jeffm   -fstype=autofs file:/some/path

My homedir would be an nfs mount coming from server 'file', but yours
would be an indirect mount defined by the map in flat file /some/path.
It just makes writing a *comprehensive* parser more difficult :\.  It's
also completely incompatible with everything else out there, which is
probably what prompted Ian M to write his patch in the first place.

>
> raven> So, appart from merging your work, and working out a way to cleanly
> raven> get the map order, what else do we need to do.
>
> raven> Can you propose a simple work plan we can focus on.
>
>>>I exchanged emails with Ulrich Drepper on the feasibility of a
>>>getautomountent (or similar) call in libc.  He was not at all opposed to
>>>the idea.  My only concern is that if things work the way Mike W. says
>
> Michael.Waychison> they
>
>>>do, then it may not make sense to add such an interface to libc/libnss.
>>>I'd have to think on this some more, though, as a standard interface
>>>would make things a lot easier for us (and it may be feasible to
>>>"stretch" the interface to look the way we want it to).
>>>
>
>
> Michael.Waychison> I'm just really against putting this in libc ;).
With a
> Michael.Waychison> single consumer and no defined interface to 'copy',
> Michael.Waychison> what's the point?
>
> What's the point?  The point is to leverage existing code.  As it stands,
> my feeling on the matter is that an entry should never have been added to
> nsswitch.conf.  It should have been in an automounter configuration file,
> since the semantics are worse than completely different, they're slightly
> different!

I pondered this over coffee this morning, and thought to myself:

"If we added this functionality to nss/, then we'd be abstracting out
the nsswitch.conf parser.  This is a benefit because we don't have to
worry about the status->action semantics and would allow us to change
the nsswitch.conf interface"

I then took another sip of coffee and realized that switching the switch
is a dumb idea ;)

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8/qfdQs4kOxk3/MRAiOjAKCN3KCousS9RctMhXsGJq4Cxsx5zwCghMxT
ClxeViTcbakJZdsA9t4aJN4=
=+/XI
-----END PGP SIGNATURE-----
