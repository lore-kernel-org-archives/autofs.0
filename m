From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Date: Wed, 24 Sep 2003 22:46:43 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0309242240500.6956-100000@raven.themaw.net>
References: <20030924155720.C31236@devserv.devel.redhat.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030924155720.C31236@devserv.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>

On Wed, 24 Sep 2003, Arjan van de Ven wrote:

> On Wed, Sep 24, 2003 at 09:38:16PM +0800, Ian Kent wrote:
> > > interruptible_sleep_on ?
> > > 
> > 
> > OK so maybe I should have suggestions instead of comments.
> 
> instead of interruptible_sleep_on(), it looks like you really want
> to use completions for this code..
> see kernel/workqueue.c for how those are used
> 

I did try that but thinking again ...

The actual expire really needs to be interrutible.
I didn't like the idea that the additional waiters would be 
uninterruptible but perhaps I have no choice.

Given that do you think that using an interruptible_sleep_on for the 
expire and a completion for the additional waiters could give an 
acceptable solution?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
