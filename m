From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: [PATCH] nested mounts with loop
Date: Mon, 08 Oct 2007 18:10:40 +0200
Message-ID: <n7xodf91ta7.fsf@sor.suse.de>
References: <n7xir5ybts0.fsf@sor.suse.de>
	<1191819321.3129.12.camel@raven.themaw.net>
	<n7xsl4l23ka.fsf@sor.suse.de>
	<1191858699.3129.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191858699.3129.16.camel@raven.themaw.net> (Ian Kent's message
	of "Mon\, 08 Oct 2007 23\:51\:39 +0800")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent <raven@themaw.net> writes:

> Mmm .. but my comment above assumes you're autofs build uses the
> configure option --disable-mount-locking.
>
> Is that correct?
>
> If not then this can't be done because the locking will cause a
> deadlock, consequently the code that calls access isn't compiled in and
> recursive mounts aren't possible.

Yes, the build is with the --disable-mount-locking option.

Thanks,
Matthias
