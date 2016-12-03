From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Sat, 3 Dec 2016 05:13:22 +0000
Message-ID: <20161203051322.GA24765@ZenIV.linux.org.uk>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

	FWIW, I've folded that pile into vfs.git#work.autofs.

Problems:
	* (fixed) __path_is_mountpoint() should _not_ treat NULL from
__lookup_mnt() as "nothing's mounted there" until it has checked
that mount_lock hadn't been touched - mount --move on something unrelated
can race with lockless hash lookup and lead to false negatives.
	* linux/mount.h might be the wrong place for path_is_mountpoint().
Or it shouldn't be inlined.  I don't like the includes you've added there.
	* path_has_submounts() is broken.  At the very least, it's
AB-BA between mount_lock and rename_lock.  I would suggest trying to
put read_seqlock_excl(&mount_lock) around the call of d_walk() in there,
and using __lookup_mnt() in the callback (without retries on the mount_lock,
of course - read_seqlock_excl done on the outside is enough).  I'm not sure
if it won't cause trouble with contention, though; that needs testing.  As
it is, that function is broken in #work.autofs, same as it is in -mm and
-next.
	* the last one (propagation-related) is too ugly to live - at the
very least, its pieces should live in fs/pnode.c; exposing propagate_next()
is simply wrong.  I hadn't picked that one at all, and I would suggest
coordinating anything in that area with ebiederman - he has some work
around fs/pnode.c and you risk stepping on his toes.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
