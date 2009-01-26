From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Mon, 26 Jan 2009 10:54:56 +0900
Message-ID: <1232934896.3009.3.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
	<408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
	<1232872567.3019.20.camel@zeus.themaw.net>
	<408431290901250340l68b48f8btba212c7451d711d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901250340l68b48f8btba212c7451d711d4@mail.gmail.com>
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

On Sun, 2009-01-25 at 22:40 +1100, Paul Wankadia wrote:
> On Sun, Jan 25, 2009 at 7:36 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > What problem(s) were you having with dmalloc?
>         
>         
>         Can't remember now but I think, compilation problems, link
>         problems and
>         then not being able to find the shared libraries mostly.
>         Mostly it I
>         just ended up spending too much time on it. I probably should
>         spend some
>         time on it again.
> 
> Aren't there any Red Hat packages for dmalloc? I just installed the
> Ubuntu packages and then rebuilt autofs without any trouble.

Nope.
I have a spec file I can use but the tarball from the download site
still doesn't compile. I'll get back to that some time but not just now.

What version was installed?

> 
> BTW, perhaps you could check dmalloc's log file as part of the
> automated testing?

If I could easily build an rpm each time I updated Fedora then I would
script something and run it regularly. Maybe looking at the patches
applied by the deb would be useful.

Ian
