From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount and nsswitch.conf
Date: Tue, 13 Jul 2004 10:35:52 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16627.62280.129793.903146@segfault.boston.redhat.com>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
	<Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
	<16627.53979.532064.36562@segfault.boston.redhat.com>
	<40F3DD67.8000200@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40F3DD67.8000200@sun.com>
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


> ==> Regarding Re: automount and nsswitch.conf; Michael Waychison adds:
[snip]

>>>> What I would like to see (and what I have quasi-implemented with some
>>>> kludgey patches) is Linux behavior that matches (or at least is
>>>> capable of matching) the Solaris behavior.  This has obvious benefits
>>>> in heterogeneous environments.
>>
raven> This is the patch I have, yes?
>>
raven> And you would be wanting me to merge it for 4.1.4 or produce a
raven> supported patch for 4.1.3, yes?
>>
raven> Have you done any additional work on it?
>> The patch Ian M. came up with hard codes the lookup order to "files
>> nis".  I've been trying to do additional work on it, but that requires
>> getting a few things straight in my head, and then writing gobs of code,
>> and then upgrading glibc, etc, etc.
>> 
>> I think we can go with what Ian proposed for now, as it definitely
>> solved a problem for him.

Michael.Waychison> Ian M. is correct in that nsswitch.conf logic should be
Michael.Waychison> observed when looking up a map.  I don't think it's
Michael.Waychison> worth the hassle and kludgyness of trying to bring any
Michael.Waychison> sort of API into glibc.  For the majority of Solaris
Michael.Waychison> users, 'files nis' is 'good enough'.  This is slowly
Michael.Waychison> changing to 'files ldap', so we do eventually need to
Michael.Waychison> have this be a configurable option for things to work
Michael.Waychison> properly..

Ok, my only beef here is that we are not at all honoring the semantics of
nsswitch.conf.  I attest that this is a design flaw, but given the Sun
automounter legacy, I see now ay around it.  We'll adhere to what is done
by all other automounters, even though it's wrong and poorly documented.

So, can I make the assumption that Suns's automounter does not then honor
the "reaction on lookup result", ala [NOTFOUND=return]?  If so, then our job
is a bit easier, though we are _still_ duplicating a parser, which I
despise.  (I'll do it, I just won't like it ;)


>>
>>>>
>>>>> As well as the map order there is missing functionality in the
>>>>> current approach in that if a map key appears more than once, say in
>>>>> a global
>>>> map > and in a local file map, the two maps are not merged. They
>>>> should be. This > needs to be catered for in handling nsswitch.conf
>>>> map sources and even > multiple entries in the same map (master map
>>>> that is).
>>>> 
>>>> This does not match the Solaris behavior (at least, not based on tests
>>>> that I've done on the Solaris infra here).  The only circumstance
>>>> where the Solaris automounter will combine maps is if a file map
>>>> contains "+" notation.  In this case, it will merge the NIS map into
>>>> the file map.

Michael.Waychison> Side note: If the included 'mapname' starts with a '/',
Michael.Waychison> then only local databases in nsswitch.conf should be
Michael.Waychison> checked.  If it doesn't, then only remote databases
Michael.Waychison> should be checked.  This all happens in the order
Michael.Waychison> specified.

Michael.Waychison> This differs from lookup of maps in auto.master however.
Michael.Waychison> In the master map, lookup is done (regardless of the
Michael.Waychison> first character) in the order specified by
Michael.Waychison> nsswitch.conf, prepending '/etc/' for 'files' if
Michael.Waychison> required.

And we don't support the '+' notation, correct?  Should we?  Since we're in
the code, it may make sense.

>>>> In all other cases, Solaris seems to do the following:
>>>> 
>>>> -Search for the map (including auto.master) in the order specified in
>>>> nsswitch.conf -Stop after the first match and process the map (do not
>>>> continue, do not merge additional matches)
>>>> 
>>
raven> That's not what I have observed, of course I could be mistaken (and
raven> often am), but is not an big issue atm.
>>

Michael.Waychison> Ian M's description is the correct one.

Easy enough.

[snip]

>>>> If nothing else, it would be nice to have a "SOLARIS_COMPAT" flag that
>>>> switches Linux autofs to the two behaviors described above.
>>
raven> I would rather move autofs toward the Solaris behaviour.
>> Agreed.  If there was a compat flag, it would default to on in my
Michael.Waychison> packages.
>>

Michael.Waychison> I don't know where the Linuxisms came from originally,
Michael.Waychison> but they really do smell of lazyness to not implement
Michael.Waychison> nsswitch.conf logic.  All other Unix do the right thing
Michael.Waychison> in a not so incompatible way.

ziiing!  call us lazy, will ya.  ;)

raven> So, appart from merging your work, and working out a way to cleanly
raven> get the map order, what else do we need to do.
>>
raven> Can you propose a simple work plan we can focus on.
>> I exchanged emails with Ulrich Drepper on the feasibility of a
>> getautomountent (or similar) call in libc.  He was not at all opposed to
>> the idea.  My only concern is that if things work the way Mike W. says
Michael.Waychison> they
>> do, then it may not make sense to add such an interface to libc/libnss.
>> I'd have to think on this some more, though, as a standard interface
>> would make things a lot easier for us (and it may be feasible to
>> "stretch" the interface to look the way we want it to).
>> 

Michael.Waychison> I'm just really against putting this in libc ;).  With a
Michael.Waychison> single consumer and no defined interface to 'copy',
Michael.Waychison> what's the point?

What's the point?  The point is to leverage existing code.  As it stands,
my feeling on the matter is that an entry should never have been added to
nsswitch.conf.  It should have been in an automounter configuration file,
since the semantics are worse than completely different, they're slightly
different!

So, as such, it seems I agree with you in that we should not add an
interface to libc.  ;)


>> Mike, would you mind re-iterating your position, and perhaps
>> correcting any misinterpretations of your email I've made?
>> 

Michael.Waychison> Sure.

Michael.Waychison> - Current automount 4 (and 3) do not support any 
Michael.Waychison>   nsswitch.conf logic.
Michael.Waychison> - We need nsswitch.conf logic.
Michael.Waychison> - I don't think we should have to add any API to glibc.
Michael.Waychison>   - we don't want to be completely dependent on 'given 
Michael.Waychison>     versions of glibc'.
Michael.Waychison>   - it becomes a bit of a maintenance nightmare.
Michael.Waychison>   - so far, we'd be the _only_ consumer of such an API.
Michael.Waychison>   - lack of standard API means we are playing guessing 
Michael.Waychison>     games at coming up with API semantics.
Michael.Waychison>   - nss/* is a maze of macros and one liner files that 
Michael.Waychison>     bogs my mind.
Michael.Waychison> - My understanding is Ian M's patch adds 'files nis' 
Michael.Waychison>   logic.  Good.
Michael.Waychison> - Let's try to extend that somehow to actually parse out
Michael.Waychison>   and use nsswitch.conf
Michael.Waychison> - Maps are not automatically 'merged'.
Michael.Waychison> - Maps are instead explictly 'included' (only possible 
Michael.Waychison>   from local flat files).
Michael.Waychison> - There _is_ a lookup algorithm.. ..it's just not well 
Michael.Waychison>   documented.

I believe I've addressed these points.  Thanks for your time on this, Mike.

-Jeff
