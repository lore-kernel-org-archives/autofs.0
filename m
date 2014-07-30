From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] VFS: allow ->d_manage() to declare -EISDIR in rcu_walk
 mode.
Date: Wed, 30 Jul 2014 13:16:52 -0700
Message-ID: <20140730201652.GA23156@infradead.org>
References: <20140730160833.5eac00ec@notabene.brown>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140730160833.5eac00ec@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org

This looks good enough that I'll apply it to the interim vfs queue.

