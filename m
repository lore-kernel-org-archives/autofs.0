From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Wed, 16 Feb 2011 15:08:05 +0800
Message-ID: <1297840085.2825.8.camel@perseus>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus> <1297741021.13007.12.camel@perseus>
	<20110215052857.GV27735@sunapee.qualcomm.com>
	<1297772933.13007.28.camel@perseus>
	<AANLkTi=fSs58yKLnWFLLDk-ep+wDbqNLpj0r9AZUjZ+Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=+FrUgBifIwcDso3zcyAyWo7iuWs=;
	b=iMkJ0TnUqmFbrW2aZyqeOPFkySnPVHXSKSdk4BnZ+g/NFgMhQ958vI819qyEWG+akI2mHX/6Pvkvj/05co1C2XtD3hltTjbbrL4I9sfxII4PLsCM/KPfp3Mb4N6I0rgcI5xk8qCfI5ed5+dpAUJNgPoSxpmrGzJblzMmnxc1h5c=
In-Reply-To: <AANLkTi=fSs58yKLnWFLLDk-ep+wDbqNLpj0r9AZUjZ+Y@mail.gmail.com>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, Mike Marion <mmarion@qualcomm.com>

On Tue, 2011-02-15 at 16:11 -0200, Leonardo Chiquitto wrote:
> On Tue, Feb 15, 2011 at 10:28 AM, Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2011-02-14 at 21:28 -0800, Mike Marion wrote:
> >> On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:
> >>
> >> > That is kernel revision and autofs revision?
> >>
> >> 2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge, patch).
> >> autofs 5.0.5 with most of the patches up to a couple months ago.  It's hard to
> >> get exacts because it's a PTF from Novell (we really pushed them to upgrade to
> >> 5.0.5) but it should be pretty much equal to the patch they just released for
> >> sle 11 sp1 that they're recommending as they default going forward.
> >
> > That make it hard, as you know.
> >
> > But I wouldn't mind spending a bit of time on it, if you can also.
> >
> > Let's assume that it's a user space problem for now.
> 
> Here are the call traces for all automount processes on the kernel side:

I think it's a user space problem.

snip ...

> And here are the call traces from the user land daemon:
> 
> Thread 9 (Thread 4017):
> #0  0x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthread.so.0
> #1  0x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.so.0
> #2  0x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread.so.0
> #3  0x00005555555746cd in master_mutex_lock () at master.c:49
> #4  0x000055555555d260 in do_hup_signal (master=0x55555568d010, age=1296063258)
>     at automount.c:1276
> #5  0x0000555555560bd3 in statemachine (arg=<value optimized out>)
>     at automount.c:1354
> #6  main (arg=<value optimized out>) at automount.c:2142
> 
> Thread 8 (Thread 20702):
> #0  0x00002b56e4dd62a7 in brk () from /lib64/libc.so.6
> #1  0x0000555555577dfe in expire (logopt=2, cmd=<value optimized out>, fd=21,
>     ioctlfd=21, path=0x55555569ca20 "/usr2", arg=0x41c27ef4)
>     at dev-ioctl-lib.c:657
> #2  0x0000555555577ebe in ioctl_expire (logopt=21, ioctlfd=-1,
>     path=0x55555569ca20 "/usr2", when=0) at dev-ioctl-lib.c:701
> #3  0x0000555555561e4e in expire_proc_indirect (arg=<value optimized out>)
>     at indirect.c:545
> #4  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #5  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #6  0x0000000000000000 in ?? ()
> 
> Thread 7 (Thread 7060):
> #0  0x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthread.so.0
> #1  0x00005555555752ea in master_source_writelock (entry=<value optimized out>)
>     at master.c:527
> #2  0x0000555555575f8f in master_add_map_source (entry=0x5555556a10b0,
>     type=0x0, format=0x0, age=1296059657, argc=1, argv=<value optimized out>)
>     at master.c:191
> #3  0x0000555555579ee3 in master_parse_entry (buffer=<value optimized out>,
>     default_timeout=86400, logging=<value optimized out>, age=1296059657)
>     at master_parse.y:823
> #4  0x00002aaaaaab83fe in lookup_read_master (master=<value optimized out>,
>     age=1296059657, context=<value optimized out>) at lookup_ldap.c:1625
> #5  0x0000555555569052 in do_read_master (master=0x55555568d010,
>     type=<value optimized out>, age=1296059657) at lookup.c:96
> #6  0x000055555556aa3c in lookup_nss_read_master (master=0x55555568d010,
>     age=1296059657) at lookup.c:229
> #7  0x0000555555575c28 in master_read_master (master=0x55555568d010,
>     age=1296059657, readall=1) at master.c:831
> #8  0x000055555555d844 in do_read_master (arg=<value optimized out>)
>     at automount.c:1259
> #9  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #10 0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #11 0x0000000000000000 in ?? ()
> 
> Thread 6 (Thread 6851):
> #0  0x00002b56e465aa3d in pthread_rwlock_rdlock () from /lib64/libpthread.so.0
> #1  0x000055555556deb6 in cache_readlock (mc=0x55555568e5b8) at cache.c:60
> #2  0x000055555556baff in do_readmap (arg=<value optimized out>) at state.c:479
> #3  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #4  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #5  0x0000000000000000 in ?? ()
> 
> Thread 5 (Thread 4026):
> #0  0x00002b56e465d6a8 in __lll_mutex_lock_wait () from /lib64/libpthread.so.0
> #1  0x00002b56e46599fb in _L_mutex_lock_92 () from /lib64/libpthread.so.0
> #2  0x00002b56e4659455 in pthread_mutex_lock () from /lib64/libpthread.so.0
> #3  0x00005555555746cd in master_mutex_lock () at master.c:49
> #4  0x0000555555560ff9 in handle_packet_missing_indirect (ap=0x55555569c940,
>     pkt=0x41823ec0) at indirect.c:808
> #5  0x000055555555fa32 in handle_packet (ap=<value optimized out>)
>     at automount.c:1026
> #6  handle_mounts (ap=<value optimized out>) at automount.c:1551
> #7  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #8  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #9  0x0000000000000000 in ?? ()
> 
> Thread 4 (Thread 4025):
> #0  0x00002b56e4dd4b26 in fts_read () from /lib64/libc.so.6
> #1  0x00007fff37314e80 in ?? ()
> #2  0x0000000000000000 in ?? ()
> 
> Thread 3 (Thread 4022):
> #0  0x00002b56e465ac77 in pthread_rwlock_wrlock () from /lib64/libpthread.so.0
> #1  0x00005555555752ea in master_source_writelock (entry=<value optimized out>)
>     at master.c:527
> #2  0x00005555555631af in handle_packet_missing_direct (ap=0x5555556a11c0,
>     pkt=0x40821ec0) at direct.c:1296
> #3  0x000055555555fa1d in handle_packet (ap=<value optimized out>)
>     at automount.c:1029
> #4  handle_mounts (ap=<value optimized out>) at automount.c:1551
> #5  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #6  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #7  0x0000000000000000 in ?? ()
> 
> Thread 2 (Thread 4019):
> #0  0x00002b56e465b326 in pthread_cond_wait@@GLIBC_2.3.2 ()
>    from /lib64/libpthread.so.0
> #1  0x000055555556c8b3 in st_queue_handler (arg=<value optimized out>)
>     at state.c:1104
> #2  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #3  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #4  0x0000000000000000 in ?? ()
> 
> Thread 1 (Thread 4018):
> #0  0x00002b56e465b517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
>    from /lib64/libpthread.so.0
> #1  0x0000555555573762 in alarm_handler (arg=<value optimized out>)
>     at alarm.c:206
> #2  0x00002b56e4657193 in start_thread () from /lib64/libpthread.so.0
> #3  0x00002b56e4ddcdfd in sysctl () from /lib64/libc.so.6
> #4  0x0000000000000000 in ?? ()
> 

It looks like a lock ordering bug to me and I think it's the same hang
that Steve Thompson reported.

This will be hard to test I think, hopefully Mike or Steve will be able
to use a couple of machines for testing, even so it may take a while
before we know.

Could you prepare a test package for Mike using this patch please.
It should apply OK but of course you'll need to discard or fix the
CHANGELOG hunk.

I'll prepare a test package for Steve soon as I get time.

autofs-5.0.5 - fix out of order locking in readmap

From: Ian Kent <raven@themaw.net>

When re-reading the master map and a mount lookup for a particular map
entry arrives at the same time a map source is being added to the map
entry and a map entry re-read is also initiated at the same time an
out of order mutex locking bug which results in a hang.
---

 CHANGELOG    |    1 +
 lib/master.c |    8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index 11054da..631094f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -55,6 +55,7 @@
 - add external bind method.
 - fix add simple bind auth.
 - add option to dump configured automount maps.
+- fix out of order locking in readmap.
 
 03/09/2009 autofs-5.0.5
 -----------------------
diff --git a/lib/master.c b/lib/master.c
index 95bd3fb..daedf66 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -611,8 +611,6 @@ struct master_mapent *master_find_mapent(struct master *master, const char *path
 {
 	struct list_head *head, *p;
 
-	master_mutex_lock();
-
 	head = &master->mounts;
 	list_for_each(p, head) {
 		struct master_mapent *entry;
@@ -625,8 +623,6 @@ struct master_mapent *master_find_mapent(struct master *master, const char *path
 		}
 	}
 
-	master_mutex_unlock();
-
 	return NULL;
 }
 
@@ -703,9 +699,7 @@ struct master_mapent *master_new_mapent(struct master *master, const char *path,
 
 void master_add_mapent(struct master *master, struct master_mapent *entry)
 {
-	master_mutex_lock();
 	list_add_tail(&entry->list, &master->mounts);
-	master_mutex_unlock();
 	return;
 }
 
@@ -813,6 +807,7 @@ int master_read_master(struct master *master, time_t age, int readall)
 	 * We need to clear and re-populate the null map entry cache
 	 * before alowing anyone else to use it.
 	 */
+	master_mutex_lock();
 	if (master->nc) {
 		cache_writelock(master->nc);
 		nc = master->nc;
@@ -831,6 +826,7 @@ int master_read_master(struct master *master, time_t age, int readall)
 	master_init_scan();
 	lookup_nss_read_master(master, age);
 	cache_unlock(nc);
+	master_mutex_unlock();
 
 	if (!master->read_fail)
 		master_mount_mounts(master, age, readall);
