From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] autofs-5.0.4 - always read file maps
Date: Tue, 20 Jan 2009 12:31:11 +1100
Message-ID: <408431290901191731l446ae961md66abc8b1eac63f7@mail.gmail.com>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
	<20090119122438.31454.99701.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3333960594703658338=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090119122438.31454.99701.stgit@zeus.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

--===============3333960594703658338==
Content-Type: multipart/alternative; boundary=0016e652fe7e96494d0460dffe89

--0016e652fe7e96494d0460dffe89
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jan 19, 2009 at 11:24 PM, Ian Kent <raven@themaw.net> wrote:

autofs tries to not load an entire map into the internal cache unless it
> has to. For maps that do get loaded into the cache it relies on checks to
> work out if a map is up to date in order to trigger a map read. This is
> fine for maps that can do direct key lookups but file maps need to do a
> linear search through the file when locating an entry for a key. For large
> maps this can be a huge overhead. This patch make autofs always load file
> based maps at start and makes use of the map file mtime to discover if the
> cache needs to be refreshed.
> ---
>
>  daemon/lookup.c       |    9 +++++--
>  modules/lookup_file.c |   59
> +++++++++++++++++--------------------------------
>  2 files changed, 27 insertions(+), 41 deletions(-)
>
> diff --git a/daemon/lookup.c b/daemon/lookup.c
> index 741d846..e034348 100644
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
> +       if (strcmp(map->type, "file") &&
> +           !(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT)
>                return NSS_STATUS_SUCCESS;
>
>        if (!map->stale)
> diff --git a/modules/lookup_file.c b/modules/lookup_file.c
> index 95b9f6f..7672725 100644
> --- a/modules/lookup_file.c
> +++ b/modules/lookup_file.c
> @@ -44,7 +44,6 @@ typedef enum { esc_none, esc_char, esc_val, esc_all }
> ESCAPES;
>
>  struct lookup_context {
>        const char *mapname;
> -       time_t mtime;
>        struct parse_mod *parse;
>  };
>
> @@ -54,7 +53,6 @@ int lookup_init(const char *mapfmt, int argc, const char
> *const *argv, void **co
>  {
>        struct lookup_context *ctxt;
>        char buf[MAX_ERR_BUF];
> -       struct stat st;
>
>        *context = NULL;
>
> @@ -87,15 +85,6 @@ int lookup_init(const char *mapfmt, int argc, const char
> *const *argv, void **co
>                return 1;
>        }
>
> -       if (stat(ctxt->mapname, &st)) {
> -               free(ctxt);
> -               logmsg(MODPREFIX "file map %s, could not stat",
> -                    argv[0]);
> -               return 1;
> -       }
> -
> -       ctxt->mtime = st.st_mtime;
> -
>        if (!mapfmt)
>                mapfmt = MAPFMT_DEFAULT;
>
> @@ -391,7 +380,6 @@ int lookup_read_master(struct master *master, time_t
> age, void *context)
>        int blen;
>        char *path;
>        char *ent;
> -       struct stat st;
>        FILE *f;
>        int fd;


You should be able to get rid of `fd' and the fileno(3) call now.

       unsigned int path_len, ent_len;
> @@ -504,13 +492,6 @@ int lookup_read_master(struct master *master, time_t
> age, void *context)
>                        break;
>        }
>
> -       if (fstat(fd, &st)) {
> -               crit(logopt, MODPREFIX "file map %s, could not stat",
> -                      ctxt->mapname);
> -               return NSS_STATUS_UNAVAIL;
> -       }
> -       ctxt->mtime = st.st_mtime;
> -
>        fclose(f);
>
>        return NSS_STATUS_SUCCESS;
> @@ -642,7 +623,6 @@ int lookup_read_map(struct autofs_point *ap, time_t
> age, void *context)
>        struct mapent_cache *mc;
>        char *key;
>        char *mapent;
> -       struct stat st;
>        FILE *f;
>        int fd;


You should be able to get rid of `fd' and the fileno(3) call now.

       unsigned int k_len, m_len;
> @@ -748,13 +728,6 @@ int lookup_read_map(struct autofs_point *ap, time_t
> age, void *context)
>                        break;
>        }
>
> -       if (fstat(fd, &st)) {
> -               crit(ap->logopt,
> -                    MODPREFIX "file map %s, could not stat",
> -                    ctxt->mapname);
> -               return NSS_STATUS_UNAVAIL;
> -       }
> -       ctxt->mtime = st.st_mtime;
>        source->age = age;
>
>        fclose(f);
> @@ -951,9 +924,6 @@ static int check_map_indirect(struct autofs_point *ap,
>        if (ret == CHE_FAIL)
>                return NSS_STATUS_NOTFOUND;
>
> -       if (ret & CHE_UPDATED)
> -               source->stale = 1;
> -
>        pthread_cleanup_push(cache_lock_cleanup, mc);
>        cache_writelock(mc);
>        exists = cache_lookup_distinct(mc, key);
> @@ -963,7 +933,6 @@ static int check_map_indirect(struct autofs_point *ap,
>                        free(exists->mapent);
>                        exists->mapent = NULL;
>                        exists->status = 0;
> -                       source->stale = 1;
>                }
>        }
>        pthread_cleanup_pop(1);
> @@ -985,14 +954,8 @@ static int check_map_indirect(struct autofs_point *ap,
>                we = cache_lookup_distinct(mc, "*");
>                if (we) {
>                        /* Wildcard entry existed and is now gone */
> -                       if (we->source == source && (wild & CHE_MISSING)) {
> +                       if (we->source == source && (wild & CHE_MISSING))
>                                cache_delete(mc, "*");
> -                               source->stale = 1;
> -                       }
> -               } else {
> -                       /* Wildcard not in map but now is */
> -                       if (wild & (CHE_OK | CHE_UPDATED))
> -                               source->stale = 1;
>                }
>                pthread_cleanup_pop(1);
>
> @@ -1062,9 +1025,28 @@ int lookup_mount(struct autofs_point *ap, const char
> *name, int name_len, void *
>         * we never know about it.
>         */
>        if (ap->type == LKP_INDIRECT && *key != '/') {
> +               struct stat st;
>                char *lkp_key;
>
> +               /*
> +                * We can skip the map lookup and cache update altogether
> +                * if we know the map hasn't been modified since it was
> +                * last read. If it has then we can mark the map stale
> +                * so a re-read is triggered following the lookup.
> +                */
> +               if (stat(ctxt->mapname, &st)) {
> +                       error(ap->logopt, MODPREFIX
> +                             "file map %s, could not stat",
> ctxt->mapname);
> +                       return NSS_STATUS_UNAVAIL;
> +               }
> +
>                cache_readlock(mc);
> +               me = cache_lookup_first(mc);
> +               if (me && st.st_mtime <= me->age)
> +                       goto do_cache_lookup;
> +               else
> +                       source->stale = 1;


Perhaps some output for debugging purposes wouldn't go astray?

+
>                me = cache_lookup_distinct(mc, key);
>                if (me && me->multi)
>                        lkp_key = strdup(me->multi->key);
> @@ -1088,6 +1070,7 @@ int lookup_mount(struct autofs_point *ap, const char
> *name, int name_len, void *
>        }
>
>        cache_readlock(mc);
> +do_cache_lookup:
>        me = cache_lookup(mc, key);
>        /* Stale mapent => check for entry in alternate source or wildcard
> */
>        if (me && !me->mapent) {
>
>

--0016e652fe7e96494d0460dffe89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Jan 19, 2009 at 11:24 PM, Ian Kent <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&g=
t;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
autofs tries to not load an entire map into the internal cache unless it<br=
>
has to. For maps that do get loaded into the cache it relies on checks to<b=
r>
work out if a map is up to date in order to trigger a map read. This is<br>
fine for maps that can do direct key lookups but file maps need to do a<br>
linear search through the file when locating an entry for a key. For large<=
br>
maps this can be a huge overhead. This patch make autofs always load file<b=
r>
based maps at start and makes use of the map file mtime to discover if the<=
br>
cache needs to be refreshed.<br>
---<br>
<br>
&nbsp;daemon/lookup.c &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp;9 +++++--<br>
&nbsp;modules/lookup_file.c | &nbsp; 59 +++++++++++++++++------------------=
--------------<br>
&nbsp;2 files changed, 27 insertions(+), 41 deletions(-)<br>
<br>
diff --git a/daemon/lookup.c b/daemon/lookup.c<br>
index 741d846..e034348 100644<br>
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
+ &nbsp; &nbsp; &nbsp; if (strcmp(map-&gt;type, &quot;file&quot;) &amp;&amp=
;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; !(ap-&gt;flags &amp; MOUNT_FLAG_GHOST)=
 &amp;&amp; ap-&gt;type !=3D LKP_DIRECT)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return NSS_STATUS_S=
UCCESS;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!map-&gt;stale)<br>
diff --git a/modules/lookup_file.c b/modules/lookup_file.c<br>
index 95b9f6f..7672725 100644<br>
--- a/modules/lookup_file.c<br>
+++ b/modules/lookup_file.c<br>
@@ -44,7 +44,6 @@ typedef enum { esc_none, esc_char, esc_val, esc_all } ESC=
APES;<br>
<br>
&nbsp;struct lookup_context {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;const char *mapname;<br>
- &nbsp; &nbsp; &nbsp; time_t mtime;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct parse_mod *parse;<br>
&nbsp;};<br>
<br>
@@ -54,7 +53,6 @@ int lookup_init(const char *mapfmt, int argc, const char =
*const *argv, void **co<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct lookup_context *ctxt;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;char buf[MAX_ERR_BUF];<br>
- &nbsp; &nbsp; &nbsp; struct stat st;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;*context =3D NULL;<br>
<br>
@@ -87,15 +85,6 @@ int lookup_init(const char *mapfmt, int argc, const char=
 *const *argv, void **co<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; if (stat(ctxt-&gt;mapname, &amp;st)) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; free(ctxt);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; logmsg(MODPREFIX &quot;f=
ile map %s, could not stat&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;argv=
[0]);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 1;<br>
- &nbsp; &nbsp; &nbsp; }<br>
-<br>
- &nbsp; &nbsp; &nbsp; ctxt-&gt;mtime =3D st.st_mtime;<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!mapfmt)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mapfmt =3D MAPFMT_D=
EFAULT;<br>
<br>
@@ -391,7 +380,6 @@ int lookup_read_master(struct master *master, time_t ag=
e, void *context)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int blen;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;char *path;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;char *ent;<br>
- &nbsp; &nbsp; &nbsp; struct stat st;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FILE *f;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int fd;</blockquote><div><br>You should be able=
 to get rid of `fd&#39; and the fileno(3) call now.<br><br></div><blockquot=
e class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204);=
 margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp; &nbsp; &nbsp;&nbsp; unsigned int path_len, ent_len;<br>
@@ -504,13 +492,6 @@ int lookup_read_master(struct master *master, time_t a=
ge, void *context)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; if (fstat(fd, &amp;st)) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; crit(logopt, MODPREFIX &=
quot;file map %s, could not stat&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;ctxt-&gt;mapname);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return NSS_STATUS_UNAVAI=
L;<br>
- &nbsp; &nbsp; &nbsp; }<br>
- &nbsp; &nbsp; &nbsp; ctxt-&gt;mtime =3D st.st_mtime;<br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp;fclose(f);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return NSS_STATUS_SUCCESS;<br>
@@ -642,7 +623,6 @@ int lookup_read_map(struct autofs_point *ap, time_t age=
, void *context)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct mapent_cache *mc;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;char *key;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;char *mapent;<br>
- &nbsp; &nbsp; &nbsp; struct stat st;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FILE *f;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int fd;</blockquote><div><br>You should be able=
 to get rid of `fd&#39; and the fileno(3) call now.<br><br></div><blockquot=
e class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204);=
 margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp; &nbsp; &nbsp;&nbsp; unsigned int k_len, m_len;<br>
@@ -748,13 +728,6 @@ int lookup_read_map(struct autofs_point *ap, time_t ag=
e, void *context)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; if (fstat(fd, &amp;st)) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; crit(ap-&gt;logopt,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;MODP=
REFIX &quot;file map %s, could not stat&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctxt=
-&gt;mapname);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return NSS_STATUS_UNAVAI=
L;<br>
- &nbsp; &nbsp; &nbsp; }<br>
- &nbsp; &nbsp; &nbsp; ctxt-&gt;mtime =3D st.st_mtime;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;source-&gt;age =3D age;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;fclose(f);<br>
@@ -951,9 +924,6 @@ static int check_map_indirect(struct autofs_point *ap,<=
br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ret =3D=3D CHE_FAIL)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return NSS_STATUS_N=
OTFOUND;<br>
<br>
- &nbsp; &nbsp; &nbsp; if (ret &amp; CHE_UPDATED)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; source-&gt;stale =3D 1;<=
br>
-<br>
 &nbsp; &nbsp; &nbsp; &nbsp;pthread_cleanup_push(cache_lock_cleanup, mc);<b=
r>
 &nbsp; &nbsp; &nbsp; &nbsp;cache_writelock(mc);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;exists =3D cache_lookup_distinct(mc, key);<br>
@@ -963,7 +933,6 @@ static int check_map_indirect(struct autofs_point *ap,<=
br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;free(exists-&gt;mapent);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;exists-&gt;mapent =3D NULL;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;exists-&gt;status =3D 0;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; source-&gt;stale =3D 1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp;pthread_cleanup_pop(1);<br>
@@ -985,14 +954,8 @@ static int check_map_indirect(struct autofs_point *ap,=
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;we =3D cache_lookup=
_distinct(mc, &quot;*&quot;);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (we) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;/* Wildcard entry existed and is now gone */<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; if (we-&gt;source =3D=3D source &amp;&amp; (wild &amp; CHE_MISSING)) {<=
br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; if (we-&gt;source =3D=3D source &amp;&amp; (wild &amp; CHE_MISSING))<br=
>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cache_delete(mc, &quot;*&quot;);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; source-&gt;stale =3D 1;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; }<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; /* Wildcard not in map but now is */<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; if (wild &amp; (CHE_OK | CHE_UPDATED))<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; source-&gt;stale =3D 1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pthread_cleanup_pop=
(1);<br>
<br>
@@ -1062,9 +1025,28 @@ int lookup_mount(struct autofs_point *ap, const char=
 *name, int name_len, void *<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * we never know about it.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ap-&gt;type =3D=3D LKP_INDIRECT &amp;&amp; =
*key !=3D &#39;/&#39;) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct stat st;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char *lkp_key;<br>
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* We can skip the =
map lookup and cache update altogether<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* if we know the m=
ap hasn&#39;t been modified since it was<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* last read. If it=
 has then we can mark the map stale<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* so a re-read is =
triggered following the lookup.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (stat(ctxt-&gt;mapnam=
e, &amp;st)) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; error(ap-&gt;logopt, MODPREFIX<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &quot;file map %s, could not stat&quot;, ctxt-&gt;=
mapname);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; return NSS_STATUS_UNAVAIL;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cache_readlock(mc);=
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; me =3D cache_lookup_firs=
t(mc);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (me &amp;&amp; st.st_=
mtime &lt;=3D me-&gt;age)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; goto do_cache_lookup;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; else<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; source-&gt;stale =3D 1;</blockquote><div><br>Perhaps some output for de=
bugging purposes wouldn&#39;t go astray?<br><br></div><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;me =3D cache_lookup=
_distinct(mc, key);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (me &amp;&amp; m=
e-&gt;multi)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;lkp_key =3D strdup(me-&gt;multi-&gt;key);<br>
@@ -1088,6 +1070,7 @@ int lookup_mount(struct autofs_point *ap, const char =
*name, int name_len, void *<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;cache_readlock(mc);<br>
+do_cache_lookup:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;me =3D cache_lookup(mc, key);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Stale mapent =3D&gt; check for entry in alte=
rnate source or wildcard */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (me &amp;&amp; !me-&gt;mapent) {<br>
<br>
</blockquote></div><br>

--0016e652fe7e96494d0460dffe89--


--===============3333960594703658338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3333960594703658338==--

