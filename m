From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: Re[2]: [NFS] nfs or autofs related hangs
Date: Mon, 09 Feb 2004 17:24:25 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1AqCKn-0002dW-00.ia6432-inbox-ru@f22.mail.ru>
References: <Pine.LNX.4.58.0402072320470.15570@raven.themaw.net>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402072320470.15570@raven.themaw.net>
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
Cc: =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= <autofs@linux.kernel.org>, nfs@lists.sourceforge.net

On Sat, 7 Feb 2004 at 23:24:28 +0800 Ian Kent wrote:

> > some of our server keep hanging (well just any nfs
> > access hangs) and there're always stuck
> > "umount //auto/dir" or "umount //home/dir"
> Can you give any more context?
well here is our setup:

a bunch of dual p4 "work" servers (ht disabled) with 2-4gb mem

dual p3 fileserver with 1gb mem (high mem disabled) giving
/auto/* and some /home/*
(currently it runs 2.4.22aa1 + important bugfixes)

all kind of linux and solaris single cpu workstations, many of them
giving /home/<workstation_owner>

most users doing development work on "work"-servers at their
home directories - compilation (gcc and some other), debugging
(gdb, ddd, etc), testing (regression tests, benchmarks, etc.
most task with low io but high cpu load)...

i was unable to detect any unusual activity at the time of hangs.
and hangs are absolutely random.

memory checked on all servers.

anything else?

> > i've done sysrq-t traces (attached) when this
> > happened with stock 2.4.22 + NFS_ALL (by trond) and
> > with 2.4.23aa1 + autofs4-2.4.22.patch
> I can't see an NFS_ALL for 2.4.22?
i believe it was just all tronds patches for 2.4.22...

> > in both cases autofs-4.1.0 were used but there're
> > the same hangs with debian autofs-3.9.99-4.0.0pre10-1
> > and autofs-3.9.99-4.0.0pre10-16
> Was this with the same kernel module ie
> autofs4-2.4.22-20031201.patch
i can confirm that we had such hangs with at least this
configurations:
2.4.22 + trond 2.4.22 + stock autofs4 + autofs-3.9.99-4.0.0pre10-1
2.4.22 + trond 2.4.22 + stock autofs4 + autofs-3.9.99-4.0.0pre10-16
2.4.22 + trond 2.4.22 + stock autofs4 + autofs-4.1.0
2.4.23-rc4 + trond 2.4.23-rc1 + stock autofs4 + autofs-3.9.99-4.0.0pre10-1
2.4.23-rc4 + trond 2.4.23-rc1 + stock autofs4 + autofs-4.1.0
2.4.23aa1 + autofs4-2.4.22-20031201 + autofs-3.9.99-4.0.0pre10-1
2.4.23aa1 + autofs4-2.4.22-20031201 + autofs-4.1.0
