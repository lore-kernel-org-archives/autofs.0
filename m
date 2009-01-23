From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Fri, 23 Jan 2009 13:00:54 +1100
Message-ID: <408431290901221800y3c008d5dib66b2786e832c086@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
	<1232604292.3239.17.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556139333447851109=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232604292.3239.17.camel@zeus.themaw.net>
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

--===============0556139333447851109==
Content-Type: multipart/alternative; boundary=0016e65385c853e28d04611cc281

--0016e65385c853e28d04611cc281
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 daemon/direct.c:
   1045 int handle_packet_expire_direct(struct autofs_point *ap,
autofs_packet_expire_direct_t *pkt)
...
   1087                 crit(ap->logopt, "can't find map entry for
(%lu,%lu)",
   1088                     (unsigned long) pkt->dev, (unsigned long)
pkt->ino);
   1089                 master_source_unlock(ap->entry);
   1090                 master_mutex_unlock();
   1091                 pthread_setcancelstate(state, NULL);
   1092                 return 1;
...
   1099                 if (ioctlfd == -1) {
   1100                         crit(ap->logopt, "can't open ioctlfd for
%s",
   1101                              me->key);
   1102                         pthread_setcancelstate(state, NULL);
   1103                         return 1;
   1104                 }

`mc->rwlock' and `ap->entry->source_lock' are still held at line 1103.

Also, is line 1090 unlocking the right thing?


modules/lookup_multi.c:
    137 int lookup_init(const char *my_mapfmt, int argc, const char *const
*argv, void **context)
...
    162         if (!(ctxt->m = malloc(ctxt->n * sizeof(struct
module_info))) ||
    163             !(ctxt->argl = malloc((argc + 1) * sizeof(const char
*))))
    164                 goto nomem;
...
    210 nomem:
    211         estr = strerror_r(errno, buf, MAX_ERR_BUF);
    212         logerr(MODPREFIX "error: %s", estr);
    213 error_out:
    214         if (ctxt) {
    215                 for (i = 0; i < ctxt->n; i++) {
    216                         if (ctxt->m[i].mod)
    217                                 close_lookup(ctxt->m[i].mod);
    218                         if (ctxt->m[i].argv)
    219                                 free_argv(ctxt->m[i].argc,
ctxt->m[i].argv);
    220                 }

`ctxt->m' is unchecked within the loop.


modules/lookup_program.c:
    106 int lookup_mount(struct autofs_point *ap, const char *name, int
name_len, void *context)
...
    199         mapent = (char *) malloc(MAPENT_MAX_LEN + 1);
...
    395         cache_writelock(mc);
    396         ret = cache_update(mc, source, name, mapent, time(NULL));
    397         cache_unlock(mc);
    398         if (ret == CHE_FAIL)
    399                 return NSS_STATUS_UNAVAIL;

That is a memory leak.


modules/mount_nfs.c:
     57 int mount_mount(struct autofs_point *ap, const char *root, const
char *name, int name_len,
...
    223                 loc = malloc(strlen(this->name) + 1 +
strlen(this->path) + 1);
    224                 strcpy(loc, this->name);
    225                 strcat(loc, ":");
    226                 strcat(loc, this->path);

That is an unchecked malloc(3) call.


lib/mounts.c:
    206 struct mnt_list *get_mnt_list(const char *table, const char *path,
int include)
...
    265                 ent->path = malloc(len + 1);
    266                 if (!ent->path) {
    267                         endmntent(tab);
    268                         free_mnt_list(list);
    269                         return NULL;
    270                 }
    271                 strcpy(ent->path, mnt->mnt_dir);
    272
    273                 ent->fs_name = malloc(strlen(mnt->mnt_fsname) + 1);
    274                 if (!ent->fs_name) {
    275                         endmntent(tab);
    276                         free_mnt_list(list);
    277                         return NULL;
    278                 }
    279                 strcpy(ent->fs_name, mnt->mnt_fsname);
    280
    281                 ent->fs_type = malloc(strlen(mnt->mnt_type) + 1);
    282                 if (!ent->fs_type) {
    283                         endmntent(tab);
    284                         free_mnt_list(list);
    285                         return NULL;
    286                 }
    287                 strcpy(ent->fs_type, mnt->mnt_type);
    288
    289                 ent->opts = malloc(strlen(mnt->mnt_opts) + 1);
    290                 if (!ent->opts) {
    291                         endmntent(tab);
    292                         free_mnt_list(list);
    293                         return NULL;
    294                 }
    295                 strcpy(ent->opts, mnt->mnt_opts);
...
    659 struct mnt_list *tree_make_mnt_tree(const char *table, const char
*path)
...
    705                 ent->path = malloc(len + 1);
    706                 if (!ent->path) {
    707                         endmntent(tab);
    708                         tree_free_mnt_tree(tree);
    709                         return NULL;
    710                 }
    711                 strcpy(ent->path, mnt->mnt_dir);

Those are memory leaks. (`ent' isn't cleaned up and/or freed.)

Also, strdup(3) is useful. :P


modules/parse_sun.c:
    840 static int parse_mapent(const char *ent, char *g_options, char
**options, char **location, int logopt)
...
    895         if (*p == '/') {
    896                 warn(logopt, MODPREFIX "error location begins with
\"/\"");
    897                 free(myoptions);
    898                 return 0;
    899         }
...
   1316 int parse_mount(struct autofs_point *ap, const char *name,
...
   1637                 if (*p == '/') {
   1638                         free(options);
   1639                         warn(ap->logopt,
   1640                               MODPREFIX "error location begins with
\"/\"");
   1641                         return 1;
   1642                 }

Those are memory leaks. (`loc' isn't freed.)


modules/parse_sun.c:
    266 int parse_init(int argc, const char *const *argv, void **context)
...
    387                         } else {
    388                                 noptstr = (char *) malloc(len + 1);
    389                                 strcpy(noptstr, argv[i] + offset);
    390                                 optlen = len;
    391                         }

That is an unchecked malloc(3) call.

--0016e65385c853e28d04611cc281
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable








daemon/direct.c:<br>&nbsp;&nbsp; 1045 int handle_packet_expire_direct(struc=
t autofs_point *ap, autofs_packet_expire_direct_t *pkt)<br>...<br>&nbsp;&nb=
sp; 1087&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crit(ap-&gt;logopt, &quot;can&#39;t find map =
entry for (%lu,%lu)&quot;,<br>









&nbsp;&nbsp; 1088&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned lo=
ng) pkt-&gt;dev, (unsigned long) pkt-&gt;ino);<br>&nbsp;&nbsp; 1089&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; master_source_unlock(ap-&gt;entry);<br>&nbsp;&nbsp; 1090&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; master_mutex_unlock();<br>&nbsp;&nbsp; 1091&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pthread_setcancelstate(state, NULL);<br>









&nbsp;&nbsp; 1092&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>...<br>&nbsp;&nbsp; 109=
9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (ioctlfd =3D=3D -1) {<br>&nbsp;&nbsp; 1100&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crit(ap-&gt;=
logopt, &quot;can&#39;t open ioctlfd for %s&quot;,<br>
&nbsp;&nbsp; 1101&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me-&gt;key);<br>&nbsp;&nbsp; 1102=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthre=
ad_setcancelstate(state, NULL);<br>&nbsp;&nbsp; 1103&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>&nbsp;&nbsp; 11=
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br><br>`mc-&gt;rwlock&#39; and `ap-&gt;entry-&gt;=
source_lock&#39; are still held at line 1103.<br>










<br>Also, is line 1090 unlocking the right thing?<br><br><br>modules/lookup=
_multi.c:<br>&nbsp;&nbsp;&nbsp; 137 int lookup_init(const char *my_mapfmt, =
int argc, const char *const *argv, void **context)<br>...<br>&nbsp;&nbsp;&n=
bsp; 162&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(ctxt-&gt;m =
=3D malloc(ctxt-&gt;n * sizeof(struct module_info))) ||<br>



&nbsp;&nbsp;&nbsp; 163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; !(ctxt-&gt;argl =3D malloc((argc + 1) * sizeof(const ch=
ar *))))<br>&nbsp;&nbsp;&nbsp; 164&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto nomem;<br>...<=
br>&nbsp;&nbsp;&nbsp; 210 nomem:<br>&nbsp;&nbsp;&nbsp; 211&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; estr =3D strerror_r(errno, buf, MAX_ERR_BUF=
);<br>&nbsp;&nbsp;&nbsp; 212&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; logerr(MODPREFIX &quot;error: %s&quot;, estr);<br>



&nbsp;&nbsp;&nbsp; 213 error_out:<br>&nbsp;&nbsp;&nbsp; 214&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctxt) {<br>&nbsp;&nbsp;&nbsp; 215&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ctxt-&gt;n; i++) {<br>&nbsp;&nbsp;&nb=
sp; 216&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (ctxt-&gt;m[i].mod)<br>&nbsp;&nbsp;&nbsp; 217&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; close_lookup(ctxt-&gt;m[i].mod);<br>



&nbsp;&nbsp;&nbsp; 218&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (ctxt-&gt;m[i].argv)<br>&nbsp;&nbsp;&nbsp; 219&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_argv(ctxt-&gt;m[i].argc, ctxt-&gt;m[=
i].argv);<br>&nbsp;&nbsp;&nbsp; 220&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>`ctxt-&gt=
;m&#39; is unchecked within the loop.<br>



<br><br>modules/lookup_program.c:<br>&nbsp;&nbsp;&nbsp; 106 int lookup_moun=
t(struct autofs_point *ap, const char *name, int name_len, void *context)<b=
r>...<br>&nbsp;&nbsp;&nbsp; 199&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mapent =3D (char *) malloc(MAPENT_MAX_LEN + 1);<br>...<br>&nbsp;&nbsp;=
&nbsp; 395&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache_writelock(=
mc);<br>



&nbsp;&nbsp;&nbsp; 396&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D cache_update(mc, source, name, mapent, time(NULL));<br>&nbsp;&nbsp;&nbs=
p; 397&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache_unlock(mc);<br=
>&nbsp;&nbsp;&nbsp; 398&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ret =3D=3D CHE_FAIL)<br>&nbsp;&nbsp;&nbsp; 399&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 NSS_STATUS_UNAVAIL;<br><br>That is a memory leak.<br>



<br><br>modules/mount_nfs.c:<br>&nbsp;&nbsp;&nbsp;&nbsp; 57 int mount_mount=
(struct autofs_point *ap, const char *root, const char *name, int name_len,=
<br>...<br>&nbsp;&nbsp;&nbsp; 223&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loc =3D malloc(strle=
n(this-&gt;name) + 1 + strlen(this-&gt;path) + 1);<br>



&nbsp;&nbsp;&nbsp; 224&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(loc, this-&gt;name);<br>=
&nbsp;&nbsp;&nbsp; 225&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcat(loc, &quot;:&quot;);<br>=
&nbsp;&nbsp;&nbsp; 226&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcat(loc, this-&gt;path);<br>=
<br>That is an unchecked malloc(3) call.<br><br><br>lib/mounts.c:<br>



&nbsp;&nbsp;&nbsp; 206 struct mnt_list *get_mnt_list(const char *table, con=
st char *path, int include)<br>...<br>&nbsp;&nbsp;&nbsp; 265&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ent-&gt;path =3D malloc(len + 1);<br>&nbsp;&nbsp;&nbsp; 266&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!ent-&gt;path) {<br>&nbsp;&nbsp;&nbsp; 267&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; endmntent(tab);<br>


&nbsp;&nbsp;&nbsp; 268&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; free_mnt_list(list);<br>&nbsp;&nbsp;&nbsp; 269&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>&=
nbsp;&nbsp;&nbsp; 270&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; 271&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; strcpy(ent-&gt;path, mnt-&gt;mnt_dir);<br>&nbsp;&nbsp;&nbs=
p; 272<br>&nbsp;&nbsp;&nbsp; 273&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent-&gt;fs_name =3D m=
alloc(strlen(mnt-&gt;mnt_fsname) + 1);<br>


&nbsp;&nbsp;&nbsp; 274&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ent-&gt;fs_name) {<br>&nbs=
p;&nbsp;&nbsp; 275&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; endmntent(tab);<br>&nbsp;&nbsp;&nbsp; 276&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_mnt_list(list);<br>&n=
bsp;&nbsp;&nbsp; 277&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return NULL;<br>&nbsp;&nbsp;&nbsp; 278&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<br>


&nbsp;&nbsp;&nbsp; 279&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(ent-&gt;fs_name, mnt-&gt=
;mnt_fsname);<br>&nbsp;&nbsp;&nbsp; 280<br>&nbsp;&nbsp;&nbsp; 281&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ent-&gt;fs_type =3D malloc(strlen(mnt-&gt;mnt_type) + 1);<br>&n=
bsp;&nbsp;&nbsp; 282&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ent-&gt;fs_type) {<br>&nbsp;=
&nbsp;&nbsp; 283&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; endmntent(tab);<br>


&nbsp;&nbsp;&nbsp; 284&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; free_mnt_list(list);<br>&nbsp;&nbsp;&nbsp; 285&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>&=
nbsp;&nbsp;&nbsp; 286&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; 287&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; strcpy(ent-&gt;fs_type, mnt-&gt;mnt_type);<br>&nbsp;&nbsp;=
&nbsp; 288<br>&nbsp;&nbsp;&nbsp; 289&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent-&gt;opts =3D =
malloc(strlen(mnt-&gt;mnt_opts) + 1);<br>


&nbsp;&nbsp;&nbsp; 290&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ent-&gt;opts) {<br>&nbsp;&=
nbsp;&nbsp; 291&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; endmntent(tab);<br>&nbsp;&nbsp;&nbsp; 292&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_mnt_list(list);<br>&nbsp=
;&nbsp;&nbsp; 293&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return NULL;<br>&nbsp;&nbsp;&nbsp; 294&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>


&nbsp;&nbsp;&nbsp; 295&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(ent-&gt;opts, mnt-&gt;mn=
t_opts);<br>...<br>&nbsp;&nbsp;&nbsp; 659 struct mnt_list *tree_make_mnt_tr=
ee(const char *table, const char *path)<br>...<br>&nbsp;&nbsp;&nbsp; 705&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ent-&gt;path =3D malloc(len + 1);<br>


&nbsp;&nbsp;&nbsp; 706&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ent-&gt;path) {<br>&nbsp;&=
nbsp;&nbsp; 707&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; endmntent(tab);<br>&nbsp;&nbsp;&nbsp; 708&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tree_free_mnt_tree(tree);<br>=
&nbsp;&nbsp;&nbsp; 709&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return NULL;<br>&nbsp;&nbsp;&nbsp; 710&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>


&nbsp;&nbsp;&nbsp; 711&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(ent-&gt;path, mnt-&gt;mn=
t_dir);<br><br>Those are memory leaks. (`ent&#39; isn&#39;t cleaned up and/=
or freed.)<br><br>Also, strdup(3) is useful. :P<br><br><br>modules/parse_su=
n.c:<br>&nbsp;&nbsp;&nbsp; 840 static int parse_mapent(const char *ent, cha=
r *g_options, char **options, char **location, int logopt)<br>


...<br>&nbsp;&nbsp;&nbsp; 895&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; if (*p =3D=3D &#39;/&#39;) {<br>&nbsp;&nbsp;&nbsp; 896&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; warn(logopt, MODPREFIX &quot;error location begins with \&quot;/\&quot;=
&quot;);<br>&nbsp;&nbsp;&nbsp; 897&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(myoptions);<br=
>&nbsp;&nbsp;&nbsp; 898&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>


&nbsp;&nbsp;&nbsp; 899&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>...<br>&nbsp;&nbsp; 1316 int parse_mount(struct autofs_point *ap, const ch=
ar *name,<br>...<br>&nbsp;&nbsp; 1637&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*p =3D=3D &#=
39;/&#39;) {<br>&nbsp;&nbsp; 1638&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; free(options);<br>&nbsp;&nbsp; 1639&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn(ap-&gt;logop=
t,<br>


&nbsp;&nbsp; 1640&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MODPREFIX &quot;error locat=
ion begins with \&quot;/\&quot;&quot;);<br>&nbsp;&nbsp; 1641&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>&nbsp;&=
nbsp; 1642&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>Those are memory leaks. (`loc&#39;=
 isn&#39;t freed.)<br>


<br><br>modules/parse_sun.c:<br>&nbsp;&nbsp;&nbsp; 266 int parse_init(int a=
rgc, const char *const *argv, void **context)<br>...<br>&nbsp;&nbsp;&nbsp; =
387&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else {<br>&nbsp;&nbsp;&nbsp; 388&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
noptstr =3D (char *) malloc(len + 1);<br>


&nbsp;&nbsp;&nbsp; 389&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(nop=
tstr, argv[i] + offset);<br>&nbsp;&nbsp;&nbsp; 390&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; optlen =3D len;<br>&nbsp;&nbsp;&nbsp; 391&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>That is an u=
nchecked malloc(3) call.<br>

--0016e65385c853e28d04611cc281--


--===============0556139333447851109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0556139333447851109==--

