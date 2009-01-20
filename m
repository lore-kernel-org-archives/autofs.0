From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] autofs-5.0.4 - always read file maps
Date: Tue, 20 Jan 2009 10:43:07 +0900
Message-ID: <1232415787.3136.20.camel@zeus.themaw.net>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
	<20090119122438.31454.99701.stgit@zeus.themaw.net>
	<408431290901191731l446ae961md66abc8b1eac63f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901191731l446ae961md66abc8b1eac63f7@mail.gmail.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 2009-01-20 at 12:31 +1100, Paul Wankadia wrote:
> On Mon, Jan 19, 2009 at 11:24 PM, Ian Kent <raven@themaw.net> wrote:

snip ...

>         @@ -391,7 +380,6 @@ int lookup_read_master(struct master
>         *master, time_t age, void *context)
>                int blen;
>                char *path;
>                char *ent;
>         -       struct stat st;
>                FILE *f;
>                int fd;
> 
> You should be able to get rid of `fd' and the fileno(3) call now.
> 
> 
>                unsigned int path_len, ent_len;
>         @@ -504,13 +492,6 @@ int lookup_read_master(struct master
>         *master, time_t age, void *context)
>                                break;
>                }
>         
>         -       if (fstat(fd, &st)) {
>         -               crit(logopt, MODPREFIX "file map %s, could not
>         stat",
>         -                      ctxt->mapname);
>         -               return NSS_STATUS_UNAVAIL;
>         -       }
>         -       ctxt->mtime = st.st_mtime;
>         -
>                fclose(f);
>         
>                return NSS_STATUS_SUCCESS;
>         @@ -642,7 +623,6 @@ int lookup_read_map(struct autofs_point
>         *ap, time_t age, void *context)
>                struct mapent_cache *mc;
>                char *key;
>                char *mapent;
>         -       struct stat st;
>                FILE *f;
>                int fd;
> 
> You should be able to get rid of `fd' and the fileno(3) call now.

Yep, quite right.

> 
> 
>                unsigned int k_len, m_len;
>         @@ -748,13 +728,6 @@ int lookup_read_map(struct autofs_point
>         *ap, time_t age, void *context)
>                                break;
>                }
>         
>         -       if (fstat(fd, &st)) {
>         -               crit(ap->logopt,
>         -                    MODPREFIX "file map %s, could not stat",
>         -                    ctxt->mapname);
>         -               return NSS_STATUS_UNAVAIL;
>         -       }
>         -       ctxt->mtime = st.st_mtime;
>                source->age = age;
>         
>                fclose(f);
>         @@ -951,9 +924,6 @@ static int check_map_indirect(struct
>         autofs_point *ap,
>                if (ret == CHE_FAIL)
>                        return NSS_STATUS_NOTFOUND;
>         
>         -       if (ret & CHE_UPDATED)
>         -               source->stale = 1;
>         -
>                pthread_cleanup_push(cache_lock_cleanup, mc);
>                cache_writelock(mc);
>                exists = cache_lookup_distinct(mc, key);
>         @@ -963,7 +933,6 @@ static int check_map_indirect(struct
>         autofs_point *ap,
>                                free(exists->mapent);
>                                exists->mapent = NULL;
>                                exists->status = 0;
>         -                       source->stale = 1;
>                        }
>                }
>                pthread_cleanup_pop(1);
>         @@ -985,14 +954,8 @@ static int check_map_indirect(struct
>         autofs_point *ap,
>                        we = cache_lookup_distinct(mc, "*");
>                        if (we) {
>                                /* Wildcard entry existed and is now
>         gone */
>         -                       if (we->source == source && (wild &
>         CHE_MISSING)) {
>         +                       if (we->source == source && (wild &
>         CHE_MISSING))
>                                        cache_delete(mc, "*");
>         -                               source->stale = 1;
>         -                       }
>         -               } else {
>         -                       /* Wildcard not in map but now is */
>         -                       if (wild & (CHE_OK | CHE_UPDATED))
>         -                               source->stale = 1;
>                        }
>                        pthread_cleanup_pop(1);
>         
>         @@ -1062,9 +1025,28 @@ int lookup_mount(struct autofs_point
>         *ap, const char *name, int name_len, void *
>                 * we never know about it.
>                 */
>                if (ap->type == LKP_INDIRECT && *key != '/') {
>         +               struct stat st;
>                        char *lkp_key;
>         
>         +               /*
>         +                * We can skip the map lookup and cache update
>         altogether
>         +                * if we know the map hasn't been modified
>         since it was
>         +                * last read. If it has then we can mark the
>         map stale
>         +                * so a re-read is triggered following the
>         lookup.
>         +                */
>         +               if (stat(ctxt->mapname, &st)) {
>         +                       error(ap->logopt, MODPREFIX
>         +                             "file map %s, could not stat",
>         ctxt->mapname);
>         +                       return NSS_STATUS_UNAVAIL;
>         +               }
>         +
>                        cache_readlock(mc);
>         +               me = cache_lookup_first(mc);
>         +               if (me && st.st_mtime <= me->age)
>         +                       goto do_cache_lookup;
>         +               else
>         +                       source->stale = 1;
> 
> Perhaps some output for debugging purposes wouldn't go astray?

Mmm .. I'll see what I can do.

> 
> 
>         +
>                        me = cache_lookup_distinct(mc, key);
>                        if (me && me->multi)
>                                lkp_key = strdup(me->multi->key);
>         @@ -1088,6 +1070,7 @@ int lookup_mount(struct autofs_point
>         *ap, const char *name, int name_len, void *
>                }
>         
>                cache_readlock(mc);
>         +do_cache_lookup:
>                me = cache_lookup(mc, key);
>                /* Stale mapent => check for entry in alternate source
>         or wildcard */
>                if (me && !me->mapent) {
>         
> 
