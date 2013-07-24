From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fix hesiod check error, use correct $(LIBS)
Date: Wed, 24 Jul 2013 10:16:44 +0800
Message-ID: <1374632204.2358.20.camel@perseus.fritz.box>
References: <1374595177-24485-1-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Nd4jmIDvnx4y+bWbpdwRZ7LjnVk=; b=vpH7SCNyLzTH+2I0dVkhLCDcsfUC
	/LCT145IZf5/UQiLp/Oj7sOOxjM3bhLhqNqbPil4EtLogRR5pzjt7YEFysVQm7xU
	/+HFrMXNu5dv+us8kTE63a0zZinjN7a5ig80tbvZe5QRmAvEIc+x6G3QcsboTEUN
	u3evP1qvffi1Kjc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Nd4jmIDvnx4y+bWbpdwRZ7
	LjnVk=; b=FA2leXVBAAM/GGk3weEPiCpW1Hl7m5PagTkPEMtaiy7TT+K1xTa6qa
	VZWVnSOaHckQx2T+qbvvEV9FqYjYKYf7PsgVLoiN3Ncf2jpmN2Xe8NlrdaXJz05k
	c8H/JEnkuHgsNWiCdAiVLpBlk79sni7Ko7dWGx380T48Dwyjyi3T4=
In-Reply-To: <1374595177-24485-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2013-07-23 at 23:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>=20
> the problem here is that hesiod checking always fail due to wrong $(L=
DFLAGS),
> no matter hesiod library is installed or not. moving "-lhesiod" into
> $(LIBS) solve this problem.
>=20
> 1) convert "char *" -> "void *" to fix the compile warning
> 2) put "-lhesiod -lresolv" into $(LIBS), not into $(LDFLAGS), otherwi=
se we got link error

Right, on the queue, will push to the repo next time I commit.
Thanks
Ian
=20
>=20
> ---
> tst_hesiod.c: In function =E2=80=98main=E2=80=99:
> tst_hesiod.c:38:3: warning: passing argument 1 of =E2=80=98hesiod_ini=
t=E2=80=99 from incompatible pointer type
> [enabled by default]
>    char *c; hesiod_init(&c);
>    ^
> In file included from tst_hesiod.c:34:0:
> /usr/include/hesiod.h:36:5: note: expected =E2=80=98void **=E2=80=99 =
but argument is of type =E2=80=98char **=E2=80=99
>  int hesiod_init(void **context);
>=20
>=20
>=20
> $ x86_64-pc-linux-gnu-gcc -o conftest -O2 -pipe -march=3Dcore2  -I/us=
r/include
>  -Wl,-O1 -Wl,--as-needed -g -lhesiod -lresolv tst_hesiod.c -L/usr/lib=
64
>  -lkrb5 -lhx509 -lcom_err -lhcrypto -lasn1 -lwind -lheimbase -lroken
> -lcrypt -ldl -lresolv
>=20
> /tmp/ccN6GW0r.o: In function `main':
> /root/tst_hesiod.c:38: undefined reference to `hesiod_init'
> collect2: error: ld returned 1 exit status
>=20
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  aclocal.m4 | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/aclocal.m4 b/aclocal.m4
> index 7a8b03c..637a775 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -316,20 +316,20 @@ dnl -------------------------------------------=
-------------------------------
>  AC_DEFUN([AF_CHECK_LIBHESIOD],
>  [AC_MSG_CHECKING(for libhesiod)
> =20
> -# save current ldflags
> -af_check_hesiod_save_ldflags=3D"$LDFLAGS"
> -LDFLAGS=3D"$LDFLAGS -lhesiod -lresolv"
> +# save current libs
> +af_check_hesiod_save_libs=3D"$LIBS"
> +LIBS=3D"$LIBS -lhesiod -lresolv"
> =20
>  AC_TRY_LINK(
>    [ #include <hesiod.h> ],
> -  [ char *c; hesiod_init(&c); ],
> +  [ void *c; hesiod_init(&c); ],
>    [ HAVE_HESIOD=3D1
>      LIBHESIOD=3D"$LIBHESIOD -lhesiod -lresolv"
>      AC_MSG_RESULT(yes) ],
>    [ AC_MSG_RESULT(no) ])
> =20
> -# restore ldflags
> -LDFLAGS=3D"$af_check_hesiod_save_ldflags"
> +# restore libs
> +LIBS=3D"$af_check_hesiod_save_libs"
>  ])
> =20
>  dnl ----------------------------------------------------------------=
----------


