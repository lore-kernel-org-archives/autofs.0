From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v3 2/3] autofs-5.1.1 - use monotonic clock for pthread
 cond timed wait.
Date: Thu, 17 Sep 2015 16:39:48 +0800
Message-ID: <1442479188.2915.25.camel@themaw.net>
References: <1442402500.2977.80.camel@themaw.net>
	 <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
	 <1442461733-22907-2-git-send-email-ning.yu@ubuntu.com>
	 <1442472560.2915.14.camel@themaw.net>
	 <CAA1QoHR848Ddirva0Gorpd6_zSHa3zhLkh5TCqAVvCH5KZCgEw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=YYqo7o1kgJf6t3jskLC1hohe2Ks=; b=KAI+Dz
	8Uk6u9+qurPXsj7/i2CAccSkfdcd/6+VQWJMnVrvY1GPgPLC8ix4U+f1OzKo/+0l
	aXv6koeOd0KIb9F01CVbo1/OOIXE3caIGNTf1nN6kl52Mvd/0oG9vTM0t1O0rU6J
	kr62tN2TV6gRhezTxRc2nzB7kbcDeRkoLsKY4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YYqo7o1kgJf6t3j
	skLC1hohe2Ks=; b=e/iXSKRPB44Yj8aV3X2C+pDDzZIPlX02oFIb4S67lfDepew
	A3nh3Mg4blCgkfjNj7LlKO+qXb3+AB4IgDj+sKpa0bM2roTU6VOxiG9IybRmmLdD
	4iew9mPsLK4+E6+aRRt/Pd9brkb5JTZBiM3/kXMpuUAAGwPomG0N1UcAEo/M=
In-Reply-To: <CAA1QoHR848Ddirva0Gorpd6_zSHa3zhLkh5TCqAVvCH5KZCgEw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ning Yu <ning.yu@canonical.com>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

On Thu, 2015-09-17 at 15:19 +0800, Ning Yu wrote:
> On Thu, Sep 17, 2015 at 2:49 PM, Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2015-09-17 at 11:48 +0800, Yu Ning wrote:
> >> The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
> >> we need to switch to use the monotic clock.
> >>
> >> Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
> >> ---
> >>  lib/alarm.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/alarm.c b/lib/alarm.c
> >> index 65a80ae..5b98b2d 100755
> >> --- a/lib/alarm.c
> >> +++ b/lib/alarm.c
> >> @@ -23,7 +23,7 @@ struct alarm {
> >>  };
> >>
> >>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
> >> -static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
> >> +static pthread_cond_t cond;
> >>  static LIST_HEAD(alarms);
> >>
> >>  #define alarm_lock() \
> >> @@ -212,6 +212,7 @@ int alarm_start_handler(void)
> >>       pthread_t thid;
> >>       pthread_attr_t attrs;
> >>       pthread_attr_t *pattrs = &attrs;
> >> +     pthread_condattr_t condattrs;
> >>       int status;
> >>
> >>       status = pthread_attr_init(pattrs);
> >> @@ -224,8 +225,18 @@ int alarm_start_handler(void)
> >>  #endif
> >>       }
> >>
> >> +     status = pthread_condattr_init(&condattrs);
> >> +     if (status)
> >> +             fatal(status);
> >> +
> >> +     pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
> >> +     pthread_cond_init(&cond, &condattrs);
> >> +
> >>       status = pthread_create(&thid, pattrs, alarm_handler, NULL);
> >>
> >> +     pthread_condattr_destroy(&condattrs);
> >> +     pthread_condattr_destroy(&cond);
> >
> > I don't think we can do this.
> >
> > The condition is used by the alarm_handler() for the duration of it's
> > life so I don't think we can't destroy its attributes after thread
> > creation.
> >
> > In fact I'm not sure we even need the pthread_condattr_destroy(&cond)
> > but I'm not sure.
> >
> > Destroying the condition attributes (condattrs) OTOH must not affect any
> > condition which it has been used to initialize so destroying that is
> > fine.
> >
> > Let me have a closer look at this, maybe I've misunderstood what's going
> > on, and report back later.
> >
> 
> I think you are right, we shouldn't destroy the cond attrs, nor the cond
> (and I used wrong function to destroy cond...) if the thread is successfully
> created.
> 
> In fact I think we should do the cleanup at the end of the thread, however
> since the thread is expected to live __forever__, maybe we can simply ignore
> the cleanup.

That's what I'm thinking too.

I don't think there is any problem assuming the monotonic clock is
available (I think it's been around a very long time) so there's no
point in complicating things to cater for that case.

Although I am thinking of checking the return and calling the fatal()
function on failure as I do for other pthreads functions that should
never fail, so if it does fail we'll get a simple message and a core so
we know where to look.

> 
> >> +
> >>       if (pattrs)
> >>               pthread_attr_destroy(pattrs);
> >>
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
