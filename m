From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Re: autofs map updates not working properly for
	multi-mounts
Date: Mon, 14 Feb 2005 15:36:00 -0500
Message-ID: <42110BB0.3090201@sun.com>
References: <16905.15217.105499.777724@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0502092116510.2140@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-reply-to: <Pine.LNX.4.61.0502092116510.2140@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

raven@themaw.net wrote:

> So the bottom line at the moment is "multi-mount entries must be handled
> a a single mount entry". So they can't be dynamically updated until the
> next time they are mounted following the update.
> 

This is a perfectly fair assumption and is handled the same way on other
platforms.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCEQuvdQs4kOxk3/MRAoWNAJ9crYNXPjvM90EdaNxLkHPCaoVU1wCdEm0A
K+voKmkaB9DWhcCjaC/Ub50=
=IV4t
-----END PGP SIGNATURE-----
