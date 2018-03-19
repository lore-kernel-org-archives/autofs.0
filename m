From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Date: Mon, 19 Mar 2018 12:30:31 -0700
Message-ID: <20180319193031.GC6739@bombadil.infradead.org>
References: <20180319191609.23880-1-willy@infradead.org>
 <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kINsG3r93I0Z6YBwF0S0AjDGplHinAaiDKduQ5k3D4g=; b=gknZQzU52S9S02jqOMKb+C2JZ
        DA0s2NDuawxCfjHRgXtcUPgUJUL54ViOa++aUbGQTw3mZ6WZMeG96/loR0dFFGAuS2c7VJK9OrSya
        CFJxcKq8ot2KLjmE/bNQk4HRnbfq6G4aI2D/jIonvWt0xPqVWyR2gydKMoRN7hLD6IV2GJ+rluVmF
        Cas7RWNj9dL8fPeT7c31A82vTdFVnNMm8o6rcplko7EhOLN92pOJU94lEVZW5QUesQ+fmAhpdhWZH
        eg7JWbWn6z7ZoZB/k2agrsN0T6SbIQyIafGTZ1YpCA9VqXpCgh/iypu9bf0/Pd8W04GghqB401bdG
    
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Rientjes <rientjes@google.com>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>

On Mon, Mar 19, 2018 at 12:25:58PM -0700, David Rientjes wrote:
> On Mon, 19 Mar 2018, Matthew Wilcox wrote:
> >  	 * wq->name.name is NULL iff the lock is already released
> >  	 * or the mount has been made catatonic.
> >  	 */
> > -	if (wq->name.name) {
> > -		/* Block all but "shutdown" signals while waiting */
> > -		unsigned long shutdown_sigs_mask;
> > -		unsigned long irqflags;
> > -		sigset_t oldset;
> > -
[...]
> > -
> > -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
[...]
> > -	} else {
> > -		pr_debug("skipped sleeping\n");
> > -	}
> > -
> > +	wait_event_killable(wq->queue, wq->name.name == NULL);
>
> I understand converting the wait_event_interruptible() to 
> wait_event_killable(), but why was the above wait_event_interruptible() 
> only called when wq->name.name != NULL?  

My guess is that it was to avoid the overhead of diddling the signal set
when wq->name.name was already NULL.  I don't really kow though, it
predates git history and I'm too lazy to go and poke through the historical
repos to see if that reason was captured by BitKeeper.

> wait_event_{killable,interruptible}() will return without sleeping when 
> wq->name.name == NULL, so I suppose it has something to do with the 
> comment above it.
