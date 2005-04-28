From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] get rid of is_mounted checks in cache_clean
Date: Thu, 28 Apr 2005 15:16:19 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504281513440.13323@wombat.indigo.net.au>
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

I remember now why this is needed.

The directory creation/removal isn't done at mount/umount for browsable 
maps. It's done when the map is updated.

Ian
