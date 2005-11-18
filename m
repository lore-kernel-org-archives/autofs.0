From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 18 Nov 2005 10:57:45 -0800
Message-ID: <1132340265.5720.191.camel@localhost>
References: <20051116101740.GA9551@RAM>
	 <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
	 <1132159817.5720.33.camel@localhost>
	 <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>
	 <1132192362.5720.163.camel@localhost>
	 <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
	 <437CD7D2.40003@us.ibm.com>
	 <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>
	 <437DF12A.5050805@us.ibm.com>
	 <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>
	 <437E0B62.4000306@us.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <437E0B62.4000306@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: William H Taber <wtaber@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Fri, 2005-11-18 at 09:12, William H. Taber wrote:
> Ian Kent wrote:
> > On Fri, 18 Nov 2005, William H. Taber wrote:
> >>
> >>No, it is actually a little more subtle than that.  The problem is that since
> >>you can be called from two code paths, one of which get's the lock and one of
> >>them doesn't, you are stuck if you find that the lock is held because you
> >>don't know who holds it.  The danger is that some innocent third party is
> >>holding the lock and counting on being protected by it. If you release the
> >>lock, then you can be creating the potential for a race in their code and
> >>there would be no way to detect it.  Their code path would look correct
> >>because it is.  Not only that but the lock itself could get confused because
> >>it would have more unlocks than locks, because presumably the process that
> >>thinks it has the lock would eventually unlock as well.  I don't know how the
> >>semaphores are implemented on all architectures so I don't know if that would
> >>be an actual problem or not but it I would be surprised if they all handled
> >>that case gracefully.
> > 
> > 
> > Yes. Thinking about it I hadn't considered the third process.
> > 
> > How can we get advice on this?
> > 
> > Ian
> > 
> Hey, I'm new here. I came here looking for advice. :^)
> However, if there is no way to fix this in the autofs code then the only 
> alternative is to fix the locking in the VFS.  So VFS folks, which is 
> the better solution.  Should all callers to d_revalidate get the 
> parent's i_sem lock or should d_revalidate never be called with the 
> parent i_sem lock and so we need to change lookup_one_len so that it 
> does not expect the parent i_sem lock to be held?

I think the problem is with cached_lookup(). It is the only place which 
calls ->revalidate() holding the parent's inode-semaphore AFAICT.

note: cached_lookup() is only called from __lookup_hash() and
__lookup_hash() is always called holding the semaphore.

VFS experts agree?
RP




> 
> Will Taber
> 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 

