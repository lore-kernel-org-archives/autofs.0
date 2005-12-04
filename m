From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 17:17:29 +0000
Message-ID: <20051204171729.GA31111@infradead.org>
References: <438E1A05.7000308@us.ibm.com> <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net> <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Christoph Hellwig <hch@infradead.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, Jeff Moyer <jmoyer@redhat.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Sun, Dec 04, 2005 at 10:58:03PM +0800, Ian Kent wrote:
> > never called by the VFS.  autofs (v4 at least) doesn't use it so now always
> > get a nameidata.  In fact if you look in -mm there's a patch from me that
> > makes use of that fact.
> > 
> 
> But Will is calling it in a something like a stacking context and autofs 
> fails to handle it. Hence this discussion.

No, for current TOT that can't happen.  It could happen for older kernels
but nothing is doing it in the tree anymore and if anything outside is doing
it it's fundamentally broken.

