From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: [patch] Underscore in hostnames
Date: Mon, 11 Dec 2006 10:05:07 -0200
Message-ID: <20061211120507.GA2629@sleipnir.redhat.com>
References: <20061207232212.GA1994@sleipnir.redhat.com>
	<1165809391.3380.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1165809391.3380.8.camel@raven.themaw.net>
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

On Mon, Dec 11, 2006 at 12:56:31PM +0900, Ian Kent wrote:
> =

> Not valid at all.
> And they are tolerated because the admin explicitly configures DNS to
> violate the RFC.

The sad thing is that mount(1) does no such validation, and allows one
to mount an NFS export on a hostname containing underscores just fine.
So we can end up in a situation where automount does not allow the
user to configure a working NFS mount she has.

Regards,
F=E1bio
-- =

ex sed lex awk yacc, e pluribus unix, amem
