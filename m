From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: Re[2]: [NFS] nfs or autofs related hangs
Date: Thu, 05 Feb 2004 17:44:43 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1AokkF-0002Gu-00.ia6432-inbox-ru@f19.mail.ru>
References: <Pine.LNX.4.58.0402050849290.1536@wombat.indigo.net.au>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402050849290.1536@wombat.indigo.net.au>
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
To: =?koi8-r?Q?=22?=Ian Kent=?koi8-r?Q?=22=20?= <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, 5 Feb 2004 at 08:58:43 +0800 Ian Kent wrote:

> > i've done sysrq-t traces (attached) when this
> > happened with stock 2.4.22 + NFS_ALL (by trond) and
> > with 2.4.23aa1 + autofs4-2.4.22.patch
> > in both cases autofs-4.1.0 were used but there're
> > the same hangs with debian autofs-3.9.99-4.0.0pre10-1
> > and autofs-3.9.99-4.0.0pre10-16
> > there're no oopses or any error messages prior to
> > hang. we have no such problem with 2.4.20aa kernels
> > but on newer servers we can't go below 2.4.22 because
> > of hardware compatibility.
> 
> And this doesn't happen with manually mounted/umounted filesystems?
next time i'll try to mount some nfs shares to different location...

> You probably already know that the standard response is that autofs
> only runs the mount/umount commands.

> But, did the autofs4 patch apply cleanly (it should).
absolutely

> Does the one you are using have a date stamp 20031201 in the tar
> name?
yes

> You don't mention whether there's anything that looks interesting
> in the trace?
that's because i don't know what to look for. any aplication
accessing nfs hangs in 'D' state and all unmounts just sleeping.
