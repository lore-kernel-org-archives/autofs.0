From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] nfs or autofs related hangs
Date: Thu, 5 Feb 2004 08:58:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402050849290.1536@wombat.indigo.net.au>
References: <E1AoQvL-0002NP-00.ia6432-inbox-ru@f21.mail.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1AoQvL-0002NP-00.ia6432-inbox-ru@f21.mail.ru>
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
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Wed, 4 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> Hello,
> 
> i'm not sure which list is correct to post about
> our problem so i'm cc'ing both autofs and nfs lists...
> 
> some of our server keep hanging (well just any nfs
> access hangs) and there're always stuck
> "umount //auto/dir" or "umount //home/dir"
> processes (btw i thought that double "/" problem
> was fixed?). 

I know, the same coding error is in the umount code. It doesn't cause 
additional problems as the kernel path walk ignores multiple slashes. I'll 
get around to fixing it, honest.

> 
> i've done sysrq-t traces (attached) when this
> happened with stock 2.4.22 + NFS_ALL (by trond) and
> with 2.4.23aa1 + autofs4-2.4.22.patch
> in both cases autofs-4.1.0 were used but there're
> the same hangs with debian autofs-3.9.99-4.0.0pre10-1
> and autofs-3.9.99-4.0.0pre10-16
> there're no oopses or any error messages prior to
> hang. we have no such problem with 2.4.20aa kernels
> but on newer servers we can't go below 2.4.22 because
> of hardware compatibility.

And this doesn't happen with manually mounted/umounted filesystems?

You probably already know that the standard response is that autofs only 
runs the mount/umount commands.

But, did the autofs4 patch apply cleanly (it should).
Does the one you are using have a date stamp 20031201 in the tar name?

You don't mention whether there's anything that looks interesting in the 
trace?

Ian
