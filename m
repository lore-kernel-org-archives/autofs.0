From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: nfs or autofs related hangs (additional info)
Date: Wed, 11 Feb 2004 18:28:52 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1AqwIG-000LZu-00.ia6432-inbox-ru@f21.mail.ru>
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
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Thu, 5 Feb 2004 at 08:58:43 +0800 Ian Kent wrote:

> > there're no oopses or any error messages prior to
> > hang. we have no such problem with 2.4.20aa kernels
> > but on newer servers we can't go below 2.4.22 because
> > of hardware compatibility.
>
> And this doesn't happen with manually mounted/umounted filesystems?

we just had 2 more hangs (autofs wait queue fix wasn't applied there yet)
and i've tried mounting nfs to directory not controlled by autofs. i was
able to mount nfs shares and read from them but _umount_ hung. so after
all it looks like not autofs related. it is possible that
unlink/truncate-umount race descussed recently in nfs mailing list is
the cause?
