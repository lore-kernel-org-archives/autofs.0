From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 7 Dec 2005 15:25:19 +0000
Message-ID: <20051207152519.GA21158@infradead.org>
References: <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org> <1133968943.4581.22.camel@brilong-lnx>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1133968943.4581.22.camel@brilong-lnx>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Long <brilong@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Will Taber <wtaber@us.ibm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

On Wed, Dec 07, 2005 at 10:22:23AM -0500, Brian Long wrote:
> I believe the filesystem is IBM Rational's mvfs (multi-version
> filesystem) used in ClearCase.  My team is the internal support
> organization at Cisco for Red Hat Enterprise Linux issues and we opened
> the support case with Red Hat about this issue.  Our internal ClearCase
> support folks also have a case opened with IBM Rational Tech Support.
> Thank you for clarifying that mvfs is doing the "wrong thing" by calling
> lookup_one_len.

Well, mvfs is the worst filesystem ever.  I wish could beat up the people at
rational that wrote it personally.  Everytime some implementation detail
in the VFS changes it turns out mvfs uses it in the most braindead way.

I also really doubt they could claim it's not derived work of the linux
kernel given all this poking it does.

Maybe I should sue IBM about so they take it off the market ;-)

*evil grin*
