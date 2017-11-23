From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 08:36:49 +0800
Message-ID: <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=38g11eqZMIdLB7WVvSG52ahvlZdST
        2ESVjXUxnH6+/4=; b=Pd2g7CxtNuiWFKMNcVBCaQ53IJvsXvXdKUmkpwjfRF6Fu
        zl7pl4unlYozaJzXqMJCy06MAjJKPoAmmeyScJuQ/LA+cZNlhbolrAmdTRF8mcsa
        vNdtLk3Dx/VYWm/EjbOEI/UhdnT2/Zpx1GCpjnvf4c6fqVSDX7HC0qFEPdp2vuzb
        e0tfaPY8muSY28wh+KoDG/0nLpqlKcLv3JfROBdnNF93DbncLkOIpJdAT1UtfjgI
        LVdaePjPz3VhpUDvoTx105FGlocjWnyObD2f1xqYfHJ/eM5EZwB3jJx2Ke6w1Jf2
        qJC/7sdzfUWu8OW2qpLZ26nz5dViu4O8ukOEd1YTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=38g11e
        qZMIdLB7WVvSG52ahvlZdST2ESVjXUxnH6+/4=; b=hs5me3BSLUyXaieK8o1k7b
        CS+ejk7QcjnUpIznsBQq50rNSSDqUJ/6RnSvdod6kSqCdOhhWfIQW6Zb+BXZnW6c
        VNlzgp+/qa/d9wl9nXYA5rza+OigMprQ5/n0z/hDRTozHLXMHCuUIMP+djADGPu7
        EaeaNU8fPIoe/FR45/VhTzRA6PsritKdbiayBsFJqhC8CHycuAT3XfTLcOwiKgyE
        UU/67ZC9ACUgNbDLHDS6HXqlklxrfEcn3HFaYogEfY9c3pADwUz01ctih8s3ysPu
        UGeM9VH1PFxDd1eMT141H57fjHubNMHzlYrNSIZEKQRMbqo/jN4L5LuLDnUT5AMw
        ==
In-Reply-To: <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 22/11/17 12:28, Ian Kent wrote:
> On 21/11/17 09:53, NeilBrown wrote:
>> On Wed, May 10 2017, Ian Kent wrote:
>>
>>> The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
>>> which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
>>> of an automount by the call. But this flag is unconditionally cleared
>>> for all stat family system calls except statx().
>>>
>>> stat family system calls have always triggered mount requests for the
>>> negative dentry case in follow_automount() which is intended but prevents
>>> the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.
>>>
>>> In order to handle the AT_NO_AUTOMOUNT for both system calls the
>>> negative dentry case in follow_automount() needs to be changed to
>>> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
>>> required flags are clear).
>>>
>>> AFAICT this change doesn't have any noticable side effects and may,
>>> in some use cases (although I didn't see it in testing) prevent
>>> unnecessary callbacks to the automount daemon.
>>
>> Actually, this patch does have a noticeable side effect.
> 
> That's right.
> 
>>
>> Previously, if /home were an indirect mount point so that /home/neilb
>> would mount my home directory, "ls -l /home/neilb" would always work.
>> Now it doesn't.
> 
> An this is correct too.
> 
> The previous policy was that a ->lookup() would always cause a mount to
> occur. It's that policy that prevents the AT_NO_AUTOMOUNT flag from being
> able to work consistently.
> 
> If you set the indirect mount "browse" option that will cause the mount
> point directories for each of the map keys to be pre-created. So a
> directory listing will show the mount points and an attempt to access
> anything within the mount point directory will cause it to be mounted.
> 
> There is still the problem of not knowing map keys when the wildcard
> map entry is used.
> 
> Still, stat family systems calls have always had similar problems that
> prevent consistent behavior.
> 
>>
>> This happens because "ls" calls 'lstat' on the path and when that fails
>> with "ENOENT", it doesn't bother trying to open.
> 
> I know, I believe the ENOENT is appropriate because there is no mount
> and no directory at the time this happens.
> 
>>
>> An alternate approach to the problem that this patch addresses is to
>> *not* change follow_automount() but instead change the automount daemon
>> and possibly autofs.
> 
> Perhaps, but the daemon probably doesn't have enough information to
> make decisions about this so there would need to be something coming
> from the kernel too.
> 
>>
>> When a notification of access for an indirect mount point is received,
>> it would firstly just create the directory - not triggering a mount.
>> If another notification is then received (after the directory has been
>> created), it then triggers the mount.
> 
> Not sure, perhaps.
> 
> But I don't think that will work, I've had many problems with this type
> behavior due to bugs and I think the the same sort of problems would be
> encountered.
> 
> The indirect mount "browse" option which behaves very much like what your
> suggesting is the internal program default, and has been since the initial
> v5 release. Historically it is disabled on install to maintain backward
> compatibility with the original Linux autofs (which is also the reason for
> always triggering an automount on ->lookup()).
> 
> Perhaps now is the time for that to change. 
> 
>>
>> I suspect this might need changes to autofs to avoid races when two
>> threads call lstat() on the same path at the same time.  We would need
>> to ensure that automount didn't see this as two requests.... though
>> maybe it already has enough locking.
>>
>> Does that seem reasonable?  Should we revert this patch (as a
>> regression) and do something in automount instead?

Hey Neil, I'm looking at this again because RH QE have complained about
a regression test failing with a kernel that has this change.

Maybe I'm just dumb but I though a "find <base directory> <options>"
would, well, just look at the contents below <base directory> but an
strace shows that it reads and calls fstatat() on "every entry in the
mount table" regardless of the path.

And with the move of userspace to use /proc based mount tables (one
example being the symlink of /etc/mtab into /proc) even modest sized
direct mount maps will be a problem with every entry getting mounted.

Systems will cope with this fine but larger systems not so much.

If find does this then the user space changes needed to accommodate
this sort of change are almost certainly far more than I expected.

I think this is an example of the larger problem I'm faced with and
this change was was meant to be a starting point for resolution.

The most obvious symptom of the problem is auto-mounts no longer able
to be expired due to being re-mounted immediately after expire. Another
symptom is unwanted (by the user) accesses causing unexpected auto-mount
attempts.

I believe this monitoring of the mount table is what leads to excessive
CPU consumption I've seen, usually around six processes, under heavy
mount activity. And following this, when the mount table is large and
there is "no mount activity" two of the six processes continue to consume
excessive CPU, until the mount table shrinks.

So now I'm coming around to the idea of reverting this change ..... and
going back to the drawing board.

> 
> Can you check out the "browse" option behavior before we talk further
> about this please.
> 
> The problem in user space now is that there is no way to control
> whether an indirect mount that uses the "nobrowse" option is triggered
> or not (using fstatat() or statx()) regardless of the flags used and it's
> essential the AT_NO_AUTOMOUNT flag work as expected to have user space
> take more care in not triggering automounts.
> 
>>
>> Thanks,
>> NeilBrown
>>
>>
>>>
>>> It's also possible that a stat family call has been made with a
>>> path that is in the process of being mounted by some other process.
>>> But stat family calls should return the automount state of the path
>>> as it is "now" so it shouldn't wait for mount completion.
>>>
>>> This is the same semantic as the positive dentry case already
>>> handled.
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: Colin Walters <walters@redhat.com>
>>> Cc: Ondrej Holy <oholy@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  fs/namei.c         |   15 ++++++++++++---
>>>  include/linux/fs.h |    3 +--
>>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/namei.c b/fs/namei.c
>>> index 7286f87..cd74838 100644
>>> --- a/fs/namei.c
>>> +++ b/fs/namei.c
>>> @@ -1129,9 +1129,18 @@ static int follow_automount(struct path *path, struct nameidata *nd,
>>>  	 * of the daemon to instantiate them before they can be used.
>>>  	 */
>>>  	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
>>> -			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>>> -	    path->dentry->d_inode)
>>> -		return -EISDIR;
>>> +			   LOOKUP_OPEN | LOOKUP_CREATE |
>>> +			   LOOKUP_AUTOMOUNT))) {
>>> +		/* Positive dentry that isn't meant to trigger an
>>> +		 * automount, EISDIR will allow it to be used,
>>> +		 * otherwise there's no mount here "now" so return
>>> +		 * ENOENT.
>>> +		 */
>>> +		if (path->dentry->d_inode)
>>> +			return -EISDIR;
>>> +		else
>>> +			return -ENOENT;
>>> +	}
>>>  
>>>  	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
>>>  		return -EACCES;
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 26488b4..be09684 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -2935,8 +2935,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
>>>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>>>  			      struct kstat *stat, int flags)
>>>  {
>>> -	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
>>> -			 stat, STATX_BASIC_STATS);
>>> +	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>>>  }
>>>  static inline int vfs_fstat(int fd, struct kstat *stat)
>>>  {
> 

