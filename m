From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Mon, 21 Nov 2005 11:40:19 -0500
Message-ID: <4381F873.2010408@us.ibm.com>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>  <1132192362.5720.163.camel@localhost>  <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>  <437CD7D2.40003@us.ibm.com>  <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>  <437DF12A.5050805@us.ibm.com>  <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>  <437E0B62.4000306@us.ibm.com> <1132340265.5720.191.camel@localhost> <437E34D9.4050102@us.ibm.com> <Pine.LNX.4.63.0511190947540.2069@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511190947540.2069@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:
> On Fri, 18 Nov 2005, William H. Taber wrote:
> 
> 
>>Ram Pai wrote:
>>
>>>On Fri, 2005-11-18 at 09:12, William H. Taber wrote:
>>
>>>I think the problem is with cached_lookup(). It is the only place which
>>>calls ->revalidate() holding the parent's inode-semaphore AFAICT.
>>>
>>>note: cached_lookup() is only called from __lookup_hash() and
>>>__lookup_hash() is always called holding the semaphore.
>>>
>>>VFS experts agree?
>>>RP
>>>
>>
>>Ram,
>>Lookup_one_len calls lookup_hash and it is the callers of lookup_one_len that
>>are problematical.  Just as an example, lookup_one_len is called from
>>nfs_sillyrename which is called, among other places in the nfs_rename code.
>>In that path the parent i_sem is obtained in do_rename   in the vfs code
>>(namei.c). I would think that it would be extremely difficult to to change
>>that usage.  The alternative is to move the obtaining of the parent i_sem from
>>real_lookup to do_lookup.  We would also have to put the locking around the
>>d_revalidate call at return_reval in __link_path_walk.
>>
> 
>  
> Perhaps we are making this altogether to complicated.
> 
> I'm sure that there are good reasons for the locking being the way 
> it is and any attempt to change it is likely to be a disaster. So what 
> about solving this by defining a usage policy based on the intent of 
> the functions concerned.
> 
> For example.
> 
> The lookup_one_len a special use funtion to return the dentry 
> corresponding to a path element and by definition it does not follow 
> mounts or symlinks. To function correctly autofs needs to follow mounts 
> and some time soon I will be posting patches that will use the the 
> follow_link method as well.
> 
> So the policy could be that if autofs revalidate is called with the 
> directory inode semaphore held it must validate the autofs dentry itself 
> and not cause a mount request be triggered. The responsibility then 
> moves to the filesystem to check if the dentry is an autofs dentry and to 
> decide if it needs to then make an unlocked revalidate call. It is easy 
> enough to check if the semaphore is held the autofs module. The 
> filesystem check is easy enough to do once the filesystem magic number is 
> moved to one of the common autofs header files.
> 
> Thoughts?
> 
> Ian
So you are asking that lookup_one_len be modified so that it knows about 
the internals of the autofs4 so that it can determine enough to know, 
before it makes the revalidate call that the the call is going to pend 
so that it can release the lock if it needs to?  This does not seem like 
a good idea to me.  The whole point of having the d_revalidate functions 
is so the VFS does not have to know the specifics of any individual 
filesystem.

Since there does not appear to be a clear locking policy on 
d_revalidate, then the autofs4 revalidate function cannot make 
assumptions about that locking state.  This means that 
autofs4_revalidate cannot pend.  I have looked some more at the 
real_lookup code, and it is prepared for the case in which the lookup 
function returns a dentry other than the one passed in.  So here is a 
proposal that might work (but I haven't looked at the autofs4 code to 
verify this.)
1) A lookup request is made for a non-existant automounted file. 
Real_lookup calls autofs4_lookup.
2) Autofs4_lookup saves the information about this request somewhere it 
can find it again and wakes up the automount demon that it has work to 
do.  It does not put a dentry in the dentry cache and it then releases 
the parent i_sem and waits for the mount to complete.
3) Any subsequent lookup for this directory that is not from the 
automount demon will look for a mount request in progress, and if found, 
it will also release the parent lock and add itself to the wait queue.
4)The automount demon will run and get the information that it needs to 
complete the mount request and  then issue the mount.  The lookup 
request from mount will call real_lookup.  Since the demon is in OZ mode 
it does not pend, it fills in the dentry and when the dentry is fully 
ready for consumption, it calls d_add and wakes up the waiters.
5) When the waiters wake up, they get the new dentry and real_lookup 
will discard the one that had been allocated.

This keeps all of the waiting inside the autofs4 lookup function where 
the lock state is defined.  I realize that this may be a lot of work, 
but I haven't seen a possible solution that doesn't involve that.

Will
