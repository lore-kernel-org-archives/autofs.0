From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] get rid of is_mounted checks in cache_clean
Date: Tue, 26 Apr 2005 10:25:51 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504261020310.19250@wombat.indigo.net.au>
References: <17005.16721.218171.703321@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17005.16721.218171.703321@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 25 Apr 2005, Jeff Moyer wrote:

> Hi, Ian,
> 
> I'm not sure what purpose the following check serves in the cache_clean
> function:
> 
>                 if (is_mounted(_PATH_MOUNTED, path)) {
>                         free(path);
>                         continue;
>                 }
> 
> In the event that the map was updated, we signal the daemon to do a re-read
> of the entire map.  If the mount finishes before the daemon is able to
> process this signal, we end up not pruning the old entry for the given
> path.  Now, because we append entries to the cache, we end up with the
> stale entry first, followed by the updated entry.  This means that
> subsequent lookups will give the old entry.

This was originally meant to stop busy (currently mounted) entries from 
disappearing from the cache.

I'll check whether this is actually needed and get back.

One thing that comes to mind is that the direct mount rework design might 
need this.

> 
> As I don't see the cache information being used aside from during mount, I
> think we can safely get rid of this check.  Do you agree?
> 
> (Note that if you don't remove this check, there is a memory leak in the
> second check for is_mounted; we don't free path in that case)

OK.

I'll check that to.

Thanks
Ian

> 
> -Jeff
> 
> Index: lib/cache.c
> ===================================================================
> RCS file: /root/autofs/lib/cache.c,v
> retrieving revision 1.14
> diff -u -p -r1.14 cache.c
> --- a/lib/cache.c	25 Apr 2005 03:42:08 -0000	1.14
> +++ b/lib/cache.c	25 Apr 2005 19:17:28 -0000
> @@ -312,11 +312,6 @@ void cache_clean(const char *root, time_
>  			if (!path)
>  				return;
>  
> -			if (is_mounted(_PATH_MOUNTED, path)) {
> -				free(path);
> -				continue;
> -			}
> -
>  			if (me->age < age) {
>  				pred->next = me->next;
>  				free(me->key);
> @@ -336,9 +331,6 @@ void cache_clean(const char *root, time_
>  		path = cache_fullpath(root, me->key);
>  		if (!path)
>  			return;
> -
> -		if (is_mounted(_PATH_MOUNTED, path))
> -			continue;
>  
>  		if (me->age < age) {
>  			mapent_hash[i] = me->next;
> 
