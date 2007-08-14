From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [PATCH] autofs4: deadlock during create
Date: Tue, 14 Aug 2007 10:17:45 -0400
Message-ID: <x49mywuci9i.fsf@segfault.boston.devel.redhat.com>
References: <1187087280.4963.18.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761516AbXHNOS0@vger.kernel.org>
In-Reply-To: <1187087280.4963.18.camel@raven.themaw.net> (Ian Kent's message of "Tue\, 14 Aug 2007 18\:28\:00 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Ian Kent <raven@themaw.net> writes:

> Hi,
>
> Due to inconsistent locking in the VFS between calls to lookup and
> revalidate deadlock can occur in the automounter.
>
> The inconsistency is that the directory inode mutex is held for both
> lookup and revalidate calls when called via lookup_hash whereas it is
> held only for lookup during a path walk. Consequently, if the mutex
> is held during a call to revalidate autofs4 can't release the mutex
> to callback the daemon as it can't know whether it owns the mutex.
>
> This situation happens when a process tries to create a directory
> within an automount and a second process also tries to create the
> same directory between the lookup and the mkdir. Since the first
> process has dropped the mutex for the daemon callback, the second
> process takes it during revalidate leading to deadlock between the
> autofs daemon and the second process when the daemon tries to create
> the mount point directory.
>
> After spending quite a bit of time trying to resolve this on more than
> one occassion, using rather complex and ulgy approaches, it turns out
> that just delaying the hashing of the dentry until the create operation
> work fine.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Acked-by: Jeff Moyer <jmoyer@redhat.com>

-Jeff
