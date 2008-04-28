From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] autofs4 - use lookup access intent to support
	recursive bind mounts
Date: Mon, 28 Apr 2008 07:22:13 +0100
Message-ID: <20080428062213.GB5882@ZenIV.linux.org.uk>
References: <Pine.LNX.4.64.0804281410160.10684@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804281410160.10684@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Mon, Apr 28, 2008 at 02:14:54PM +0800, Ian Kent wrote:
> 
> Hi Andrew,
> 
> For autofs maps that recursively reference other map entries in their
> mount point path we need to ensure that these mounts are performed
> prior to the current mount request being done. We've used the access
> system call, made just prior to performing the mount, to make this
> happen. In the case of bind mounts, however, the lookup flags in 
> the path walk don't trigger a mount. To do this we need to also
> trigger a mount when we see the LOOKUP_ACCESS flag.

That's too fscking bad, since ->lookup() is about to lose access to
nameidata *and* flags for anything but the last step.  IOW, we'll need
cleaner solution...
