From: raven@themaw.net
Subject: Re: automount and nsswitch.conf
Date: Tue, 13 Jul 2004 21:39:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407132058450.4483@donald.themaw.net>
References: <Pine.LNX.4.44.0407121145390.1698-100000@localhost.localdomain>
 <Pine.LNX.4.58.0407131858440.1375@donald.themaw.net>
 <16627.53979.532064.36562@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Resent-Message-ID: <16627.59961.528249.503852@segfault.boston.redhat.com>
Resent-To: autofs@linux.kernel.org
In-Reply-To: <16627.53979.532064.36562@segfault.boston.redhat.com>
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
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>

On Tue, 13 Jul 2004, Jeff Moyer wrote:

> ==> Regarding Re: automount and nsswitch.conf; raven@themaw.net adds:
> 
> raven> On Mon, 12 Jul 2004, Ian McLeod wrote:
> >> On Tue, 13 Jul 2004 raven@themaw.net wrote:
> >> 
> >> [snip] > > 3) for fstype=autofs, we need to explicitly set the map type.
> >> I'm unsure > > where this is done, or if it must be a source:map format
> >> in the map > > file?  At any rate, this certainly does not allow us to
> >> take advantage > > of nsswitch.conf, and may result in unexpected
> >> behaviour for the user.
> >> > 
> >> > fstype=autofs is basically a submount and is specified as a filesystem
> >> > rather than a map source. This shouldn't be to big a problem (or have
> >> I > missed your point).
> >> 
> >> This one is near and dear to my heart, so I'll clarify my understanding.
> >> 
> >> Here's an actual line from the NIS based maps at a client site:
> >> 
> >> clearcase -fstype=autofs auto.src.clearcase
> >> 
> >> This line works on Solaris.  Specifically, Solaris will look for
> >> "auto.src.clearcase" in the places and order specified in nsswitch.conf.
> >> 
> >> This line will fail under the current Linux code with an error "missing
> >> script type on".  The code expects the map source to be explicitly
> >> specified in <source>:<map> format.  Something like:
> >> 
> >> clearcase -fstype=autofs yp:auto.src.clearcase
> >> 
> >> What I would like to see (and what I have quasi-implemented with some
> >> kludgey patches) is Linux behavior that matches (or at least is capable
> >> of matching) the Solaris behavior.  This has obvious benefits in
> >> heterogeneous environments.
> 
> raven> This is the patch I have, yes?
> 
> raven> And you would be wanting me to merge it for 4.1.4 or produce a
> raven> supported patch for 4.1.3, yes?
> 
> raven> Have you done any additional work on it?
> 
> The patch Ian M. came up with hard codes the lookup order to "files nis".
> I've been trying to do additional work on it, but that requires getting a
> few things straight in my head, and then writing gobs of code, and then
> upgrading glibc, etc, etc.
> 
> I think we can go with what Ian proposed for now, as it definitely solved a
> problem for him.
> 
> >> 
> >> 
> >> > As well as the map order there is missing functionality in the current
> >> > approach in that if a map key appears more than once, say in a global
> >> map > and in a local file map, the two maps are not merged. They should
> >> be. This > needs to be catered for in handling nsswitch.conf map sources
> >> and even > multiple entries in the same map (master map that is).
> >> 
> >> This does not match the Solaris behavior (at least, not based on tests
> >> that I've done on the Solaris infra here).  The only circumstance where
> >> the Solaris automounter will combine maps is if a file map contains "+"
> >> notation.  In this case, it will merge the NIS map into the file map.
> >> In all other cases, Solaris seems to do the following:
> >> 
> >> -Search for the map (including auto.master) in the order specified in
> >> nsswitch.conf -Stop after the first match and process the map (do not
> >> continue, do not merge additional matches)
> >> 
> 
> raven> That's not what I have observed, of course I could be mistaken (and
> raven> often am), but is not an big issue atm.
> 
> This is one thing I really want to understand.  Let me phrase my question
> as precisely as I can:

Please disregard merging of maps comment I made. It's confusing what you 
are trying to clear up.

Having said that ....

> 
> The format of the nsswitch.conf is as follows:
> 
> database: lookuptype
> 
> (we will ignore the [NOTFOUND=return] stuff for now)
> 
> For each database, you specify one or more lookup types.  Then, for each
> query to the database, each lookup type is consulted for data, and we do
> not stop until we find it or we've exhausted lookup types.  I believe Ian
> K. calls this merging of maps.

Not quite what I originally meant but the way I believe that nsswitch.conf 
works.

> 
> Please let me know if this is how autofs is expected to interpret its line
> in the nsswitch.conf.  Mike Waychison believes this not to be true.  Here
> is his take on the differences:
> 
> ---Mike W.---
> - getXXXent semantics for SUCCESS|UNAVAIL|NOTFOUND|TRYAGAIN apply to the
>   entries in the tables (defined by service name) themselves.
> - automounter semantics for SUCCESS|UNAVAIL|NOTFOUND|TRYAGAIN apply to
>   the tables (or 'maps').  (where the service name is 'automount').

This assumes that the map entries themselves are delivered by the 
getXXXent routines. I think that's what your proposing, right?

Then we have the added complexity of different retrieval methods for 
different map types aka gobs of code but already present in autofs 
modules.

I think the bigger task here would be defining the API as the getXXXent 
above may not be sufficient for autofs as is. The current autofs 
uses the lookup module code in several ways. I'd have to ponder this for a 
while.

> 
> 
> With automounting, there are two level's of lookup.
> 
> 1) Give me the entity described by this map name.
> 2) Give me the entity described by this key, from this map entity.
> ---Mike W.---
> 
> This means that we consult nsswitch.conf only to find the first lookup type
> that _exists_, not whether its contents contain the key we are looking
> for.  I find this quite odd, and a departure from the semantics of every
> other entry in nsswitch.conf.  However, I think this is the way we operate
> today, right?

Yes. Agreed.

But this was implemented (by someone) in the init script, found in the v3 
RH package ages ago, to get some semblance of using nsswitch.conf. There 
has never been any real effort to implement real nsswitch.conf 
infrastructure.

Merging that into autofs v4 was my doing.

> 
> I might add that I find it quite frustrating that the Solaris man pages
> don't really touch on this issue.  It's impossible to read documentation and
> figure out the precise behaviour.  :(

Tell me about it!

> 
> >> If nothing else, it would be nice to have a "SOLARIS_COMPAT" flag that
> >> switches Linux autofs to the two behaviors described above.
> 
> raven> I would rather move autofs toward the Solaris behaviour.
> 
> Agreed.  If there was a compat flag, it would default to on in my packages.
> 
> raven> So, appart from merging your work, and working out a way to cleanly
> raven> get the map order, what else do we need to do.
> 
> raven> Can you propose a simple work plan we can focus on.
> 
> I exchanged emails with Ulrich Drepper on the feasibility of a
> getautomountent (or similar) call in libc.  He was not at all opposed to
> the idea.  My only concern is that if things work the way Mike W. says they
> do, then it may not make sense to add such an interface to libc/libnss.
> I'd have to think on this some more, though, as a standard interface would
> make things a lot easier for us (and it may be feasible to "stretch" the
> interface to look the way we want it to).

Seems to me the choice is whether to "go the whole hog with libc" or 
"keep the implemention in autofs and grab map types ourselves". There is 
one consideration though and that's that the lookup functions change fairly 
frequently and as I said above a fair amount of autofs function is 
included there. The current design calls lookup then calls parse from 
inside with context and then calls mount from within that with differnet 
context so going libc will require considerable internal autofs change.

> 
> Mike, would you mind re-iterating your position, and perhaps correcting any
> misinterpretations of your email I've made?
> 
> Thanks!
> 
> Jeff
> 
> p.s.  Do you think we should move this discussion to on-list?  It may be
> a good thing to archive.
>

Yep.

Ian
