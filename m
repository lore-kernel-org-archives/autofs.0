From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] get rid of is_mounted checks in cache_clean
Date: Wed, 27 Apr 2005 10:37:32 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504271018300.9124@wombat.indigo.net.au>
References: <17005.16721.218171.703321@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504261020310.19250@wombat.indigo.net.au>
	<17006.55834.519305.364296@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17006.55834.519305.364296@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
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

On Tue, 26 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [patch] get rid of is_mounted checks in cache_clean; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Mon, 25 Apr 2005, Jeff Moyer wrote:
> >> Hi, Ian,
> >> 
> >> I'm not sure what purpose the following check serves in the cache_clean
> >> function:
> >> 
> >> if (is_mounted(_PATH_MOUNTED, path)) { free(path); continue; }
> >> 
> >> In the event that the map was updated, we signal the daemon to do a
> >> re-read of the entire map.  If the mount finishes before the daemon is
> >> able to process this signal, we end up not pruning the old entry for the
> >> given path.  Now, because we append entries to the cache, we end up with
> >> the stale entry first, followed by the updated entry.  This means that
> >> subsequent lookups will give the old entry.

I see the problem.
Side affect from a previous bug fix.

> 
> raven> This was originally meant to stop busy (currently mounted) entries
> raven> from disappearing from the cache.
> 
> raven> I'll check whether this is actually needed and get back.
> 
> raven> One thing that comes to mind is that the direct mount rework design
> raven> might need this.
> 
> Well, unfortunately I cannot comment on that.  We had have a very precise
> definite of what it means to be in the cache, then, if there are to be
> side-effects of removing entries.

That's a bit unclear?

> 
> Anyway, the patch I sent was somewhat incomplete.  Look at this:
> 
> 		if (me->age < age) {
> 			pred->next = me->next;
> 			free(me->key);
> 			free(me->mapent);
> 			free(me);
> 			me = pred;
> 			rmdir_path(path);
> 		}
> 
> The rmdir_path is unneeded, and I would argue has no business being here.
> It is the job of the umount_multi code to clean up the directory tree, not
> the cache code.  Lucky for us, the umount_multi path doesn't error out if a
> directory is removed for it (thinking of odd races, here).  Anyway, the
> attached patch (diffed against current cvs) is more complete in this
> respect.  It gets rid of these rmdir_path calls.

Agreed.

But I remember I put that in there to fix an obsucure problem I was 
having. Removing it may cause undesirable side effects. Unfortuneatly, I 
can't remember what the symptoms were.

It's probably better to fix the problem as you suggest above though.
I'll spend some time to see if I can work out why I thought I had to 
have it there. A lot has changed since then so maybe removing it will 
work fine.

The direct mount rework is driven by the cache. If it's mounted then it 
needs to stay in the cache. To fix the problem above we could mark the 
entry as stale and skip it on lookup. We could do this by adding a field, 
stale, to the cache struct or by simply setting age to zero and adding the 
needed tests.

Ian
