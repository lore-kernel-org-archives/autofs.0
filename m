From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 12:56:12 +0000
Message-ID: <20051204125612.GA28229@infradead.org>
References: <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com> <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com> <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net> <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1133547148.8976.25.camel@lade.trondhjem.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ian Kent <raven@themaw.net>, Will Taber <wtaber@us.ibm.com>, Jeff Moyer <jmoyer@redhat.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Fri, Dec 02, 2005 at 01:12:27PM -0500, Trond Myklebust wrote:
> On Sat, 2005-12-03 at 01:29 +0800, Ian Kent wrote:
> 
> > It's sufficient to recognize the nameidata struct is NULL on a call 
> > from lookup_hash nothing more that I'm aware of is needed. If that changes 
> > then of course autofs will need to be changed. autofs also makes 
> > assumptions about what flags are set for different reasons.
> 
> Consider those cases where the VFS calls ->lookup()/->d_revalidate()
> with the nameidata argument set to NULL to be bugs. They are pretty much
> all slated to be fixed soon in order to enable features like read-only
> bind mounts etc.

They are still NULL in exactly one case: lookup_one_len.  Given the design
of lookup_one_len we can't get at a nameidata there at all.

