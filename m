From: raven@themaw.net
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Date: Tue, 24 May 2005 23:50:14 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505242325331.8219@donald.themaw.net>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<Pine.LNX.4.61.0505231847470.6229@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0505231847470.6229@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>

On Mon, 23 May 2005, Jim Carter wrote:

> On Mon, 23 May 2005 raven@themaw.net wrote:
>
>> I've been investigating a bug report about bind mounting an autofs
>> controlled mount point. It is indeed disastrous for autofs. It would be
>> simple enough it to check and fail silently but that won't give sensible
>> behavior.
>>
>> What should the semantics be for these type of mount requests against
>> autofs?
>
> So in the reported bug, the person did a bind mount on the toplevel autofs
> mount point.  I was expecting to see a particular server, or more likely a
> particular NFS-mounted dir from that server, as the subject of the mount.
> It's not too unreasonable to expect any of these to work transparently,
> since autofs does its magic when the user looks up a name in the autofs
> directory, and it shouldn't matter whether he got there from the original
> mount point or the bind target.  The kernel module would send the name to
> the userspace daemon, which would spawn a submount daemon or mount
> something in the original location, and the subdir and whatever is mounted
> on it ought to be visible even from the bind target.

So your in favour of a bind mount behaving in a sense like a chroot.

This I think I can do that but that's not how bind mount behaviour is 
defined in mount(8). Hence the discussion.

What I would have trouble doing is maintaining two distinct trees 
of mount points which is in line with the definition.

And there's also the question of recursive bind mounts????

>
> But evidently that's not true.  As you say, if it can't be made to work
> transparently, the next best is to make the bind mount fail.  A distant
> third choice is to say "don't do that" in the documnetation.  Sorry, no
> insights in the code; I'm just acting as a sounding board.
>
> I wonder what the person is trying to do.  Maybe a chroot jail, but it's

But an actual chroot should work as expected. If not it's a bug.

> unlikely that the client would be allowed to use the whole automount
> mechanism.  How about this concept (not what's described in the bug
> report): the client's homedir server is autofs mounted (i.e. a submount
> process is spawned) and the server dir is bind-mounted into the jail.
> Then a shell is jailed.  He can use anything on his server, using the
> out-of-jail autofs daemon to mount the filesystems, but no other host will
> be accessible.

Oh yes Miklos, we haven't even started talking about submounts, each with 
its own map! Sorry, I'm sure you have enough to do already but I thought 
you might like to follow the discussion a little further.

>
> Certainly a "move" mount should be illegal: how would the userspace daemon
> know where the main mount point had gone?

Exactly. But the pipe to the daemon should still be there (maybe). It may 
turn out that it can be handled the same way as the bind mount above. The actual 
difficulty is locating the correct vfsmount kernel struct from the module, 
which is probably now gone with during a move mount.

>
> Am I correct that if a filesystem is unmounted by force majeure, e.g.
> manually by the sysadmin or any other reason, the userspace daemon that
> mounted it may be a little unhappy but it will not suffer any permanent
> damage?  I've always assumed that to be true, in case of stubborn messed-up
> mounts.

It will catch up at the next expire event. It shouldn't cause to much 
grief. The fact that it doesn't catch up until the next expire event is a 
long standing bug.

Ian
