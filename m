From: Mike Waychison <michael.waychison@sun.com>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Tue, 30 Sep 2003 08:51:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F797C61.5000706@sun.com>
References: <Pine.LNX.4.44.0309302012010.2982-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309302012010.2982-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, Ion Badulescu <lists@news.cs.columbia.edu>, nfs@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>

Ian Kent wrote:

>>>OK.  Did you try Olaf's NFS patch?
>>>      
>>>
>>This is not an NFS problem. The message occurs regardless of what is 
>>mounted on /misc/homes (NFS, local ext2, bind mount, whatever).
>>    
>>
>
>I must admit, reading through the thread, I was wondering how it could 
>be an NFS problem.
>
>  
>
Inodes are only initialized once, when they are first allocated from the 
slab.  Any reused inodes will continue having a bad refcount, causing 
similar behaviour on different filesystems.

Can this be reproduced on a filesystem other than NFS for which the 
system has never made an NFS mount?

Mike Waychison
