From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Direct maps!!
Date: Mon, 14 Feb 2005 15:56:34 -0500
Message-ID: <42111082.50001@sun.com>
References: <420D3666.3010208@trdlnk.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-reply-to: <420D3666.3010208@trdlnk.com>
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
To: Chip Seraphine <chip@trdlnk.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Chip,

Chip Seraphine wrote:
> 
> I was looking in the TODO file for version 4.0 and noticed that you have
> "* direct maps?" listed for v5.  From the question mark, I assume that
> you are not sure if you wanted to implement that or not...
> 
> I just wanted to beg you to please do the support for direct maps.  My
> shop is stuck on Solaris for the simple reason that we use auto.direct
> very extensively, and migrating to Linux is too painful because of that
> one reason.  My life would be far better if direct map support is
> implemented!!!!!

Thought I'd take this opportunity to plug autofsng.  It supports lazy
mounting and direct maps.

It still a bit beta, and lacks some of the heuristic logic available in
autofs 4.1.*.  However, the project's goal is to be a drop-in substitute
that allows %100 integration into a Solaris automount environment.

If interested, patches and tarballs are available at:

ftp://ftp-eng.cobalt.com/pub/users/ssmith/autofsng/

(home will be changing soon).

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

iD8DBQFCERCCdQs4kOxk3/MRAlTbAKCC3zIVD3D9hdortOWvsU3kQ1p9CQCeJFFk
PT79cUZ+iaJS4SHwJoE0KjQ=
=aapz
-----END PGP SIGNATURE-----
