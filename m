From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 27 Nov 2005 18:47:10 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051116101740.GA9551@RAM>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "William H. Taber" <wtaber@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Wed, 16 Nov 2005, Ram Pai wrote:

> Autofs4 assumes that its ->revalidate() function gets called with the
> parent_dentry's_inode_semaphore released. This is true mostly
> but not in one particular case.
> 
> Process P1  calls autofs4's ->lookup(). The lookup finds that the dentry
> does not exist. It creates a dentry and adds to the cache. Releases
> the parent's inode's semaphore and than calls ->revalidate().
> 
> Process P2 meanwhile comes in and cached_lookup() gets called. It finds
> the dentry in the cache and finds ->revalidate() function exists. So
> it calls ->revalidate() holding the parent's inode's semaphore.
> 
> Now the automounter daemon comes in and tries to hold the same semaphore
> in order to mount. But since the semaphore is held by P2 it
> goes to sleep.
> 
> Process P1 and P2 continue waiting for the mount to complete and it never
> happens. Deadlock.
> 
> The stack of the deadlock is as follows:
> 
> ls            S 00000000     0 13049  11954                     (NOTLB)
> f5221df0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 f5d44a70 c721b520 00000000 d4f33800 003d0990 c721b9d8 f5d44030
> f5d44164 f5220000 f5221e3c f3dd6880 f5221e68 c0215207 f3b95580 80000000
> Call Trace:
> [<c0215207>] autofs4_wait+0x307/0x3d0
> [<c02141d3>] try_to_fill_dentry+0xf3/0x150
> [<c0214389>] autofs4_revalidate+0x159/0x170
> [<c02144e0>] autofs4_lookup+0x110/0x150
> [<c016f3f5>] __lookup_hash+0x85/0xb0
> [<c016f42a>] lookup_hash+0xa/0x10
> [<c016f483>] lookup_one_len+0x53/0x70
> [<f8851293>] stubfs_readdir+0x113/0x170 [stubfs]
> [<c0172fcb>] vfs_readdir+0x8b/0xa0
> [<c01733b3>] sys_getdents64+0x63/0xb5
> [<c010464d>] syscall_call+0x7/0xb
> 
> ls            S C011B1AF     0 13050  11898                     (NOTLB)
> f1337df0 00000082 f1337e04 c011b1af 06ce3f60 00000027 00000027 00000080
> 06d03f60 00000000 c721b520 00000000 d4f33800 003d0990 f1337df0 f5d44a70
> f5d44ba4 f1336000 f1337e3c f3dd6880 f1337e68 c0215207 f3b95580 80000000
> Call Trace:
> [<c0215207>] autofs4_wait+0x307/0x3d0
> [<c02141d3>] try_to_fill_dentry+0xf3/0x150
> [<c0214389>] autofs4_revalidate+0x159/0x170
> [<c016dc77>] cached_lookup+0x47/0x80
> [<c016f3ca>] __lookup_hash+0x5a/0xb0
> [<c016f42a>] lookup_hash+0xa/0x10
> [<c016f483>] lookup_one_len+0x53/0x70  
> [<f88512e3>] stubfs_readdir+0x163/0x170 [stubfs]
> [<c0172fcb>] vfs_readdir+0x8b/0xa0  
> [<c01733b3>] sys_getdents64+0x63/0xb5
> [<c010464d>] syscall_call+0x7/0xb
> 
> automount     D 00000010     0 13052  13016                     (NOTLB)
> f3321f00 fff80000 00000007 00000010 f3321f68 c7b1cd20 00000000 f3321f34
> f3321ee8 f5e92a70 c7233520 00000000 d5304100 003d0990 c7233560 f1e31a70
> f1e31ba4 f5f59914 f5f5991c 00000296 f3321f38 c03b4cd3 f1e31a70 00000001
> Call Trace:
> [<c03b4cd3>] __down+0x83/0xe0
> [<c03b3632>] __down_failed+0xa/0x10
> [<c0171e6d>] .text.lock.namei+0xeb/0x1de
> [<c0170482>] sys_mkdir+0x52/0xd0
> [<c010464d>] syscall_call+0x7/0xb
> BUG: soft lockup detected on CPU#0!
> 

Hi guys,

I've been thinking about this one for a while now and have a suggestion 
about how it may be fixed.

To re-state the problem:

The autofs4 revalidate callback needs to function properly when called 
with the inode semaphore either held or not.

Summary:

Ram Pai provided the excelent problem profile above and offered a patch 
for comment which droped the inode semaphore. Will pointed out that 
droping the semaphore was not a good thing to do because of possible side 
affects.

A fair bit of interesting discussion followed.

My thoughts:

The cause of this issue is user space programs using autofs4 need to 
call services that must be able to take the inode semaphore. Notably 
sys_mkdir and sys_symlink in order to complete their task.

I believe that, in this case, releasing the semaphore is ok since the 
entry is part of the autofs filesystem and so autofs is responsible for 
taking care of it, provided that it is done carefully. The semaphore is 
meant to serialize changes being to the directory and these changes are 
done in autofs by asking the user space process to do it. Which are 
themselves serialized by the same semaphore.

The only tricky thing I can think of here is that care must be taken to 
ensure that the semaphore is not released before the DCACHE_AUTOFS_PENDING 
flag is set to make sure that other incoming requests are sent to the wait 
queue.

The attached patch does this and opts for a conservative approach by 
broadening the critical region instead of narrowing it.

It may also be necessary to review the return codes from revaliate but I'm 
only part way through that.

Please review and test this patch and offer further comment.
Sorry guys but I haven't been able to test this at all save verifying that 
it compiles.

Hopefully I haven't missed anything completely obvious ... DOH!

Ian

--- linux-2.6.15-rc1/fs/autofs4/root.c.lookup-deadlock	2005-11-17 18:58:38.000000000 +0800
+++ linux-2.6.15-rc1/fs/autofs4/root.c	2005-11-27 17:00:40.000000000 +0800
@@ -487,11 +487,8 @@ static struct dentry *autofs4_lookup(str
 	dentry->d_fsdata = NULL;
 	d_add(dentry, NULL);
 
-	if (dentry->d_op && dentry->d_op->d_revalidate) {
-		up(&dir->i_sem);
+	if (dentry->d_op && dentry->d_op->d_revalidate)
 		(dentry->d_op->d_revalidate)(dentry, nd);
-		down(&dir->i_sem);
-	}
 
 	/*
 	 * If we are still pending, check if we had to handle
--- linux-2.6.15-rc1/fs/autofs4/waitq.c.lookup-deadlock	2005-11-27 17:09:42.000000000 +0800
+++ linux-2.6.15-rc1/fs/autofs4/waitq.c	2005-11-27 17:17:34.000000000 +0800
@@ -161,6 +161,8 @@ int autofs4_wait(struct autofs_sb_info *
 		enum autofs_notify notify)
 {
 	struct autofs_wait_queue *wq;
+	struct inode *dir = dentry->d_parent->d_inode;
+	int i_sem_held;
 	char *name;
 	int len, status;
 
@@ -227,6 +229,14 @@ int autofs4_wait(struct autofs_sb_info *
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}
 
+	/*
+	 * If we are called from lookup or lookup_hash the
+	 * the inode semaphore needs to be released for
+	 * userspace to do its thing.
+	 */
+	i_sem_held = down_trylock(&dir->i_sem);
+	up(&dir->i_sem);
+
 	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
 		int type = (notify == NFY_MOUNT ?
 			autofs_ptype_missing : autofs_ptype_expire_multi);
@@ -268,6 +278,10 @@ int autofs4_wait(struct autofs_sb_info *
 		DPRINTK("skipped sleeping");
 	}
 
+	/* Re-take the inode semaphore if it was held */
+	if (i_sem_held)
+		down(&dir->i_sem);
+
 	status = wq->status;
 
 	/* Are we the last process to need status? */
