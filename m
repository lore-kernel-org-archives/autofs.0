From: Ian Kent <raven@themaw.net>
Subject: Re[2]: [NFS] nfs or autofs related hangs
Date: Mon, 9 Feb 2004 23:21:12 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402092314180.5821@raven.themaw.net>
References: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
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
Cc: =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= <linux-kernel@vger.kernel.org>

On Mon, 9 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> On Sun, 8 Feb 2004 at 23:32:08 +0800 Ian Kent wrote:
> 
> > Looking at the trace I can't tell if autofs v4 is causing this but
> > I believe there is a potential race in the wait queue code of the
> > autofs4 module.
> > 
> > Could you try this patch please.
> ok, i'll test it and let you know.
> but it may take up to several days or week...
> 

No problem.

The patch is against my 20031201 autofs4.
If you wish to test against a vanila kernel I'll need to revise it.

By the way, if you use the kernel module build kit you can 'make' the 
module, then 'make install', test and then 'make uninstall' to put the 
original module back. All you need is the source tree of the running 
kernel available (and macros set in Makefile.conf). I would need to make 
a different patch for this as well.

Ian
