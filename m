From: Ian Kent <raven@themaw.net>
Subject: Re: Deadlock in automount caused by AB/BA lock ordering
Date: Tue, 24 May 2011 13:38:06 +0800
Message-ID: <1306215486.3398.8.camel@perseus.themaw.net>
References: <20110519232152.GA3226@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=5vy0KcHOpREg9hhfIb8wrGmbld0=;
	b=CrZCEA9hVedZ2Fi3TaAxFcGYzMJ+df316xPtAzM8MZzVX1X5XIXYB7x1FGRRffDC6pikJr1tJheyEFOVu4PD9aKW5VzPe0joFf5jIMGHCe2BCmF2zWWVMaZ+cw/B2FvzihRDdi4m/9s02AVvqKZ/LHikWhcDrSOQS7ANXQ9X6yg=
In-Reply-To: <20110519232152.GA3226@libre.l.ngdn.org>
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

On Thu, 2011-05-19 at 20:21 -0300, Leonardo Chiquitto wrote:
> Hello,
> 
> We received a support request from a customer reporting a hang in the
> automount daemon. Analyzing the core dump, it looks like automount
> can deadlock if two threads execute in the following order:

This looks like a rather interesting mistake on my part.
It doesn't look simple to fix either, anyway I'm working on it.

> 
> (All the line numbers are adjusted to match the latest version from Git)
> 
> Thread 7 (Thread 25043):			Thread 6 (Thread 24007):
> 
> #9 start_thread() libpthread.so.0		#3  start_thread() libpthread.so.0
> #8 do_read_master() at automount.c:1259		#2  do_readmap() at state.c:479
> #7 master_read_master() at master.c:853		    --> master_mutex_lock() [state.c:462]
> 						    --> master_mutex_unlock() [state.c:466]
>    --> master_mutex_lock() [master.c:836]
>    --> cache_writelock() [master.c:838 or :849]
> 						    --> master_source_readlock() [state.c:477]
> #6 lookup_nss_read_master() at lookup.c:229
> #5 do_read_master() at lookup.c:96
> #4 lookup_read_master() at lookup_ldap.c:1676
> #3 master_parse_entry() at master_parse.y:829
> #2 master_add_map_source() at master.c:192
> #1 master_source_writelock() at master.c:543	#1  cache_readlock() at cache.c:60
> #0 pthread_rwlock_wrlock() libpthread.so.0	#0  pthread_rwlock_rdlock() libpthread.so.0
> 
> At this point:
> 
>   Thread 7: locked(master_mutex_lock)
> 	    locked(cache_writelock)		A
> 	    waits(master_source_writelock)	B
>   Thread 6: locked(master_source_readlock)	B
> 	    waits(cache_readlock)		A
> 
> The AutoFS version is 5.0.5 plus all upstream patches up to
> autofs-5.0.5-fix-submount-shutdown-wait.patch plus
> autofs-5.0.5-fix-out-of-order-locking-in-readmap.patch
> autofs-5.0.5-fix-next-task-list-update.patch
> autofs-5.0.5-fix-stale-map-read.patch
> 
> At the first sight, moving pthread_cleanup_pop(1) (and consequently
> master_mutex_unlock()) to the end of do_readmap() could avoid the
> problem, but I didn't test this yet (please see untested patch below).
> 
> Any insight would be much appreciated!
> 
> Thanks,
> Leonardo
> 
> Index: autofs/daemon/state.c
> ===================================================================
> --- autofs.orig/daemon/state.c
> +++ autofs/daemon/state.c
> @@ -463,7 +463,6 @@ static void *do_readmap(void *arg)
>  	status = lookup_nss_read_map(ap, NULL, now);
>  	if (!status)
>  		pthread_exit(NULL);
> -	pthread_cleanup_pop(1);
>  
>  	if (ap->type == LKP_INDIRECT) {
>  		lookup_prune_cache(ap, now);
> @@ -504,6 +503,7 @@ static void *do_readmap(void *arg)
>  	}
>  
>  	pthread_cleanup_pop(1);
> +	pthread_cleanup_pop(1);
>  
>  	return NULL;
>  }
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
