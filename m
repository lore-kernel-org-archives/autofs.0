From: raven@themaw.net
Subject: Re: Is autofs4 8-bit compatible?
Date: Mon, 7 Mar 2005 10:55:19 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0503071054040.8807@donald.themaw.net>
References: <421E3F05.00006A.08775@mfront7.yandex.ru>
	<Pine.LNX.4.62.0503061109090.8484@donald.themaw.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1629620785-942055595-1110164119=:8807"
In-Reply-To: <Pine.LNX.4.62.0503061109090.8484@donald.themaw.net>
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
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1629620785-942055595-1110164119=:8807
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE


My inline patch looks mangled so here it is as an attachment.

On Sun, 6 Mar 2005 raven@themaw.net wrote:

> On Thu, 24 Feb 2005, atlantos41 wrote:
>
>>  Hi.
>>  I start automount with command:
>>  automount --timeout=3D60 /smb file /etc/auto.smb
>>=20
>>  where /etc/auto.smb is
>>  test_data<cyrchar>est    -fstype=3Dsmbfs    ://test/data<cyrchar>est
>>=20
>>  where <cyrchar> is one cyrillic char, for example "=D4", i. e.
>>  ~ echo -n <cyrchar> | hexdump
>>  0000000 00d4
>>  0000001
>>=20
>>  When I try to change directory to /smb/test_data<cyrchar>est, then auto=
fs
>>  fails with messages in syslog:
>>  automount[13111]: failed to mount /smb/test_data
>>=20
>>  But if I change key in /etc/auto.smb to 7-bit, for example
>>  "test_data<cyrchar>est" to "test_datatest":
>>  test_datatest    -fstype=3Dsmbfs    ://test/data<cyrchar>est
>>=20
>>  and then restart automount, autofs works as it should be.
>>=20
>>  This problem appears to be in autofs 4.1.3 and autofs 4.1.4_beta1, but =
not=20
>>  in
>>  autofs 3.1.7.
>
> Could you try this patch for me please.
>
> Ian
>
> --- autofs-4.1.4_beta2/modules/lookup_file.c.char-compare=092005-03-06=20
> 11:06:19.000000000 +0800
> +++ autofs-4.1.4_beta2/modules/lookup_file.c=092005-03-06 11:06:57.000000=
000=20
> +0800
> @@ -147,7 +147,7 @@
> else if (ch =3D=3D '*') {
> state =3D st_star;
> *(kptr++) =3D ch;
> -=09=09=09=09} else if (isprint((char) ch)) {
> +=09=09=09=09} else if (!iscntrl((char) ch)) {
> state =3D st_compare;
> *(kptr++) =3D ch;
> }
>
>

--1629620785-942055595-1110164119=:8807
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=autofs-4.1.4-char-compare.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0503071055190.8807@donald.themaw.net>
Content-Description: as an attachment
Content-Disposition: attachment; filename=autofs-4.1.4-char-compare.patch

LS0tIGF1dG9mcy00LjEuNF9iZXRhMi9tb2R1bGVzL2xvb2t1cF9maWxlLmMu
Y2hhci1jb21wYXJlCTIwMDUtMDMtMDYgMTE6MDY6MTkuMDAwMDAwMDAwICsw
ODAwDQorKysgYXV0b2ZzLTQuMS40X2JldGEyL21vZHVsZXMvbG9va3VwX2Zp
bGUuYwkyMDA1LTAzLTA2IDExOjA2OjU3LjAwMDAwMDAwMCArMDgwMA0KQEAg
LTE0Nyw3ICsxNDcsNyBAQA0KIAkJCQllbHNlIGlmIChjaCA9PSAnKicpIHsN
CiAJCQkJCXN0YXRlID0gc3Rfc3RhcjsNCiAJCQkJCSooa3B0cisrKSA9IGNo
Ow0KLQkJCQl9IGVsc2UgaWYgKGlzcHJpbnQoKGNoYXIpIGNoKSkgew0KKwkJ
CQl9IGVsc2UgaWYgKCFpc2NudHJsKChjaGFyKSBjaCkpIHsNCiAJCQkJCXN0
YXRlID0gc3RfY29tcGFyZTsNCiAJCQkJCSooa3B0cisrKSA9IGNoOw0KIAkJ
CQl9DQo=

--1629620785-942055595-1110164119=:8807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--1629620785-942055595-1110164119=:8807--

