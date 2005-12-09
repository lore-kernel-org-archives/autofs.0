From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 9 Dec 2005 12:12:39 +0000
Message-ID: <20051209121239.GA17898@infradead.org>
References: <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org> <1133968943.4581.22.camel@brilong-lnx> <43971FFF.2090900@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43971FFF.2090900@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Taber <wtaber@us.ibm.com>
Cc: Brian Long <brilong@cisco.com>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

On Wed, Dec 07, 2005 at 12:46:39PM -0500, Will Taber wrote:
> problem at hand.  Anyway, with this information, is it appropriate for 
> us to replace our calls to lookup_one_len with calls to path_walk or is 
> that also forbidden?

path_walk and firends resolve a full path.  As such they are definitly not
suitable for stackable filesystem, they are intendeded only for implementating
syscalls (and syscall-like interfaces, e.g. some ioctls)
