From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Fri, 23 Jan 2009 13:08:44 +0900
Message-ID: <1232683724.3011.6.camel@zeus.themaw.net>
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
	<408431290901221800y3c008d5dib66b2786e832c086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901221800y3c008d5dib66b2786e832c086@mail.gmail.com>
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

On Fri, 2009-01-23 at 13:00 +1100, Paul Wankadia wrote:

Where getting quite a list of goodies for this.

> daemon/direct.c:
>    1045 int handle_packet_expire_direct(struct autofs_point *ap,
> autofs_packet_expire_direct_t *pkt)
> ...
>    1087                 crit(ap->logopt, "can't find map entry for (%
> lu,%lu)",
>    1088                     (unsigned long) pkt->dev, (unsigned long)
> pkt->ino);
>    1089                 master_source_unlock(ap->entry);
>    1090                 master_mutex_unlock();
>    1091                 pthread_setcancelstate(state, NULL);
>    1092                 return 1;
> ...
>    1099                 if (ioctlfd == -1) {
>    1100                         crit(ap->logopt, "can't open ioctlfd
> for %s",
>    1101                              me->key);
>    1102                         pthread_setcancelstate(state, NULL);
>    1103                         return 1;
>    1104                 }
> 
> `mc->rwlock' and `ap->entry->source_lock' are still held at line 1103.

Mmmm ... thought I fixed this but clearly not.

> 
> Also, is line 1090 unlocking the right thing?

No it's not, the master map mutex is not aquired here (although it was
at one time but that may not have made it to a release).

snip ...

> 
> lib/mounts.c:
>     206 struct mnt_list *get_mnt_list(const char *table, const char
> *path, int include)
> ...

at this point either list == ent or ent is linked into list.

>     265                 ent->path = malloc(len + 1);
>     266                 if (!ent->path) {
>     267                         endmntent(tab);
>     268                         free_mnt_list(list);
>     269                         return NULL;
>     270                 }
>     271                 strcpy(ent->path, mnt->mnt_dir);
>     272
>     273                 ent->fs_name = malloc(strlen(mnt->mnt_fsname)
> + 1);
>     274                 if (!ent->fs_name) {
>     275                         endmntent(tab);
>     276                         free_mnt_list(list);
>     277                         return NULL;
>     278                 }
>     279                 strcpy(ent->fs_name, mnt->mnt_fsname);
>     280
>     281                 ent->fs_type = malloc(strlen(mnt->mnt_type) +
> 1);
>     282                 if (!ent->fs_type) {
>     283                         endmntent(tab);
>     284                         free_mnt_list(list);
>     285                         return NULL;
>     286                 }
>     287                 strcpy(ent->fs_type, mnt->mnt_type);
>     288
>     289                 ent->opts = malloc(strlen(mnt->mnt_opts) + 1);
>     290                 if (!ent->opts) {
>     291                         endmntent(tab);
>     292                         free_mnt_list(list);
>     293                         return NULL;
>     294                 }
>     295                 strcpy(ent->opts, mnt->mnt_opts);
> ...

So in all these cases it looks to me like free_mnt_list() handles the
dealloc.

>     659 struct mnt_list *tree_make_mnt_tree(const char *table, const
> char *path)
> ...
>     705                 ent->path = malloc(len + 1);
>     706                 if (!ent->path) {
>     707                         endmntent(tab);
>     708                         tree_free_mnt_tree(tree);
>     709                         return NULL;
>     710                 }
>     711                 strcpy(ent->path, mnt->mnt_dir);
> 
> Those are memory leaks. (`ent' isn't cleaned up and/or freed.)

But this is a mistake.

> 
> Also, strdup(3) is useful. :P

Sure, but not this time around, ;)

Ian
