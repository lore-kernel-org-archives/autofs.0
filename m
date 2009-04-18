From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Negative caching of failed mount attempts
Date: Sat, 18 Apr 2009 19:58:59 -0400
Message-ID: <x49y6txcy4c.fsf@segfault.boston.devel.redhat.com>
References: <c2d0b6ec0904161339j3573f25em3b6a1ac1168fa032@mail.gmail.com>
	<49E7E544.8070609@themaw.net>
	<c2d0b6ec0904170328k54fd9068h883434b6be217dd9@mail.gmail.com>
	<49E86ABC.70706@themaw.net>
	<c2d0b6ec0904170529r40be50a5wab4eb6e0a88e3d2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0904170529r40be50a5wab4eb6e0a88e3d2c@mail.gmail.com>
	(Leonardo Chiquitto's message of "Fri, 17 Apr 2009 09:29:46 -0300")
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Leonardo Chiquitto <leonardo.lists@gmail.com> writes:

>> So what do you have, 4.1.4 will all the patches from kernel.org or the
>> SLES 10 package, or an SLES 10 update of some sort?
>
> Sorry for not being specific here.
>
> I'm using the latest SLES10 update, which basically is 4.1.4 + some
> patches from kernel.org + distribution specific configuration and build
> changes + a couple of other bug fixes that are not upstream.
>
> To make things easier to everyone, I grabbed the latest tarball and
> patches from kernel.org and applied autofs-4.1.4-negative-timeout.patch
> from RHEL 4 (credits to Jeff Moyer). Just one chunk was rejected (the
> one from lookup_hesiod.c). Please find the refreshed patch attached,
> minimally tested so far.
>
> I'd appreciate if it could be merged upstream (after proper testing, of
> course).

I think you need at least two more patches:

autofs-4.1.3-negative-timeout-doc-update.patch
autofs-4.1.3-teach-cache-about-negative-mapents.patch

There may be more, though.

Cheers,
Jeff
