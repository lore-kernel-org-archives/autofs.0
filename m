From: Ion Badulescu <lists@news.cs.columbia.edu>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 22:26:48 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200309180226.h8I2QmW29876@moisil.badula.org>
References: <3F68C6EB.2080706@zytor.com>
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F68C6EB.2080706@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

On Wed, 17 Sep 2003 13:41:15 -0700, H. Peter Anvin <hpa@zytor.com> wrote:
> Okay... let me ask this so I get it straight...
> 
> Has anyone seen this (busy inodes after stopping the automounter) using 
> autofs v3 kernel module and daemon?

Why do you bring the daemon into the picture, it is irrelevant here. 
Sure it probably does things differently which might avoid the error, 
but the kernel issue exists nonetheless.

To answer your question again: yes, the issue is present in both v3 and
v4 kernel modules. You can always replicate it yourself if you don't
believe me, using the little recipe I posted earlier:

# lsmod | grep autofs
autofs                 11236   4  (autoclean)
# cat /proc/mounts
[snip]
boxter:(pid29327) /bar autofs rw 0 0
boxter:(pid29327) /net autofs rw 0 0
boxter:(pid29327) /src autofs rw 0 0
boxter:(pid29327) /misc autofs rw 0 0
buggy:/n/buggy/misc/homes /misc/homes nfs rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=buggy 0 0
# umount /misc/homes
# umount /misc
# dmesg |tail
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
