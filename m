From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 7/7] autofs - change CONFIG_AUTOFS4_FS to
 CONFIG_AUTOFS_FS
Date: Mon, 1 Jul 2013 14:39:24 +1000
Message-ID: <20130701143924.79f57e7206577a2e7777c0a2@canb.auug.org.au>
References: <20130701031335.4423.6154.stgit@perseus.fritz.box>
	<20130701031449.4423.58614.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__1_Jul_2013_14_39_24_+1000_bMcIZ276g6lW1pxA"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130701031449.4423.58614.stgit@perseus.fritz.box>
Sender: linux-next-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: linux-next@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

--Signature=_Mon__1_Jul_2013_14_39_24_+1000_bMcIZ276g6lW1pxA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, 01 Jul 2013 11:14:51 +0800 Ian Kent <raven@themaw.net> wrote:
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Please don't do this.  Find a simple way to make sure that if
CONFIG_AUTOFS4_FS is set, then "make oldconfig"  (or equivalent) will
cause CONFIG_AUTOFS_FS to be set the same.

The maintainers will update the defconfigs over time.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__1_Jul_2013_14_39_24_+1000_bMcIZ276g6lW1pxA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR0Qf8AAoJEECxmPOUX5FEQvoP/3u/A4/fXkfMCXm8dI/gTwYK
NyF+lERmn6glCxmRKoU+UnSaXsUpy0lLYAtAgmHU3fY6rMfmIsV32gBpCbmO4PFo
FwN3SaKi6dG7bhnt54mWxNmDT+4b7RsSdjcI2Olb+AVmxdVv3e1oPzUmLo5t7bu7
1suLM4nXwvk2hjUWbhHAsWs8k46MXdTHVQCvsy+FP2cuA75s3JVoVhGoQ+Sq1GHt
2IbvbBq6JcI510GHi445kgc2fzNDY7n8V5VYMaq424M3fgfcMQEVDmtrW4zYP7j3
2KfOKGObo3zlsqeC6+zz0QUF5ZXcBCxjhul8LknnwI1YYu1M7mUFfnXEr4D8ALx+
KCuIXpcoofuMX5wL0YI1qKx5ZzJwldqJSADQCPv5UvyX8BFa3i19RmJvpSTAFgKa
07yqpwNSmfsTFTvW8zO8HLCTtLuW/shY/hF/XqVs2r1GV2XWegLVsIU/REzd1t6N
xC+1xB3XZKCp75o42K510ncqEkvx+/xBRDJGgwujlEHkWFkzu3QhxEgMHf3eA44q
wrnHMyOCBZwnbyNHB9SYg2ZA3un2gJ1bgU/evHGjV7mLq0H2bvECN/7xHOsK7HGK
w4HqE1Ufo5udbb2w9VsTYXJf6YL8LqoGAutpC8dL/RM5NW2wX1VnYDZlDzX6tF+h
YKUGqIDskDC4fceTALPg
=z/m9
-----END PGP SIGNATURE-----

--Signature=_Mon__1_Jul_2013_14_39_24_+1000_bMcIZ276g6lW1pxA--
