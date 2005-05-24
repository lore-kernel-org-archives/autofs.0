From: raven@themaw.net
Subject: Re: [VFS-RFC] autofs4 and bind,
	rbind and move mount requests
Date: Tue, 24 May 2005 23:24:07 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505242215330.8219@donald.themaw.net>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
	<E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>
	<E1DaSRW-0003V9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1DaSRW-0003V9-00@dorka.pomaz.szeredi.hu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Miklos Szeredi wrote:

>>>> Perhaps not in this case.
>>>
>>> Maybe I'm misunderstanding.
>>>
>>> Are you talking about an automounted filesystem, or the autofs
>>> filesystem itself.
>>
>> I'm talking about the autofs filesystem (actually the autofs4 module).
>
> OK.
>
>>>
>>> With the later I can well imagine that you have problems with bind and
>>> move.
>>
>> yep.
>>
>> I'm not really concerned about whether bind and move mounts work or not. I
>> just need to establish whether these should be supported and if so, how
>> they should work so I can resolve the problem. Personally, I would be
>> happy to say these types of mounts are not supported by autofs if I could
>> veto the requests.
>
> Does it work if somebody renames a directory in the path leading to
> the autofs mountpoint?  The result is very similar to move mount.

Don't know but I doubt it.
I don't think it should because autofs needs be true to the mount maps 
that define what automounts are to be provided.

>
> You could solve both, by having the automoutnter daemon chdir to the
> autofs root, and then it would just not care about any namespace
> changes outside it's own filesystem.

Perhaps but I think it will not be that simple.
It's worth thinking about.

I'm working on providing full direct mount support atm (I have limited 
functionality now). I will have many autofs mounts handled by a single 
daemon. So that makes it a bit harder. This will be done using a file 
handle to identify (for map entry lookup) each direct mount point in the 
map, but still I suspect the corresponding vfsmount will end up being 
wrong. I'm also thinking of doing this for indirect mounts during this 
rework. A similar approach I think, to what you describe below.

I must point out that my current focus is to push the current autofs 
implementation as far as it can go within its original design. Which is 
probably not much further than implementing functionaly workable direct 
mounts. This means that multiple namespace support is not under 
consideration. Indeed the current design will not easily lend itself to 
it.

Mike Waychison was working on a new version to address this and other 
limitations of the current design but development of this seems to have 
stopped.

>
> Bind and clone(... CLONE_NEWNS) are trickier if you want to make
> automounting work in the new instance.  It should be workable, if the
> autofs kernel module returns a reference not just to the dentry but
> the dentry/vfsmount pair to the daemon.  For example it could open a
> file descriptor with dentry_open() refering to the mountpoint, and
> pass that to userspace.  The daemon then can do the mount on in
> (either by doing fchdir(fd) and 'mount blah .', or 'mount blah
> /proc/PID/fd/FD').
>
> This is all very theoretical, I don't know how the internals of
> autofs...
>
> On a related note, have you looked at using the kernel atumounter
> support for autofs? (Documentation/filesystems/automount-support.txt)

I saw that code when I was looking at this problem.
It looks quite interesting.
Again, I'll have to think about it.
Changes of that magnitude won't happen quickly.
It's already been a hard slog to get autofs to a reasonably stable state.

When I was looking at it I didn't see anything that would help with some 
of the issues such as:

1) lazy mount/umount/expire of a tree of mount points (needs to be handled 
atomically).
2) Didn't see anything relating to expire timeouts just busyness.
3) I don't think that item (1) in the file you refer to above is correct. 
The nameidata struct passed to follow_link assumes that a mount point has 
not been followed prior to the call. So this approach can't work for 
direct mounts without some more work in the VFS. Maybe it can be done 
another way but I'm not aware of it.
5) It seems that exporting the vfsmount_lock so it can be used in a 
module is not good pratice (at least that was the case the last time I 
needed it).

Please don't get me wrong. I did notice this code (but not the doco) and 
it does look really useful to me but it means a significant redesign of 
autofs. I need what's currently in place to work as it's likely to be 
around for quite a while yet.

What I really need is agreement that adding a super_operations method such 
as "mount" is acceptable so that I can veto bind and move mounts with the 
current version. Perhaps I can do it another way ?????

Ian
