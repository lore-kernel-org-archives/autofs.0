From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: automount usb key (vfat and ntfs)
Date: Mon, 1 Dec 2008 14:34:18 -0500
Message-ID: <20081201193418.GT13650@eeg.ccf.org>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
	<x49tz9n96ao.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49tz9n96ao.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, Dec 01, 2008 at 12:03:27PM -0500, Jeff Moyer wrote:

> If that doesn't work, then I'd suggest a program map.  Something simple
> should work:
> 
> ---[cut here]---
> #!/bin/bash
> ntfs-3g.probe /dev/sda1
> if [ $? -eq 0 ]; then
>         ntfs-3g /dev/sda1 /media/$1
>         RET=$?
> else
>         mount -t vfat /dev/sda1 /media/$1
>         RET=$?
> fi
> 
> exit $RET
> ---[cut here]---

That can be simplified:

#!/bin/sh
if ntfs-3g.probe /dev/sda1; then
	ntfs-3g /dev/sda1 /media/"$1"
else
	mount -t vfat /dev/sda1 /media/"$1"
fi

The exit status of a script is the status from the last command which
was executed, so there's no need to save $? and then exit with it later.
