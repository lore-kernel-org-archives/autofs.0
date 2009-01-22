From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 18:39:13 +0900
Message-ID: <1232617153.3239.36.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
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

On Thu, 2009-01-22 at 19:28 +1100, Paul Wankadia wrote:
> On Thu, Jan 22, 2009 at 5:00 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > Sorry, I just don't understand why that's the right thing to
>         do. If a
>         > daemon can't allocate memory in order to perform the
>         operations that
>         > it needs to perform, then how can it provide the
>         functionality that
>         > it's expected to provide? Why should it continue
>         indefinitely instead
>         > of aborting and being restarted automatically?
>         
>         
>         Yeah, your entitled to your option but this has been discussed
>         in the
>         past and some people say just the opposite. I'm going to leave
>         things
>         the way they are for now.
> 
> I wanted to understand your position...
> 
> Oh, and I've just noticed that there's a `fatal' macro that calls
> abort(3). It seems to be used widely, but solely for unexpected
> Pthreads errors?

So, now it looks like I'm contradicting myself, well called, ;)

The fatal() function was added much later than the times we got
complains about autofs exiting upon errors, which lead to the common
approach of continue if at all possible. The call is used almost
exclusively for checking pthreads call returns that should "never" fail.
The idea is that, rather than not bother checking them, abort so we can
see where the fail occurred and get a backtrace from the core.

Ian
