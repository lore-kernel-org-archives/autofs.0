From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 18 Nov 2005 15:08:57 -0500
Message-ID: <437E34D9.4050102@us.ibm.com>
References: <20051116101740.GA9551@RAM>	 <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>	 <1132159817.5720.33.camel@localhost>	 <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>	 <1132192362.5720.163.camel@localhost>	 <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>	 <437CD7D2.40003@us.ibm.com>	 <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>	 <437DF12A.5050805@us.ibm.com>	 <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>	 <437E0B62.4000306@us.ibm.com> <1132340265.5720.191.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1132340265.5720.191.camel@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ram Pai <linuxram@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ram Pai wrote:
> On Fri, 2005-11-18 at 09:12, William H. Taber wrote:

> 
> I think the problem is with cached_lookup(). It is the only place which 
> calls ->revalidate() holding the parent's inode-semaphore AFAICT.
> 
> note: cached_lookup() is only called from __lookup_hash() and
> __lookup_hash() is always called holding the semaphore.
> 
> VFS experts agree?
> RP
> 
Ram,
Lookup_one_len calls lookup_hash and it is the callers of lookup_one_len 
that are problematical.  Just as an example, lookup_one_len is called 
from nfs_sillyrename which is called, among other places in the 
nfs_rename code.  In that path the parent i_sem is obtained in do_rename 
   in the vfs code (namei.c). I would think that it would be extremely 
difficult to to change that usage.  The alternative is to move the 
obtaining of the parent i_sem from real_lookup to do_lookup.  We would 
also have to put the locking around the d_revalidate call at 
return_reval in __link_path_walk.

Again, what do the VFS experts think?

Will Taber
