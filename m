From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Mon, 15 Nov 2010 09:54:34 +0100
Message-ID: <201011150954.34289.arnd@arndb.de>
References: <4CDFDC2B.6040205@redhat.com> <4CE00194.3070601@redhat.com> <1289785533.3248.18.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1289785533.3248.18.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Avi Kivity <avi@redhat.com>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Monday 15 November 2010 02:45:33 Ian Kent wrote:

> You can't hold an exclusive mutex during an autofs expire because the
> daemon will start by calling the ioctl to check for a dentry to expire
> then call back to the daemon to perform the umount and wait for a status
> return (also an ioctl).

Ok, I see. So it's my fault for not realizing that there are long blocking
ioctls. I was under the assumption that all of these ioctl commands were
simple non-blocking commands.

> >From memory the expire is the only ioctl that is sensitive to this
> deadlock.
> 
> So, either the mutex must be released while waiting for the status
> return or get rid of the autofs4_ioctl_mutex altogether.

Right. As I said with the original patch, I don't think the mutex
is really needed, but using it seemed to be the safer alternative.
It was in the sense that it guaranteed the breakage to be obvious
rather than silent...

Ian, if you can prove that the lock is not needed, I think we shold
just remove it.

	Arnd
