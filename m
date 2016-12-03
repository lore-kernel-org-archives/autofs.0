From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Sat, 3 Dec 2016 23:29:12 +0000
Message-ID: <20161203232912.GE1555@ZenIV.linux.org.uk>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
 <20161203051322.GA24765@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161203051322.GA24765@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Sat, Dec 03, 2016 at 05:13:22AM +0000, Al Viro wrote:
> 	* path_has_submounts() is broken.  At the very least, it's
> AB-BA between mount_lock and rename_lock.  I would suggest trying to
> put read_seqlock_excl(&mount_lock) around the call of d_walk() in there,
> and using __lookup_mnt() in the callback (without retries on the mount_lock,
> of course - read_seqlock_excl done on the outside is enough).  I'm not sure
> if it won't cause trouble with contention, though; that needs testing.  As
> it is, that function is broken in #work.autofs, same as it is in -mm and
> -next.

	Fix for path_has_submounts() (as above) force-pushed.  It does
need testing and profiling, obviously.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
