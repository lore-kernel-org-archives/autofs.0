From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] nfs or autofs related hangs
Date: Sat, 7 Feb 2004 23:24:28 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402072320470.15570@raven.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net


I'll try to duplicate this problem.

On Wed, 4 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> Hello,
> 
> i'm not sure which list is correct to post about
> our problem so i'm cc'ing both autofs and nfs lists...
> 
> some of our server keep hanging (well just any nfs
> access hangs) and there're always stuck
> "umount //auto/dir" or "umount //home/dir"

Can you give any more context?

> 
> i've done sysrq-t traces (attached) when this
> happened with stock 2.4.22 + NFS_ALL (by trond) and
> with 2.4.23aa1 + autofs4-2.4.22.patch

I can't see an NFS_ALL for 2.4.22?

> in both cases autofs-4.1.0 were used but there're
> the same hangs with debian autofs-3.9.99-4.0.0pre10-1
> and autofs-3.9.99-4.0.0pre10-16

Was this with the same kernel module ie autofs4-2.4.22-20031201.patch

Ian
