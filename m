From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] VFS: Fix automount for negative autofs dentries
Date: Mon, 11 Jul 2011 15:13:41 +0100
Message-ID: <16882.1310393621@redhat.com>
References: <20110711134147.GA6853@infradead.org> <20110711132057.14641.36229.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110711134147.GA6853@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, viro@ZenIV.linux.org.uk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Christoph Hellwig <hch@infradead.org> wrote:

> would do the same.

But is much less obvious.  The LOOKUP_FOLLOW flag is the primary reason for
this statement.  The rest are subordinate and would be wholly irrelevant if
LOOKUP_FOLLOW was to be removed from the list.

David
