From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Date: Wed, 24 Sep 2003 21:38:16 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
References: <1064408962.5074.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1064408962.5074.2.camel@laptop.fenrus.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>

On Wed, 24 Sep 2003, Arjan van de Ven wrote:

> On Wed, 2003-09-24 at 15:01, Ian Kent wrote:
> > This is a corrected patch for the autofs4 daedlock problem I posted about 
> > @@ -206,6 +207,11 @@
> >  
> >  		interruptible_sleep_on(&wq->queue);
> >  
> > +		if (waitqueue_active(&wq->queue) && current != wq->owner) {
> > +			set_current_state(TASK_INTERRUPTIBLE);
> > +			schedule_timeout(wq->wait_ctr * (HZ/10));
> > +		}
> > +
> 
> this really really looks like you're trying to pamper over a bug by
> changing the timing somewhere instead of fixing it...

Agreed.

> 
> also are you sure the deadlock isn't because of the racey use of
> interruptible_sleep_on ?
> 

OK so maybe I should have suggestions instead of comments.

Please elaborate.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
