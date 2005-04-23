From: raven@themaw.net
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under process
Date: Sat, 23 Apr 2005 11:26:12 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504231058210.1616@donald.themaw.net>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
 <16986.44640.269893.824019@segfault.boston.redhat.com>
 <Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
 <16998.50065.652052.980908@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0504211004020.4802@wombat.indigo.net.au>
 <17001.16965.174521.970813@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <17001.16965.174521.970813@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Fri, 22 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [PATCH 1/3] autofs4 - expiring filesystem from under process; Ian Kent <raven@themaw.net> adds:
>
> raven> On Wed, 20 Apr 2005, Jeff Moyer wrote:
>>> ==> Regarding Re: [PATCH 1/3] autofs4 - expiring filesystem from under
>>> process; raven@themaw.net adds:
>>>
> raven> On Mon, 11 Apr 2005, Jeff Moyer wrote:
>>>>> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under >>
>>> process; raven@themaw.net adds:
>>>>>
>>>>> Could also please explain how the following is handled:
>>>>>
>>>>> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets >>
>>> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
>>>>> process access the directory in question, causing a call to >>
>>> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING >>
>>> flag is set, and so calls autofs4_wait with notify set to NFY_NONE.  >>
>>> However, when we take the wq sem, we find that the expire has finished,
>>>>> and thus create a new wq entry.  Because NFY_NONE is set, we don't
>>> tell >> the daemon.
>>>>>
>>>>> So how will this process ever get woken up?
>>>>>
>>>
> raven> I've thought about this for quite a while and I think all that's
> raven> needed is to recognise that we're about to expire a dentry that's
> raven> not mounted anymore.
>>>
> raven> Can you think of a case for which this patch fails?
>>> I don't see how the patch you provided addresses the race between an
>>> expire event and a lookup.  The real issue here is that the checking of
>>> AUTOFS_INF_EXPIRING and the list operations associated therewith need to
>>> happen atomically.  Until this happens, we will have races.
>>>
>>> The attached patch is more in line with how I think the problem should
>>> be fixed.  I have not yet tested or even compiled this.  Could you
>>> please look this over and comment?
>
> raven> Sorry about this but the test should be for a notify event of
> raven> NFY_NONE not NFY_EXPIRE.
>
> Oh, that makes a bit more sense.  So the patch I am commenting on is this:

That's right.

>
> @@ -191,6 +191,13 @@ int autofs4_wait(struct autofs_sb_info *
>  	}
>
>  	if ( !wq ) {
> +		/* Can't expire if we are not mounted */
> +		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
> +			kfree(name);
> +			up(&sbi->wq_sem);
> +			return -ENOENT;
> +		}
> +
>  		/* Create a new wait queue */
>  		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
>  		if ( !wq ) {
>
> The original case you mentioned was where the expire is racing with an
> access at the beginning of the expiry.  So, they both enter autofs4_wait,
> one with NFY_EXPIRE and the other with NFY_NONE.  The caller with NFY_NONE
> gets the semaphore first, and so doesn't notify the daemon.  The NFY_EXPIRE
> caller then gets added to the wait list, and no one wakes them up.  I don't
> belive your patch addresses that race, since d_mountpoint(dentry) will
> still return true.

Now my little brain is spinning.
I think that's not quite what we are discussing here.

The original patch from this thread is meant to address the race at expire 
initiation and I still believe it does. On lead in to the expire 
d_mountpoint should always be true so this test will always be false.

Following that you gave an example of a race at the tail end of the expire 
(good catch) which I believe the above patch resolves.

I thought about the possibilities for each of these cases for several days 
and I'm fairly confident that the two patches together address both 
issues.

Please, if you can think of a counter example for either case I'll be 
happy to reconsider, as always.

>
> raven> I started something similar to what you propose myself but I don't
> raven> think it's needed to resolve the issue.
>
> raven> I'll reconsider, but ...
>
> raven> One possible issue with your proposal is that the dentry info may
> raven> not yet exist for mount requests in directories that are not
> raven> browsable (ie. via lookup) as at this point we have a newly created
> raven> negative dentry that we are attempting to fill in. I'll have to
> raven> check further to see if this is actually the case.
>
> Okay, I'll look into this further, as well.
>
> raven> The point of the notify none is to "wait" until the expire operation
> raven> is done then return a fail status so that the following lookup can
> raven> perform the mount.
>
> Right.
>
> raven> To explain.
>
> raven> In this case, during the path walk the cached lookup is called as
> raven> the dentry concerned is present (it's dgot) until the very end of
> raven> the expire. The cached lookup fails as the revalidate (NFY_NONE)
> raven> returns fail and the dput allows d_invalidate to succeed. The path
> raven> walk then calls real lookup which triggers a mount following the
> raven> expire.
>
> raven> There may still be an oppertunity for a race between the time the
> raven> autofs4_release function is called and before the dput is
> raven> executed. I'll think more about that.
>
> raven> But, given the correct test, as far as the original issue you
> raven> describe is concerned I think my recommended patch covers what's
> raven> needed.
>
> raven> A single counter example is all that's needed.
>
> raven> Thanks for the help Jeff.
>
> No problem.  In case you are actually considering the patch I sent earlier,
> I missed a hunk which changes fs/autofs4/root.c.  Let me know if you want
> me to send that to you.  It basically changed try_to_fill_dentry to call
> autofs4_wait unconditionally with NFY_NONE.

I'll give that some thought but I suspect it will produce incorrect 
behaviour. I haven't checked but when the lookup is called it may prevent 
mounts from happening when they should.

We are focusing on interactions with expire here but I agree we probably 
need to do a similar analysis for the mount case. OTOH that hasn't been 
problematic as far a I can remember.

Ian

