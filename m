From: Ian Kent <raven@themaw.net>
Subject: Re: more than 1024 mounts ==>hangs
Date: Tue, 09 Dec 2008 15:25:52 +0900
Message-ID: <1228803952.3044.53.camel@zeus.themaw.net>
References: <4937D794.6040908@itwm.fraunhofer.de>
	<1228403765.3038.118.camel@zeus.themaw.net>
	<x493ah261yt.fsf@segfault.boston.devel.redhat.com>
	<1228493730.14030.77.camel@zeus.themaw.net>
	<4939563C.3030405@itwm.fraunhofer.de>
	<493CF2E0.8000903@itwm.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <493CF2E0.8000903@itwm.fraunhofer.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Martin Vogt <vogt@itwm.fraunhofer.de>
Cc: autofs@linux.kernel.org

On Mon, 2008-12-08 at 11:11 +0100, Martin Vogt wrote:
> Martin Vogt wrote:
> > Ian Kent wrote:
> > 
> >> You would need to enable debug logging.
> >> autofs and syslog setup instructions for this can be seen at
> >> http://people.redhat.com/jmoyer.
> >>
> > 
> > I think I can simply start it with "-d" ?.
> > As from the page this logging is meant to be used when
> > the daemon ist started without debugging, but I can start
> > it directly and can directly hang autofs.
> > 
> > Hm, I think I will write a small script for you, which
> > lets you simply reproduce this behaviour.
> > 
> > (A script with 2000 direct bind mount :)
> > 
> 
> Hello list,
> 
> the following script:
> 
> #!/bin/sh
> NET=/net/pxe1/var/tmp
> for i in `seq 1 2025` ; do
>     echo "/homes/vogt${i} -fstype=bind,ro :${NET}"
> done
> 
> creates a direct mount map with 2025 direct mount.
> (I assume you know how to configure autofs how to use this map :)
> (Please really use a remote host for the mounts when you trigger
> it, for "localhost" you will find another bug, but currently I'm focused
> on the remote part, so really use a remote machine here)
> 
> Then run a find . -maxdepth 2 to really trigger the mounts.
> These are the bugs:
> 
> - SuSE 11.1 rc1 hangs on the 1024th mount(autofs-5.0.3+patches)
> - RHEL52 works (autofs-5.0.1-rc1) on mounting
> - RHEL52 has a kernel panic on unmounting (see screenshot attachment)

Looks like a known issue.

Fixed in patch series included in 2.6.27 (but there was one additional
bug fix, not related to this issue, that is included in 2.6.28).

There is no need to log a bug against RHEL-5.2 for this as the 2.6.27
(and the bug fix mentioned above) update has been ported to the RHEL
kernel and will be included in 5.3.

The patch series has been posted to this list and the commit history can
be viewed in git for upstream kernels so other vendors will need to
decide for themselves any action they may wish to take regarding this.
In fact there are several issues fixed in the update.

> 
> (started with: automount -d -f -t 600 )
> 
> For the kernel panic I started automount in the forground and hit CTRL-C
> when it was done with mounting, then after a long time, when it tries
> to umount the mounts it gives the kernel panic.
> 
> regards,
> 
> Martin
> 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
