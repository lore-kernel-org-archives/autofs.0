From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] VFS: Fix automount for negative autofs dentries
Date: Mon, 11 Jul 2011 11:24:48 -0400
Message-ID: <20110711152447.GA20501@infradead.org>
References: <20110711134147.GA6853@infradead.org>
 <20110711132057.14641.36229.stgit@warthog.procyon.org.uk>
 <16882.1310393621@redhat.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16882.1310393621@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, viro@ZenIV.linux.org.uk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

On Mon, Jul 11, 2011 at 03:13:41PM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > would do the same.
> 
> But is much less obvious.  The LOOKUP_FOLLOW flag is the primary reason for
> this statement.  The rest are subordinate and would be wholly irrelevant if
> LOOKUP_FOLLOW was to be removed from the list.

Then keep the LOOKUP_FOLLOW semi-separate as in the original code.
But there's absolutely no reason for the goto spaghetti.
