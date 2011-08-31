From: Ian Kent <raven@themaw.net>
Subject: Re: Segmentation fault in read_one_map() -> ldap_msgfree()
Date: Wed, 31 Aug 2011 09:16:25 +0800
Message-ID: <1314753385.3238.2.camel@perseus.themaw.net>
References: <20110830182735.GA31035@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=tahvSvQHULwm8hQ8dyF/SD
 1SOKI=; b=b9Vjiva/NlQ2pG/TLd1t77JV4x5QDxr7p2CyggMrrMStMk+19Q7VU+
 vfi4V8rMrYGqxNC/FI3Fl2iC0OU3JTPZvYVNTwrp9ijG40mi/jhNyKQ5xEivkL16
 Qhz0gszL8dxzH8byFMr9dxz5goO+qS17yRswzsp/+YcfMc1ZlIXyw=
In-Reply-To: <20110830182735.GA31035@libre.l.ngdn.org>
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

On Tue, 2011-08-30 at 14:27 -0400, Leonardo Chiquitto wrote:
> Hello,
> 
> A customer reported a segmentation fault in automount (one occurrence
> so far, but we have a core dump). More information about the exact
> autofs version and included patches below.

Thanks for reporting this and for spending the time to try and work out
what's going on.

I'll have a look see too.

> 
> Call trace:
> 
> Thread 7 (Thread 4254):
> #0  do_sigwait (set=0x7fff9eb877c0, sig=0x7fff9eb878dc)
>     at ../sysdeps/unix/sysv/linux/sigwait.c:65
> #1  __sigwait (set=0x7fff9eb877c0, sig=0x7fff9eb878dc)
>     at ../sysdeps/unix/sysv/linux/sigwait.c:100
> #2  statemachine (argc=<value optimized out>, 
>     argv=<value optimized out>) at automount.c:1327
> #3  main (argc=<value optimized out>, argv=<value optimized out>)
>     at automount.c:2142
> 
> Thread 6 (Thread 4255):
> #0  pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
> #1  alarm_handler (arg=<value optimized out>) at alarm.c:206
> #2  start_thread (arg=<value optimized out>) at pthread_create.c:306
> #3  clone () from /lib64/libc.so.6
> 
> Thread 5 (Thread 4256):
> #0  pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
> #1  st_queue_handler (arg=<value optimized out>) at state.c:1103
> #2  start_thread (arg=<value optimized out>) at pthread_create.c:306
> #3  clone () from /lib64/libc.so.6
> 
> Thread 4 (Thread 4259):
> #0  __poll (fds=0x40822150, nfds=3, timeout=-1)
>     at ../sysdeps/unix/sysv/linux/poll.c:87
> #1  get_pkt (arg=<value optimized out>) at automount.c:882
> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
> #4  start_thread (arg=<value optimized out>) at pthread_create.c:306
> #5  clone () from /lib64/libc.so.6
> 
> Thread 3 (Thread 4262):
> #0  __poll (fds=0x41023150, nfds=3, timeout=-1)
>     at ../sysdeps/unix/sysv/linux/poll.c:87
> #1  get_pkt (arg=<value optimized out>) at automount.c:882
> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
> #4  start_thread (arg=<value optimized out>) at pthread_create.c:306
> #5  clone () from /lib64/libc.so.6
> 
> Thread 2 (Thread 4263):
> #0  __poll (fds=0x41824150, nfds=3, timeout=-1)
>     at ../sysdeps/unix/sysv/linux/poll.c:87
> #1  get_pkt (arg=<value optimized out>) at automount.c:882
> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
> #4  start_thread (arg=<value optimized out>) at pthread_create.c:306
> #5  clone () from /lib64/libc.so.6
> 
> Thread 1 (Thread 18996):
> #0  __libc_free (mem=0x5555556a0498) at malloc.c:3461
> #1  ber_free_buf (ber=0x5555556a0460) at io.c:177
> #2  ber_free (ber=0x5555556a0460, freebuf=0) at io.c:196
> #3  ldap_msgfree (lm=0x555555e4ddc0) at result.c:1151
> #4  read_one_map (ap=0x55555569c120, age=1311189199, 
>     context=0x5555556a0040) at lookup_ldap.c:2341
> #5  lookup_read_map (ap=0x55555569c120, age=1311189199, context=0x5555556a0040)
>     at lookup_ldap.c:2361
> #6  do_read_map (ap=0x55555569c120, map=0x55555568d1c0, 
>     age=1311189199) at lookup.c:296
> #7  read_source_instance (this=<value optimized out>, 
>     ap=0x55555569c120, map=0x55555569c220, age=1311189199) at lookup.c:374
> #8  read_map_source (this=<value optimized out>, ap=0x55555569c120, 
>     map=0x55555569c220, age=1311189199) at lookup.c:393
> #9  lookup_nss_read_map (ap=0x55555569c120, 
>     source=<value optimized out>, age=1311189199) at lookup.c:534
> #10 do_readmap (arg=<value optimized out>) at state.c:463
> #11 start_thread (arg=<value optimized out>) at pthread_create.c:306
> #12 clone () from /lib64/libc.so.6
> 
> The crash happens because we're passing an invalid (already freed?)
> LDAPMessage structure to ldap_msgfree() in read_one_map():
> 
> static int read_one_map(struct autofs_point *ap,
>                         struct lookup_context *ctxt,
>                         time_t age, int *result_ldap)
> {
> (...)
>               rv = do_get_entries(&sp, source, ctxt);
>               if (rv != LDAP_SUCCESS) {
>                       ldap_msgfree(sp.result);
>                       unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
>                       *result_ldap = rv;
>                       free(sp.query);
>                       return NSS_STATUS_NOTFOUND;
>               }
>               ldap_msgfree(sp.result);        <=== 
>       } while (sp.morePages == TRUE);
> 
> (gdb) frame 4
> #4  0x00002aaaaaab8c74 in read_one_map (ap=0x55555569c120, age=1311189199, context=0x5555556a0040) at lookup_ldap.c:2341
> 2341                     ldap_msgfree(sp.result);
> (gdb) print sp
> $1 = {ap = 0x55555569c120, ldap = 0x555555769c10, query = 0x55555569ef00 "(objectclass=automount)", attrs = 0x41a25c80, cookie = 0x0, pageSize = 2000, 
>   morePages = 0, totalCount = 0, result = 0x5555556a8e40, age = 1311189199}
> 
> I'm staring at the code for some time now, and still can't figure out how
> that could happen. Is it somehow possible that do_get_entries() return
> LDAP_SUCCESS but keep an invalid/outdated query result in sp.result?
> 
> I'd also like to suggest the patch below. I believe it can potentially
> avoid the crash.

The patch looks like it's sensible to do anyway.
I wonder if it actually prevents the crash?

> 
> Thanks,
> Leonardo
> 
> AutoFS version is 5.0.5 plus all upstream patches up and including
> autofs-5.0.5-fix-submount-shutdown-wait.patch plus these assorted
> bug fixes:
> 
> autofs-5.0.5-auto-adjust-ldap-page-size.patch
> autofs-5.0.5-replace-gplv3-code.patch
> autofs-5.0.5-fix-paged-ldap-map-read.patch
> autofs-5.0.5-fix-next-task-list-update.patch
> autofs-5.0.5-fix-stale-map-read.patch
> autofs-5.0.5-fix-out-of-order-locking-in-readmap.patch
> autofs-5.0.5-remove-master_mutex_unlock-leftover.patch
> autofs-5.0.5-fix-null-cache-deadlock.patch
> 
> Index: autofs/modules/lookup_ldap.c
> ===================================================================
> --- autofs.orig/modules/lookup_ldap.c
> +++ autofs/modules/lookup_ldap.c
> @@ -361,6 +361,7 @@ static int get_query_dn(unsigned logopt,
>  			      MODPREFIX "query succeeded, no matches for %s",
>  			      query);
>  			ldap_msgfree(result);
> +			result = NULL;
>  			free(query);
>  			return 0;
>  		}
> @@ -1583,6 +1584,7 @@ int lookup_read_master(struct master *ma
>  		      MODPREFIX "query succeeded, no matches for %s",
>  		      query);
>  		ldap_msgfree(result);
> +		result = NULL;
>  		unbind_ldap_connection(logging, ldap, ctxt);
>  		free(query);
>  		return NSS_STATUS_NOTFOUND;
> @@ -2380,8 +2382,8 @@ static int read_one_map(struct autofs_po
>  
>  		if (rv == LDAP_ADMINLIMIT_EXCEEDED ||
>  		    rv == LDAP_SIZELIMIT_EXCEEDED) {
> -			if (sp.result)
> -				ldap_msgfree(sp.result);
> +			ldap_msgfree(sp.result);
> +			sp.result = NULL;
>  			sp.pageSize = sp.pageSize / 2;
>  			if (sp.pageSize < 5) {
>  				debug(ap->logopt, MODPREFIX
> @@ -2404,12 +2406,14 @@ static int read_one_map(struct autofs_po
>  		rv = do_get_entries(&sp, source, ctxt);
>  		if (rv != LDAP_SUCCESS) {
>  			ldap_msgfree(sp.result);
> +			sp.result = NULL;
>  			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
>  			*result_ldap = rv;
>  			free(sp.query);
>  			return NSS_STATUS_NOTFOUND;
>  		}
>  		ldap_msgfree(sp.result);
> +		sp.result = NULL;
>  	} while (sp.morePages == TRUE);
>  
>  	debug(ap->logopt, MODPREFIX "done updating map");
> @@ -2582,6 +2586,7 @@ static int lookup_one(struct autofs_poin
>  		debug(ap->logopt,
>  		     MODPREFIX "got answer, but no entry for %s", query);
>  		ldap_msgfree(result);
> +		result = NULL;
>  		unbind_ldap_connection(ap->logopt, ldap, ctxt);
>  		free(query);
>  		return CHE_MISSING;
> @@ -2768,6 +2773,7 @@ next:
>  	}
>  
>  	ldap_msgfree(result);
> +	result = NULL;
>  	unbind_ldap_connection(ap->logopt, ldap, ctxt);
>  
>  	/* Failed to find wild entry, update cache if needed */
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
