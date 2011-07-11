From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] VFS: Fix automount for negative autofs dentries
Date: Mon, 11 Jul 2011 09:41:47 -0400
Message-ID: <20110711134147.GA6853@infradead.org>
References: <20110711132057.14641.36229.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110711132057.14641.36229.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: viro@ZenIV.linux.org.uk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

> +	if (!(flags & LOOKUP_FOLLOW)) {
> +		/* We do, however, want to mount if someone wants to open or
> +		 * create a file of any type under the mountpoint, wants to
> +		 * traverse through the mountpoint or wants to open the mounted
> +		 * directory.
> +		 */
> +		if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
> +			     LOOKUP_OPEN | LOOKUP_CREATE))
> +			goto need_automount;
> +
> +		/* Also, autofs may mark negative dentries as being automount
> +		 * points.  These will need the attentions of the daemon to
> +		 * instantiate them before they can be used.
> +		 */
> +		if (!path->dentry->d_inode)
> +			goto need_automount;
>  		return -EISDIR;
> +	}
> +need_automount:

That's some really odd code structure.

	if (!(flags & (LOOKUP_FOLLOW | LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
		        LOOKUP_OPEN | LOOKUP_CREATE)) &&
	    path->dentry->d_inode)
		return -EISDIR;

would do the same.
