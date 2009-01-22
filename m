From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 15:04:52 +0900
Message-ID: <1232604292.3239.17.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
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

On Thu, 2009-01-22 at 15:55 +1100, Paul Wankadia wrote:
> BTW, I'm still working through the analysis results. A few more
> problems have turned up.

Yeah, I can't see for looking.
Keep'em coming.

> 
> 
> modules/lookup_hosts.c:
>     119 int lookup_mount(struct autofs_point *ap, const char *name,
> int name_len, void *context)
> ...
>     146                 if (!me->mapent) {
>     147                         cache_delete(me->mc, name);
>     148                         me = NULL;
>     149                 }
>     150
>     151                 cache_unlock(me->mc);
> 
> That is a NULL pointer dereference.
> 
> 
> lib/macros.c:
>     163 int macro_parse_globalvar(const char *define)
>     164 {
>     165         char buf[MAX_MACRO_STRING];
>     166         char *pbuf, *value;
>     167
>     168         if (strlen(define) > MAX_MACRO_STRING)
>     169                 return 0;
>     170
>     171         strcpy(buf, define);
> 
> That is a buffer overflow.
> 
> 
> modules/parse_hesiod.c:
>      84 static int parse_nfs(struct autofs_point *ap,
> ...
>     108         for (i = 0; (!isspace(p[i]) && i < (int)
> sizeof(mount)); i++) {
>     109                 mount[i] = p[i];
>     110         }
>     111
>     112         mount[i] = 0;
>     113         p += i;
> 
> That is a buffer overflow. There are six more loops with similar
> problems.
> 
> 
> daemon/indirect.c:
>      86 static int do_mount_autofs_indirect(struct autofs_point *ap,
> const char *root)
> ...
>     160         free(options);
>     161
>     162         ret = stat(root, &st);
>     163         if (ret == -1) {
>     164                 crit(ap->logopt,
>     165                      "failed to stat mount for autofs path %
> s", ap->path);
>     166                 goto out_umount;
>     167         }
> ...
>     185 out_umount:
>     186         umount(root);
>     187 out_rmdir:
>     188         if (ap->flags & MOUNT_FLAG_DIR_CREATED)
>     189                 rmdir(root);
>     190 out_err:
>     191         if (options)
>     192                 free(options);
> 
> That is a double free(3) call.
> 
> 
> lib/cache.c:
>     180 struct mapent_cache *cache_init(struct autofs_point *ap,
> struct map_source *map)
> ...
>     195         mc->hash = malloc(mc->size * sizeof(struct entry *));
> ...
>     231 struct mapent_cache *cache_init_null_cache(struct master
> *master)
> ...
>     246         mc->hash = malloc(mc->size * sizeof(struct entry *));
> 
> `struct mapent *' might be more correct. ;)
