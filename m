From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: [patch] Underscore in hostnames
Date: Mon, 11 Dec 2006 14:58:24 -0200
Message-ID: <20061211165824.GB2629@sleipnir.redhat.com>
References: <20061207232212.GA1994@sleipnir.redhat.com>
	<1165809391.3380.8.camel@raven.themaw.net>
	<20061211120507.GA2629@sleipnir.redhat.com>
	<x49lkler00t.fsf@segfault.boston.devel.redhat.com>
	<1165851275.3380.42.camel@raven.themaw.net>
	<457D7FD7.5030702@redhat.com>
	<x494ps2quec.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x494ps2quec.fsf@segfault.boston.devel.redhat.com>
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

On Mon, Dec 11, 2006 at 11:17:31AM -0500, Jeff Moyer wrote:
> =

> If you want to disallow this, then surely it is best to simply "fix"
> the name resolution routines in libc.  At this point, however, that
> could be viewed as a regression.

Even though I do my own RFC evangelizing at times, I can't help but
think: why limit automount with a hostname validation routine when
automount is *not* the authoritative entity that decides what is a
valid hostname? Will you want to patch automount again whenever the
RFCs get updated?

automount should regard the hostname as a string, and if it can be
resolved, great. If it cannot, complain in the logs and exit. But it
should not enforce validation on top of something that can be
redefined under its feet anytime in the future.

Will you also include validation for bracketed IPv6 literals? And
whatever comes next?

Two additional cents...
F=E1bio
-- =

ex sed lex awk yacc, e pluribus unix, amem
