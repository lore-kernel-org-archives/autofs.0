From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Tue, 16 Sep 2003 19:28:45 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F67C6DD.20901@zytor.com>
References: <Pine.LNX.4.33.0309170825300.21012-100000@wombat.indigo.net.au>
	<3F67C15D.3090805@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F67C15D.3090805@intel.com>
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
To: Arun Sharma <arun.sharma@intel.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

Arun Sharma wrote:
> Ian Kent wrote:
> 
>>> It's not clear if this is a NFS issue or a autofs issue, but it's 
>>> seen often with autofs. Are there any known race conditions that have 
>>> been fixed after 2.4.20 ? The two calls I'm worried about are:
>>>
>>> fs/autofs/root.c:305:    d_instantiate(dentry, 
>>> iget(dir->i_sb,ent->ino));
>>> fs/autofs/root.c:416:    d_instantiate(dentry, iget(dir->i_sb,ino));
>>>
>> This is in the autofs (aka v3) kernel module not autofs4.
>>
> Please ignore the above lines. I corrected myself in an earlier message. 
> The problem was seen on the autofs4 kernel module in 2.4.20 + 
> autofs-3.1.7 user daemon.
> 

Please don't mix the v3 and v4 stuff (this was a misguided change on 
Linus' part which I still very much disagree with.)

	-hpa
