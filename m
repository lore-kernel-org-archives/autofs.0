From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount usb key (vfat and ntfs)
Date: Mon, 01 Dec 2008 12:03:27 -0500
Message-ID: <x49tz9n96ao.fsf@segfault.boston.devel.redhat.com>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
	(Paolo Minazzi's message of "Mon, 1 Dec 2008 14:42:57 +0100")
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
To: Paolo Minazzi <paolo.minazzi@gmail.com>
Cc: autofs@linux.kernel.org

"Paolo Minazzi" <paolo.minazzi@gmail.com> writes:

> Hi,
> I'd like to use automount in an arm embedded system to mount
> automatically usb keys.
> I have done it for vfat and all is OK.
> Now I'd like to include also ntfs file system, so my system can
> automount also ntfs filesystems.
>
> I have searched in this list, but I have not found a post that shows
> how do it in a CLEAN way.
>
> This is my /etc/auto.misc
>
>>>> /etc/auto.misc
> pen   -fstype=vfat   :/dev/sda1
>
> I run automount in this way :
>>>>  /sbin/automount --timeout=20 /media file /etc/auto.misc
>
> I would like to add ntfs (using ntfs-3g fuse driver).
> I have tried two ways to do it, but no one is very good.
>
> ** 1 **
> I have tried this /etc/auto.misc:
>
> pen   -fstype=vfat        :/dev/sda1
> pen   -fstype=ntfs-3g   :/dev/sda1
>
> ** 2 **
> I have tried an executable map, but in this way I will need to
> identify the filesystem type (for example using fdisk -l) and I will
> prefer to avoid to do in this way.
>
>
>
>
> In my opinion the best way should be the ** 1**.
> Automount should try first to mount as vfat, and if it fails try ** 2
> **(ntfs-3g)
> But the syntax I used does not work ok.
>
> There is a way to do it ?

In my opinion, mount should automatically mount the file system without
having to be told the fstype.

If that doesn't work, then I'd suggest a program map.  Something simple
should work:

---[cut here]---
#!/bin/bash
ntfs-3g.probe /dev/sda1
if [ $? -eq 0 ]; then
        ntfs-3g /dev/sda1 /media/$1
        RET=$?
else
        mount -t vfat /dev/sda1 /media/$1
        RET=$?
fi

exit $RET
---[cut here]---

I know this is an embedded system, but don't you still have hal/udev and
hotplug events?  Personally, I have no experience wiring these things
up, but I think that's the right place for this sort of thing.

Cheers,
Jeff
