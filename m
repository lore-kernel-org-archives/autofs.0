From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 10:57:10 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F6208F6.2080508@intel.com>
References: <3F610F3C.5040704@intel.com> <3F611BE8.6040900@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F611BE8.6040900@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

H. Peter Anvin wrote:
> 
> Which version of autofs are you running?  What version of mount(8)?
>

autofs-3.1.7 and mount-2.11g
 
> It's possible NFS lets you umount a mount which has busy inodes under
> certain conditions.

Are you thinking of the MNT_FORCE flag ? I have reasons to believe that it won't help. Mainly because if it was a RPC task that marked the inode busy, it'd have put itself on the waitq of the inode. However I found that waitqueue_active(&inode->i_wait) == 0.

	-Arun
