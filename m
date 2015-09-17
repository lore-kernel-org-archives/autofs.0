From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v3 2/3] autofs-5.1.1 - use monotonic clock for pthread
 cond timed wait.
Date: Thu, 17 Sep 2015 14:49:20 +0800
Message-ID: <1442472560.2915.14.camel@themaw.net>
References: <1442402500.2977.80.camel@themaw.net>
	 <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
	 <1442461733-22907-2-git-send-email-ning.yu@ubuntu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9xsPfrY7DuZbO4DvAmVp0Rfuv70=; b=RFjtry
	zM9dmWUXboIYrIDrtZRx2DLGe7rsQNOnOb7lEACjOaUCeVmmIoIqf9wxVSPR9NMn
	1wKvuyqMIGCmK2hyPILT+8gR4K7xFPYF7CGAhXtXH5xKeW6OBwM67BVczEUsItY7
	nYqv+6k2FHni3KWEYNLyb7n75ty2f6vJrrjp8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9xsPfrY7DuZbO4D
	vAmVp0Rfuv70=; b=VmxQIL1w7MIpD1BD31ge4Dkfmy0kFboloprXylWaugjiJ3q
	bPVw76P574n23dsI9aQQ9QFhu867qN0aiJ6kMzS6y9dQHbwqs9xZJc+ctiUGs6bq
	nSaKmSaKdc8d9Nf1DTmjXfbY+Xfk9b1bHa01Uwcwu2TiaXTfYNSAMsPVNIcA=
In-Reply-To: <1442461733-22907-2-git-send-email-ning.yu@ubuntu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yu Ning <ning.yu@canonical.com>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

On Thu, 2015-09-17 at 11:48 +0800, Yu Ning wrote:
> The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
> we need to switch to use the monotic clock.
> 
> Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
> ---
>  lib/alarm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/alarm.c b/lib/alarm.c
> index 65a80ae..5b98b2d 100755
> --- a/lib/alarm.c
> +++ b/lib/alarm.c
> @@ -23,7 +23,7 @@ struct alarm {
>  };
>  
>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
> -static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
> +static pthread_cond_t cond;
>  static LIST_HEAD(alarms);
>  
>  #define alarm_lock() \
> @@ -212,6 +212,7 @@ int alarm_start_handler(void)
>  	pthread_t thid;
>  	pthread_attr_t attrs;
>  	pthread_attr_t *pattrs = &attrs;
> +	pthread_condattr_t condattrs;
>  	int status;
>  
>  	status = pthread_attr_init(pattrs);
> @@ -224,8 +225,18 @@ int alarm_start_handler(void)
>  #endif
>  	}
>  
> +	status = pthread_condattr_init(&condattrs);
> +	if (status)
> +		fatal(status);
> +
> +	pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
> +	pthread_cond_init(&cond, &condattrs);
> +
>  	status = pthread_create(&thid, pattrs, alarm_handler, NULL);
>  
> +	pthread_condattr_destroy(&condattrs);
> +	pthread_condattr_destroy(&cond);

I don't think we can do this.

The condition is used by the alarm_handler() for the duration of it's
life so I don't think we can't destroy its attributes after thread
creation.

In fact I'm not sure we even need the pthread_condattr_destroy(&cond)
but I'm not sure.

Destroying the condition attributes (condattrs) OTOH must not affect any
condition which it has been used to initialize so destroying that is
fine.

Let me have a closer look at this, maybe I've misunderstood what's going
on, and report back later.

> +
>  	if (pattrs)
>  		pthread_attr_destroy(pattrs);
>  


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
