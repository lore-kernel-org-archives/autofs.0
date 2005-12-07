From: Will Taber <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 07 Dec 2005 09:52:04 -0500
Message-ID: <4396F714.1010407@us.ibm.com>
References: <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <43906968.6080508@us.ibm.com> <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20051206214033.GA31000@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>, Trond Myklebust <trond.myklebust@fys.uio.no>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Christoph Hellwig wrote:
> To rephrease the above:  With current mainline the nameidata argument
> is always valid when ->lookup or ->d_revalidate are called except when
> the filesystem uses lookup_one_len.  lookup_one_len is a helper for fileystem
> usage that is only valid to be used on the filesystems own trees.
> 
Is this documented anywhere?  How is one to know about this restriction 
since it isn't obvious from the code?  And if this function is only to 
be used to lookup in ones own filesystem how is a filesystem supposed to 
lookup a file in another filesystem if they already have a directory 
dentry in hand? Walking up the dentry tree to recreate a path name so 
you can call path_walk seems a bit much.  Without this capablility how 
does one write a stackable file system?

Will
