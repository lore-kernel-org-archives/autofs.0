From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 16 Nov 2005 10:22:40 -0500
Message-ID: <17275.20160.12805.536289@segfault.boston.redhat.com>
References: <20051116101740.GA9551@RAM>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: Ram Pai <linuxram@us.ibm.com>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

==> Regarding [autofs] [RFC PATCH]autofs4: hang and proposed fix; linuxram@us.ibm.com (Ram Pai) adds:

ram> Autofs4 assumes that its ->revalidate() function gets called with the
ram> parent_dentry's_inode_semaphore released. This is true mostly
ram> but not in one particular case.

ram> Process P1  calls autofs4's ->lookup(). The lookup finds that the dentry
ram> does not exist. It creates a dentry and adds to the cache. Releases
ram> the parent's inode's semaphore and than calls ->revalidate().

ram> Process P2 meanwhile comes in and cached_lookup() gets called. It finds
ram> the dentry in the cache and finds ->revalidate() function exists. So
ram> it calls ->revalidate() holding the parent's inode's semaphore.

ram> Now the automounter daemon comes in and tries to hold the same semaphore
ram> in order to mount. But since the semaphore is held by P2 it
ram> goes to sleep.

ram> Process P1 and P2 continue waiting for the mount to complete and it never
ram> happens. Deadlock.

ram> The stack of the deadlock is as follows:

ram> ls            S 00000000     0 13049  11954                     (NOTLB)
ram> f5221df0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ram> 00000000 f5d44a70 c721b520 00000000 d4f33800 003d0990 c721b9d8 f5d44030
ram> f5d44164 f5220000 f5221e3c f3dd6880 f5221e68 c0215207 f3b95580 80000000
ram> Call Trace:
ram> [<c0215207>] autofs4_wait+0x307/0x3d0
ram> [<c02141d3>] try_to_fill_dentry+0xf3/0x150
ram> [<c0214389>] autofs4_revalidate+0x159/0x170
ram> [<c02144e0>] autofs4_lookup+0x110/0x150
ram> [<c016f3f5>] __lookup_hash+0x85/0xb0
ram> [<c016f42a>] lookup_hash+0xa/0x10
ram> [<c016f483>] lookup_one_len+0x53/0x70
ram> [<f8851293>] stubfs_readdir+0x113/0x170 [stubfs]

What's stubfs?

-Jeff
