From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Mon, 15 Nov 2010 21:22:21 +0800
Message-ID: <1289827341.3248.49.camel@localhost>
References: <4CDFDC2B.6040205@redhat.com> <4CE00194.3070601@redhat.com>
	 <1289785533.3248.18.camel@localhost>  <201011150954.34289.arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201011150954.34289.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Kivity <avi@redhat.com>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, 2010-11-15 at 09:54 +0100, Arnd Bergmann wrote:
> On Monday 15 November 2010 02:45:33 Ian Kent wrote:
> 
> > You can't hold an exclusive mutex during an autofs expire because the
> > daemon will start by calling the ioctl to check for a dentry to expire
> > then call back to the daemon to perform the umount and wait for a status
> > return (also an ioctl).
> 
> Ok, I see. So it's my fault for not realizing that there are long blocking
> ioctls. I was under the assumption that all of these ioctl commands were
> simple non-blocking commands.

This isn't anyone's fault (except maybe mine) because I'm the one most
likely to realize it was a problem and didn't notice it. I've even been
caught by this deadlock (when holding a singular lock) before when I
tried to use .. ummm .. netlink (I think, not even sure what it's called
any more) instead of an ioctl interface for the new autofs control
interface.

> 
> > >From memory the expire is the only ioctl that is sensitive to this
> > deadlock.
> > 
> > So, either the mutex must be released while waiting for the status
> > return or get rid of the autofs4_ioctl_mutex altogether.
> 
> Right. As I said with the original patch, I don't think the mutex
> is really needed, but using it seemed to be the safer alternative.
> It was in the sense that it guaranteed the breakage to be obvious
> rather than silent...
> 
> Ian, if you can prove that the lock is not needed, I think we shold
> just remove it.

I don't think I can prove it but I will have a long look at the code.
I don't think it is needed and I expect I'll recommend it be removed.

Oh and btw ... please excuse this off-topic question.

In your recent commit 6e9624b8caec290d28b4c6d9ec75749df6372b87 regarding
BKL removal you implied that blkdev_{get,put} shouldn't need the BLK.
I'm working on a btrfs problem and one of the issues is a deadlock
caused by the out of order acquisition of the BLK and the bdev->bd_mutex
between these two functions. Clearly this isn't a problem from 2.6.36
but do you think it would be safe just to apply the hunks for
blkdev_{get,put} from your commit to fix my problem for older an older
kernel, say 2.6.35?

Ian

