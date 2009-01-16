From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 13:21:54 +0900
Message-ID: <1232079714.3166.56.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Fri, 2009-01-16 at 14:59 +1100, Paul Wankadia wrote:
> On Fri, Jan 16, 2009 at 12:43 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         > > > If we can simply flag the cached version as stale, then
>         lazy reloads
>         > > > should be possible.
>         > >
>         > > Maybe not.
>         > >
>         > > The layer of code above the lookup modules does the
>         re-loads but it is
>         > > general wrt. the map type so for a "nobrowse" map it won't
>         read the map.
>         > > I'm not sure yet that putting special case exceptions in
>         that code is a
>         > > good thing to do or even straight forward. But, for the
>         large map case,
>         >
>         > Or maybe I'm talking nonsense as it looks like I've actually
>         got plenty
>         > of map type context in the layer above, hehe.
>         >
>         > > we can consider reading the entire map an expensive
>         operation, so if we
>         > > did change the layer above and we found the map needed to
>         be modified
>         > > then marked the map as stale we would need to scan the
>         file map for the
>         > > key (as the map is out of date) and then read the whole
>         map later. That
>         > > means we would end up reading the map at least one and a
>         half times (on
>         > > average) instead of once (assuming no lookups between
>         marking the map
>         > > stale and re-reading).
>         > >
>         > > I'm tending toward reading the map during the lookup so
>         the map is up to
>         > > date when we look for the key in the cache.
>         
>         Or maybe not.
>         
>         If we take advantage of the existing code to mark the map as
>         stale and
>         handle the re-read and we accept the overhead of scanning the
>         file map
>         while waiting for the update something like this could be all
>         that's
>         needed.
>         
>         autofs-5.0.4 - always read file maps
>         
>         From: Ian Kent <raven@themaw.net>
>         
>         
>         ---
>         
>          daemon/lookup.c       |    9 ++++++---
>          modules/lookup_file.c |   11 ++++++++++-
>          2 files changed, 16 insertions(+), 4 deletions(-)
>         
>         
>         diff --git a/daemon/lookup.c b/daemon/lookup.c
>         index 741d846..b954045 100644
>         --- a/daemon/lookup.c
>         +++ b/daemon/lookup.c
>         @@ -283,10 +283,13 @@ static int do_read_map(struct
>         autofs_point *ap, struct map_source *map, time_t a
>                 * for the fail cases to function correctly and to
>         cache the
>                 * lookup handle.
>                 *
>         -        * We always need to whole map for direct mounts in
>         order to
>         -        * mount the triggers.
>         +        * We always need to read the whole map for direct
>         mounts in
>         +        * order to mount the triggers. We also want to read
>         the whole
>         +        * map if it's a file map to avoid potentially lengthy
>         linear
>         +        * file scanning.
>                 */
>         -       if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type !=
>         LKP_DIRECT)
>         +       if (strcmp(map->type, "file") ||
> 
> I suspect that you want && instead.

Yeah, I think that isn't quite right but I also think that && won't fix
it. I'll think on that one again.

> 
> 
>         +           (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type !=
>         LKP_DIRECT))
>                        return NSS_STATUS_SUCCESS;
>         
>                if (!map->stale)
>         diff --git a/modules/lookup_file.c b/modules/lookup_file.c
>         index 95b9f6f..9a1c39b 100644
>         --- a/modules/lookup_file.c
>         +++ b/modules/lookup_file.c
>         @@ -93,7 +93,6 @@ int lookup_init(const char *mapfmt, int
>         argc, const char *const *argv, void **co
>                             argv[0]);
>                        return 1;
>                }
>         -
>                ctxt->mtime = st.st_mtime;
>         
>                if (!mapfmt)
>         @@ -1064,7 +1063,16 @@ int lookup_mount(struct autofs_point
>         *ap, const char *name, int name_len, void *
>                if (ap->type == LKP_INDIRECT && *key != '/') {
>                        char *lkp_key;
>         
>         +               /*
>         +                * We can skip the map lookup and cache update
>         altogether
>         +                * if we know the map hasn't been modified
>         since it was
>         +                * last read.
>         +                */
>                        cache_readlock(mc);
>         +               me = cache_lookup_first(mc);
>         +               if (me && ctxt->mtime <= me->age)
> 
> You have to call stat(2) or fstat(2) at some point or else ctxt->mtime
> will never change.

We set the mtime when we read the entire map, see
modules/lookup_file.c:lookup_read_map(). This is totally taking
advantage of the existing code to read a map that is marked as stale. It
doesn't however attempt to simplify the code which works out if we need
to mark the map stale but we probably don't want to anyway as we need to
ensure we use up to date entries for lookups done while waiting for the
map update to be done. 

> 
> 
>         +                       goto do_lookup;
> 
> My brain is bleeding.
> 
> 
>         +
>                        me = cache_lookup_distinct(mc, key);
>                        if (me && me->multi)
>                                lkp_key = strdup(me->multi->key);
>         @@ -1088,6 +1096,7 @@ int lookup_mount(struct autofs_point
>         *ap, const char *name, int name_len, void *
>                }
>         
>                cache_readlock(mc);
>         +do_lookup:
>                me = cache_lookup(mc, key);
>                /* Stale mapent => check for entry in alternate source
>         or wildcard */
>                if (me && !me->mapent) {
>         
>         
> 
