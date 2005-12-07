From: Will Taber <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 07 Dec 2005 12:46:39 -0500
Message-ID: <43971FFF.2090900@us.ibm.com>
References: <438F251B.7060602@us.ibm.com>	 <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>	 <43906968.6080508@us.ibm.com>	 <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>	 <1133547148.8976.25.camel@lade.trondhjem.org>	 <20051204125612.GA28229@infradead.org>	 <20051204125740.GB28229@infradead.org>	 <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>	 <20051204171729.GA31111@infradead.org>	 <17302.157.540958.723305@segfault.boston.redhat.com>	 <20051206214033.GA31000@infradead.org> <1133968943.4581.22.camel@brilong-lnx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1133968943.4581.22.camel@brilong-lnx>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Brian Long <brilong@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

Brian Long wrote:
> On Tue, 2005-12-06 at 21:40 +0000, Christoph Hellwig wrote:
> 
>>On Tue, Dec 06, 2005 at 04:20:29PM -0500, Jeff Moyer wrote:
>>
>>>hch> No, for current TOT that can't happen.  It could happen for older
>>>hch> kernels but nothing is doing it in the tree anymore and if anything
>>>hch> outside is doing it it's fundamentally broken.
>>>
>>>This is a bit unclear to me.  What do you mean when you refer to "it" and
>>>"that" above?  Oh, and TOT is a TLA I haven't run across before.
>>
>>TOT = top of tree.
>>
>>To rephrease the above:  With current mainline the nameidata argument
>>is always valid when ->lookup or ->d_revalidate are called except when
>>the filesystem uses lookup_one_len.  lookup_one_len is a helper for fileystem
>>usage that is only valid to be used on the filesystems own trees.
>>
>>
>>>We know that there is at least one out of tree module that calls
>>>lookup_one_len, and ends up in the autofs4 revalidate code without the
>>>valid nameidata structure.  In this case, with your patch, wouldn't we
>>>blindly dereference the structure and cause an oops?  If so, who is at
>>>fault?
>>
>>This out of tree module is wrong and always has been wrong.  Any actual
>>breakage of such a module is expected.
>>
>>Do you happen to know what module that is?
> 
> 
> I believe the filesystem is IBM Rational's mvfs (multi-version
> filesystem) used in ClearCase.  My team is the internal support
> organization at Cisco for Red Hat Enterprise Linux issues and we opened
> the support case with Red Hat about this issue.  Our internal ClearCase
> support folks also have a case opened with IBM Rational Tech Support.
> Thank you for clarifying that mvfs is doing the "wrong thing" by calling
> lookup_one_len.
> 
> /Brian/

Maybe we are doing "the wrong thing" by calling lookup_one_len on the 
autofs but that begs the question of what the right thing would be. 
There is no vfs_lookup function that will look up a single component in 
a pathname.  There may be things we can do in the future so that we 
don't have to make this call at all, but that doesn't resolve the 
problems you have today.

Likewise one could argue that the vfs layer is broken because it is 
inconsistent in its handling of the parent i_sem lock on d_revalidate 
calls.  While this may be true in some abstract software engineering 
sense I have learned enough from this thread already to realize that 
there is no easy solution there.

On the assumption that our use of lookup_one_len was appropriate, Ian 
has been working on a fix to autofs.  I am not particularly interested 
in where the change is made.  What I have been looking for was a 
solution that could then be backported to earlier releases to fix the 
problem at hand.  Anyway, with this information, is it appropriate for 
us to replace our calls to lookup_one_len with calls to path_walk or is 
that also forbidden?

Will

