From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/10] Documentation: filesystems: eliminate duplicated
 words
Date: Sun, 5 Jul 2020 14:44:49 -0600
Message-ID: <20200705144449.5cf9c163@lwn.net>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-unionfs-owner@vger.kernel.org>
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
Sender: linux-unionfs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org

On Fri,  3 Jul 2020 14:43:15 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix doubled words in filesystems files.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cachefs@redhat.com
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: linux-fscrypt@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: linux-unionfs@vger.kernel.org
> 
> 
>  Documentation/filesystems/autofs-mount-control.rst |    6 +++---
>  Documentation/filesystems/caching/operations.rst   |    2 +-
>  Documentation/filesystems/configfs.rst             |    2 +-
>  Documentation/filesystems/directory-locking.rst    |    4 ++--
>  Documentation/filesystems/fsverity.rst             |    2 +-
>  Documentation/filesystems/mount_api.rst            |    4 ++--
>  Documentation/filesystems/overlayfs.rst            |    2 +-
>  Documentation/filesystems/path-lookup.rst          |    2 +-
>  Documentation/filesystems/sysfs-tagging.rst        |    2 +-
>  Documentation/filesystems/vfs.rst                  |    4 ++--
>  10 files changed, 15 insertions(+), 15 deletions(-)
> 
Applied, thanks.

jon
