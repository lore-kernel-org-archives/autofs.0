From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: compatibility with solaris '[no]browse' mount option
Date: Mon, 14 Jun 2004 18:03:05 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40CE2099.8050605@sun.com>
References: <16589.63971.33237.4865@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <16589.63971.33237.4865@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Moyer wrote:
> Hello,
>
> I've currently got a request to support the browse mount option.  It seems
> do-able entirely in the init script (and this seems the right place).
> Would there be any objections to such an approach?
>
> -Jeff
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

How would you be able to do browsing from the init script given the
protocol restrictions imposed by autofs4?  Autofs4 uses the magic pgid
value as well as requiring a pipe fd to do communication.

If you are simply looking towards translating the browse option to the
ghosting used in automount4, then by all means go for it :)  However
please note that you will have to handle this in the daemon as well as
it is possible to nest indirect maps:

auto_master:

/src  auto_src -browse

auto_src:

linux -fstype=linux,browse auto_linux

If you are willing to wait, I've been working on the autofs
implementation I described at http://lkml.org/lkml/2004/1/6/167 that
will support browsing/lazy mounts.  I will be releasing it to the
community in the coming weeks pending some approvals..

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAziCYdQs4kOxk3/MRAtDKAJ9LpL5XG6Jzz3GMxV37xn+fFFGnAACgkY69
d0xqX+0xTLKaTwja5pI1cGg=
=p9c+
-----END PGP SIGNATURE-----
