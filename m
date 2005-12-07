From: Brian Long <brilong@cisco.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 07 Dec 2005 10:22:23 -0500
Message-ID: <1133968943.4581.22.camel@brilong-lnx>
References: <438F251B.7060602@us.ibm.com>
	 <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	 <43906968.6080508@us.ibm.com>
	 <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
	 <1133547148.8976.25.camel@lade.trondhjem.org>
	 <20051204125612.GA28229@infradead.org>
	 <20051204125740.GB28229@infradead.org>
	 <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>
	 <20051204171729.GA31111@infradead.org>
	 <17302.157.540958.723305@segfault.boston.redhat.com>
	 <20051206214033.GA31000@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20051206214033.GA31000@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

On Tue, 2005-12-06 at 21:40 +0000, Christoph Hellwig wrote:
> On Tue, Dec 06, 2005 at 04:20:29PM -0500, Jeff Moyer wrote:
> > hch> No, for current TOT that can't happen.  It could happen for older
> > hch> kernels but nothing is doing it in the tree anymore and if anything
> > hch> outside is doing it it's fundamentally broken.
> > 
> > This is a bit unclear to me.  What do you mean when you refer to "it" and
> > "that" above?  Oh, and TOT is a TLA I haven't run across before.
> 
> TOT = top of tree.
> 
> To rephrease the above:  With current mainline the nameidata argument
> is always valid when ->lookup or ->d_revalidate are called except when
> the filesystem uses lookup_one_len.  lookup_one_len is a helper for fileystem
> usage that is only valid to be used on the filesystems own trees.
> 
> > We know that there is at least one out of tree module that calls
> > lookup_one_len, and ends up in the autofs4 revalidate code without the
> > valid nameidata structure.  In this case, with your patch, wouldn't we
> > blindly dereference the structure and cause an oops?  If so, who is at
> > fault?
> 
> This out of tree module is wrong and always has been wrong.  Any actual
> breakage of such a module is expected.
> 
> Do you happen to know what module that is?

I believe the filesystem is IBM Rational's mvfs (multi-version
filesystem) used in ClearCase.  My team is the internal support
organization at Cisco for Red Hat Enterprise Linux issues and we opened
the support case with Red Hat about this issue.  Our internal ClearCase
support folks also have a case opened with IBM Rational Tech Support.
Thank you for clarifying that mvfs is doing the "wrong thing" by calling
lookup_one_len.

/Brian/
-- 
       Brian Long                      |         |           |
       IT Data Center Systems          |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s

