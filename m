From: Ian Kent <raven@themaw.net>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 09 Oct 2009 16:56:19 +0800
Message-ID: <4ACEFAB3.4050904@themaw.net>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net> <20091009074211.GD2983@wotan.suse.de> <4ACEED94.6040002@themaw.net> <20091009080709.GA17818@wotan.suse.de> <4ACEF0FA.1060605@themaw.net> <20091009083335.GB17818@wotan.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091009083335.GB17818@wotan.suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Nick Piggin wrote:
> On Fri, Oct 09, 2009 at 04:14:50PM +0800, Ian Kent wrote:
>> Nick Piggin wrote:
>>> Yeah I will redo it against mainline and send it out again. I will
>>> get around to doing a git tree of the vfs scalability stuff after
>>> I get the series in a bit more reasonable shape... I'll need you to
>>> look at that too because autofs4 does a lot of meddling with
>>> dcache_lock ;)
>> Hehe, sorry.
>>
>> np, just point me at it and I'll do what I can.
> 
> I will do so, I just want to get a chance to clean it up and
> document it all a bit better before I ask filesystem maintainres
> to take a really good look.
> 
> 
>> I'm open to advice on where and why I don't need to use the dcache_lock.
>> I think there are case where I unnecessarily take it, especially in the
>> changes that I have just posted to support the Sage Weil change to the
>> taking of the directory i_mutex over revalidate in real_lookup(). Which
>> are present in the mm kernel atm, if the latest one has been posted yet
>> that is.
> 
> Well, after my patches there is no dcache_lock, so we need to
> be sure that we _don't_ need dcache_lock :)

Oh wow, that's a fairly big change, it will certainly need a bit of
though on my part. How does this design protect directory list changes
during traversals?

fyi, there are plans to retire autofs and rename autofs4 to autofs, but
that is potentially very disruptive so I'm not sure yet when I will
propose it. In any case, once the real_lookup() locking change goes in
autofs will unavoidably deadlock, so it's got to go.

> 
> Basically what I have done for autofs4 is that I've tried to
> preserve the same guarantees (from the dcache) that it looks
> like you need, when replacing each instance of dcache_lock.

Right, I do sometimes do things that are probably not OK in general file
systems because of the fact that the daemon, a single process, is the
only one that can do certain things, like create or remove a directory,
for example. OTOH, taking that further, I probably often don't really
need to take the dcache_lock as often as I do.

> 
> I have then replaced each dcache_lock with a new global
> autofs4_lock, because there is so much state in there and
> so many places where you take dcache_lock that I can't tell
> what autofs internals are being protected with it.

This may offer an opportunity to simplify that locking a lot, if I
analyse why I'm taking it, and relate that back to the way the locking
is now meant to work. So the documentation you mentioned will be essential.

> 
> I.... have it "working", but the reality is that there will be
> bugs especially in my initial conversions of something hard like
> autofs4. So just informed reviewing and questions/comments are
> going to be important.

Bugs .. surely not !!!

Ian
