From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 16 Nov 2005 13:25:36 -0500
Message-ID: <17275.31136.794385.872761@segfault.boston.redhat.com>
References: <20051116101740.GA9551@RAM>
	<17275.20160.12805.536289@segfault.boston.redhat.com>
	<1132160404.5720.44.camel@localhost>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1132160404.5720.44.camel@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ram Pai <linuxram@us.ibm.com>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

==> Regarding Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix; Ram Pai <linuxram@us.ibm.com> adds:

linuxram> On Wed, 2005-11-16 at 07:22, Jeff Moyer wrote:
>> ==> Regarding [autofs] [RFC PATCH]autofs4: hang and proposed fix;
>> linuxram@us.ibm.com (Ram Pai) adds:
>> 
ram> Autofs4 assumes that its ->revalidate() function gets called with the
ram> parent_dentry's_inode_semaphore released. This is true mostly but not
ram> in one particular case.
>>
ram> Process P1 calls autofs4's ->lookup(). The lookup finds that the
ram> dentry does not exist. It creates a dentry and adds to the
ram> cache. Releases the parent's inode's semaphore and than calls
ram> ->revalidate().
>>
ram> Process P2 meanwhile comes in and cached_lookup() gets called. It
ram> finds the dentry in the cache and finds ->revalidate() function
ram> exists. So it calls ->revalidate() holding the parent's inode's
ram> semaphore.
>>
ram> Now the automounter daemon comes in and tries to hold the same
ram> semaphore in order to mount. But since the semaphore is held by P2 it
ram> goes to sleep.
>>
ram> Process P1 and P2 continue waiting for the mount to complete and it
ram> never happens. Deadlock.
>>
ram> The stack of the deadlock is as follows:
>>
ram> ls S 00000000 0 13049 11954 (NOTLB) f5221df0 00000000 00000000
ram> 00000000 00000000 00000000 00000000 00000000 00000000 f5d44a70
ram> c721b520 00000000 d4f33800 003d0990 c721b9d8 f5d44030 f5d44164
ram> f5220000 f5221e3c f3dd6880 f5221e68 c0215207 f3b95580 80000000 Call
ram> Trace: [<c0215207>] autofs4_wait+0x307/0x3d0 [<c02141d3>]
ram> try_to_fill_dentry+0xf3/0x150 [<c0214389>]
ram> autofs4_revalidate+0x159/0x170 [<c02144e0>] autofs4_lookup+0x110/0x150
ram> [<c016f3f5>] __lookup_hash+0x85/0xb0 [<c016f42a>] lookup_hash+0xa/0x10
ram> [<c016f483>] lookup_one_len+0x53/0x70 [<f8851293>]
ram> stubfs_readdir+0x113/0x170 [stubfs]
>> What's stubfs?

linuxram> Its a small stub filesystem we wrote(thanks to Will Taber) to
linuxram> demonstrate the problem. All it does is holds the parent's
linuxram> inode-semaphore before calling lookup_one_len() on the dentry
linuxram> that needs a automount.

linuxram> This problem demonstrates a very very small race window which
linuxram> cannot be triggered in normal operations. The stubfs kind of
linuxram> orchestrates the exact timing to demonstrate the problem.

linuxram> note: the timing should be such that, process 1 should have added
linuxram> the newly created dentry in the dcache and jolted the automounter
linuxram> daemon.  And then process P2 has to come in asking for the same
linuxram> dentry, and should go to sleep waiting on the automounter to
linuxram> mount at the dentry. And finally the automounter has to come in.

I've been trying to reproduce this using sleeps in the user space daemon,
and I can't.  Can you post your test code so that I'm not guessing at
what's going on?  For example, one thing that's unclear is how you are
stuffing stubfs in between the vfs and autofs.

-Jeff
