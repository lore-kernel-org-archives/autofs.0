From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Thu, 22 Sep 2011 08:29:05 -0400
Message-ID: <20110922082905.0d43a8f4@tlielax.poochiereds.net>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org, linux-nfs@vger.kernel.org

On Mon, 05 Sep 2011 18:06:26 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> From: Miklos Szeredi <mszeredi@suse.cz>
> 
> Prior to 2.6.38 automount would not trigger on either stat(2) or
> lstat(2) on the automount point.
> 
> After 2.6.38, with the introduction of the ->d_automount()
> infrastructure, stat(2) and others would start triggering automount
> while lstat(2), etc. still would not.  This is a regression and a
> userspace ABI change.
> 
> Problem originally reported here:
> 
>   http://thread.gmane.org/gmane.linux.kernel.autofs/6098
> 
> It appears that there was an attempt at fixing various userspace tools
> to not trigger the automount.  But since the stat system call is
> rather common it is impossible to "fix" all userspace.
> 
> This patch reverts the original behavior, which is to not trigger on
> stat(2) and other symlink following syscalls.
> 
> Reported-by: Leonardo Chiquitto <leonardo.lists@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> CC: David Howells <dhowells@redhat.com>
> CC: Ian Kent <raven@themaw.net>
> CC: stable@kernel.org
> ---
>  fs/namei.c |   33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 

This patch is causing a regression with NFSv4.

When I mount up a filesystem, and do any activity on it, a new
automount gets triggered on top of the original mountpoint.

The first mount ends up getting the fsid of the pseudo root (fsid=0),
rather than the correct one for the fs. Once it traverses into the
actual filesystem the fsid's look different and d_automount gets
triggered.

I think the problem is that nfs_follow_remote_path() uses
LOOKUP_FOLLOW, and with the above patch this is now ignored.

Let me know if you need details on how to reproduce this.

-- 
Jeff Layton <jlayton@redhat.com>
