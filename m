From: Chris Walker <cwalker@pixar.com>
Subject: Re: determining which process triggered an automount
Date: Thu, 12 Apr 2007 22:22:44 -0700
Message-ID: <20070413052244.GV21698@pixar.com>
References: <20070411234847.GH21698@pixar.com>
	<1176372304.3441.63.camel@raven.themaw.net>
	<20070412141307.GV5812@lenin.net>
	<20070413042058.GB5320@sleipnir.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070413042058.GB5320@sleipnir.redhat.com>
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
To: autofs@linux.kernel.org

This is *exactly* what I wanted. I tried it out and it works great.
Thanks.

From fleite:
> On Thu, Apr 12, 2007 at 07:13:07AM -0700, Peter C. Norton wrote:
> > =

> > I think a system tap module could get you this, but it will take some
> > time investment for you to find out how to use it.
> > =

> > http://sourceware.org/systemtap/
> =

> And it also takes a bit of time to find probe points that have not
> been optimized away, auto-inlined, etc. In any case, here's a working
> (in FC5) probe that will tell you who requested a directory. It could
> be improved to provide a full path, but I'm satisfied by it as is.
> =

> probe module("autofs4").function("autofs4_find_wait") {
> 	printf("%s(%d) requested %s\n", execname(), pid(),
> 		kernel_string($name))
> }
> =

> The output is:
> =

> $ sudo stap autofs4_notify_daemon.stap
> bash(5913) requested foobar
> bash(5913) requested foobar
> bash(5913) requested foobar
> ...
> =

> Maybe autofs4_find_wait is not the best place, but it works, and I
> found the more obvious autofs4_notify_daemon to be auto-inlined.
> =

> Hope this helps!
> F=E1bio
> -- =

> ex sed lex awk yacc, e pluribus unix, amem
> =

> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- =

Chris Walker
Render Pipeline Group
Pixar Animation Studios
510/922.3736
cwalker@pixar.com
