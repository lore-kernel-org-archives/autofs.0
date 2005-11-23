From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 23 Nov 2005 22:11:28 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511232118220.3200@donald.themaw.net>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>
  <1132192362.5720.163.camel@localhost>  <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
  <437CD7D2.40003@us.ibm.com>  <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>
  <437DF12A.5050805@us.ibm.com>  <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>
  <437E0B62.4000306@us.ibm.com> <1132340265.5720.191.camel@localhost>
 <437E34D9.4050102@us.ibm.com> <Pine.LNX.4.63.0511190947540.2069@donald.themaw.net>
 <4381F873.2010408@us.ibm.com> <Pine.LNX.4.58.0511220724250.16196@wombat.indigo.net.au>
 <438359FA.4060105@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <438359FA.4060105@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, 22 Nov 2005, William H. Taber wrote:

> Ian Kent wrote:
> 
> > > > Perhaps we are making this altogether to complicated.
> > > > 
> > > > I'm sure that there are good reasons for the locking being the way it is
> > > > and any attempt to change it is likely to be a disaster. So what about
> > > > solving this by defining a usage policy based on the intent of the
> > > > functions concerned.
> 
> While we have been discussing this I have been playing with adding locks
> around the d_revalidate calls and it is difficult (or I am obtuse).  If I can
> get that to work it will be the simplest approach but so far I am getting
> worse deadlocks.
> 
> > > > 
> > > > For example.
> > > > 
> > > > The lookup_one_len a special use funtion to return the dentry
> > > > corresponding to a path element and by definition it does not follow
> > > > mounts or symlinks. To function correctly autofs needs to follow mounts
> > > > and some time soon I will be posting patches that will use the the
> > > > follow_link method as well.
> > > > 
> > > > So the policy could be that if autofs revalidate is called with the
> > > > directory inode semaphore held it must validate the autofs dentry itself
> > > > and not cause a mount request be triggered. The responsibility then
> > > > moves to the filesystem to check if the dentry is an autofs dentry and
> > > > to decide if it needs to then make an unlocked revalidate call. It is
> > > > easy enough to check if the semaphore is held the autofs module. The
> > > > filesystem check is easy enough to do once the filesystem magic number
> > > > is moved to one of the common autofs header files.
> > > > 
> > > > Thoughts?
> > > > 
> > > > Ian
> > > 
> > > So you are asking that lookup_one_len be modified so that it knows about
> > > the internals of the autofs4 so that it can determine enough to know,
> > > before it makes the revalidate call that the the call is going to pend so
> > > that it can release the lock if it needs to?  This does not seem like a
> > > good idea to me.  The whole point of having the d_revalidate functions is
> > > so the VFS does not have to know the specifics of any individual
> > > filesystem.
> > 
> > 
> > No not at all. Absolutely, that would be a bad idea.
> > I thought my description above was fairly clear but obviously not.
> > 
> Or maybe I was being dense. :^)
> > 
> > > Since there does not appear to be a clear locking policy on d_revalidate,
> > > then the autofs4 revalidate function cannot make assumptions about that
> > > locking state.  This means that 
> > 
> > 
> > I'm not suggesting that either. However, it is relatively simple to check if
> > a semaphore is held by someone outside of your code (my code in this case,
> > see down_trylock()). I think that checking would be safe as if the semaphore
> > is held by someone else trylock fails and autofs can assume an equivelent
> > state to oz_mode, passing through not mounting anything. If the semaphore is
> > not held trylock succeeds and autofs can immediately release the semaphore
> > and continue. Can you think of any examples of this being unsafe?
> > 
> > 
> I am not sure about safety.  I haven't researched all of the callers to
> lookup_one_len.  But what is the effect of this on the lookup itself? If your
> revalidate functions returns true, then the caller will expect to have a
> dentry that they can use.  Most likely the next thing they will do is to try
> to cross the mountpoint.  But the mountpoint might not be set up yet.
> Alternatively, you can return false but then the vfs will call d_invalidate on
> the dentry.  Either d_invalidate succeeds and the dentry is unhashed and the
> autofs lookup function is called or it returns -EBUSY, at which point the
> lookup fails and returns the error. The first case is essentially what I was
> proposing, except that I said not to even bother putting the dentry into the
> hash chains at all.  The
> EBUSY case is probably not what you want.

OK I think I'm starting to get what your saying. I guess I didn't want to 
hear it because I've been moving toward pushing everything to revalidate.

For some reason I woke up early this morning. I read your reply and I've 
been thinking about it all day (hard to change gears when there's a 
challenge like this, bad for work, fun for me, I'm sure I'll get cained 
for being somewhere else).

To verify I've got it this time all you are saying is, avoid revalidate by 
keeping all unmounted dentrys unhashed? Nothing much more really?

I haven't really thought it through completely yet. You've noticed I'm 
not a quick study no doubt.

So far it seems doable though. One problem point could be if one of these 
lookups come in during user space daemon startup but that's detail atm.

Following startup I have two cases to deal with (i'm only listing them 
cause I think you missed case 2):

1) No directory exists - it's created by the daemon during the callback to 
the userspace before it perform the mount.

2) Directory already exists - created at startup before any mount 
activity.

Case 2 needs special attention. To achieve this I would need to have two 
types of unhashed dentry, valid and invalid (perhaps because of a ENOENT 
return from the daemon on mount).

Not really that hard to do I think.

I'd need to rework the readdir code to fill unhashed, valid dentrys and I 
can set status on the return codes from the daemon. There's likely a bunch 
of other detail as well.

Unfortuneatly for me this is only half of the solution ... see below.

> 
> > > autofs4_revalidate cannot pend.  I have looked some more at the 
> > 
> > 
> > Exactly and that's what I'm suggesting. Take account of what the
> > lookup_one_len is advertised to do. My point is that lookup_one_len is not
> > supposed to follow mounts or soft links, by definition, so it shouldn't
> > cause autofs to trigger any mounts. If a filesystem wants to use it then it
> > then it needs to take account of its defined behaviour, warts and all.
> > 
> I am not expecting lookup_one_len to follow mount points.  I expect to follow
> them myself.  But I do expect that if this is a mountpoint, that autofs will
> set it up for me.  If not, what is the point of an automounter?
> > 
> > > real_lookup code, and it is prepared for the case in which the lookup
> > > function returns a dentry other than the one passed in.  So here is a
> > > proposal that might work (but I haven't looked at the autofs4 code to
> > > verify this.)
> > > 1) A lookup request is made for a non-existant automounted file.
> > > Real_lookup calls autofs4_lookup.
> > > 2) Autofs4_lookup saves the information about this request somewhere it
> > > can find it again and wakes up the automount demon that it has work to do.
> > > It does not put a dentry in the dentry cache and it then releases the
> > > parent i_sem and waits for the mount to complete.
> > > 3) Any subsequent lookup for this directory that is not from the automount
> > > demon will look for a mount request in progress, and if found, it will
> > > also release the parent lock and add itself to the wait queue.
> > > 4)The automount demon will run and get the information that it needs to
> > > complete the mount request and  then issue the mount.  The lookup request
> > > from mount will call real_lookup.  Since the demon is in OZ mode it does
> > > not pend, it fills in the dentry and when the dentry is fully ready for
> > > consumption, it calls d_add and wakes up the waiters.
> > > 5) When the waiters wake up, they get the new dentry and real_lookup will
> > > discard the one that had been allocated.
> > > 
> > > This keeps all of the waiting inside the autofs4 lookup function where the
> > > lock state is defined.  I realize that this may be a lot of work, but I
> > > haven't seen a possible solution that doesn't involve that.
> > 
> > 
> > Sounds like a lot of work and likely quite interesting but directories can
> > and often do exist in the autofs filesystem that don't have active mounts. 
> > For these directories only the revaidate method is called at auto mount
> > time. It's worth remembering that, as autofs is a pseudo filesystem, it pins
> > the dentry for each of its objects so they don't go away. Maybe you're
> > suggesting I change this?
> 
> Exactly.  If the dentries are unhashed at umount time then the revalidate case
> is not an issue.  I don't know the how much work is invovled in setting things
> up in the first place so you might want to cache your unused dentries yourself
> if that avoids having to reread the autofs configuration files.  But that is
> an implementation detail for you to consider.
> > 
> > Sorry, I don't mean to be rude but I'm suggesting your using lookup_one_len
> > incorectly. I'll need to look at other code to see if this actually holds
> > true, but, as automounting is usually not the first thing that people think
> > of when they are writting a filesystem I expect I won't get much support
> > from there either. 
> 
> I don't know what you mean by using it incorrectly.  We have a shadow
> filesytem and our lookup function is being called and we are trying to find
> the corresponding file/directory in the root filesystem.  We are calling
> lookup_one_len because we are trying to find the next name in the path.  We
> are prepared to handle mountpoint crossings, but as I said above, the
> mountpoint needs to be setup so we can cross it.  We cannot call path_walk or
> its variants because we do not have the entire path.
> 
> 
> > 
> > What I'm proposing is:
> > 
> > 1) lookup_one_len should never cause anything to be auto
> >    mounted because of its defined behaviour and autofs
> >    should behave in line with this definition.
> 
> What defined behaviour?  The purpose of autofs is to automount directories.  I
> am not looking for you to cross a mountpoint for me, I just want you to setup
> the mount so I can cross it myself.
> > 2) The filesystem that calls lookup_one_len directly or
> >    indirectly is responsibe for checking if it has walked
> >    onto an autofs dentry and decide what action it should
> >    take.
> And what action would that be?  Not enter into any autofs directory tree?  Do
> the mount myself?  Return ENOENT?  Return inconsistent results based on
> whether someone else has triggered the automount for me?

I was thinking of something like EAGAIN to the calling fs - meaning, ok 
but I need to be revalidated (lockles) for you to be sure.

> 
> And from an interface perspective, a caller of a function like lookup_one_len
> should never have to worry about the implementation of the underlying
> filesystem, or even have to know or care what the filesystem is.
> > 
> > I thought that this was quite sensible and a fairly simple resolution?
> But it defeats the whole purpose of having an automounter.

Yep. Sigh.

But there's more. The Linux autofs implementation lacks some crucial 
features which I really want to add.

I posted an RFC to LKML and had no interest but, since it relates to this 
issue, I'd really appreciate it if you could give it a quick read and 
perhaps help out a bit with your thoughts.

http://themaw.net/direct.txt

The issue that comes up with this is that, for this to work the fs would 
have to do

if (follow_link inode method is defined)
	call follow_link

where as 

if (S_ISLNK(...))
	call follow_link

won't work.

Of course the other way to do it would be to add another method but that 
would complicate an already busy link_path_walk. I don't think people 
would agree with that.

The side affects of setting the link bit would have undesirable 
consequences.

Ideas?

Ian

