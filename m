From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 13 Dec 2005 18:39:38 +0000
Message-ID: <20051213183938.GA10907@infradead.org>
References: <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org> <1133968943.4581.22.camel@brilong-lnx> <43971FFF.2090900@us.ibm.com> <20051209121239.GA17898@infradead.org> <6cd5k6xume.fsf@sumu.lexma.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cd5k6xume.fsf@sumu.lexma.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "John T. Kohl" <jtk@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Brian Long <brilong@cisco.com>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, wtaber@us.ibm.com, Trond Myklebust <trond.myklebust@fys.uio.no>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

On Fri, Dec 09, 2005 at 08:33:45AM -0500, John T. Kohl wrote:
> Christoph> path_walk and firends resolve a full path.  As such they are
> Christoph> definitly not suitable for stackable filesystem, they are
> Christoph> intendeded only for implementating syscalls (and syscall-like
> Christoph> interfaces, e.g. some ioctls)
> 
> path_lookup() takes a pathname and interprets it relative to cwd or
> root, so it's definitely not useful for stacking.  But path_walk() takes
> a pathname fragment and an initialized nameidata (start point), so it
> *could* be used to resolve a single component, or multiple components.
> 
> If lookup_one_len() is for use within the caller's file system only, and
> path_walk() is not suitable for stacking, then what calls *are* suitable
> for stacking file systems to use?  We want to start with an existing
> (dentry,vfsmnt) and a pathname component, converting it to the
> (dentry,vfsmnt) of the result.

As there are no stackable filesystems in the tree there's currently no
interface designed for them, and once we'll get interfaces for stackable
filesystems they'll surely be _GPL as they're clearly internal and any
stackable filesystem needs to know a lot about the VFS and will have to
change far more frequently than leaf filesystems.

path_walk is an internal implementation detail that will hopefull go away
as an export.
