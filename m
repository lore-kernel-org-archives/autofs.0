From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Sat, 19 Nov 2005 00:30:26 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>
 <1132192362.5720.163.camel@localhost> <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
 <437CD7D2.40003@us.ibm.com> <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>
 <437DF12A.5050805@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <437DF12A.5050805@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Fri, 18 Nov 2005, William H. Taber wrote:

> Ian Kent wrote:
> > On Thu, 17 Nov 2005, William H. Taber wrote:
> > 
> > Hi Taber,
> 
> Hi,
> You can call me Will. Most everyone else does. :^)

Sorry.

> > 
> > > 
> > > Ian,
> > > I don't think that you can fix this in the autofs by tinkering with
> > > holding and releasing the parent i_sem.  The reason for this is that you
> > > don't have any way of knowing if you hold that lock or not.  The easy case
> > > is that nobody holds the lock.  But if the lock is held you have no way to
> > > know that you are the person holding the lock and you cannot unlock
> > > someone elses lock without serious consequences.
> > 
> > 
> > Yes. I see.
> > 
> > But let me make sure I understand what you are saying.
> > 
> > The problem would be that if I release and then retake the lock for autofs
> > to do it thing there is a risk of opening the caller to the potential races
> > it is protecting itself from. 
> > Correct?
> > 
> No, it is actually a little more subtle than that.  The problem is that since
> you can be called from two code paths, one of which get's the lock and one of
> them doesn't, you are stuck if you find that the lock is held because you
> don't know who holds it.  The danger is that some innocent third party is
> holding the lock and counting on being protected by it. If you release the
> lock, then you can be creating the potential for a race in their code and
> there would be no way to detect it.  Their code path would look correct
> because it is.  Not only that but the lock itself could get confused because
> it would have more unlocks than locks, because presumably the process that
> thinks it has the lock would eventually unlock as well.  I don't know how the
> semaphores are implemented on all architectures so I don't know if that would
> be an actual problem or not but it I would be surprised if they all handled
> that case gracefully.

Yes. Thinking about it I hadn't considered the third process.

How can we get advice on this?

Ian

