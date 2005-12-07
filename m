From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 7 Dec 2005 15:18:18 +0000
Message-ID: <20051207151818.GA21146@infradead.org>
References: <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org> <4396F714.1010407@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4396F714.1010407@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Taber <wtaber@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Moyer <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>, Trond Myklebust <trond.myklebust@fys.uio.no>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Wed, Dec 07, 2005 at 09:52:04AM -0500, Will Taber wrote:
> Christoph Hellwig wrote:
> >To rephrease the above:  With current mainline the nameidata argument
> >is always valid when ->lookup or ->d_revalidate are called except when
> >the filesystem uses lookup_one_len.  lookup_one_len is a helper for 
> >fileystem
> >usage that is only valid to be used on the filesystems own trees.
> >
> Is this documented anywhere?

It's documented in the mail on lkml where it was introduce long time ago.
I have a patch in my queue to add a comment about this and various other
bits.  It'll go into 2.6.26 I hope.

> How is one to know about this restriction 
> since it isn't obvious from the code? 

Actually it is obvious for the code :)  Because it doesn't get an nfsmount
it's inherently dangerous to use to look up random files.

> And if this function is only to 
> be used to lookup in ones own filesystem how is a filesystem supposed to 
> lookup a file in another filesystem if they already have a directory 
> dentry in hand?

It's not supposed to do that.  All these lookups must be done by VFS code.
The lowest level entry points to do something on the namespace of a filesystem
are the vfs_* routines or thing like dentry_open().

