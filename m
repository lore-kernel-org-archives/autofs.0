From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] get rid of is_mounted checks in cache_clean
Date: Thu, 28 Apr 2005 10:12:29 -0400
Message-ID: <17008.61261.953067.70296@segfault.boston.redhat.com>
References: <17005.16721.218171.703321@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504261020310.19250@wombat.indigo.net.au>
	<17006.55834.519305.364296@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504281513440.13323@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504281513440.13323@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [patch] get rid of is_mounted checks in cache_clean; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 26 Apr 2005, Jeff Moyer wrote:
>> ==> Regarding Re: [patch] get rid of is_mounted checks in cache_clean;
>> Ian Kent <raven@themaw.net> adds:
>> 
raven> On Mon, 25 Apr 2005, Jeff Moyer wrote:
>> >> Hi, Ian,
>> >> 
>> >> I'm not sure what purpose the following check serves in the
>> cache_clean >> function:
>> >> 
>> >> if (is_mounted(_PATH_MOUNTED, path)) { free(path); continue; }
>> >> 
>> >> In the event that the map was updated, we signal the daemon to do a
>> >> re-read of the entire map.  If the mount finishes before the daemon
>> is >> able to process this signal, we end up not pruning the old entry
>> for the >> given path.  Now, because we append entries to the cache, we
>> end up with >> the stale entry first, followed by the updated entry.
>> This means that >> subsequent lookups will give the old entry.
>> 
raven> This was originally meant to stop busy (currently mounted) entries
raven> from disappearing from the cache.
>>
raven> I'll check whether this is actually needed and get back.
>>
raven> One thing that comes to mind is that the direct mount rework design
raven> might need this.
>> Well, unfortunately I cannot comment on that.  We had have a very
>> precise definite of what it means to be in the cache, then, if there are
>> to be side-effects of removing entries.
>> 
>> Anyway, the patch I sent was somewhat incomplete.  Look at this:
>> 
>> if (me->age < age) {
pred-> next = me->next;
>> free(me->key); free(me->mapent); free(me); me = pred; rmdir_path(path);
>> }
>> 
>> The rmdir_path is unneeded, and I would argue has no business being
>> here.  It is the job of the umount_multi code to clean up the directory
>> tree, not the cache code.  Lucky for us, the umount_multi path doesn't
>> error out if a directory is removed for it (thinking of odd races,
>> here).  Anyway, the attached patch (diffed against current cvs) is more
>> complete in this respect.  It gets rid of these rmdir_path calls.

raven> I remember now why this is needed.

raven> The directory creation/removal isn't done at mount/umount for
raven> browsable maps. It's done when the map is updated.

A ha!  That makes sense, so I guess we should do:

  if (!is_mounted(path))
      rmdir_path(path);

At least that is what I'm going with for now, since we have to get a
release out the door.  I understand your concerns with the direct mount
rework, and so I definitely view this as a temporary fix.

Thanks,

Jeff
