From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?=<ia6432@inbox.ru>
Subject: Re[3]: [NFS] nfs or autofs related hangs
Date: Mon, 09 Feb 2004 18:37:57 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1AqDTx-000Cfl-00.ia6432-inbox-ru@f15.mail.ru>
References: <Pine.LNX.4.58.0402092254390.5821@raven.themaw.net>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402092254390.5821@raven.themaw.net>
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

On Mon, 9 Feb 2004 at 23:13:09 +0800 Ian Kent wrote:

> The info I am looking for here is the usage pattern of autofs. Stuff
> like, how many entries are in the master map,
only 3 - auto.home, auto.auto and auto.direct
> how many in the maps,
auto.home - about 300 but only about 40-60 are used in described setup
auto.auto - about 40 but only about 10-15 are used
auto.direct is realy small and it's _never_ accessed from discribed
systems...

> are they all indirect, are some direct or multi-mount,
no multi-mount and no direct accessed

> what are the usage patterns in terms of mount frequency,
> particularly if there are situations that trigger many mounts at
> once etc.
there're some schedulled tests that run on most servers at the
same time, possibly causing mounts of single nfs share at fileserver
from most "work"-servers. but there're no situations that trigger
many different mounts on one "work"-server.

> Of course it's possible this is an NFS issue.
i still wasn't able to try mounting nfs outside of /auto and /home
at the time of hang...
