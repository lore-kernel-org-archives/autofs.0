From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: Re[2]: [NFS] nfs or autofs related hangs
Date: Mon, 09 Feb 2004 17:32:53 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
References: <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net>
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
Cc: =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= <linux-kernel@vger.kernel.org>

On Sun, 8 Feb 2004 at 23:32:08 +0800 Ian Kent wrote:

> Looking at the trace I can't tell if autofs v4 is causing this but
> I believe there is a potential race in the wait queue code of the
> autofs4 module.
> 
> Could you try this patch please.
ok, i'll test it and let you know.
but it may take up to several days or week...
