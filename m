From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] autofs4 - add miscelaneous device for ioctls
Date: Sat, 9 Aug 2008 08:59:53 -0400
Message-ID: <20080809125953.GB16308@infradead.org>
References: <20080807114002.4142.30417.stgit@web.messagingengine.com> <20080807114030.4142.76568.stgit@web.messagingengine.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080807114030.4142.76568.stgit@web.messagingengine.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Thu, Aug 07, 2008 at 07:40:31PM +0800, Ian Kent wrote:
> The actual problem with autofs is that it can't reconnect to existing
> mounts. Immediately one things of just adding the ability to remount
> autofs file systems would solve it, but alas, that can't work. This is
> because autofs direct mounts and the implementation of "on demand mount
> and expire" of nested mount trees have the file system mounted on top of
> the mount trigger dentry.

So what you really need instead of all the ioctl cruft is to get access
to the sb of the hidden autofs4 mount.  One way to do that that I can
think of right now is to change from using get_sb_nodev as ->get_sb
to a variant that can find an existing superblock using some mount
options.

