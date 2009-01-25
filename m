From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 12:36:59 +0900
Message-ID: <1232854619.3019.8.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901232147k55887ecdqf683c57b5ca6b6c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901232147k55887ecdqf683c57b5ca6b6c3@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Sat, 2009-01-24 at 16:47 +1100, Paul Wankadia wrote:
> modules/replicated.c:
>     303 static int add_host(struct host **list, struct host *host)
> ...
>     307         if (!list) {
>     308                 *list = host;
>     309                 return 1;
>     310         }
> 
> That is a NULL pointer dereference.

Oops!

> 
> 
> lib/alarm.c:
>     223 int alarm_start_handler(void)
> ...
>     230         status = pthread_attr_init(pattrs);
> ...
>     240         status = pthread_create(&thid, pattrs, alarm_handler,
> NULL);
>     241         if (status)
>     242                 return 0;
>     243 
>     244         return 1;
> 
> Should you call pthread_attr_destroy(3) before returning?

Yes, missed that as it used to use a global attributes.

> 
> 
> lib/defaults.c:
>     544 struct ldap_searchdn *defaults_get_searchdns(void)
> ...
>     566                         if (!new) {
>     567                                 defaults_free_searchdns(sdn);
>     568                                 return NULL;
>     569                         }
> 
> That is a resource leak. (`f' is not closed.)
> 
> 
> modules/mount_changer.c:
>     142 int swapCD(const char *device, const char *slotName)
> ...
>     161         if (total_slots_available <= 1) {
>     162                 logerr(MODPREFIX
>     163                       "Device %s is not an ATAPI compliant CD
> changer.",
>     164                       device);
>     165                 return 1;
>     166         }
> ...
>     170         if (slot < 0) {
>     171                 logerr(MODPREFIX "CDROM_SELECT_DISC failed");
>     172                 return 1;
>     173         }
> 
> Those are resource leaks. (`fd' is not closed.)

Great, obvious catches.

> 
> 
> daemon/state.c:
>    1124 int st_start_handler(void)
> ...
>    1131         status = pthread_attr_init(pattrs);
> ...
>    1141         status = pthread_create(&thid, pattrs,
> st_queue_handler, NULL);
>    1142         if (status)
>    1143                 return 0;
>    1144 
>    1145         return 1;
> 
> Should you call pthread_attr_destroy(3) before returning?


Yes, also missed that as it used to use a global attributes.

Ian
