From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 19:54:45 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F691E75.6040807@zytor.com>
References: <200309180226.h8I2QmW29876@moisil.badula.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200309180226.h8I2QmW29876@moisil.badula.org>
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
To: Ion Badulescu <lists@news.cs.columbia.edu>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

Ion Badulescu wrote:
> On Wed, 17 Sep 2003 13:41:15 -0700, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>Okay... let me ask this so I get it straight...
>>
>>Has anyone seen this (busy inodes after stopping the automounter) using 
>>autofs v3 kernel module and daemon?
> 
> Why do you bring the daemon into the picture, it is irrelevant here. 

Because it makes it a lot harder to debug the problem.

> Sure it probably does things differently which might avoid the error, 
> but the kernel issue exists nonetheless.
> 
> To answer your question again: yes, the issue is present in both v3 and
> v4 kernel modules. You can always replicate it yourself if you don't
> believe me, using the little recipe I posted earlier:
> 
> # lsmod | grep autofs
> autofs                 11236   4  (autoclean)
> # cat /proc/mounts
> [snip]
> boxter:(pid29327) /bar autofs rw 0 0
> boxter:(pid29327) /net autofs rw 0 0
> boxter:(pid29327) /src autofs rw 0 0
> boxter:(pid29327) /misc autofs rw 0 0
> buggy:/n/buggy/misc/homes /misc/homes nfs rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=buggy 0 0
> # umount /misc/homes
> # umount /misc
> # dmesg |tail
> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

OK.  Did you try Olaf's NFS patch?

	-hpa
