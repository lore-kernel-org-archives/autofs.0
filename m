From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: RE: autofs scalability
Date: Wed, 03 Dec 2003 15:01:39 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FCE4123.8050301@sun.com>
References: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============050799401022298518=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============050799401022298518==
Content-type: multipart/signed;
 boundary=------------enig4F6B7FC16E9942A35DCEEC23;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F6B7FC16E9942A35DCEEC23
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ogden, Aaron A. wrote:

>Hello all,
>I was reading through Joe Pranevich's "Wonderful World of Linux 2.6" and
>I came across this, I thought you might find it interesting. (source:
>http://kniggit.net/wwol26.html)  The "Network Filesystems" section makes
>for interesting reading as well.  If I am reading this correctly, the
>'unnamed device' limit has been raised from 256 to 4096 in kernel 2.6,
>can anyone confirm this?  
>

No.  The major count went from 256 -> 4096.  The minor count went from 
256 to 1048576.  The maximum pseudo-block-device limit is still 256 
currently.

>If this is the case the only barrier left to
>remove is the RPC port limitation of ~800 open ports.  If the
>connections were multiplexed such that all connections to a given server
>used the same port then 800 ports would stretch a lot farther than they
>do now...
>
>  
>
Yes.  This has been identified as an upper limit.  :(

But you're right, these two limits are blocking being able to mount 
large numbers of NFS mounts.


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


--------------enig4F6B7FC16E9942A35DCEEC23
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/zkEndQs4kOxk3/MRAnh5AJ9789/kl+H0zH9HPhY2EbYvlHXlfwCcCNv0
J+xJB2dTXEqg2hSyO3swLes=
=ZOsn
-----END PGP SIGNATURE-----

--------------enig4F6B7FC16E9942A35DCEEC23--


--===============050799401022298518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============050799401022298518==--

