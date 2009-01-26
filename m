From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Mon, 26 Jan 2009 16:00:10 +0900
Message-ID: <1232953210.27316.9.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
	<408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
	<1232872567.3019.20.camel@zeus.themaw.net>
	<408431290901250340l68b48f8btba212c7451d711d4@mail.gmail.com>
	<1232934896.3009.3.camel@zeus.themaw.net>
	<408431290901252006u190ef6aega8d3276172b98b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901252006u190ef6aega8d3276172b98b92@mail.gmail.com>
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

On Mon, 2009-01-26 at 15:06 +1100, Paul Wankadia wrote:
> On Mon, Jan 26, 2009 at 12:54 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         > Aren't there any Red Hat packages for dmalloc? I just
>         installed the
>         > Ubuntu packages and then rebuilt autofs without any trouble.
>         
>         
>         Nope.
>         I have a spec file I can use but the tarball from the download
>         site
>         still doesn't compile. I'll get back to that some time but not
>         just now.
> 
> I suspect that Red Hat packages could be useful for a lot of users. If
> you don't have time to maintain them, then perhaps one of your
> colleagues does?

Maintaining an rpm isn't so bad but I don't have a good enough
understanding of the package internals to make it work so I'm not likely
to be useful at fixing bugs, case in point below. The other issue is
that the upstream support is pretty much non-existent so the former is
actually a big issue as far as adding a new package to Fedora goes.

> 
> 
>         What version was installed?
> 
> Dapper and Feisty have version 5.4.2.
> Gutsy, Hardy, Intrepid and Jaunty have version 5.5.1.

I've tried 5.4.2 and 5.5.2.
I think that 4.8.1 worked at some stage but I haven't gone their again.

I spent a couple of hours on it again after sending my last mail and
ended up in exactly the same spot I did last time.

[root@zeus ~]# /etc/init.d/autofs start
Starting automount: automount: symbol lookup error: /usr/lib/libdmallocth.so: undefined symbol: __stack_chk_fail_local

There's clearly something wrong with the linking but after stuffing
around with the make file to even get this far I tend to run out of
steam at this stage.

> 
> 
>         > BTW, perhaps you could check dmalloc's log file as part of
>         the
>         > automated testing?
>         
>         
>         If I could easily build an rpm each time I updated Fedora then
>         I would
>         script something and run it regularly. Maybe looking at the
>         patches
>         applied by the deb would be useful.
> 
> FWIW, SourceForge seems to offer i386 and src .rpm downloads for
> version 5.4.2.

I checked a few src rpms.
I haven't checked any debs yet but I'll do that before giving
completely, again.

Ian
