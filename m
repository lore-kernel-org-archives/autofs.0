From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 10:22:22 +0800
Message-ID: <1393726942.9725.5.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
	 <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
	 <1392898704.2508.26.camel@perseus.fritz.box>
	 <530625D0.7020808@molgen.mpg.de>
	 <1392946952.2495.3.camel@perseus.fritz.box>
	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4nmeM7oxOvP+i5kwHmjt3Cx2a4k=; b=RlAbPQZzRbVrLgLXLP6IxLWQ1/yc
	PfBkQOqfj8qHZPVEIXiwjK9qovRMBl31SjJGfwV2J7BAivHPBHp1JxSd+HeerUiM
	+1z8l0rC7zaN0QWm4T5V3esNtQnDM7PIvBIwqg9tf38y36vggW392HJQRNEr8AKd
	6aTW9qyz/Oo6HXM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4nmeM7oxOvP+i5kwHmjt3C
	x2a4k=; b=bFDnamKxtkZErm0T9kK3XhClUkej8lxZ6AB+jPVOMUJzamoIU4wQxk
	MRAQbu9FpgQigNrFIv6w9mlPDtlUFpM0f0eegqZsSUaCmtD+4w2J9J7fx43Zxat2
	vZzKq2OU5QSJg2PWU0V3tFnnkw9jLObvvJM/ab6lR6pnGOys4ENm0=
In-Reply-To: <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Viro <aviro@redhat.com>
Cc: Donald Buczek <buczek@molgen.mpg.de>, autofs <autofs@vger.kernel.org>

On Fri, 2014-02-28 at 08:29 -0500, Alexander Viro wrote:
> On Fri, Feb 28, 2014 at 01:12:58PM +0100, Donald Buczek wrote:
> 
> > Obviously, "cleared mounted on dentry" is missing.
> > 
> > It looks like we enter put_mountpoint() but don't get to
> > dentry->d_flags &= ~DCACHE_MOUNTED;
> > 
> > mp->m_count is not zero probably.
> > 
> > What does it mean? The mount is still locked but not in the mount hash?
> 
> No, it means that something else is mounted on the same dentry (in another
> part of mount tree, obviously).
> 
> If you mount the same fs on two different mountpoints, e.g.
> mount /dev/sda1 /mnt
> mount /dev/sda1 /tmp/foo
> you will have the same dentries seen in two places.  Now,
> mount /dev/sdb11 /mnt/a
> mount /dev/sdc5 /tmp/foo/a
> 
> and you've got two different filesystems mounted on two different places
> (/mnt/a and /tmp/foo/a).  These two places have different vfsmounts,
> but the same dentry.  struct mountpoint is associated with dentry, so
> it's also the same for both.  And it serves as a mountpoint for two
> vfsmounts - one for fs from sdb11, another for fs from sdc5.
> 
> Now umount /mnt/a; one of those two vfsmounts is gone now.  struct mountpoint
> survives, of course, and dentry is *still* a mountpoint.  sdc5 is still
> mounted on /tmp/foo/a, after all...

Ahh, right ... I'll need to think about my use (misuse) of
d_mountpoint().

Thanks Al.

