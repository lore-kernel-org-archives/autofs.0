From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Fix typos in
 Documentation/filesystems/autofs4.txt
Date: Thu, 07 Jul 2016 12:26:25 +0800
Message-ID: <1467865585.3206.14.camel@themaw.net>
References: <1467484618-1908-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=QpbmH4g82EOBIjOiMLok8c7gHNc=; b=lzrIae
	6QuFWYkJa5Pr0SuR53MFb1FCfo2JvDjFWqskPYXqgXgjZF77IActX+sniHPhEJWH
	mH0WlUpVrJx1CsKahTlDE6pAwjBeqsxBgiQM/+vsWcZwoh1s/Ya5PDfZ8jpBUXb3
	lXS2DzNh74BHT89nE/ea6Em2l4zi4ujdvxSl8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=QpbmH4g82EOBIjO
	iMLok8c7gHNc=; b=DtLN/5dJZbWoKIayyEFj0T1mqY+OAH3DAqx1G1ddiQSAz8E
	TzBz7TzW+SD1hFpmPeueKJiR4/o3+Ix8UJ/TvJldH4MOND4uJ0TXIvwan1+5KDby
	PFTfkPoJ6Jiv6qdNEOBxZRmJCTXCkUj5qOqHe6GQU4Pu3BjGSnseM//VN7F4=
In-Reply-To: <1467484618-1908-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Sun, 2016-07-03 at 03:36 +0900, Tomohiro Kusumi wrote:
> plus minor whitespace fixes.

Also added to my patch queue.

It's great you are looking around in here.

I had completely forgotten about the interface documentation and this file needs
to be renamed as well for my autofs4 -> autofs rename series.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  Documentation/filesystems/autofs4.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/autofs4.txt
> b/Documentation/filesystems/autofs4.txt
> index 39d02e1..8fac3fe 100644
> --- a/Documentation/filesystems/autofs4.txt
> +++ b/Documentation/filesystems/autofs4.txt
> @@ -203,9 +203,9 @@ initiated or is being considered, otherwise it returns 0.
>  Mountpoint expiry
>  -----------------
>  
> -The VFS has a mechansim for automatically expiring unused mounts,
> +The VFS has a mechanism for automatically expiring unused mounts,
>  much as it can expire any unused dentry information from the dcache.
> -This is guided by the MNT_SHRINKABLE flag.  This  only applies to
> +This is guided by the MNT_SHRINKABLE flag.  This only applies to
>  mounts that were created by `d_automount()` returning a filesystem to be
>  mounted.  As autofs doesn't return such a filesystem but leaves the
>  mounting to the automount daemon, it must involve the automount daemon
> @@ -298,7 +298,7 @@ remove directories and symlinks using normal filesystem
> operations.
>  autofs knows whether a process requesting some operation is the daemon
>  or not based on its process-group id number (see getpgid(1)).
>  
> -When an autofs filesystem it mounted the pgid of the mounting
> +When an autofs filesystem is mounted the pgid of the mounting
>  processes is recorded unless the "pgrp=" option is given, in which
>  case that number is recorded instead.  Any request arriving from a
>  process in that process group is considered to come from the daemon.
> @@ -450,7 +450,7 @@ Commands are:
>      numbers for existing filesystems can be found in
>      `/proc/self/mountinfo`.
>  - **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**: same as `close(ioctlfd)`.
> -- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the  filesystem is in
> +- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the filesystem is in
>      catatonic mode, this can provide the write end of a new pipe
>      in `arg1` to re-establish communication with a daemon.  The
>      process group of the calling process is used to identify the
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
