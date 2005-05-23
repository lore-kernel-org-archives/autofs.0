From: raven@themaw.net
Subject: Re: [VFS-RFC] autofs4 and bind,
	rbind and move mount requests
Date: Tue, 24 May 2005 00:00:41 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu>
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

On Mon, 23 May 2005, Miklos Szeredi wrote:

>> I've been investigating a bug report about bind mounting an autofs
>> controlled mount point. It is indeed disastrous for autofs. It would be
>> simple enough it to check and fail silently but that won't give sensible
>> behavior.
>>
>> What should the semantics be for these type of mount requests against
>> autofs?
>>
>> First, a move mount doesn't make sense as it places the autofs
>> filesystem in a location that is not specified in the autofs map to which
>> it belongs. It looks like the user space daemon would loose contact with
>> the newly mounted filesystem and so it would become useless and probably
>> not umountable, not to mention how the daemon would handle it. I believe
>> that this shouldn't be allowed. What do people think? If we don't treat
>> these as invalid then how should they behave?
>
> Move is very similar to rbind + umount.  So if you find sane semantics
> for the rbind case, that should do for move as well.
>

Perhaps not in this case.

If I read it correctly rbind is a copy of the mount tree. It leaves behind 
the original. A move operation appears to copy the tree and then 
basically umounts the source tree.

For autofs the originating mount point is owned and controled by the 
userspace daemon and the corresponding automount map specifies what may be 
mounted. We can't just umount it without cooperation from the daemon.

>> Bind mount requests are another question.
>>
>> In the case of a bind mount we can find ourselves with a dentry in the
>> bound filesystem that is marked as mounted but can't be followed
>> because the parent vfsmount is in the source filesystem.
>
> I don't understand this.  A bind will just copy a vfsmount and add the
> copy to some other place in the mount tree.  It should not matter if
> the original mount was automounted or not.  What am I missing?

And assigns the same super block and root dentry.

The problem is that when an autofs dentry is walked on it sends a message 
to the userspace daemon. The daemon performs the corresponding mount, in 
the source filesystem, causing a mount to appear in the destination 
filesystem as well, but without the correct vfsmount linkages.

>
>> Should the automount functionality go along with the bind mount
>> filesystem?
>
> No.  With bind you copy the mount to another place.  Now it has
> nothing to do with the automouter, it becomes a perfectly ordinary
> mount.

An autofs4 filesystem is intimately tied to some userspace program. For me 
it's the automount daemon and the automount map defining the mountpounts 
it knows about.

This is the source of the difficulty in defining the way it should behave.

Ian
