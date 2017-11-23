From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 14:34:29 +0800
Message-ID: <710ea4ce-f20f-9f49-368e-ca992d82533d@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <87375520qy.fsf@notabene.neil.brown.name>
 <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
 <87r2spzjk0.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=r7K+yEc+fa3sGTYhTdW1WUhKiWV6d
        OxF5U+Xy869CE0=; b=cst9amBp7tJaWrMASM//Btjr2CWqYFN9wTHKWaqNN6GxZ
        eRUabyBM2RcDfZtg79oasFhL4/9uYoaUZ7uQmvn64Pw7969umwcqO66hR51gLCc6
        2B95dLqpAZUogDuHVOhQFaGbt9oL4R6dPufoGkAVHgXEg5/MvRj5Loz0ZhbyNQaC
        D4f5vqUaAUNls9zH0jWtLFd1s2Cd3DyT/GjzUSzqZGaTKFls0nOMvkU/h6biuoqP
        A+kk+z2YYeQPPs8tY+K2aLawMQw7ukoVi+a2DsZeIs4czAs029FXAas5cbzhj5nN
        fh1yWANCT1BPfK6K0EUdUHYzqf1w6M+NqUEyB7RRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=r7K+yE
        c+fa3sGTYhTdW1WUhKiWV6dOxF5U+Xy869CE0=; b=JdxyKqvm1nG8qgoDhtIWpR
        8F9ZjlbA8/GuluCyRf34fjzqr5OukisxOLzaUzO4lnEYp+kd1llxCGHrc6nd864R
        6hhZ5MQ4HpUzKgKVXjMeclH5x5YrRw6kfyJ9cL/xdJTfmj3xWxJRa6Hc7IJ9PYqb
        S4Lph7W+y8SabyDW4/idpeEe89D1LF21R3xootEoaZOrY9WvG1jclkD2h72vPh1t
        gcgEyXph7Hvf0HTBOM7ZQHHCOmS6Mstf7nP8AyWSoHixJtphFjhHotzTnUADb+KQ
        HzvJEeZkqjWUFF7rBVN7aZdja0qm3Fa9MEtLEmvRky43Nzcfxquvww4+W3sB/yuQ
        ==
In-Reply-To: <87r2spzjk0.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 23/11/17 12:49, NeilBrown wrote:
> On Thu, Nov 23 2017, Ian Kent wrote:
> 
>> On 23/11/17 10:21, NeilBrown wrote:
>>> On Thu, Nov 23 2017, Ian Kent wrote:
>>>
>>>>
>>>> Hey Neil, I'm looking at this again because RH QE have complained about
>>>> a regression test failing with a kernel that has this change.
>>>>
>>>> Maybe I'm just dumb but I though a "find <base directory> <options>"
>>>> would, well, just look at the contents below <base directory> but an
>>>> strace shows that it reads and calls fstatat() on "every entry in the
>>>> mount table" regardless of the path.
>>>
>>> weird ... I can only get find to look at the mount table if given the
>>> -fstyp option, and even then it doesn't fstatat anything that isn't in
>>> the tree it is searching.
>>
>> It's probably the -xautofs (exclude autofs fs'es) that was used in
>> the test that requires reading the mount table to get info about
>> excluding autofs mounts but the fstatat() on all the entries,
>> regardless of path, that was a surprise to me.
>>
>> find did use AT_SYMLINK_NOFOLLOW which historically behaved like
>> AT_NO_AUTOMOUNT.
>>
>>>
>>>
>>>>
>>>> And with the move of userspace to use /proc based mount tables (one
>>>> example being the symlink of /etc/mtab into /proc) even modest sized
>>>> direct mount maps will be a problem with every entry getting mounted.
>>>
>>> But the patch in question is only about indirect mount maps, isn't it?
>>> How is it relevant to direct mount maps?
>>
>> The change here will cause fstatat() to trigger direct mounts on access
>> if it doesn't use AT_NO_AUTOMOUNT.
> 
> Ahhh... light dawns.
> This is about this bit of the patch:
> 
>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>                               struct kstat *stat, int flags)
>  {
> -       return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
> -                        stat, STATX_BASIC_STATS);
> +       return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>  }
> 
> I hadn't paid much attention to that.
> 
> I before this patch:
>   stat and lstat act as you would expect AT_NO_AUTOMOUNT to act on
>       direct mount and browseable indirect mount, but not on unbrowseable
>       indirect mounts

Yep, because of the fall thru for negative dentrys at:

 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
	    path->dentry->d_inode)
		return -EISDIR;

which is missing a LOOKUP_FOLLOW check if we wanted to catch AT_SYMLINK_NOFOLLOW.

>   fstatat appeared to accept the AT_NO_AUTOMOUNT flag, but actually
>       assumed it was always set, but acted like stat and lstat

Yep, always set AT_NO_AUTOMOUNT so that it behaved the same as ....

>   xstatat actually accepted the AT_NO_AUTOMOUNT flag, but it had no
>       effect on unbrowseable indirect mounts.

Yep.

> 
> after the patch, the distinction between direct and indirect was gone,
> and fstatat now handles AT_NO_AUTOMOUNT the same as xstatat.
> So:
>   stat and lstat now don't trigger automounts even on indirect, but
>     this is a mixed blessing as they don't even trigger the mkdir

Yep.

>   fstatat without AT_NO_AUTOMOUNT now always triggers an automount
>     This is a problematic regression that you have noticed and
>     likely needs to be reverted.  Maybe we can assume
>     AT_NO_AUTOMOUNT when AT_SYMLINK_NOFOLLOW is set, and require
>     people to use xstatat if they need to set the flags separately

Yep.

The introduction of AT_NO_AUTOMOUNT (and the introduction of
follow_managed() and friends) was meant to do away with the
misleading use the AT_SYMLINK_NOFOLLOW (at the time the automount
mechanism abused the ->follow_link() method because it had similar
semantics to symlinks).

To catch the older usage pattern re-adding an AT_SYMLINK_NOFOLLOW
check would be helpful.

The reality is there are still the same old problems of unintended
mounting (mount storms) and AT_NO_AUTOMOUNT not being properly
handled.

Certainly the implementation we have now is much better but these
niggling problems remain and user space steps on them way too often,
and it feels like its much more so lately.  

>   xstatat now correctly honours AT_NO_AUTOMOUNT for indirect mounts
>     but is otherwise unchanged.

Yep, assuming we accept the ENOENT return as sensible for AT_NO_AUTOMOUNT
no browse indirect mount case. statx() being a new system call it would
be ideal to get the semantics of this call right now before it becomes well
used.

> 
> What would you think of changing the above to
> 
>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>                               struct kstat *stat, int flags)
>  {
> -       return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
> -                        stat, STATX_BASIC_STATS);
> +       return vfs_statx(dfd, filename,
> +                        (flags & AT_SYMLINK_NOFOLLOW) ? (flags |
> +                             AT_NO_AUTOMOUNT) : flags,
> +                             stat, STATX_BASIC_STATS);
>  }

Yes, I think so, and we'd need to add LOOKUP_FOLLOW to the check in
follow_automount().

Not sure I like that nested ternary in this case though.

> 
> ??
> 
> Thanks,
> NeilBrown
> 
>>
>> It's not a problem for browse indirect mounts because they are plain
>> directories within the autofs mount point not individual autofs mount
>> triggers.
>>
>>>
>>>>
>>>> Systems will cope with this fine but larger systems not so much.
>>>>
>>>> If find does this then the user space changes needed to accommodate
>>>> this sort of change are almost certainly far more than I expected.
>>>>
>>>> I think this is an example of the larger problem I'm faced with and
>>>> this change was was meant to be a starting point for resolution.
>>>>
>>>> The most obvious symptom of the problem is auto-mounts no longer able
>>>> to be expired due to being re-mounted immediately after expire. Another
>>>> symptom is unwanted (by the user) accesses causing unexpected auto-mount
>>>> attempts.
>>>>
>>>> I believe this monitoring of the mount table is what leads to excessive
>>>> CPU consumption I've seen, usually around six processes, under heavy
>>>> mount activity. And following this, when the mount table is large and
>>>> there is "no mount activity" two of the six processes continue to consume
>>>> excessive CPU, until the mount table shrinks.
>>>>
>>>> So now I'm coming around to the idea of reverting this change ..... and
>>>> going back to the drawing board.
>>>
>>> I can well imaging that a large mount table could cause problems for
>>> applications that are written to expect one, and I can imagine that
>>> autofs could cause extra issues for such a program as it might change
>>> the mount table more often.  But I haven't yet worked out how this is
>>> related to the patch in question....
>>>
>>> Thanks,
>>> NeilBrown
>>>

