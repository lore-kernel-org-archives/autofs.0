From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 13/18] autofs4: Clean up autofs4_free_ino() [ver #4]
Date: Fri, 14 Jan 2011 16:03:01 +0000
Message-ID: <20110114160301.GE19804@ZenIV.linux.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <20110113215509.19406.9034.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110113215509.19406.9034.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2011 at 09:55:09PM +0000, David Howells wrote:
> From: Ian Kent <raven@themaw.net>
> 
> When this function is called the local reference count does't need to
> be updated since the dentry is going away and dput definitely must
> not be called here.
> 
> Also the autofs info struct field inode isn't used so remove it.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Signed-off-by: David Howells <dhowells@redhat.com>

BTW, you might want to look at pending stuff in #autofs in vfs-2.6.git.
A lot will probably overlap, but...
