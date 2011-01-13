From: Valdis.Kletnieks@vt.edu
Subject: Re: WARNING: at fs/dcache.c:1359 d_set_d_op [was: mmotm 2011-01-06-15-41 uploaded]
Date: Thu, 13 Jan 2011 10:33:44 -0500
Message-ID: <12521.1294932824@localhost>
References: <201101070014.p070Egpo023959@imap1.linux-foundation.org>
            <4D2ECB56.4070802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1294932824_5688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: Your message of "Thu, 13 Jan 2011 10:52:22 +0100."
             <4D2ECB56.4070802@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-fsdevel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org, npiggin@kernel.dk

--==_Exmh_1294932824_5688P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Jan 2011 10:52:22 +0100, Jiri Slaby said:
> On 01/07/2011 12:41 AM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2011-01-06-15-41 has been uploaded to
> 
> Hi, after some uptime and several suspend/resume cycles, I got:
> WARNING: at fs/dcache.c:1359 d_set_d_op+0x82/0xb0()
> Hardware name: To Be Filled By O.E.M.
> Modules linked in: dvb_usb_af9015 tda18271 af9013 dvb_usb dvb_core
> Pid: 3474, comm: automount Tainted: G        W   2.6.37-mm1_64+ #1344
> Call Trace:
>  [<ffffffff8106bd2a>] ? warn_slowpath_common+0x7a/0xb0
>  [<ffffffff8106bd75>] ? warn_slowpath_null+0x15/0x20
>  [<ffffffff81125a32>] ? d_set_d_op+0x82/0xb0
>  [<ffffffff8120d829>] ? autofs4_dir_mkdir+0x169/0x180

Wow. So it wasn't just configfs that trips over this one.  I'm now hoping that
Al audited all the pseudo file systems for this...

--==_Exmh_1294932824_5688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNLxtYcC3lWbTT17ARAhhEAJwIFEg1aaD7HDu19DcxtVZOrdOphACg1hoU
G7AcaN42/xWnhCPoIUl0tPM=
=jiEU
-----END PGP SIGNATURE-----

--==_Exmh_1294932824_5688P--

