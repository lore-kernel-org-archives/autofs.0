From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/4] autofs4 - add miscelaneous device for ioctls
Date: Sat, 09 Aug 2008 23:29:09 +0800
Message-ID: <1218295750.2994.61.camel@raven.themaw.net>
References: <20080807114002.4142.30417.stgit@web.messagingengine.com>
	 <20080807114030.4142.76568.stgit@web.messagingengine.com>
	 <20080809125953.GB16308@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080809125953.GB16308@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


On Sat, 2008-08-09 at 08:59 -0400, Christoph Hellwig wrote:
> On Thu, Aug 07, 2008 at 07:40:31PM +0800, Ian Kent wrote:
> > The actual problem with autofs is that it can't reconnect to existing
> > mounts. Immediately one things of just adding the ability to remount
> > autofs file systems would solve it, but alas, that can't work. This is
> > because autofs direct mounts and the implementation of "on demand mount
> > and expire" of nested mount trees have the file system mounted on top of
> > the mount trigger dentry.
> 
> So what you really need instead of all the ioctl cruft is to get access
> to the sb of the hidden autofs4 mount.  One way to do that that I can
> think of right now is to change from using get_sb_nodev as ->get_sb
> to a variant that can find an existing superblock using some mount
> options.

I wished I'd spoken to you about this a long time ago since you seem to
know how I can do this using a remount option but this isn't enough of
an explanation of how it can be done.

AFAICT, mount(8) will never be able to get a "struct path" or "struct
nameidata" to a mount point that is covered using the path lookup in
fs/namespace.c:do_*_mount() so we'll never be called back via any VFS
methods. So tell me more about how this could work please!

Ian


