From: Ian Kent <raven@themaw.net>
Subject: Re: [patch rfc] address regression in duplicate map entry
	order
Date: Tue, 8 Feb 2005 09:30:31 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502080917480.13459@wombat.indigo.net.au>
References: <16798.38327.587983.840248@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0411212219580.10238@donald.themaw.net>
	<16802.11524.992409.610071@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0411230856060.27086@wombat.indigo.net.au>
	<16898.16820.640543.489325@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0502040929270.21690@wombat.indigo.net.au>
	<16899.45023.789578.736494@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0502051136030.1673@donald.themaw.net>
	<16903.36946.328572.613857@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16903.36946.328572.613857@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 7 Feb 2005, Jeff Moyer wrote:

> ==> Regarding Re: [patch rfc] address regression in duplicate map entry order; raven@themaw.net adds:
> 
> raven> On Fri, 4 Feb 2005, Jeff Moyer wrote:
> >> ==> Regarding Re: [patch rfc] address regression in duplicate map entry
> >> order; Ian Kent <raven@themaw.net> adds:
> >> 
> raven> On Thu, 3 Feb 2005, Jeff Moyer wrote:
> >>>> ==> Regarding Re: [patch rfc] address regression in duplicate map
> >>>> entry order; Ian Kent <raven@themaw.net> adds:
> >>>> 
> raven> On Mon, 22 Nov 2004, Jeff Moyer wrote:
> >>>>>> ==> Regarding Re: [patch rfc] address regression in duplicate map
> >>>> entry >> order; raven@themaw.net adds:
> >>>>>>
> raven> On Fri, 19 Nov 2004, Jeff Moyer wrote:
> >>>>>>>> Hi, Ian, list,
> >>>>>>>> 
> >>>>>>>> In my proposed fix, I meant to say:
> >>>>>>>> 
> >>>>>>>> We could expire the cache in lookup_ghost, and then go ahead and
> >>>> only >> >> insert new entries (instead of overwriting what was there).
> >>>>>>>> So, I've implemented this, though it isn't tested just yet.  There
> >>>>>> were >> some other bugs.
> >>>>>>>> In lookup_multi, we iterate through each map's lookup_ghost
> >>>> function.  >> >> The problem here is that you will end up doing the
> >>>> following:
> >>>>>>>> static int read_map(const char *root, struct lookup_context *ctxt)
> >>>> { >> >> char key[KEY_MAX_LEN + 1]; char mapent[MAPENT_MAX_LEN + 1];
> >>>> char
> >>>>>>>> *mapname; FILE *f; int entry; time_t age = time(NULL); >> >>
> >>>> <=================
> >>>>>>>> mapname = alloca(strlen(ctxt->mapname) + 6); sprintf(mapname, >>
> >>>> "file:%s", >> ctxt->mapname);
> >>>>>>>> f = fopen(ctxt->mapname, "r"); if (!f) { error(MODPREFIX "could
> >>>> not >> open >> map file %s", ctxt->mapname); return 0; }
> >>>>>>>> while(1) { entry = read_one(f, key, mapent); if (entry) >> >>
> >>>> cache_update(root, key, mapent, age); <==========
> >>>>>>>> if (feof(f)) break; }
> >>>>>>>> 
> >>>>>>>> fclose(f);
> >>>>>>>> 
> >>>>>>>> /* Clean stale entries from the cache */ cache_clean(root, age);
> >>>>>>>> <=============
> >>>>>>>> 
> >>>>>>>> return 1; }
> >>>>>>>> 
> >>>>>>>> Notice the lines I've pointed out.  We decide what the expiration
> >>>> age >> >> should be at the beginning of the function.  We update
> >>>> entries and >> give >> them that "age."  And finally, we expire all
> >>>> entries that were >> made >> prior to that.  The problem arises in
> >>>> that we call the read_map >> routine >> for each map in the list in
> >>>> order.  What will happen is that >> each map, >> as it is processed,
> >>>> will end up with a new value for age.  >> Thus, we >> expire all of
> >>>> the work done by the previous read_maps!  This >> is bad.  To >> fix
> >>>> this, I've passed in the age field from the >> top-level.
> >>>>>>>> I've changed ldap's lookup_ghost routine (well, a function it
> >>>> calls, >> >> anyway) to use cache_insert_unique instead of cache_add.
> >>>>>>>> Please let me know what you think.  If you only like some parts,
> >>>> let >> me >> know which ones and I'll break them out from the rest of
> >>>> the >> patch.  >> BTW, this patch is applied on top of your map
> >>>> expiration >> changes.  I can >> rediff the thing to any version of
> >>>> the code you want.
> >>>>>>
> raven> Understand the problem.
> >>>>>>
> raven> I've had a look at the patch and it looks good.
> >>>>>>
> raven> I had a slightly different idea though.
> >>>>>>
> raven> I think the cache_insert_unique might be a problem later as if
> raven> people add multiple attributes (map entries) for multi-mount keys,
> raven> instead of one attribute containing multiple mounts, in what they
> raven> think is "the LDAP way" it probably won't work. I can't say we've
> raven> seen this problem yet but I have been trying to allow for it in the
> raven> code.
> >>>>>>
> raven> The other thing that occured to me was that, together with passing
> raven> the time to keep things consistent, processing the maps in reverse
> raven> order in lookup_ghost of the multi map module would fix most of the
> raven> issues. Along with modifying cache_add to append to any existing
> raven> entries, rather than prepend.
> >>>>>>
> raven> I spotted something you missed in the yp module. Have a look at the
> raven> lookup_yp patch chunks in the attached map-entry-order patch.
> >>>>>>
> raven> Have a look at what I've tried to do and let me know what you
> raven> think. I've done some basic testing but not against the issue we are
> raven> trying to fix. So let me know how it goes.
> >>>>>>
> raven> Also, I found a couple of other bugs and have attached a couple of
> raven> other patches as well.
> >>>>>> Thanks, Ian!  This all looks good to me, though I haven't been able
> >>>> to >> test.  What version of the tree was this applied to?
> >>>> 
> raven> That's a rather interesting question.
> >>>>
> raven> I originally made the patch against your 55.1 but couldn't get
> raven> rpmbuild to work OK under Gentoo so I added approiate patches to my
> raven> Gentoo portage install and built there. Only minor changes were
> raven> needed, which I believe would have been needed for the rpm as well.
> >>>>
> raven> Hopefully, it will also apply to earlier rpms without much trouble
> raven> as the changes appear to be mostly outside of the areas with lots of
> raven> change.
> >>>> In testing 4.1.4 beta 1, this problem still isn't addressed.
> >>>> Automount will use the last of the duplicate entries in an indirect
> >>>> map, precisely the opposite behaviour as before.
> >>
> raven> The last !!??
> >>
> raven> Bizare ....
> >>
> raven> At least the idea was good but .....
> >>
> raven> More things to fix.
> >> Regressions are priority 1.  Customers hate them!  ;-)
> >> 
> >> So, here is the offending code:
> >> 
> >> lookup_ghost calls read_map, which does this:
> >> 
> >> while(1) { entry = read_one(f, key, mapent); if (entry)
> >> cache_update(root, key, mapent, age);
> >> 
> >> if (feof(f)) break; }
> 
> raven> Yes. I see that in the lookup_yp module as well but the lookup_ldap
> raven> module doesn't have the same problem.
> 
> >> This is the first time the map is read.  If cache_update doesn't find a
> >> previous entry, it creates one.  If it does find an entry, it /replaces/
> >> it with what you pass in.  Thus, the last entry in an indirect map shows
> >> up as the only entry.
> 
> raven> Yep. I see that's the way it behaves.
> 
> >> This is a bit of a tricky problem.  It could be addressed in one of a
> >> number of ways, but before I go off implementing anything, I wanted to
> >> get your input on the matter.
> >> 
> >> The cache wasn't really meant to have multiple copies of the same key
> >> with different values.  What you really want, I guess is something that
> >> conceptually works like this:
> >> 
> >> cache_update: change key X value Y to key X value Z
> 
> raven> After looking at this more closely I think the problem might not be
> raven> so hard to solve after all.
> 
> raven> I don't really care if there's multiple entries for a key. To
> raven> maintain sensible behaviour we should return the first match on
> raven> lookup and that's what happens now anyway. As you point out the
> raven> problem happens when we populate the cache.
> 
> raven> But there's more. See below.
> 
> >> I guess we could get the current versions from the cache, but is there a
> >> deterministic way of mapping old key/value pairs to updated ones in the
> >> presence of multiple entries per key?  (confusing question?  read it a
> >> few more times ;)
> 
> raven> This is the bit I'm not sure about yet.
> 
> raven> Perhaps we need to carry a map id in cache entries or in the context
> raven> to identify them when we lookup them up later and possibly update
> raven> them?
> 
> How?  There is no deterministic way to do this because the backing store
> (whether it's a file or nis or ldap) does not keep this information.  At
> the end of the day, I don't really think it matters, though.  What I think
> should happen is that we simply preserve the order in the map.
> 
> Instead of only updating one key in the cache, if the cache has gone stale
> we should re-read the whole thing.

It's not quite like that.

Locating an updated entry is a clue we need to reread the whole map.
It's not possible to reread the whole map during a lookup as it's done in 
a subprocess. However, if a change is found then a HUP signal is sent to 
the parent so it does reread the whole map.

> 
> Note that current behaviour is pretty broken for things like files.  If the
> modification time changes on a file, we revert to always bypassing the
> cache!  We never re-read the entire map, and even if we have the freshest
> copy of a data item in the cache, we still go to disk.
> 
> raven> Anyway we'll always be updating the first match (as the semantic
> raven> requires) so it might not matter.
> 
> I think we're on the same page here, but to be sure: map entries should be
> read in and populated in the cache in the order they appear in the map.
> The first entry should always be returned.
> 
> raven> The question that arises from this is "will we allow duplicate keys
> raven> within individual maps"?
> 
> raven> That would make things much more difficult and probably won't give
> raven> functionality that's needed or used.
> 
> No need.
> 
> >> So, I'll ponder this for a bit, and maybe come up with a patch that you
> >> can tear to shreds, but I'd really like your input on the matter.
> 
> raven> It seems that our first attempt at solving this (the bad bits due to
> raven> me of course) did two things.
> 
> raven> 1) Changed cache_add to add if no key is present but to append to
> raven> the end of the hash chain for that key if it is present.
> 
> raven> That would be OK if we called cache_add (as we do in lookup_ldap)
> raven> instead of cache_update (as we do in lookup_file and lookup_yp)
> raven> (doh!).
> 
> raven> 2) I changed the lookup_multi module to populate the cache in
> raven> reverse map order.
> 
> raven> Now that's just broken.
> 
> raven> So consider the following patch together with the original patch. I
> raven> think this might be all that's needed, at least in populating the
> raven> cache.
> 
> raven> It reverts the change in 2) and changes cache_update to cache_add in
> raven> the needed places.
> 
> raven> What do you think?
> 
> I'll take a look.
> 
> raven> As I said above the other question that needs to be answered is
> raven> whether this will have undesirable side affects at lookup time?
> 
> So long as we return the first entry that appears in the map, we are doing
> the right thing.  The hard part is handling updates, and I think we need
> more code to account for that.

Looks to me like this should be able to be achieved without much change.

It really shouldn't be that difficult to do. I hope that the patch in 
my last mail will acheive it.

Ian
