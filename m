From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 6 Dec 2005 21:40:33 +0000
Message-ID: <20051206214033.GA31000@infradead.org>
References: <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17302.157.540958.723305@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ian Kent <raven@themaw.net>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, Dec 06, 2005 at 04:20:29PM -0500, Jeff Moyer wrote:
> hch> No, for current TOT that can't happen.  It could happen for older
> hch> kernels but nothing is doing it in the tree anymore and if anything
> hch> outside is doing it it's fundamentally broken.
> 
> This is a bit unclear to me.  What do you mean when you refer to "it" and
> "that" above?  Oh, and TOT is a TLA I haven't run across before.

TOT = top of tree.

To rephrease the above:  With current mainline the nameidata argument
is always valid when ->lookup or ->d_revalidate are called except when
the filesystem uses lookup_one_len.  lookup_one_len is a helper for fileystem
usage that is only valid to be used on the filesystems own trees.

> We know that there is at least one out of tree module that calls
> lookup_one_len, and ends up in the autofs4 revalidate code without the
> valid nameidata structure.  In this case, with your patch, wouldn't we
> blindly dereference the structure and cause an oops?  If so, who is at
> fault?

This out of tree module is wrong and always has been wrong.  Any actual
breakage of such a module is expected.

Do you happen to know what module that is?
