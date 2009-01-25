From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 17:36:07 +0900
Message-ID: <1232872567.3019.20.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
	<408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
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

On Sun, 2009-01-25 at 18:06 +1100, Paul Wankadia wrote:
> On Sun, Jan 25, 2009 at 2:23 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > What problem(s) were you having?
>         
>         
>         This was added during the development of version 5 when I did
>         memory
>         management (leak) checking. The idea was that as time passed
>         and changes
>         were made I could simply enable DMALLOC and run checks from
>         time to time
>         but it didn't work out. The code analysis seems quite good at
>         detecting
>         those mistakes that seem to be inevitable or mistakes in code
>         that
>         hasn't been looked since taking over maintenance of a product.
> 
> What problem(s) were you having with dmalloc?

Can't remember now but I think, compilation problems, link problems and
then not being able to find the shared libraries mostly. Mostly it I
just ended up spending too much time on it. I probably should spend some
time on it again.

Ian
