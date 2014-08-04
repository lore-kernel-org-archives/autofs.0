From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH - V2] VFS: allow ->d_manage() to declare -EISDIR in
 rcu_walk mode.
Date: Mon, 4 Aug 2014 09:57:31 +0100
Message-ID: <20140804085731.GP18016@ZenIV.linux.org.uk>
References: <20140730160833.5eac00ec@notabene.brown>
 <20140801083318.GA4907@mwanda>
 <20140801184815.22dd193f@notabene.brown>
 <20140804170629.5b2c9013@notabene.brown>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140804170629.5b2c9013@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org

On Mon, Aug 04, 2014 at 05:06:29PM +1000, NeilBrown wrote:
> 
> In REF-walk mode, ->d_manage can return -EISDIR to indicate
> that the dentry is not really a mount trap (or even a mount point)
> and that any mounts or any DCACHE_NEED_AUTOMOUNT flag should be
> ignored.
> 
> RCU-walk mode doesn't currently support this, so if there is a dentry
> with DCACHE_NEED_AUTOMOUNT set but which shouldn't be a mount-trap,
> lookup_fast() will always drop in REF-walk mode.
> 
> With this patch, an -EISDIR from ->d_manage will always cause mounts
> and automounts to be ignored, both in REF-walk and RCU-walk.

In queue.  Right now I'm trying to linearize the damn acct fixes from late
April, needed to get Eric's umount-on-rmdir series into the mix safely ;-/
Hopefully I'll have something pushable by Tuesday; your patch definitely
will be in the pile.
