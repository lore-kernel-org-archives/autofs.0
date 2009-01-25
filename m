From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 12:23:18 +0900
Message-ID: <1232853798.3019.5.camel@zeus.themaw.net>
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
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
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

On Sun, 2009-01-25 at 01:07 +1100, Paul Wankadia wrote:
> On Fri, Jan 23, 2009 at 8:05 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > Does dmalloc provide similar functionality in the event of
>         memory
>         > exhaustion?
>         
>         
>         No.
>         
>         Dmalloc is more like valgrind but is linked in as a library.
>         I found Dmalloc much better in pointing to trouble spots than
>         valgrind.
>         Unfortunately, I have not been able to get it to work for some
>         time now
>         and I never got the 64 bit library to function.
> 
> What problem(s) were you having?

This was added during the development of version 5 when I did memory
management (leak) checking. The idea was that as time passed and changes
were made I could simply enable DMALLOC and run checks from time to time
but it didn't work out. The code analysis seems quite good at detecting
those mistakes that seem to be inevitable or mistakes in code that
hasn't been looked since taking over maintenance of a product.

Ian
