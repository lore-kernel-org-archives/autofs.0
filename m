From: raven@themaw.net
Subject: Re: Re: [NFS] Re: Busy inodes after unmount followed by
 Oops
Date: Sat, 22 May 2004 23:24:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405222320471.6824@donald.themaw.net>
References: <3FFE8B28.1E645E4E@moving-picture.com>
	<40AE23DC.6C240DAE@moving-picture.com>
	<40AE3532.8EBA0D7B@moving-picture.com>
	<Pine.LNX.4.58.0405222250470.6824@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405222250470.6824@donald.themaw.net>
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
To: Greg Banks <gnb@sgi.com>
Cc: autofs@linux.kernel.org, James Pearson <james-p@moving-picture.com>, nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>

On Sat, 22 May 2004 raven@themaw.net wrote:

> 
> There is the possibility that it is now hidden as I cannot give you an 
> exact decription of how this occurs except for the above observations.
> 
> There's not much doubt in my mind that there was a potential race for the 
> wait q. There are 4 possible execution paths that modify the wait q 
> struct. Two are syncronous (so really are only one) but two are not.

Auugh. It's not as simple as that either in 2.4 due to the use of the BKL 
and a flag in autofs dentry struct. But I maintain there at least two 
paths that are timing sensitive.

Ian
