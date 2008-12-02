From: Ian Kent <raven@themaw.net>
Subject: Re: automount usb key (vfat and ntfs)
Date: Tue, 02 Dec 2008 11:40:13 +0900
Message-ID: <1228185613.2954.17.camel@zeus.themaw.net>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
	<x49tz9n96ao.fsf@segfault.boston.devel.redhat.com>
	<20081201193418.GT13650@eeg.ccf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20081201193418.GT13650@eeg.ccf.org>
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
To: Greg Wooledge <wooledg@eeg.ccf.org>
Cc: autofs@linux.kernel.org

On Mon, 2008-12-01 at 14:34 -0500, Greg Wooledge wrote:
> On Mon, Dec 01, 2008 at 12:03:27PM -0500, Jeff Moyer wrote:
> 
> > If that doesn't work, then I'd suggest a program map.  Something simple
> > should work:
> > 
> > ---[cut here]---
> > #!/bin/bash
> > ntfs-3g.probe /dev/sda1
> > if [ $? -eq 0 ]; then
> >         ntfs-3g /dev/sda1 /media/$1
> >         RET=$?
> > else
> >         mount -t vfat /dev/sda1 /media/$1
> >         RET=$?
> > fi
> > 
> > exit $RET
> > ---[cut here]---
> 
> That can be simplified:
> 
> #!/bin/sh
> if ntfs-3g.probe /dev/sda1; then
> 	ntfs-3g /dev/sda1 /media/"$1"
> else
> 	mount -t vfat /dev/sda1 /media/"$1"
> fi
> 
> The exit status of a script is the status from the last command which
> was executed, so there's no need to save $? and then exit with it later.

Right, but this probably should be something like:

#!/bin/sh
if ntfs-3g.probe /dev/sda1; then
	echo "-fstype=ntfs-3g,other-opts :/dev/sda1"
else
	echo "-fstype=vfat,other-opts :/dev/sda1"
fi

Ian
