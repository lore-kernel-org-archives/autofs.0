From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 13:51:04 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F6231B8.3090303@zytor.com>
References: <3F610F3C.5040704@intel.com> <3F611BE8.6040900@zytor.com>
	<3F6208F6.2080508@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F6208F6.2080508@intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Arun Sharma <arun.sharma@intel.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

Arun Sharma wrote:
> H. Peter Anvin wrote:
> 
>>
>> Which version of autofs are you running?  What version of mount(8)?
>>
> 
> autofs-3.1.7 and mount-2.11g
> 
>> It's possible NFS lets you umount a mount which has busy inodes under
>> certain conditions.
> 
> 
> Are you thinking of the MNT_FORCE flag ? I have reasons to believe that
> it won't help. Mainly because if it was a RPC task that marked the inode
> busy, it'd have put itself on the waitq of the inode. However I found
> that waitqueue_active(&inode->i_wait) == 0.
> 

No, I'm thinking about the possibility that there is a bug.

autofs depends critically on a filesystem *not* allowing itself to be
unmounted when there are busy inodes; however, this is something that
things other than autofs doesn't really stress a whole lot.

	-hpa
