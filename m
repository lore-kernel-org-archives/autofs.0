From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] Underscore in hostnames
Date: Mon, 11 Dec 2006 11:17:31 -0500
Message-ID: <x494ps2quec.fsf@segfault.boston.devel.redhat.com>
References: <20061207232212.GA1994@sleipnir.redhat.com>
	<1165809391.3380.8.camel@raven.themaw.net>
	<20061211120507.GA2629@sleipnir.redhat.com>
	<x49lkler00t.fsf@segfault.boston.devel.redhat.com>
	<1165851275.3380.42.camel@raven.themaw.net>
	<457D7FD7.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <457D7FD7.5030702@redhat.com> (Peter Staubach's message of "Mon,
	11 Dec 2006 10:57:11 -0500")
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Mon, 11 Dec 2006 10:57:11 -0500, Peter Staubach <staubach@redhat.com> said:

Peter> I might be more in favor of fixing the NFS mount code than modifying
Peter> autofs in this fashion.

If you want to disallow this, then surely it is best to simply "fix"
the name resolution routines in libc.  At this point, however, that
could be viewed as a regression.

-Jeff
