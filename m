From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] autofs: sanity check status reported with AUTOFS_DEV_IOCTL_FAIL
Date: Fri, 16 Jun 2017 12:13:47 +1000
Message-ID: <87fuf07k84.fsf@notabene.neil.brown.name>
References: <871sqwczx5.fsf@notabene.neil.brown.name> <20170615163400.e2f024125581f452d48f1aca@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20170615163400.e2f024125581f452d48f1aca@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15 2017, Andrew Morton wrote:

> On Wed, 07 Jun 2017 12:08:38 +1000 NeilBrown <neilb@suse.com> wrote:
>
>>=20
>> If a positive status is passed with the AUTOFS_DEV_IOCTL_FAIL
>> ioctl, autofs4_d_automount() will return
>>    ERR_PTR(status)
>> with that status to follow_automount(), which will then
>> dereference an invalid pointer.
>>=20
>> So treat a positive status the same as zero, and map
>> to ENOENT.
>>=20
>> See comment in systemd src/core/automount.c::automount_send_ready().
>>=20
>> ...
>>
>> --- a/fs/autofs4/dev-ioctl.c
>> +++ b/fs/autofs4/dev-ioctl.c
>> @@ -344,7 +344,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
>>  	int status;
>>=20=20
>>  	token =3D (autofs_wqt_t) param->fail.token;
>> -	status =3D param->fail.status ? param->fail.status : -ENOENT;
>> +	status =3D param->fail.status < 0 ? param->fail.status : -ENOENT;
>>  	return autofs4_wait_release(sbi, token, status);
>>  }
>
> Sounds serious.  Was the absence of a cc:stable deliberate?

You need CAP_SYS_ADMIN to  get the ioctl even looked at.  Doesn't that
mean the bug can only be triggered by a process that could easily do
worse?

Or do containers allow admins to give out CAP_SYS_ADMIN to untrusted
people??  I haven't been keeping up.

Given how simple the patch is, it probably makes sense to add a
cc:stable, just in case.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAllDPtwACgkQOeye3VZi
gbn7lRAAsfDstCozm/lzOfdtzdxpZrNEX3BjuD0mC7a+Cslf2NWoVRcB8/GYW8F/
qFmPtUsX2EBKjfoEXywzWn8pW7AF20HUDqvUFPRNS3dyZzmxV0chv/pUdmKoQEnI
WfwYLLmKtWQNs7p9nsqQ91MrD7d9nJFkBsOiQdcuKX/QSL3RwMrJXdwAggDHtOmQ
iphp5w/kswUGgkqsA02K1WmmX6aZSRsMzbZVXyASUF49sbEBVKzg6KeKF8w/5BfO
Mn7nEN/Z1FY7JW+PdeN9Zyf2ZpsbZX6WuphhfOOZTfSV1IGfjNuGSYTPgVvZH8x3
KyRf/29jCsj4NnHdveC3mdNrnsDN1fyXXQQK6ZlawoMjfMvQp3n48S2iUnHgd1KY
9rueBpSnT8SPCzwULzDdUmN09RJHwb8EQV89p0nYggK9pa4wYdoIirDD1fq+b/jX
xhTQnzPV78Z3eGWZY6FUjOOxhP0WHICWsMyjQR2om1ha2x9jbiTPtY5jsqKWk+CT
AsZGXwp7HdspNAdA2f72jgqc8nafmYD1j30iIwrCaJd3E6dXP6x+lsEY5U7w72Po
DNt8NgJjl8rI0iKxGTX+qGlFzN2TA4vBORlTCnTswHbqs0hYnrd/n5py13wCq0j4
f6NfylhHYs2ao4h1XLcfPnOBr/KecTEZbL8kXc6JfzKoF+kR1uk=
=N1/M
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
