From: Ian Kent <raven@themaw.net>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 09 Oct 2009 16:14:50 +0800
Message-ID: <4ACEF0FA.1060605@themaw.net>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net> <20091009074211.GD2983@wotan.suse.de> <4ACEED94.6040002@themaw.net> <20091009080709.GA17818@wotan.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091009080709.GA17818@wotan.suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Nick Piggin wrote:
> On Fri, Oct 09, 2009 at 04:00:20PM +0800, Ian Kent wrote:
>> Nick Piggin wrote:
>>> On Fri, Oct 09, 2009 at 01:47:20PM +0800, Ian Kent wrote:
>>>> Nick Piggin wrote:
>>>>> Hi,
>>>>>
>>>>> I'd just like to ask you to look at autofs4 in the context of this change.
>>>>> I don't really know what needs to be considered there. If this is a
>>>>> generally visible dentry that any other users may mount filesystems on,
>>>>> then this might be difficult to get working here.
>>>>>
>>>>> I'm not quite sure what games you're playing here with d_mounted... In the
>>>>> simplest case we might be able to just remove DCACHE_MOUNTED.
>>>> Hahaha, "games", harsh but true.
>>>>
>>>> My need is fairly simple really.
>>>>
>>>> I must be able to stop the follow down at the mount point for some cases
>>>> of a covered dentry. Which, IIRC, means that d_mountpoint() needs to be
>>>> sensitive to this requirement, and that's about all.
>>>>
>>>> This was always questionable, but seemed like the best way to do it at
>>>> the time, without adding autofs specific code to the VFS. Since we are
>>>> changing this part of the VFS now with this patch, it is a good time to
>>>> fix it in a generic non-autofs specific way.
>>> I guess you could have a flag in the vfsmount which you could then set
>>> to have lookup_mnt (and hence follow_mount etc) ignore it.
>>>
>>> Unsetting / decrementing d_mounted I guess works, but I would just
>>> be worried if other mounts can be attached to the dentry then you
>>> might ignore that other mount or even follow your autofs mount.i
>>>
>>> If there is no way to have anything else mounted here, then there
>>> shouldn't be a problem and indeed unsetting d_mounted might be the
>>> easiest approach. However you still have to be careful of a racing
>>> lookup that has found d_mounted to be true, but is yet to look up
>>> the mount hash table -- that might be tricky and is a case where
>>> the vfsmount flag approach should work better.
>> My original description was a bit simple mined.
>>
>> This is only ever done for dentrys in the autofs fs.
>>
>> Although I won't go into the ongoing and difficult problem of submounts,
>> when this is done for the common case all user space walks are blocked
>> waiting on the expire while the daemon does the umount. The reason it
>> needs to be done at all is because autofs mount types AUTOFS_TYPE_DIRECT
>> and AUTOFS_TYPE_OFFSET are such that the autofs fs is mounted on the
>> host dentry (that may also be another autofs fs) and another mount (that
>> is being expired in this case) is mounted on top of that. Hence path
>> walks skips right over the top of the dentry and into the expiring mount.
> 
> OK, that makes some sense to me ;) If nothing else can meddle
> with the dentry (like attaching a mount to it) then I see no
> problem with just clearing d_mounted.
> 
> 
>>>>> Anyway this would be great if we can make it work so I can replace the
>>>>> member with d_seq for my path walk patches and not bloat dentry. Can you
>>>>> take a look please if you have a chance?
>>>> Sure, let me have a look around and think about it for a while.
>>>>
>>>> >From a quick look it appears that all I could just change the
>>>> DCACHE_MOUNTED flag and check the actual mounted status when restoring it.
>>> OK, thanks. I'll do that as an intermediate hack here, and if you
>>> find a problem with it or if we devise a better generic approach,
>>> then I'll rip it out.
>> Ummm .. I don't seem to be able to cleanly apply this patch to a linus
>> tree or an mm tree?
>>
>> Is there a git repo I can use to work on this?
> 
> Yeah I will redo it against mainline and send it out again. I will
> get around to doing a git tree of the vfs scalability stuff after
> I get the series in a bit more reasonable shape... I'll need you to
> look at that too because autofs4 does a lot of meddling with
> dcache_lock ;)

Hehe, sorry.

np, just point me at it and I'll do what I can.

I'm open to advice on where and why I don't need to use the dcache_lock.
I think there are case where I unnecessarily take it, especially in the
changes that I have just posted to support the Sage Weil change to the
taking of the directory i_mutex over revalidate in real_lookup(). Which
are present in the mm kernel atm, if the latest one has been posted yet
that is.

Ian
