From: Ian Kent <raven@themaw.net>
Subject: Re: Deadlock in automount caused by AB/BA lock ordering
Date: Sat, 25 Jun 2011 09:49:44 +0800
Message-ID: <1308966585.3194.0.camel@perseus.themaw.net>
References: <20110519232152.GA3226@libre.l.ngdn.org>
	<1308018861.3268.5.camel@perseus.themaw.net>
	<BANLkTi=HAV9VjPwZEbT8EMMs-evB5UtPxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=ReHzV3RJPEeUuwM9no0bhRoK03E=;
	b=JoEmWiotSjf2DDTajp9jw5S8BDV3HZS833FPhzPyLqEukwj9xbBasWfbX/GquVQJrTYAEAn2iRXLZl/hSTf5m4igTqCkJKGnLkpKQ+8YrXCU18dNt3w74/J2EY1e3vXvle8dABCAkdC7SH8bnkOnnqNmJkroOWBgLt234zh0mF8=
In-Reply-To: <BANLkTi=HAV9VjPwZEbT8EMMs-evB5UtPxw@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2011-06-24 at 17:02 -0300, Leonardo Chiquitto wrote:
> On Mon, Jun 13, 2011 at 11:34 PM, Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2011-05-19 at 20:21 -0300, Leonardo Chiquitto wrote:
> >> Hello,
> >>
> >> We received a support request from a customer reporting a hang in the
> >> automount daemon. Analyzing the core dump, it looks like automount
> >> can deadlock if two threads execute in the following order:
> >>
> >> (All the line numbers are adjusted to match the latest version from Git)
> >>
> >> Thread 7 (Thread 25043):                      Thread 6 (Thread 24007):
> >>
> >> #9 start_thread() libpthread.so.0             #3  start_thread() libpthread.so.0
> >> #8 do_read_master() at automount.c:1259               #2  do_readmap() at state.c:479
> >> #7 master_read_master() at master.c:853                   --> master_mutex_lock() [state.c:462]
> >>                                                   --> master_mutex_unlock() [state.c:466]
> >>    --> master_mutex_lock() [master.c:836]
> >>    --> cache_writelock() [master.c:838 or :849]
> >>                                                   --> master_source_readlock() [state.c:477]
> >> #6 lookup_nss_read_master() at lookup.c:229
> >> #5 do_read_master() at lookup.c:96
> >> #4 lookup_read_master() at lookup_ldap.c:1676
> >> #3 master_parse_entry() at master_parse.y:829
> >> #2 master_add_map_source() at master.c:192
> >> #1 master_source_writelock() at master.c:543  #1  cache_readlock() at cache.c:60
> >> #0 pthread_rwlock_wrlock() libpthread.so.0    #0  pthread_rwlock_rdlock() libpthread.so.0
> >>
> >> At this point:
> >>
> >>   Thread 7: locked(master_mutex_lock)
> >>           locked(cache_writelock)             A
> >>           waits(master_source_writelock)      B
> >>   Thread 6: locked(master_source_readlock)    B
> >>           waits(cache_readlock)               A
> >>
> >> The AutoFS version is 5.0.5 plus all upstream patches up to
> >> autofs-5.0.5-fix-submount-shutdown-wait.patch plus
> >> autofs-5.0.5-fix-out-of-order-locking-in-readmap.patch
> >> autofs-5.0.5-fix-next-task-list-update.patch
> >> autofs-5.0.5-fix-stale-map-read.patch
> >>
> >> At the first sight, moving pthread_cleanup_pop(1) (and consequently
> >> master_mutex_unlock()) to the end of do_readmap() could avoid the
> >> problem, but I didn't test this yet (please see untested patch below).
> >>
> >> Any insight would be much appreciated!
> >>
> >> Thanks,
> >> Leonardo
> >>
> >> Index: autofs/daemon/state.c
> >> ===================================================================
> >> --- autofs.orig/daemon/state.c
> >> +++ autofs/daemon/state.c
> >> @@ -463,7 +463,6 @@ static void *do_readmap(void *arg)
> >>       status = lookup_nss_read_map(ap, NULL, now);
> >>       if (!status)
> >>               pthread_exit(NULL);
> >> -     pthread_cleanup_pop(1);
> >>
> >>       if (ap->type == LKP_INDIRECT) {
> >>               lookup_prune_cache(ap, now);
> >> @@ -504,6 +503,7 @@ static void *do_readmap(void *arg)
> >>       }
> >>
> >>       pthread_cleanup_pop(1);
> >> +     pthread_cleanup_pop(1);
> >>
> >>       return NULL;
> >>  }
> >
> >
> > This might be all we need since once the master map is read the null
> > cache is set up and and can't change while we hold the read lock ....
> >
> > autofs-5.0.5 - fix null cache deadlock
> >
> > From: Ian Kent <ikent@redhat.com>
> >
> > ---
> >
> >  daemon/state.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/daemon/state.c b/daemon/state.c
> > index 3645440..51809a1 100644
> > --- a/daemon/state.c
> > +++ b/daemon/state.c
> > @@ -473,11 +473,11 @@ static void *do_readmap(void *arg)
> >
> >                mnts = tree_make_mnt_tree(_PROC_MOUNTS, "/");
> >                pthread_cleanup_push(tree_mnts_cleanup, mnts);
> > -               pthread_cleanup_push(master_source_lock_cleanup, ap->entry);
> > -               master_source_readlock(ap->entry);
> >                nc = ap->entry->master->nc;
> >                cache_readlock(nc);
> >                pthread_cleanup_push(cache_lock_cleanup, nc);
> > +               master_source_readlock(ap->entry);
> > +               pthread_cleanup_push(master_source_lock_cleanup, ap->entry);
> >                map = ap->entry->maps;
> >                while (map) {
> >                        /* Is map source up to date or no longer valid */
> >
> 
> Ian,
> 
> Thanks for the patch! It really seems to be enough to resolve this issue: the
> problem didn't happen again after ~10 days testing.

Great, I'll add a description to the patch and commit it.

Ian
