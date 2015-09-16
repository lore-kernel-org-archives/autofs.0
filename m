From: Ning Yu <ning.yu@canonical.com>
Subject: Re: Mount point not auto unmounted after system date/time change
Date: Wed, 16 Sep 2015 16:45:50 +0800
Message-ID: <CAA1QoHQBJhORCZZY8cS27TWsa=Tk6WJDCwCXXNSQJ5=R6ZtWNw@mail.gmail.com>
References: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hi,

I have composed a patch for this issue, it works in my side, what it
does is replacing gettimeofday() with clock_gettime(CLOCK_MONOTONIC).

Would anyone please help to review it? Thanks in advance.

From cdb2bcd563420cd39af199309e8c0c7fc45a7bd1 Mon Sep 17 00:00:00 2001
From: Yu Ning <ning.yu@ubuntu.com>
Date: Wed, 16 Sep 2015 15:56:21 +0800
Subject: [PATCH] Use clock_gettime() instead of gettimeofday().

This patch is to fix the issue that a mount point may not be
automatically unmounted after a system date/time change.

Reproducer with 100% failrate:

    $ cat /etc/auto.master
    /mnt /etc/auto.misc

    $ cat /etc/auto.misc
    removable -fstype=auto :/dev/sdb1

    ### now plugin a usb pendrive

    $ cd /mnt/removable
    $ sudo date -s "+1 year"
    $ sleep 1
    $ sudo date -s "-1 year"
    $ cd

/mnt/removable will not be automatically unmounted.

The root cause is that autofs uses gettimeofday() to identify the
timestamp and calculate the timeouts, however as mentioned in the
manpage:

    NOTES
           The time returned by gettimeofday() is affected by
discontinuous jumps
           in the system time (e.g., if the system administrator
manually changes
           the system time).  If you need a monotonically increasing
clock,  see
           clock_gettime(2).

So we can fix the issue by replacing gettimeofday() with
clock_gettime(CLOCK_MONOTONIC).
---
 daemon/automount.c        |  4 ++--
 daemon/direct.c           | 16 ++++++++--------
 daemon/indirect.c         | 16 ++++++++--------
 daemon/lookup.c           |  6 +++---
 daemon/state.c            |  2 +-
 include/automount.h       |  9 +++++++++
 include/rpc_subs.h        |  1 +
 lib/alarm.c               | 23 +++++++++++++++++------
 lib/cache.c               |  2 +-
 lib/master.c              |  4 ++--
 lib/rpc_subs.c            | 17 ++++++++++++-----
 modules/dclist.c          |  2 +-
 modules/lookup_file.c     |  8 ++++----
 modules/lookup_hesiod.c   |  6 +++---
 modules/lookup_hosts.c    |  4 ++--
 modules/lookup_ldap.c     | 10 +++++-----
 modules/lookup_nisplus.c  | 10 +++++-----
 modules/lookup_program.c  | 10 +++++-----
 modules/lookup_sss.c      |  6 +++---
 modules/lookup_userhome.c |  2 +-
 modules/lookup_yp.c       |  8 ++++----
 modules/mount_autofs.c    |  2 +-
 modules/parse_amd.c       |  2 +-
 modules/replicated.c      | 34 ++++++++++++++++------------------
 24 files changed, 115 insertions(+), 89 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 229cb1a..a49ceee 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1454,7 +1454,7 @@ static void *statemachine(void *arg)
  break;

  case SIGHUP:
- do_hup_signal(master_list, time(NULL));
+ do_hup_signal(master_list, monotonic_time(NULL));
  break;

  default:
@@ -2004,7 +2004,7 @@ int main(int argc, char *argv[])
  unsigned ghost, logging, daemon_check;
  unsigned dumpmaps, foreground, have_global_options;
  time_t timeout;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  struct rlimit rlim;
  const char *options = "+hp:t:vmdD:fVrO:l:n:CF";
  static const struct option long_options[] = {
diff --git a/daemon/direct.c b/daemon/direct.c
index 5569299..470a719 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -464,7 +464,7 @@ int mount_autofs_direct(struct autofs_point *ap)
  struct mapent_cache *nc, *mc;
  struct mapent *me, *ne, *nested;
  struct mnt_list *mnts;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);

  if (strcmp(ap->path, "/-")) {
  error(ap->logopt, "expected direct map, exiting");
@@ -1041,7 +1041,7 @@ int handle_packet_expire_direct(struct
autofs_point *ap, autofs_packet_expire_di
  char buf[MAX_ERR_BUF];
  pthread_t thid;
  struct timespec wait;
- struct timeval now;
+ struct timespec now;
  int status, state;

  pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -1159,9 +1159,9 @@ int handle_packet_expire_direct(struct
autofs_point *ap, autofs_packet_expire_di

  mt->signaled = 0;
  while (!mt->signaled) {
- gettimeofday(&now, NULL);
+ clock_gettime(CLOCK_MONOTONIC, &now);
  wait.tv_sec = now.tv_sec + 2;
- wait.tv_nsec = now.tv_usec * 1000;
+ wait.tv_nsec = now.tv_nsec;
  status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
  if (status && status != ETIMEDOUT)
  fatal(status);
@@ -1296,7 +1296,7 @@ int handle_packet_missing_direct(struct
autofs_point *ap, autofs_packet_missing_
  char buf[MAX_ERR_BUF];
  int status = 0;
  struct timespec wait;
- struct timeval now;
+ struct timespec now;
  int ioctlfd, len, state;
  unsigned int kver_major = get_kver_major();
  unsigned int kver_minor = get_kver_minor();
@@ -1388,7 +1388,7 @@ int handle_packet_missing_direct(struct
autofs_point *ap, autofs_packet_missing_
  }

  /* Check if we recorded a mount fail for this key */
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  ops->send_fail(ap->logopt,
        ioctlfd, pkt->wait_queue_token, -ENOENT);
  ops->close(ap->logopt, ioctlfd);
@@ -1478,9 +1478,9 @@ int handle_packet_missing_direct(struct
autofs_point *ap, autofs_packet_missing_

  mt->signaled = 0;
  while (!mt->signaled) {
- gettimeofday(&now, NULL);
+ clock_gettime(CLOCK_MONOTONIC, &now);
  wait.tv_sec = now.tv_sec + 2;
- wait.tv_nsec = now.tv_usec * 1000;
+ wait.tv_nsec = now.tv_nsec;
  status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
  if (status && status != ETIMEDOUT)
  fatal(status);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index a04a624..b2015f9 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -197,7 +197,7 @@ out_err:

 int mount_autofs_indirect(struct autofs_point *ap, const char *root)
 {
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  int status;
  int map;

@@ -636,7 +636,7 @@ int handle_packet_expire_indirect(struct
autofs_point *ap, autofs_packet_expire_
  char buf[MAX_ERR_BUF];
  pthread_t thid;
  struct timespec wait;
- struct timeval now;
+ struct timespec now;
  int status, state;

  pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -691,9 +691,9 @@ int handle_packet_expire_indirect(struct
autofs_point *ap, autofs_packet_expire_

  mt->signaled = 0;
  while (!mt->signaled) {
- gettimeofday(&now, NULL);
+ clock_gettime(CLOCK_MONOTONIC, &now);
  wait.tv_sec = now.tv_sec + 2;
- wait.tv_nsec = now.tv_usec * 1000;
+ wait.tv_nsec = now.tv_nsec;
  status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
  if (status && status != ETIMEDOUT)
  fatal(status);
@@ -795,7 +795,7 @@ int handle_packet_missing_indirect(struct
autofs_point *ap, autofs_packet_missin
  char buf[MAX_ERR_BUF];
  struct pending_args *mt;
  struct timespec wait;
- struct timeval now;
+ struct timespec now;
  struct mapent *me;
  int status, state;

@@ -818,7 +818,7 @@ int handle_packet_missing_indirect(struct
autofs_point *ap, autofs_packet_missin
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, pkt->name, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  ops->send_fail(ap->logopt, ap->ioctlfd,
        pkt->wait_queue_token, -ENOENT);
  cache_unlock(me->mc);
@@ -884,9 +884,9 @@ int handle_packet_missing_indirect(struct
autofs_point *ap, autofs_packet_missin

  mt->signaled = 0;
  while (!mt->signaled) {
- gettimeofday(&now, NULL);
+ clock_gettime(CLOCK_MONOTONIC, &now);
  wait.tv_sec = now.tv_sec + 2;
- wait.tv_nsec = now.tv_usec * 1000;
+ wait.tv_nsec = now.tv_nsec;
  status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
  if (status && status != ETIMEDOUT)
  fatal(status);
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 62071df..9a8fa7e 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -875,7 +875,7 @@ static int lookup_name_file_source_instance(struct
autofs_point *ap, struct map_
  struct map_source *instance;
  char src_file[] = "file";
  char src_prog[] = "program";
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  struct stat st;
  char *type, *format;

@@ -915,7 +915,7 @@ static int lookup_name_source_instance(struct
autofs_point *ap, struct map_sourc
 {
  struct map_source *instance;
  const char *format;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);

  if (*name == '/' && map->flags & MAP_FLAG_FORMAT_AMD)
  return lookup_amd_instance(ap, map, name, name_len);
@@ -1079,7 +1079,7 @@ static void update_negative_cache(struct
autofs_point *ap, struct map_source *so
  else
  map = entry->maps;
  if (map) {
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  int rv = CHE_FAIL;

  cache_writelock(map->mc);
diff --git a/daemon/state.c b/daemon/state.c
index 3174a9c..08828b1 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -553,7 +553,7 @@ static unsigned int st_readmap(struct autofs_point *ap)
  pthread_t thid;
  struct readmap_args *ra;
  int status;
- int now = time(NULL);
+ int now = monotonic_time(NULL);

  debug(ap->logopt, "state %d path %s", ap->state, ap->path);

diff --git a/include/automount.h b/include/automount.h
index 447aba1..7bbf859 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -565,6 +565,15 @@ do { \
  fatal(_m_unlock); \
 } while(0)

+static inline time_t monotonic_time(time_t *t)
+{
+ struct timespec ts;
+ clock_gettime(CLOCK_MONOTONIC, &ts);
+ if (t)
+ *t = (time_t) ts.tv_sec;
+ return (time_t) ts.tv_sec;
+}
+
 /* Expire alarm handling routines */
 int alarm_start_handler(void);
 int alarm_add(struct autofs_point *ap, time_t seconds);
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index b6d59f9..e329224 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -71,6 +71,7 @@ int rpc_portmap_getport(struct conn_info *, struct
pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
 double elapsed(struct timeval, struct timeval);
+double monotonic_elapsed(struct timespec, struct timespec);
 int rpc_time(const char *, unsigned int, unsigned int, long, long,
unsigned int, double *);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);

diff --git a/lib/alarm.c b/lib/alarm.c
index 0f04ef8..7563c9b 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -23,7 +23,7 @@ struct alarm {
 };

 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t cond;
 static LIST_HEAD(alarms);

 #define alarm_lock() \
@@ -46,7 +46,7 @@ int alarm_add(struct autofs_point *ap, time_t seconds)
  struct list_head *head;
  struct list_head *p;
  struct alarm *new;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  time_t next_alarm = 0;
  unsigned int empty = 1;
  int status;
@@ -175,17 +175,17 @@ static void *alarm_handler(void *arg)

  first = list_entry(head->next, struct alarm, list);

- now = time(NULL);
+ now = monotonic_time(NULL);

  if (first->time > now) {
- struct timeval usecs;
+ struct timespec nsecs;
  /*
  * Wait for alarm to trigger or a new alarm
  * to be added.
  */
- gettimeofday(&usecs, NULL);
+ clock_gettime(CLOCK_MONOTONIC, &nsecs);
  expire.tv_sec = first->time;
- expire.tv_nsec = usecs.tv_usec * 1000;
+ expire.tv_nsec = nsecs.tv_nsec;

  status = pthread_cond_timedwait(&cond, &mutex, &expire);
  if (status && status != ETIMEDOUT)
@@ -212,6 +212,7 @@ int alarm_start_handler(void)
  pthread_t thid;
  pthread_attr_t attrs;
  pthread_attr_t *pattrs = &attrs;
+ pthread_condattr_t condattrs;
  int status;

  status = pthread_attr_init(pattrs);
@@ -224,8 +225,18 @@ int alarm_start_handler(void)
 #endif
  }

+ status = pthread_condattr_init(&condattrs);
+ if (status)
+ fatal(status);
+
+ pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+ pthread_cond_init(&cond, &condattrs);
+
  status = pthread_create(&thid, pattrs, alarm_handler, NULL);

+ pthread_condattr_destroy(&condattrs);
+ pthread_condattr_destroy(&cond);
+
  if (pattrs)
  pthread_attr_destroy(pattrs);

diff --git a/lib/cache.c b/lib/cache.c
index 631d275..44e323d 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -775,7 +775,7 @@ void cache_update_negative(struct mapent_cache *mc,
    struct map_source *ms, const char *key,
    time_t timeout)
 {
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  struct mapent *me;
  int rv = CHE_OK;

diff --git a/lib/master.c b/lib/master.c
index 6c38b1c..cca8371 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1483,7 +1483,7 @@ int dump_map(struct master *master, const char
*type, const char *name)
  struct map_source *source;
  struct master_mapent *this;
  struct autofs_point *ap;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);

  this = list_entry(p, struct master_mapent, list);
  p = p->next;
@@ -1601,7 +1601,7 @@ int master_show_mounts(struct master *master)
  struct map_source *source;
  struct master_mapent *this;
  struct autofs_point *ap;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  unsigned int count = 0;

  this = list_entry(p, struct master_mapent, list);
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 846c40e..e8c0ca5 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1086,25 +1086,32 @@ double elapsed(struct timeval start, struct timeval end)
  return t2-t1;
 }

+double monotonic_elapsed(struct timespec start, struct timespec end)
+{
+ double t1, t2;
+ t1 =  (double)start.tv_sec + (double)start.tv_nsec/(1000*1000*1000);
+ t2 =  (double)end.tv_sec + (double)end.tv_nsec/(1000*1000*1000);
+ return t2-t1;
+}
+
 int rpc_time(const char *host,
      unsigned int ping_vers, unsigned int ping_proto,
      long seconds, long micros, unsigned int option, double *result)
 {
  int status;
  double taken;
- struct timeval start, end;
- struct timezone tz;
+ struct timespec start, end;
  int proto = (ping_proto & RPC_PING_UDP) ? IPPROTO_UDP : IPPROTO_TCP;
  unsigned long vers = ping_vers;

- gettimeofday(&start, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &start);
  status = __rpc_ping(host, vers, proto, seconds, micros, option);
- gettimeofday(&end, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &end);

  if (status == RPC_PING_FAIL || status < 0)
  return status;

- taken = elapsed(start, end);
+ taken = monotonic_elapsed(start, end);

  if (result != NULL)
  *result = taken;
diff --git a/modules/dclist.c b/modules/dclist.c
index af21ce0..4daa199 100644
--- a/modules/dclist.c
+++ b/modules/dclist.c
@@ -568,7 +568,7 @@ struct dclist *get_dc_list(unsigned int logopt,
const char *uri)
  if (!list)
  goto out_error;

- dclist->expire = time(NULL) + min_ttl;
+ dclist->expire = monotonic_time(NULL) + min_ttl;
  dclist->uri = list;

  return dclist;
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 7c982c6..4e52fce 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -743,7 +743,7 @@ static int match_key(struct autofs_point *ap,
 {
  char buf[MAX_ERR_BUF];
  struct mapent_cache *mc;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  char *lkp_key;
  char *prefix;
  size_t map_key_len;
@@ -808,7 +808,7 @@ static int lookup_one(struct autofs_point *ap,
  struct mapent_cache *mc = source->mc;
  char mkey[KEY_MAX_LEN + 1];
  char mapent[MAPENT_MAX_LEN + 1];
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  FILE *f;
  unsigned int k_len, m_len;
  int entry, ret;
@@ -914,7 +914,7 @@ static int lookup_wild(struct autofs_point *ap,
  struct mapent_cache *mc;
  char mkey[KEY_MAX_LEN + 1];
  char mapent[MAPENT_MAX_LEN + 1];
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  FILE *f;
  unsigned int k_len, m_len;
  int entry, ret;
@@ -1118,7 +1118,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, key, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 526f294..9da4f8e 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -163,7 +163,7 @@ static int lookup_one(struct autofs_point *ap,
  }

  cache_writelock(mc);
- ret = cache_update(mc, source, key, best_record, time(NULL));
+ ret = cache_update(mc, source, key, best_record, monotonic_time(NULL));
  cache_unlock(mc);
  if (ret == CHE_FAIL) {
  hesiod_free_list(ctxt->hesiod_context, hes_result);
@@ -228,7 +228,7 @@ static int lookup_one_amd(struct autofs_point *ap,
  }

  cache_writelock(mc);
- ret = cache_update(mc, source, lkp_key, *hes_result, time(NULL));
+ ret = cache_update(mc, source, lkp_key, *hes_result, monotonic_time(NULL));
  cache_unlock(mc);

  if (hes_result)
@@ -339,7 +339,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, name, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_hosts.c b/modules/lookup_hosts.c
index 0d48356..8c4bbd9 100644
--- a/modules/lookup_hosts.c
+++ b/modules/lookup_hosts.c
@@ -284,7 +284,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  struct mapent *me;
  char *mapent = NULL;
  int mapent_len;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  int ret;

  source = ap->entry->current;
@@ -296,7 +296,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, name, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 5da613e..d45e7d1 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -944,7 +944,7 @@ static LDAP *do_reconnect(unsigned logopt, struct
lookup_context *ctxt)

  uris_mutex_lock(ctxt);
  if (ctxt->dclist) {
- if (!ldap || ctxt->dclist->expire < time(NULL)) {
+ if (!ldap || ctxt->dclist->expire < monotonic_time(NULL)) {
  free_dclist(ctxt->dclist);
  ctxt->dclist = NULL;
  }
@@ -2851,7 +2851,7 @@ static int lookup_one(struct autofs_point *ap,
struct map_source *source,
  struct mapent_cache *mc;
  int rv, i, l, ql, count;
  char buf[MAX_ERR_BUF];
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  char *query;
  LDAPMessage *result = NULL, *e;
  char *class, *info, *entry;
@@ -3214,7 +3214,7 @@ static int lookup_one_amd(struct autofs_point *ap,
  struct berval **bvKey;
  struct berval **bvValues;
  char buf[MAX_ERR_BUF];
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  int rv, l, ql, count;
  int ret = CHE_MISSING;

@@ -3417,7 +3417,7 @@ static int check_map_indirect(struct autofs_point *ap,
  unsigned int is_amd_format = source->flags & MAP_FLAG_FORMAT_AMD;
  struct mapent_cache *mc;
  struct mapent *me;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  time_t t_last_read;
  int ret, cur_state;
  int status;
@@ -3555,7 +3555,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, key, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index d5eba47..17d3dde 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -288,7 +288,7 @@ static int lookup_one(struct autofs_point *ap,
  nis_result *result;
  nis_object *this;
  char *mapent;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  int ret, cur_state;
  char buf[MAX_ERR_BUF];

@@ -400,7 +400,7 @@ static int lookup_wild(struct autofs_point *ap,
  nis_result *result;
  nis_object *this;
  char *mapent;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  int ret, cur_state;
  char buf[MAX_ERR_BUF];

@@ -487,7 +487,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
  mapent = ENTRY_VAL(this, 1);

  cache_writelock(mc);
- ret = cache_update(mc, source, "/defaults", mapent, time(NULL));
+ ret = cache_update(mc, source, "/defaults", mapent, monotonic_time(NULL));
  cache_unlock(mc);

  nis_freeresult(result);
@@ -505,7 +505,7 @@ static int check_map_indirect(struct autofs_point *ap,
  unsigned int is_amd_format = source->flags & MAP_FLAG_FORMAT_AMD;
  struct mapent_cache *mc;
  struct mapent *me, *exists;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  time_t t_last_read;
  int ret = 0;

@@ -650,7 +650,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, key, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index a3a7e98..eff774b 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -369,7 +369,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
  while (isblank(*start))
  start++;
  cache_writelock(mc);
- ret = cache_update(mc, source, "/defaults", start, time(NULL));
+ ret = cache_update(mc, source, "/defaults", start, monotonic_time(NULL));
  cache_unlock(mc);
  if (ret == CHE_FAIL) {
  free(ment);
@@ -438,7 +438,7 @@ static int match_key(struct autofs_point *ap,
  start++;
  }
  cache_writelock(mc);
- ret = cache_update(mc, source, lkp_key, start, time(NULL));
+ ret = cache_update(mc, source, lkp_key, start, monotonic_time(NULL));
  cache_unlock(mc);
  if (ret == CHE_FAIL) {
  free(ment);
@@ -491,7 +491,7 @@ static int match_key(struct autofs_point *ap,
  while (isblank(*start))
  start++;
  cache_writelock(mc);
- ret = cache_update(mc, source, match, start, time(NULL));
+ ret = cache_update(mc, source, match, start, monotonic_time(NULL));
  cache_unlock(mc);
  if (ret == CHE_FAIL) {
  free(match);
@@ -537,7 +537,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, name, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
@@ -586,7 +586,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  * proceed with the program map lookup.
  */
  if (strchr(name, '/') ||
-    me->age + ap->negative_timeout > time(NULL)) {
+    me->age + ap->negative_timeout > monotonic_time(NULL)) {
  char *ent = NULL;

  if (me->mapent) {
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 528ab41..d685ccf 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -374,7 +374,7 @@ static int lookup_one(struct autofs_point *ap,
  struct mapent_cache *mc;
  struct mapent *we;
  void *sss_ctxt = NULL;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  char buf[MAX_ERR_BUF];
  char *value = NULL;
  char *s_key;
@@ -491,7 +491,7 @@ static int check_map_indirect(struct autofs_point *ap,
  struct map_source *source;
  struct mapent_cache *mc;
  struct mapent *me;
- time_t now = time(NULL);
+ time_t now = monotonic_time(NULL);
  time_t t_last_read;
  int ret, cur_state;

@@ -585,7 +585,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, key, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/lookup_userhome.c b/modules/lookup_userhome.c
index fb3caaa..d0c3e80 100644
--- a/modules/lookup_userhome.c
+++ b/modules/lookup_userhome.c
@@ -77,7 +77,7 @@ int lookup_mount(struct autofs_point *ap, const char
*name, int name_len, void *
  }

  cache_writelock(mc);
- ret = cache_update(mc, source, name, NULL, time(NULL));
+ ret = cache_update(mc, source, name, NULL, monotonic_time(NULL));
  cache_unlock(mc);

  if (ret == CHE_FAIL) {
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index fcf470a..3ffa4b6 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -405,7 +405,7 @@ static int lookup_one(struct autofs_point *ap,
  char *mapname;
  char *mapent;
  int mapent_len;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  int ret;

  mc = source->mc;
@@ -517,7 +517,7 @@ static int lookup_wild(struct autofs_point *ap,
  char *mapname;
  char *mapent;
  int mapent_len;
- time_t age = time(NULL);
+ time_t age = monotonic_time(NULL);
  int ret;

  mc = source->mc;
@@ -598,7 +598,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
  return CHE_FAIL;

  cache_writelock(mc);
- ret = cache_update(mc, source, "/defaults", mapent, time(NULL));
+ ret = cache_update(mc, source, "/defaults", mapent, monotonic_time(NULL));
  cache_unlock(mc);

  return ret;
@@ -753,7 +753,7 @@ int lookup_mount(struct autofs_point *ap, const
char *name, int name_len, void *
  /* Check if we recorded a mount fail for this key anywhere */
  me = lookup_source_mapent(ap, key, LKP_DISTINCT);
  if (me) {
- if (me->status >= time(NULL)) {
+ if (me->status >= monotonic_time(NULL)) {
  cache_unlock(me->mc);
  return NSS_STATUS_NOTFOUND;
  } else {
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 4846e7f..05ea1c1 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -242,7 +242,7 @@ int mount_mount(struct autofs_point *ap, const
char *root, const char *name,

  source = master_add_map_source(entry,
        info->type, info->format,
-       time(NULL), argc, argv);
+       monotonic_time(NULL), argc, argv);
  if (!source) {
  error(ap->logopt,
       MODPREFIX "failed to add map source to entry");
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 899be40..6e29c6c 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1181,7 +1181,7 @@ static int do_host_mount(struct autofs_point
*ap, const char *name,
  "hosts", "sun", argc, pargv);
  if (!instance) {
  instance = master_add_source_instance(source,
- "hosts", "sun", time(NULL), argc, pargv);
+ "hosts", "sun", monotonic_time(NULL), argc, pargv);
  if (!instance) {
  error(ap->logopt, MODPREFIX
      "failed to create source instance for hosts map");
diff --git a/modules/replicated.c b/modules/replicated.c
index 32860d5..8da1148 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -69,14 +69,14 @@ void seed_random(void)

  fd = open_fd("/dev/urandom", O_RDONLY);
  if (fd < 0) {
- srandom(time(NULL));
+ srandom(monotonic_time(NULL));
  return;
  }

  if (read(fd, &seed, sizeof(seed)) != -1)
  srandom(seed);
  else
- srandom(time(NULL));
+ srandom(monotonic_time(NULL));

  close(fd);

@@ -231,8 +231,7 @@ static unsigned int get_nfs_info(unsigned logopt,
struct host *host,
  socklen_t len = INET6_ADDRSTRLEN;
  char buf[len + 1];
  struct pmap parms;
- struct timeval start, end;
- struct timezone tz;
+ struct timespec start, end;
  unsigned int supported = 0;
  double taken = 0;
  int status, count = 0;
@@ -292,9 +291,9 @@ static unsigned int get_nfs_info(unsigned logopt,
struct host *host,
  supported = status;
  goto done_ver;
  } else if (!status) {
- gettimeofday(&start, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &start);
  status = rpc_ping_proto(rpc_info);
- gettimeofday(&end, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &end);
  if (status == -ETIMEDOUT) {
  supported = status;
  goto done_ver;
@@ -306,7 +305,7 @@ static unsigned int get_nfs_info(unsigned logopt,
struct host *host,
  debug(logopt,
       "nfs v4 random selection time: %f", reply);
  } else {
- reply = elapsed(start, end);
+ reply = monotonic_elapsed(start, end);
  debug(logopt, "nfs v4 rpc ping time: %f", reply);
  }
  taken += reply;
@@ -351,9 +350,9 @@ v3_ver:
  supported = status;
  goto done_ver;
  } else if (!status) {
- gettimeofday(&start, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &start);
  status = rpc_ping_proto(rpc_info);
- gettimeofday(&end, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &end);
  if (status == -ETIMEDOUT) {
  supported = status;
  goto done_ver;
@@ -365,7 +364,7 @@ v3_ver:
  debug(logopt,
       "nfs v3 random selection time: %f", reply);
  } else {
- reply = elapsed(start, end);
+ reply = monotonic_elapsed(start, end);
  debug(logopt, "nfs v3 rpc ping time: %f", reply);
  }
  taken += reply;
@@ -407,9 +406,9 @@ v2_ver:
  supported = status;
  goto done_ver;
  } else if (!status) {
- gettimeofday(&start, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &start);
  status = rpc_ping_proto(rpc_info);
- gettimeofday(&end, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &end);
  if (status == -ETIMEDOUT)
  supported = status;
  else if (status > 0) {
@@ -420,7 +419,7 @@ v2_ver:
  debug(logopt,
       "nfs v2 random selection time: %f", reply);
  } else {
- reply = elapsed(start, end);;
+ reply = monotonic_elapsed(start, end);;
  debug(logopt, "nfs v2 rpc ping time: %f", reply);
  }
  taken += reply;
@@ -523,8 +522,7 @@ static int get_supported_ver_and_cost(unsigned
logopt, struct host *host,
  struct conn_info pm_info, rpc_info;
  int proto;
  unsigned int vers;
- struct timeval start, end;
- struct timezone tz;
+ struct timespec start, end;
  double taken = 0;
  time_t timeout = RPC_TIMEOUT;
  int status = 0;
@@ -610,16 +608,16 @@ static int get_supported_ver_and_cost(unsigned
logopt, struct host *host,
  if (status == -EHOSTUNREACH)
  goto done;
  else if (!status) {
- gettimeofday(&start, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &start);
  status = rpc_ping_proto(&rpc_info);
- gettimeofday(&end, &tz);
+ clock_gettime(CLOCK_MONOTONIC, &end);
  if (status > 0) {
  if (random_selection) {
  /* Random value between 0 and 1 */
  taken = ((float) random())/((float) RAND_MAX+1);
  debug(logopt, "random selection time %f", taken);
  } else {
- taken = elapsed(start, end);
+ taken = monotonic_elapsed(start, end);
  debug(logopt, "rpc ping time %f", taken);
  }
  }
-- 
1.9.1

On Wed, Sep 16, 2015 at 4:29 PM, Ning Yu <ning.yu@canonical.com> wrote:
> Hi,
>
> A auto mounted directory won't be automatically unmounted after a
> system date/time change, for example we can reproduce the issue with
> below steps in 100% failrate:
>
> $ cat /etc/auto.master
> /mnt /etc/auto.misc
>
> $ cat /etc/auto.misc
> removable -fstype=auto :/dev/sdb1
>
> ### now plugin a usb pendrive
>
> $ cd /mnt/removable
> $ sudo date -s "+1 year"
> $ sleep 1
> $ sudo date -s "-1 year"
> $ cd
>
> Now /mnt/removable will not be automatically unmounted, the root cause
> is that autofs uses gettimeofday() to identify the timestamp and
> calculate the delta for timeouts, however as mentioned in the manpage:
>
> ```
> NOTES
>        The time returned by gettimeofday() is affected by discontinuous jumps
>        in the system time (e.g., if the system administrator manually changes
>        the system time).  If you need a monotonically increasing  clock,  see
>        clock_gettime(2).
> ```
>
> So in the above reproducer autofs will wait for a one-year-long
> timeout to unmount /mnt/removable.
>
> BR
> Ning
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
