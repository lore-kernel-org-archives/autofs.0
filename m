From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] autofs: find_autofs_mount overmounted parent support
Date: Mon, 8 Mar 2021 00:12:22 +0000
Message-ID: <YEVr5jNlpu2jcdzs@zeniv-ca.linux.org.uk>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
 <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
 <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
 <YEVm+KH/R5y2rU7K@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <YEVm+KH/R5y2rU7K@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc: Ian Kent <raven@themaw.net>, Matthew Wilcox <willy@infradead.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Ross Zwisler <zwisler@google.com>, Aleksa Sarai <cyphar@cyphar.com>, Eric Biggers <ebiggers@google.com>, Mattias Nissler <mnissler@chromium.org>, linux-fsdevel@vger.kernel.org, alexander@mihalicyn.com

On Sun, Mar 07, 2021 at 11:51:20PM +0000, Al Viro wrote:
> On Thu, Mar 04, 2021 at 01:11:33PM +0300, Alexander Mikhalitsyn wrote:
> 
> > That problem connected with CRIU (Checkpoint-Restore in Userspace) project.
> > In CRIU we have support of autofs mounts C/R. To acheive that we need to use
> > ioctl's from /dev/autofs to get data about mounts, restore mount as catatonic
> > (if needed), change pipe fd and so on. But the problem is that during CRIU
> > dump we may meet situation when VFS subtree where autofs mount present was
> > overmounted as whole.
> > 
> > Simpliest example is /proc/sys/fs/binfmt_misc. This mount present on most
> > GNU/Linux distributions by default. For instance on my Fedora 33:
> > 
> > trigger automount of binfmt_misc
> > $ ls /proc/sys/fs/binfmt_misc
> > 
> > $ cat /proc/1/mountinfo | grep binfmt
> > 35 24 0:36 / /proc/sys/fs/binfmt_misc rw,relatime shared:16 - autofs systemd-1 rw,...,direct,pipe_ino=223
> > 632 35 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime shared:315 - binfmt_misc binfmt_misc rw
> > 
> > $ sudo unshare -m -p --fork --mount-proc sh
> > # cat /proc/self/mountinfo | grep "/proc"
> > 828 809 0:23 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
> > 829 828 0:36 / /proc/sys/fs/binfmt_misc rw,relatime - autofs systemd-1 rw,...,direct,pipe_ino=223
> > 943 829 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime - binfmt_misc binfmt_misc rw
> > 949 828 0:57 / /proc rw...,relatime - proc proc rw
> > 
> > As we can see now autofs mount /proc/sys/fs/binfmt_misc is inaccessible.
> > If we do something like:
> > 
> > struct autofs_dev_ioctl *param;
> > param = malloc(...);
> > devfd = open("/dev/autofs", O_RDONLY);
> > init_autofs_dev_ioctl(param);
> > param->size = size;
> > strcpy(param->path, "/proc/sys/fs/binfmt_misc");
> > param->openmount.devid = 36;
> > err = ioctl(devfd, AUTOFS_DEV_IOCTL_OPENMOUNT, param)
> > 
> > now we get err = -ENOENT.
> 
> Where does that -ENOENT come from?  AFAICS, pathwalk ought to succeed and
> return you the root of overmounting binfmt_misc.  Why doesn't the loop in
> find_autofs_mount() locate anything it would accept?
> 
> I really dislike the patch - the whole "normalize path" thing is fundamentally
> bogus, not to mention the iterator over all mounts, etc., so I would like to
> understand what the hell is going on before even thinking of *not* NAKing
> it on sight.

	Wait, so you have /proc overmounted, without anything autofs-related on
/proc/sys/fs/binfmt_misc and still want to have the pathname resolved, just
because it would've resolved with that overmount of /proc removed?

	I hope I'm misreading you; in case I'm not, the ABI is extremely
tasteless and until you manage to document the exact semantics you want
for param->path, consider it NAKed.
