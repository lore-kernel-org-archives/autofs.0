From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 15:55:36 +1100
Message-ID: <408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7418437237036798574=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
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

--===============7418437237036798574==
Content-Type: multipart/alternative; boundary=0016e64ed5ea4b25d604610b157c

--0016e64ed5ea4b25d604610b157c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

BTW, I'm still working through the analysis results. A few more problems
have turned up.


modules/lookup_hosts.c:
    119 int lookup_mount(struct autofs_point *ap, const char *name, int
name_len, void *context)
...
    146                 if (!me->mapent) {
    147                         cache_delete(me->mc, name);
    148                         me = NULL;
    149                 }
    150
    151                 cache_unlock(me->mc);

That is a NULL pointer dereference.


lib/macros.c:
    163 int macro_parse_globalvar(const char *define)
    164 {
    165         char buf[MAX_MACRO_STRING];
    166         char *pbuf, *value;
    167
    168         if (strlen(define) > MAX_MACRO_STRING)
    169                 return 0;
    170
    171         strcpy(buf, define);

That is a buffer overflow.


modules/parse_hesiod.c:
     84 static int parse_nfs(struct autofs_point *ap,
...
    108         for (i = 0; (!isspace(p[i]) && i < (int) sizeof(mount));
i++) {
    109                 mount[i] = p[i];
    110         }
    111
    112         mount[i] = 0;
    113         p += i;

That is a buffer overflow. There are six more loops with similar problems.


daemon/indirect.c:
     86 static int do_mount_autofs_indirect(struct autofs_point *ap, const
char *root)
...
    160         free(options);
    161
    162         ret = stat(root, &st);
    163         if (ret == -1) {
    164                 crit(ap->logopt,
    165                      "failed to stat mount for autofs path %s",
ap->path);
    166                 goto out_umount;
    167         }
...
    185 out_umount:
    186         umount(root);
    187 out_rmdir:
    188         if (ap->flags & MOUNT_FLAG_DIR_CREATED)
    189                 rmdir(root);
    190 out_err:
    191         if (options)
    192                 free(options);

That is a double free(3) call.


lib/cache.c:
    180 struct mapent_cache *cache_init(struct autofs_point *ap, struct
map_source *map)
...
    195         mc->hash = malloc(mc->size * sizeof(struct entry *));
...
    231 struct mapent_cache *cache_init_null_cache(struct master *master)
...
    246         mc->hash = malloc(mc->size * sizeof(struct entry *));

`struct mapent *' might be more correct. ;)

--0016e64ed5ea4b25d604610b157c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

BTW, I&#39;m still working through the analysis results. A few more problem=
s have turned up.<br><br><br>modules/lookup_hosts.c:<br>&nbsp;&nbsp;&nbsp; =
119 int lookup_mount(struct autofs_point *ap, const char *name, int name_le=
n, void *context)<br>
...<br>&nbsp;&nbsp;&nbsp; 146&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!me-&gt;mapent) {<br=
>&nbsp;&nbsp;&nbsp; 147&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cache_delete(me-&gt;mc, name);<br>&nbsp;&nbsp;&nbsp; 148&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me =3D=
 NULL;<br>&nbsp;&nbsp;&nbsp; 149&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbs=
p; 150<br>&nbsp;&nbsp;&nbsp; 151&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache_unlock(me-&gt;m=
c);<br>
<br>That is a NULL pointer dereference.<br><br><br>lib/macros.c:<br>&nbsp;&=
nbsp;&nbsp; 163 int macro_parse_globalvar(const char *define)<br>&nbsp;&nbs=
p;&nbsp; 164 {<br>&nbsp;&nbsp;&nbsp; 165&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; char buf[MAX_MACRO_STRING];<br>&nbsp;&nbsp;&nbsp; 166&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *pbuf, *value;<br>
&nbsp;&nbsp;&nbsp; 167<br>&nbsp;&nbsp;&nbsp; 168&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (strlen(define) &gt; MAX_MACRO_STRING)<br>&nbsp;&n=
bsp;&nbsp; 169&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&nbsp;&nbsp;&nbsp; 170<br>=
&nbsp;&nbsp;&nbsp; 171&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strc=
py(buf, define);<br><br>That is a buffer overflow.<br><br><br>modules/parse=
_hesiod.c:<br>
&nbsp;&nbsp;&nbsp;&nbsp; 84 static int parse_nfs(struct autofs_point *ap,<b=
r>...<br>&nbsp;&nbsp;&nbsp; 108&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; for (i =3D 0; (!isspace(p[i]) &amp;&amp; i &lt; (int) sizeof(mount)); =
i++) {<br>&nbsp;&nbsp;&nbsp; 109&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount[i] =3D p[i];<br=
>&nbsp;&nbsp;&nbsp; 110&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 111<br>&nbsp;&nbsp;&nbsp; 112&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mount[i] =3D 0;<br>&nbsp;&nbsp;&nbsp; 113&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p +=3D i;<br><br>That is a buffer over=
flow. There are six more loops with similar problems.<br><br><br>daemon/ind=
irect.c:<br>&nbsp;&nbsp;&nbsp;&nbsp; 86 static int do_mount_autofs_indirect=
(struct autofs_point *ap, const char *root)<br>
...<br>&nbsp;&nbsp;&nbsp; 160&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; free(options);<br>&nbsp;&nbsp;&nbsp; 161<br>&nbsp;&nbsp;&nbsp; 162&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D stat(root, &amp;st);<br>=
&nbsp;&nbsp;&nbsp; 163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ret =3D=3D -1) {<br>&nbsp;&nbsp;&nbsp; 164&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crit(ap-&gt=
;logopt,<br>&nbsp;&nbsp;&nbsp; 165&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;failed to stat mount for autofs path %s&quot;, ap-&gt;path=
);<br>
&nbsp;&nbsp;&nbsp; 166&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_umount;<br>&nbsp;&nbsp=
;&nbsp; 167&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>...<br>&nb=
sp;&nbsp;&nbsp; 185 out_umount:<br>&nbsp;&nbsp;&nbsp; 186&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount(root);<br>&nbsp;&nbsp;&nbsp; 187 out_=
rmdir:<br>&nbsp;&nbsp;&nbsp; 188&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ap-&gt;flags &amp; MOUNT_FLAG_DIR_CREATED)<br>&nbsp;&nbsp;&nbsp; =
189&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; rmdir(root);<br>
&nbsp;&nbsp;&nbsp; 190 out_err:<br>&nbsp;&nbsp;&nbsp; 191&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (options)<br>&nbsp;&nbsp;&nbsp; 192&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; free(options);<br><br>That is a double free(3) call.<br><br=
><br>lib/cache.c:<br>&nbsp;&nbsp;&nbsp; 180 struct mapent_cache *cache_init=
(struct autofs_point *ap, struct map_source *map)<br>
...<br>&nbsp;&nbsp;&nbsp; 195&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; mc-&gt;hash =3D malloc(mc-&gt;size * sizeof(struct entry *));<br>...<br>=
&nbsp;&nbsp;&nbsp; 231 struct mapent_cache *cache_init_null_cache(struct ma=
ster *master)<br>...<br>&nbsp;&nbsp;&nbsp; 246&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mc-&gt;hash =3D malloc(mc-&gt;size * sizeof(struct entr=
y *));<br>
<br>`struct mapent *&#39; might be more correct. ;)<br>

--0016e64ed5ea4b25d604610b157c--


--===============7418437237036798574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7418437237036798574==--

