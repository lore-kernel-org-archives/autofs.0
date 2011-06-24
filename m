From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Deadlock in automount caused by AB/BA lock ordering
Date: Fri, 24 Jun 2011 17:02:00 -0300
Message-ID: <BANLkTi=HAV9VjPwZEbT8EMMs-evB5UtPxw@mail.gmail.com>
References: <20110519232152.GA3226@libre.l.ngdn.org>
	<1308018861.3268.5.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=KPV1Jd3QOHZAvGDWdryTx96mHkzt1nmad8Dqv6qc3SE=;
	b=ED9+J0LThuGAegPwC0ICOM7BIQsMe9jGCnwPZw9OCyxy/qN1/iEoEKK1XeB5+eAkaB
	Z0YUE66xjf45rtZ9omKs9yWes8LR1Im8NWPkrKukeUzAHT/WEIqIEQLxXE6fHMpC3BgK
	LGn+Tf7HgBj7t+WA8Y5WMEBuKvc2lycwRY7x0=
In-Reply-To: <1308018861.3268.5.camel@perseus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, Jun 13, 2011 at 11:34 PM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2011-05-19 at 20:21 -0300, Leonardo Chiquitto wrote:
>> Hello,
>>
>> We received a support request from a customer reporting a hang in the
>> automount daemon. Analyzing the core dump, it looks like automount
>> can deadlock if two threads execute in the following order:
>>
>> (All the line numbers are adjusted to match the latest version from Git)
>>
>> Thread 7 (Thread 25043): =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thre=
ad 6 (Thread 24007):
>>
>> #9 start_thread() libpthread.so.0 =A0 =A0 =A0 =A0 =A0 =A0 #3 =A0start_th=
read() libpthread.so.0
>> #8 do_read_master() at automount.c:1259 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #2 =
=A0do_readmap() at state.c:479
>> #7 master_read_master() at master.c:853 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 --> master_mutex_lock() [state.c:462]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 --> master_mutex_unlock() [state.c:466]
>> =A0 =A0--> master_mutex_lock() [master.c:836]
>> =A0 =A0--> cache_writelock() [master.c:838 or :849]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 --> master_source_readlock() [state.c:477]
>> #6 lookup_nss_read_master() at lookup.c:229
>> #5 do_read_master() at lookup.c:96
>> #4 lookup_read_master() at lookup_ldap.c:1676
>> #3 master_parse_entry() at master_parse.y:829
>> #2 master_add_map_source() at master.c:192
>> #1 master_source_writelock() at master.c:543 =A0#1 =A0cache_readlock() a=
t cache.c:60
>> #0 pthread_rwlock_wrlock() libpthread.so.0 =A0 =A0#0 =A0pthread_rwlock_r=
dlock() libpthread.so.0
>>
>> At this point:
>>
>> =A0 Thread 7: locked(master_mutex_lock)
>> =A0 =A0 =A0 =A0 =A0 locked(cache_writelock) =A0 =A0 =A0 =A0 =A0 =A0 A
>> =A0 =A0 =A0 =A0 =A0 waits(master_source_writelock) =A0 =A0 =A0B
>> =A0 Thread 6: locked(master_source_readlock) =A0 =A0B
>> =A0 =A0 =A0 =A0 =A0 waits(cache_readlock) =A0 =A0 =A0 =A0 =A0 =A0 =A0 A
>>
>> The AutoFS version is 5.0.5 plus all upstream patches up to
>> autofs-5.0.5-fix-submount-shutdown-wait.patch plus
>> autofs-5.0.5-fix-out-of-order-locking-in-readmap.patch
>> autofs-5.0.5-fix-next-task-list-update.patch
>> autofs-5.0.5-fix-stale-map-read.patch
>>
>> At the first sight, moving pthread_cleanup_pop(1) (and consequently
>> master_mutex_unlock()) to the end of do_readmap() could avoid the
>> problem, but I didn't test this yet (please see untested patch below).
>>
>> Any insight would be much appreciated!
>>
>> Thanks,
>> Leonardo
>>
>> Index: autofs/daemon/state.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- autofs.orig/daemon/state.c
>> +++ autofs/daemon/state.c
>> @@ -463,7 +463,6 @@ static void *do_readmap(void *arg)
>> =A0 =A0 =A0 status =3D lookup_nss_read_map(ap, NULL, now);
>> =A0 =A0 =A0 if (!status)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_exit(NULL);
>> - =A0 =A0 pthread_cleanup_pop(1);
>>
>> =A0 =A0 =A0 if (ap->type =3D=3D LKP_INDIRECT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 lookup_prune_cache(ap, now);
>> @@ -504,6 +503,7 @@ static void *do_readmap(void *arg)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 pthread_cleanup_pop(1);
>> + =A0 =A0 pthread_cleanup_pop(1);
>>
>> =A0 =A0 =A0 return NULL;
>> =A0}
>
>
> This might be all we need since once the master map is read the null
> cache is set up and and can't change while we hold the read lock ....
>
> autofs-5.0.5 - fix null cache deadlock
>
> From: Ian Kent <ikent@redhat.com>
>
> ---
>
> =A0daemon/state.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/daemon/state.c b/daemon/state.c
> index 3645440..51809a1 100644
> --- a/daemon/state.c
> +++ b/daemon/state.c
> @@ -473,11 +473,11 @@ static void *do_readmap(void *arg)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mnts =3D tree_make_mnt_tree(_PROC_MOUNTS, =
"/");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pthread_cleanup_push(tree_mnts_cleanup, mn=
ts);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_cleanup_push(master_source_lock_cle=
anup, ap->entry);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 master_source_readlock(ap->entry);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nc =3D ap->entry->master->nc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_readlock(nc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pthread_cleanup_push(cache_lock_cleanup, n=
c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master_source_readlock(ap->entry);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_cleanup_push(master_source_lock_cle=
anup, ap->entry);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map =3D ap->entry->maps;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (map) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Is map source up to dat=
e or no longer valid */
>

Ian,

Thanks for the patch! It really seems to be enough to resolve this issue: t=
he
problem didn't happen again after ~10 days testing.

Thanks,
Leonardo
