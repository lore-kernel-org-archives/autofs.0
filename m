From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: automount and nsswitch.conf
Date: Wed, 14 Jul 2004 11:13:13 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40F54D89.50109@sun.com>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
 <Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
 <16627.53979.532064.36562@segfault.boston.redhat.com>
 <40F3DD67.8000200@sun.com>
 <16627.62280.129793.903146@segfault.boston.redhat.com>
 <40F3FAA0.9010204@sun.com>
 <16628.1468.732296.549859@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0407142207350.1633@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0407142207350.1633@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

raven@themaw.net wrote:
> On Tue, 13 Jul 2004, Jeff Moyer wrote:
>
>
>>[snip]
>>
>>Michael.Waychison> I'm just really against putting this in libc ;).
With a
>>Michael.Waychison> single consumer and no defined interface to 'copy',
>>Michael.Waychison> what's the point?
>>
>>>>What's the point?  The point is to leverage existing code.  As it
>>>>stands, my feeling on the matter is that an entry should never have been
>>>>added to nsswitch.conf.  It should have been in an automounter
>>>>configuration file, since the semantics are worse than completely
>>>>different, they're slightly different!
>>
>>Michael.Waychison> I pondered this over coffee this morning, and
thought to
>>Michael.Waychison> myself:
>>
>>Michael.Waychison> "If we added this functionality to nss/, then we'd be
>>Michael.Waychison> abstracting out the nsswitch.conf parser.  This is a
>>Michael.Waychison> benefit because we don't have to worry about the
>>Michael.Waychison> status->action semantics and would allow us to change
>>Michael.Waychison> the nsswitch.conf interface"
>>
>>I don't entirely understand your pre-coffee nss pontification.  Might I
>>suggest a few more sips?  ;)
>>
>>If we add support to nss, then we define the interface and the
semantics of
>>that interface.  We could have one function return the result of a map
>>lookup, and another a key lookup.  They key lookup would take two
>>arguments, one being the source, the other being the key.  For ghosting,
>>you'd need an iterative function to enumerate the keys.  Hmm, what would
>>the functions be?
>>
>>struct automapent *getautomapent(const char *mapname);
>>/* provide null key for iteration */
>>struct automntent *getautomntent(struct automapent *, const char *key);
>>void endautomntent(struct automapent *);
>>
>>Now, before I go any further, Ian K's point stands.  Putting the parser
>>logic entirely in libc would require a significant structural change
to the
>>code base.  I'm not an advocate of that, certainly not before we get
things
>>a bit more stable.
>
>
> I think there is a long way to go to merge this function into libc/nss.
>
> We need to merge this into autofs now.
>

As per earlier discussions, I've confirmed that Solaris has no public
interface for grabbing map information from name services.  Infact, all
logic is done in the application layer.

>
>>SUMMARY
>>
>>The current Linux automounter does not properly handle nsswitch.conf.  It
>>is desirable to leverage the nss library within libc to implement this
>>functionality, though it is infeasible to do so in the near future.  Thus,
>>we need to implement our own nsswitch.conf parser within the automount
>>code.  I believe future implementations should move toward the libc
>>approach.
>
>
> To early to really discuss whether it would actually be benifical to
> leverage the libc code. Developing with a eye to this end should show us
> what oppertunities or shortcommings exist with this approach.
>
>
>>In either approach, we need to move parsing logic out of the init script.
>>We can do this by making the new parsing code into a sort of library which
>>can be accessed by a helper program that the init script can run.  It is
>>insane to try to write this code in two languages, especially when one of
>>them is shell.
>
>
> My thoughts were a seperate module but maybe not a seperate utility. I
> haven't done any experimentation with this specifically yet.
>
> One thing to keep in mind is that we already have a fair bit of useful
> code in the lookup modules to talk to different map sources. Perhaps the
> lookup module interface should be extended to read master maps a well as
> entries. This is consistent with the current design. Comments?
>
>
>>The current parsing of auto.master is flawed, but can be fixed with the
>>approach described in the immediately preceeding paragraph.  We definitely
>>do not want to source _all_ potential auto.master maps.
>>
>>[NOTE] Ian Kent has, "making the automounter a threaded app," on his todo
>>list.  I believe this is partly motivated by the need to move logic out of
>>the init script and into the c code.  Thus, you would start one
automounter
>>process, and it would spawn threads for each mount.  As such, the helper
>>program approach may only be an interim solution.
>
>
> If we are writting a parser then to turn it into a "supervisor" thread
may
> not be that difficult. My experiments with future developments move the
> code to this type of module seperation because of the way I think things
> should go.
>
>
>>We need to think about the impact of removing the maptype:mapname grammar
>>from the map file formats, per example provided by Mike W.  A phasing out
>>of this seems like a reasonable approach, perhaps starting out with simple
>>warning messages early on and good documentation on how to get the proper
>>semantics with the tools available.  Of course, this requires that we
>>implement the nsswitch.conf parsing logic, first.
>
>
> It shouldn't be to hard to support the existing syntax as an override.
> While my goal has been to move autofs toward coexistence within Solaris
> style sites (I haven't been to successful but still want to) I think it
> would be a shame to discard the individuality and character of the
> original autofs, created by Peter Anvin for Linux, not for coexistence in
> Solaris environments. The original autofs had (has) a face of it's own
and
> those creative ideas shouldn't be discarded out of hand.
>

I agree that supporting the nameservice prefixes as an override is
possible, but don't believe keeping it as a reminder of 'individuality'
has any merit.  When nss support comes in, I'd suggest we start
complaining loud and clear in the logs that nameservice prefixes are a)
deprecated, b) is completely incompatible with every other autofs system
out in the wild.

Prefixes are a hack.  Warts like this should only be supported for a
short term.  Let's cut our losses and move on.

>
>>Handling of the '+' inclusion directive should also be implemented.
>>
>
>
> Part and parcel of the master map parsing.

This is not master map specific.  It applies to all flat files.  But you
knew that right ;)

>
>
>>Ok, have I missed anything?  Does anyone want to contend any of these
>>points?
>>
>>-Jeff
>>
>>p.s. what a can of worms...  did anyone see the lid lying around?  ;)
>
>
> The can has been there for ages. The worms couldn't fit in the can any
> more so they just pushed it of and chucked it away.
>

Yup. Completely agree :)


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

iD8DBQFA9U2IdQs4kOxk3/MRAvgIAKCXj6ifmQnrSqSFWtZ/2xKm5QIb6gCfVUo9
fXMYpg+7LdFgKxY8Jd5Xjn4=
=Q3ya
-----END PGP SIGNATURE-----
