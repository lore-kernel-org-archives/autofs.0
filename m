From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 12:57:40 +0000
Message-ID: <20051204125740.GB28229@infradead.org>
References: <438E0C66.6040607@us.ibm.com> <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com> <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net> <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051204125612.GA28229@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ian Kent <raven@themaw.net>, Will Taber <wtaber@us.ibm.com>, Jeff Moyer <jmoyer@redhat.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Sun, Dec 04, 2005 at 12:56:12PM +0000, Christoph Hellwig wrote:
> They are still NULL in exactly one case: lookup_one_len.  Given the design
> of lookup_one_len we can't get at a nameidata there at all.

Oh, forgot the most important bit here :)  lookup_one_len is a library helper
never called by the VFS.  autofs (v4 at least) doesn't use it so now always
get a nameidata.  In fact if you look in -mm there's a patch from me that
makes use of that fact.

