From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 1 Oct 2003 20:56:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310012055370.2985-100000@raven.themaw.net>
References: <3F797C61.5000706@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F797C61.5000706@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <michael.waychison@sun.com>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, Ion Badulescu <lists@news.cs.columbia.edu>, nfs@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 30 Sep 2003, Mike Waychison wrote:

> Ian Kent wrote:

> >
> >I must admit, reading through the thread, I was wondering how it could 
> >be an NFS problem.
> >
> >  
> >
> Inodes are only initialized once, when they are first allocated from the 
> slab.  Any reused inodes will continue having a bad refcount, causing 
> similar behaviour on different filesystems.
> 
> Can this be reproduced on a filesystem other than NFS for which the 
> system has never made an NFS mount?
> 

All my usage is NFS so I can't say.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
