From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 22 Nov 2017 12:28:13 +0800
Message-ID: <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=vM9Wg2P7fd0A063TaMAdUsgNiy18+
        q7rNZEFlDLNNfI=; b=FDxhxfnS30nFx0MFYu0pUxBW1IZI/jxpQ34TozCBUDEdT
        laDZwxHiHuRXjdNqAdPG+/l3JH2NBVQzT20K+lyR/aB2rNYsS84WfYvUKdiTXQmP
        QMA+p0KSjs8Bol/5Gt6oXuRlyKZZThHBPsX6xQmpgLwHUvEoCDF6kAPSNFmlR/VP
        FVbvTKZlJioMeivuNZVYNgaUF25PT/+laSmQH39EfCq/GvdjWh2YJ4DJRdv/i8xb
        q4/xW0C3K27SG/T3c9Hk9LYEs1kzTO01dg+acFmoognfJiEHqYcRaQ+4vD1Ku5GB
        dJ+VdT3pldCC2ExIpcfVf29ZIF+esl3thoDkIgi4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vM9Wg2
        P7fd0A063TaMAdUsgNiy18+q7rNZEFlDLNNfI=; b=UkMg63WwCjG3pzK7JLw4M8
        zxuMqTxWy1T+A+3rO0a9778b+v7XOg10zl/dmNUaou3vTTjwF762GG+cz7oIfiZV
        Z++XtG+nCX3axMD150dQ4KUoeWl0P8ry39UJ+eQuLM+lvVOvI8ArvynQBw4I9/3Q
        UlRJUzkchx+tUnwBJuJ5qA7MVDUAD/G+vEYSLV0I8M792Q6gA5B/ZHrEHIoT90V3
        VmywRLcHy3x3i4dzfcdOiEr2IYId0COxwWZ52z69iuo9MuITGAo6mYEIG4ED8l3r
        bC9Aqra/EaxfvLoEMbvF9/UqOrOMiDE5akSmFmk+Tyy2ATUbpbTDjC5UtX0EiCaA
        ==
In-Reply-To: <874lpo2y9e.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 21/11/17 09:53, NeilBrown wrote:
> On Wed, May 10 2017, Ian Kent wrote:
> 
>> The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
>> which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
>> of an automount by the call. But this flag is unconditionally cleared
>> for all stat family system calls except statx().
>>
>> stat family system calls have always triggered mount requests for the
>> negative dentry case in follow_automount() which is intended but prevents
>> the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.
>>
>> In order to handle the AT_NO_AUTOMOUNT for both system calls the
>> negative dentry case in follow_automount() needs to be changed to
>> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
>> required flags are clear).
>>
>> AFAICT this change doesn't have any noticable side effects and may,
>> in some use cases (although I didn't see it in testing) prevent
>> unnecessary callbacks to the automount daemon.
> 
> Actually, this patch does have a noticeable side effect.

That's right.

> 
> Previously, if /home were an indirect mount point so that /home/neilb
> would mount my home directory, "ls -l /home/neilb" would always work.
> Now it doesn't.

An this is correct too.

The previous policy was that a ->lookup() would always cause a mount to
occur. It's that policy that prevents the AT_NO_AUTOMOUNT flag from being
able to work consistently.

If you set the indirect mount "browse" option that will cause the mount
point directories for each of the map keys to be pre-created. So a
directory listing will show the mount points and an attempt to access
anything within the mount point directory will cause it to be mounted.

There is still the problem of not knowing map keys when the wildcard
map entry is used.

Still, stat family systems calls have always had similar problems that
prevent consistent behavior.

> 
> This happens because "ls" calls 'lstat' on the path and when that fails
> with "ENOENT", it doesn't bother trying to open.

I know, I believe the ENOENT is appropriate because there is no mount
and no directory at the time this happens.

> 
> An alternate approach to the problem that this patch addresses is to
> *not* change follow_automount() but instead change the automount daemon
> and possibly autofs.

Perhaps, but the daemon probably doesn't have enough information to
make decisions about this so there would need to be something coming
from the kernel too.

> 
> When a notification of access for an indirect mount point is received,
> it would firstly just create the directory - not triggering a mount.
> If another notification is then received (after the directory has been
> created), it then triggers the mount.

Not sure, perhaps.

But I don't think that will work, I've had many problems with this type
behavior due to bugs and I think the the same sort of problems would be
encountered.

The indirect mount "browse" option which behaves very much like what your
suggesting is the internal program default, and has been since the initial
v5 release. Historically it is disabled on install to maintain backward
compatibility with the original Linux autofs (which is also the reason for
always triggering an automount on ->lookup()).

Perhaps now is the time for that to change. 

> 
> I suspect this might need changes to autofs to avoid races when two
> threads call lstat() on the same path at the same time.  We would need
> to ensure that automount didn't see this as two requests.... though
> maybe it already has enough locking.
> 
> Does that seem reasonable?  Should we revert this patch (as a
> regression) and do something in automount instead?

Can you check out the "browse" option behavior before we talk further
about this please.

The problem in user space now is that there is no way to control
whether an indirect mount that uses the "nobrowse" option is triggered
or not (using fstatat() or statx()) regardless of the flags used and it's
essential the AT_NO_AUTOMOUNT flag work as expected to have user space
take more care in not triggering automounts.

> 
> Thanks,
> NeilBrown
> 
> 
>>
>> It's also possible that a stat family call has been made with a
>> path that is in the process of being mounted by some other process.
>> But stat family calls should return the automount state of the path
>> as it is "now" so it shouldn't wait for mount completion.
>>
>> This is the same semantic as the positive dentry case already
>> handled.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Colin Walters <walters@redhat.com>
>> Cc: Ondrej Holy <oholy@redhat.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  fs/namei.c         |   15 ++++++++++++---
>>  include/linux/fs.h |    3 +--
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 7286f87..cd74838 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -1129,9 +1129,18 @@ static int follow_automount(struct path *path, struct nameidata *nd,
>>  	 * of the daemon to instantiate them before they can be used.
>>  	 */
>>  	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
>> -			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>> -	    path->dentry->d_inode)
>> -		return -EISDIR;
>> +			   LOOKUP_OPEN | LOOKUP_CREATE |
>> +			   LOOKUP_AUTOMOUNT))) {
>> +		/* Positive dentry that isn't meant to trigger an
>> +		 * automount, EISDIR will allow it to be used,
>> +		 * otherwise there's no mount here "now" so return
>> +		 * ENOENT.
>> +		 */
>> +		if (path->dentry->d_inode)
>> +			return -EISDIR;
>> +		else
>> +			return -ENOENT;
>> +	}
>>  
>>  	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
>>  		return -EACCES;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 26488b4..be09684 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2935,8 +2935,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
>>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>>  			      struct kstat *stat, int flags)
>>  {
>> -	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
>> -			 stat, STATX_BASIC_STATS);
>> +	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>>  }
>>  static inline int vfs_fstat(int fd, struct kstat *stat)
>>  {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
