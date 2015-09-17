From: Ning Yu <ning.yu@canonical.com>
Subject: Re: [PATCH v3 2/3] autofs-5.1.1 - use monotonic clock for pthread
 cond timed wait.
Date: Thu, 17 Sep 2015 15:19:09 +0800
Message-ID: <CAA1QoHR848Ddirva0Gorpd6_zSHa3zhLkh5TCqAVvCH5KZCgEw@mail.gmail.com>
References: <1442402500.2977.80.camel@themaw.net> <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
 <1442461733-22907-2-git-send-email-ning.yu@ubuntu.com> <1442472560.2915.14.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442472560.2915.14.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

On Thu, Sep 17, 2015 at 2:49 PM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2015-09-17 at 11:48 +0800, Yu Ning wrote:
>> The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
>> we need to switch to use the monotic clock.
>>
>> Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
>> ---
>>  lib/alarm.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/alarm.c b/lib/alarm.c
>> index 65a80ae..5b98b2d 100755
>> --- a/lib/alarm.c
>> +++ b/lib/alarm.c
>> @@ -23,7 +23,7 @@ struct alarm {
>>  };
>>
>>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
>> -static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>> +static pthread_cond_t cond;
>>  static LIST_HEAD(alarms);
>>
>>  #define alarm_lock() \
>> @@ -212,6 +212,7 @@ int alarm_start_handler(void)
>>       pthread_t thid;
>>       pthread_attr_t attrs;
>>       pthread_attr_t *pattrs = &attrs;
>> +     pthread_condattr_t condattrs;
>>       int status;
>>
>>       status = pthread_attr_init(pattrs);
>> @@ -224,8 +225,18 @@ int alarm_start_handler(void)
>>  #endif
>>       }
>>
>> +     status = pthread_condattr_init(&condattrs);
>> +     if (status)
>> +             fatal(status);
>> +
>> +     pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
>> +     pthread_cond_init(&cond, &condattrs);
>> +
>>       status = pthread_create(&thid, pattrs, alarm_handler, NULL);
>>
>> +     pthread_condattr_destroy(&condattrs);
>> +     pthread_condattr_destroy(&cond);
>
> I don't think we can do this.
>
> The condition is used by the alarm_handler() for the duration of it's
> life so I don't think we can't destroy its attributes after thread
> creation.
>
> In fact I'm not sure we even need the pthread_condattr_destroy(&cond)
> but I'm not sure.
>
> Destroying the condition attributes (condattrs) OTOH must not affect any
> condition which it has been used to initialize so destroying that is
> fine.
>
> Let me have a closer look at this, maybe I've misunderstood what's going
> on, and report back later.
>

I think you are right, we shouldn't destroy the cond attrs, nor the cond
(and I used wrong function to destroy cond...) if the thread is successfully
created.

In fact I think we should do the cleanup at the end of the thread, however
since the thread is expected to live __forever__, maybe we can simply ignore
the cleanup.

>> +
>>       if (pattrs)
>>               pthread_attr_destroy(pattrs);
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
