From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 14:59:49 +1100
Message-ID: <408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1985382474744970208=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232070195.3166.36.camel@zeus.themaw.net>
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

--===============1985382474744970208==
Content-Type: multipart/alternative; boundary=0016e652f714b84b130460919a3c

--0016e652f714b84b130460919a3c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jan 16, 2009 at 12:43 PM, Ian Kent <raven@themaw.net> wrote:

> > > If we can simply flag the cached version as stale, then lazy reloads
> > > > should be possible.
> > >
> > > Maybe not.
> > >
> > > The layer of code above the lookup modules does the re-loads but it is
> > > general wrt. the map type so for a "nobrowse" map it won't read the
> map.
> > > I'm not sure yet that putting special case exceptions in that code is a
> > > good thing to do or even straight forward. But, for the large map case,
> >
> > Or maybe I'm talking nonsense as it looks like I've actually got plenty
> > of map type context in the layer above, hehe.
> >
> > > we can consider reading the entire map an expensive operation, so if we
> > > did change the layer above and we found the map needed to be modified
> > > then marked the map as stale we would need to scan the file map for the
> > > key (as the map is out of date) and then read the whole map later. That
> > > means we would end up reading the map at least one and a half times (on
> > > average) instead of once (assuming no lookups between marking the map
> > > stale and re-reading).
> > >
> > > I'm tending toward reading the map during the lookup so the map is up
> to
> > > date when we look for the key in the cache.
>
> Or maybe not.
>
> If we take advantage of the existing code to mark the map as stale and
> handle the re-read and we accept the overhead of scanning the file map
> while waiting for the update something like this could be all that's
> needed.
>
> autofs-5.0.4 - always read file maps
>
> From: Ian Kent <raven@themaw.net>
>
>
> ---
>
>  daemon/lookup.c       |    9 ++++++---
>  modules/lookup_file.c |   11 ++++++++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
>
> diff --git a/daemon/lookup.c b/daemon/lookup.c
> index 741d846..b954045 100644
> --- a/daemon/lookup.c
> +++ b/daemon/lookup.c
> @@ -283,10 +283,13 @@ static int do_read_map(struct autofs_point *ap,
> struct map_source *map, time_t a
>         * for the fail cases to function correctly and to cache the
>         * lookup handle.
>         *
> -        * We always need to whole map for direct mounts in order to
> -        * mount the triggers.
> +        * We always need to read the whole map for direct mounts in
> +        * order to mount the triggers. We also want to read the whole
> +        * map if it's a file map to avoid potentially lengthy linear
> +        * file scanning.
>         */
> -       if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT)
> +       if (strcmp(map->type, "file") ||


I suspect that you want && instead.

+           (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT))
>                return NSS_STATUS_SUCCESS;
>
>        if (!map->stale)
> diff --git a/modules/lookup_file.c b/modules/lookup_file.c
> index 95b9f6f..9a1c39b 100644
> --- a/modules/lookup_file.c
> +++ b/modules/lookup_file.c
> @@ -93,7 +93,6 @@ int lookup_init(const char *mapfmt, int argc, const char
> *const *argv, void **co
>                     argv[0]);
>                return 1;
>        }
> -
>        ctxt->mtime = st.st_mtime;
>
>        if (!mapfmt)
> @@ -1064,7 +1063,16 @@ int lookup_mount(struct autofs_point *ap, const char
> *name, int name_len, void *
>        if (ap->type == LKP_INDIRECT && *key != '/') {
>                char *lkp_key;
>
> +               /*
> +                * We can skip the map lookup and cache update altogether
> +                * if we know the map hasn't been modified since it was
> +                * last read.
> +                */
>                cache_readlock(mc);
> +               me = cache_lookup_first(mc);
> +               if (me && ctxt->mtime <= me->age)


You have to call stat(2) or fstat(2) at some point or else ctxt->mtime will
never change.

+                       goto do_lookup;


My brain is bleeding.

+
>                me = cache_lookup_distinct(mc, key);
>                if (me && me->multi)
>                        lkp_key = strdup(me->multi->key);
> @@ -1088,6 +1096,7 @@ int lookup_mount(struct autofs_point *ap, const char
> *name, int name_len, void *
>        }
>
>        cache_readlock(mc);
> +do_lookup:
>        me = cache_lookup(mc, key);
>        /* Stale mapent => check for entry in alternate source or wildcard
> */
>        if (me && !me->mapent) {
>
>
>

--0016e652f714b84b130460919a3c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 16, 2009 at 12:43 PM, Ian Kent <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&g=
t;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
&gt; &gt; &gt; If we can simply flag the cached version as stale, then lazy=
 reloads<br>
&gt; &gt; &gt; should be possible.<br>
&gt; &gt;<br>
&gt; &gt; Maybe not.<br>
&gt; &gt;<br>
&gt; &gt; The layer of code above the lookup modules does the re-loads but =
it is<br>
&gt; &gt; general wrt. the map type so for a &quot;nobrowse&quot; map it wo=
n&#39;t read the map.<br>
&gt; &gt; I&#39;m not sure yet that putting special case exceptions in that=
 code is a<br>
&gt; &gt; good thing to do or even straight forward. But, for the large map=
 case,<br>
&gt;<br>
&gt; Or maybe I&#39;m talking nonsense as it looks like I&#39;ve actually g=
ot plenty<br>
&gt; of map type context in the layer above, hehe.<br>
&gt;<br>
&gt; &gt; we can consider reading the entire map an expensive operation, so=
 if we<br>
&gt; &gt; did change the layer above and we found the map needed to be modi=
fied<br>
&gt; &gt; then marked the map as stale we would need to scan the file map f=
or the<br>
&gt; &gt; key (as the map is out of date) and then read the whole map later=
. That<br>
&gt; &gt; means we would end up reading the map at least one and a half tim=
es (on<br>
&gt; &gt; average) instead of once (assuming no lookups between marking the=
 map<br>
&gt; &gt; stale and re-reading).<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m tending toward reading the map during the lookup so the m=
ap is up to<br>
&gt; &gt; date when we look for the key in the cache.<br>
<br>
Or maybe not.<br>
<br>
If we take advantage of the existing code to mark the map as stale and<br>
handle the re-read and we accept the overhead of scanning the file map<br>
while waiting for the update something like this could be all that&#39;s<br=
>
needed.<br>
<br>
autofs-5.0.4 - always read file maps<br>
<br>
From: Ian Kent &lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>=
&gt;<br>
<br>
<br>
---<br>
<br>
&nbsp;daemon/lookup.c &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp;9 ++++++---<br>
&nbsp;modules/lookup_file.c | &nbsp; 11 ++++++++++-<br>
&nbsp;2 files changed, 16 insertions(+), 4 deletions(-)<br>
<br>
<br>
diff --git a/daemon/lookup.c b/daemon/lookup.c<br>
index 741d846..b954045 100644<br>
--- a/daemon/lookup.c<br>
+++ b/daemon/lookup.c<br>
@@ -283,10 +283,13 @@ static int do_read_map(struct autofs_point *ap, struc=
t map_source *map, time_t a<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * for the fail cases to function correctly and=
 to cache the<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * lookup handle.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; *<br>
- &nbsp; &nbsp; &nbsp; &nbsp;* We always need to whole map for direct mount=
s in order to<br>
- &nbsp; &nbsp; &nbsp; &nbsp;* mount the triggers.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* We always need to read the whole map for dir=
ect mounts in<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* order to mount the triggers. We also want to=
 read the whole<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* map if it&#39;s a file map to avoid potentia=
lly lengthy linear<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* file scanning.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
- &nbsp; &nbsp; &nbsp; if (!(ap-&gt;flags &amp; MOUNT_FLAG_GHOST) &amp;&amp=
; ap-&gt;type !=3D LKP_DIRECT)<br>
+ &nbsp; &nbsp; &nbsp; if (strcmp(map-&gt;type, &quot;file&quot;) ||</block=
quote><div><br>I suspect that you want &amp;&amp; instead.<br><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204=
, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (!(ap-&gt;flags &amp; MOUNT_FLAG_GHOST=
) &amp;&amp; ap-&gt;type !=3D LKP_DIRECT))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return NSS_STATUS_S=
UCCESS;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!map-&gt;stale)<br>
diff --git a/modules/lookup_file.c b/modules/lookup_file.c<br>
index 95b9f6f..9a1c39b 100644<br>
--- a/modules/lookup_file.c<br>
+++ b/modules/lookup_file.c<br>
@@ -93,7 +93,6 @@ int lookup_init(const char *mapfmt, int argc, const char =
*const *argv, void **co<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; argv=
[0]);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp;ctxt-&gt;mtime =3D st.st_mtime;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!mapfmt)<br>
@@ -1064,7 +1063,16 @@ int lookup_mount(struct autofs_point *ap, const char=
 *name, int name_len, void *<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ap-&gt;type =3D=3D LKP_INDIRECT &amp;&amp; =
*key !=3D &#39;/&#39;) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char *lkp_key;<br>
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* We can skip the =
map lookup and cache update altogether<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* if we know the m=
ap hasn&#39;t been modified since it was<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* last read.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cache_readlock(mc);=
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; me =3D cache_lookup_firs=
t(mc);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (me &amp;&amp; ctxt-&=
gt;mtime &lt;=3D me-&gt;age)</blockquote><div><br>You have to call stat(2) =
or fstat(2) at some point or else ctxt-&gt;mtime will never change.<br><br>=
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; goto do_lookup;</blockquote><div><br>My brain is bleeding.<br><br></div=
><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,=
 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;me =3D cache_lookup=
_distinct(mc, key);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (me &amp;&amp; m=
e-&gt;multi)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;lkp_key =3D strdup(me-&gt;multi-&gt;key);<br>
@@ -1088,6 +1096,7 @@ int lookup_mount(struct autofs_point *ap, const char =
*name, int name_len, void *<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;cache_readlock(mc);<br>
+do_lookup:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;me =3D cache_lookup(mc, key);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Stale mapent =3D&gt; check for entry in alte=
rnate source or wildcard */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (me &amp;&amp; !me-&gt;mapent) {<br>
<br>
<br>
</blockquote></div><br>

--0016e652f714b84b130460919a3c--


--===============1985382474744970208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1985382474744970208==--

