From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Mon, 15 Nov 2010 09:45:33 +0800
Message-ID: <1289785533.3248.18.camel@localhost>
References: <4CDFDC2B.6040205@redhat.com> <4CDFE948.4020709@redhat.com>
	 <201011141615.32166.arnd@arndb.de>  <4CE00194.3070601@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CE00194.3070601@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Avi Kivity <avi@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 2010-11-14 at 17:34 +0200, Avi Kivity wrote:
> On 11/14/2010 05:15 PM, Arnd Bergmann wrote:
> > On Sunday 14 November 2010 14:51:04 Avi Kivity wrote:
> > >  automount     S ffff88012a28a680     0   399      1 0x00000000
> > >    ffff88012a07bd08 0000000000000082 0000000000000000 0000000000000000
> > >    ffff88012a07a010 ffff88012a07bfd8 0000000000011800 ffff88012693c260
> > >    ffff88012693c5d0 ffff88012693c5c8 0000000000011800 0000000000011800
> > >  Call Trace:
> > >    [<ffffffff81056197>] ? prepare_to_wait+0x67/0x74
> > >    [<ffffffff811b23eb>] autofs4_wait+0x5a4/0x6d5
> > >    [<ffffffff81055f25>] ? autoremove_wake_function+0x0/0x34
> > >    [<ffffffff811b2ba5>] autofs4_do_expire_multi+0x5b/0xa3
> > >    [<ffffffff811b2c39>] autofs4_expire_multi+0x4c/0x54
> > >    [<ffffffff811b1750>] autofs4_root_ioctl_unlocked+0x23e/0x252
> > >    [<ffffffff811b1808>] autofs4_root_ioctl+0x39/0x53
> > >    [<ffffffff810f5e5c>] do_vfs_ioctl+0x557/0x5bb
> > >    [<ffffffff810ca644>] ? remove_vma+0x6e/0x76
> > >    [<ffffffff810cb6a2>] ? do_munmap+0x31c/0x33e
> > >    [<ffffffff810f5f02>] sys_ioctl+0x42/0x65
> > >    [<ffffffff81002b42>] system_call_fastpath+0x16/0x1b
> > >
> > >
> > >  Shouldn't we drop autofs4_ioctl_mutex while we wait?
> >
> > If the ioctl can sleep for multiple seconds, the mutex should
> > indeed be dropped, and that would be safe because we used to
> > do the same with the BKL.
> >
> > The question is why this would sleep for more than 120 seconds.
> >
> 
> Let's fix first and ask questions later.

You can't hold an exclusive mutex during an autofs expire because the
daemon will start by calling the ioctl to check for a dentry to expire
then call back to the daemon to perform the umount and wait for a status
return (also an ioctl).

From memory the expire is the only ioctl that is sensitive to this
deadlock.

So, either the mutex must be released while waiting for the status
return or get rid of the autofs4_ioctl_mutex altogether.

Ian

