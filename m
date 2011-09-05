From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Mon, 05 Sep 2011 17:37:39 +0100
Message-ID: <17416.1315240659@redhat.com>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> After 2.6.38, with the introduction of the ->d_automount()
> infrastructure, stat(2) and others would start triggering automount
> while lstat(2), etc. still would not.  This is a regression and a
> userspace ABI change.

It doesn't necessarily mean it's wrong.  The main class of program that needs
to be prevented from automounting are things that do bulk stat'ing (e.g. ls) -
and they should probably be doing lstat() anyway.

> +	/* We don't want to mount if someone's just doing a stat -
> +	 * unless they're stat'ing a directory and appended a '/' to
> +	 * the name.

Btw, line length is 80 chars.  This comment could easily use one fewer line.

If you use emacs you can do:

	ESC 7 9 C-x f

to set the right margin and then:

	M-q

whilst the cursor is in the comment paragraph to be rearranged and it will
'fill' the paragraph to 79 characters.

David
