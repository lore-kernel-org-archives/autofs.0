From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: running out of mount points
Date: Mon, 19 Jan 2004 12:11:46 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <400C0FD2.6000507@sun.com>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
	<Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
	<40059944.4060901@rhythm.com> <400BFC65.3000700@rhythm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5136068196808834=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <400BFC65.3000700@rhythm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5136068196808834==
Content-type: multipart/signed;
 boundary=------------enig75B1DE8A9717E08116C01FEF;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75B1DE8A9717E08116C01FEF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg Bradner wrote:

> I wanted to repost this plea. I am really in a bind and could use some 
> help. I need to mount these users on the mail server.
> BTW: this is with autofs 4.1.0
>
This has been discussed various times on this mailing list and is a 
known limitation in 2.4 / 2.6.   In 2.4, you can patch your kernel using 
something similar to:

http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff

HTH,

-- 
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


--------------enig75B1DE8A9717E08116C01FEF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFADA/VdQs4kOxk3/MRAuIoAKCQq19kDka2YJED8XXVW5Ud2xy0VwCfTdQP
ldnwSoxKoJ7tWFeNhFnRQZg=
=q//O
-----END PGP SIGNATURE-----

--------------enig75B1DE8A9717E08116C01FEF--


--===============5136068196808834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5136068196808834==--

