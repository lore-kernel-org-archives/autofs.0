From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 6 Dec 2005 16:20:29 -0500
Message-ID: <17302.157.540958.723305@segfault.boston.redhat.com>
References: <438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<43906968.6080508@us.ibm.com>
	<Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
	<1133547148.8976.25.camel@lade.trondhjem.org>
	<20051204125612.GA28229@infradead.org>
	<20051204125740.GB28229@infradead.org>
	<Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>
	<20051204171729.GA31111@infradead.org>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20051204171729.GA31111@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@infradead.org>
Cc: Ian Kent <raven@themaw.net>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

==> Regarding Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix; Christoph Hellwig <hch@infradead.org> adds:

hch> On Sun, Dec 04, 2005 at 10:58:03PM +0800, Ian Kent wrote:
>> > never called by the VFS.  autofs (v4 at least) doesn't use it so now
>> always > get a nameidata.  In fact if you look in -mm there's a patch
>> from me that > makes use of that fact.
>> > 
>> 
>> But Will is calling it in a something like a stacking context and autofs
>> fails to handle it. Hence this discussion.

hch> No, for current TOT that can't happen.  It could happen for older
hch> kernels but nothing is doing it in the tree anymore and if anything
hch> outside is doing it it's fundamentally broken.

This is a bit unclear to me.  What do you mean when you refer to "it" and
"that" above?  Oh, and TOT is a TLA I haven't run across before.

We know that there is at least one out of tree module that calls
lookup_one_len, and ends up in the autofs4 revalidate code without the
valid nameidata structure.  In this case, with your patch, wouldn't we
blindly dereference the structure and cause an oops?  If so, who is at
fault?

Thanks,

Jeff
