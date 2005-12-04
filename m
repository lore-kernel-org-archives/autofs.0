From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 22:58:03 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net>
References: <438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<43906968.6080508@us.ibm.com>
	<Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
	<1133547148.8976.25.camel@lade.trondhjem.org>
	<20051204125612.GA28229@infradead.org>
	<20051204125740.GB28229@infradead.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051204125740.GB28229@infradead.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Sun, 4 Dec 2005, Christoph Hellwig wrote:

> On Sun, Dec 04, 2005 at 12:56:12PM +0000, Christoph Hellwig wrote:
> > They are still NULL in exactly one case: lookup_one_len.  Given the design
> > of lookup_one_len we can't get at a nameidata there at all.
> 
> Oh, forgot the most important bit here :)  lookup_one_len is a library helper
> never called by the VFS.  autofs (v4 at least) doesn't use it so now always
> get a nameidata.  In fact if you look in -mm there's a patch from me that
> makes use of that fact.
> 

But Will is calling it in a something like a stacking context and autofs 
fails to handle it. Hence this discussion.

Ian
