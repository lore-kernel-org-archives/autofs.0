From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 09:31:38 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E2C0BA.3070605@sun.com>
References: <40E1CCC3.1010809@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <40E1CCC3.1010809@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Deragon wrote:
> Greetings.
>
>
>   Attached, my patch for supporting backfstype.  If the OS is Linux and
> cachefs is detected, this fs is ignored and no attempt is made to mount
> a cachefs kernel module (none exist).  This way we avoid useless error
> messages in syslog.
>
>   If mounting the fstype fails or is cachefs, backfstype is then tried.
>
>   It works fine under RHL 9.  Only one file was changed:  parse_sun.c.
> The changes were made from the 4.1.3 branch.  Changes are very localized
> and I believe they are safe (though code inspection is always desired).
>
>   Please confirm if my patch has been accepted.
>

Why do this in the parser when it can easily be done in a mount module?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4sC5dQs4kOxk3/MRAmqMAJ4ozb8H/WCSLofDJ1qSC+PrJZsoFwCeIL2R
ugeytb6z6DP53zz2AC2bJm0=
=pEWR
-----END PGP SIGNATURE-----
