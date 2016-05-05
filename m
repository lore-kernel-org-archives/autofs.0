From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 0/2] autofs: fix two related bugs with lookup + expired yp
 maps
Date: Thu, 5 May 2016 09:06:10 -0400
Message-ID: <4fc33892-3d17-e2bb-b1bb-dda54f8f99d8@suse.com>
References: <1462406612-2354-1-git-send-email-jeffm@suse.com>
 <1462437320.3011.7.camel@themaw.net> <1462443706.3011.15.camel@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="unBscJ35HKLVJE0OEptTx8VWw7OwAOGUh"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1462443706.3011.15.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unBscJ35HKLVJE0OEptTx8VWw7OwAOGUh
Content-Type: multipart/mixed; boundary="bCXdDe2aajsHsGnBrxRpxorPVHEtAHjJl"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Message-ID: <4fc33892-3d17-e2bb-b1bb-dda54f8f99d8@suse.com>
Subject: Re: [PATCH 0/2] autofs: fix two related bugs with lookup + expired yp
 maps
References: <1462406612-2354-1-git-send-email-jeffm@suse.com>
 <1462437320.3011.7.camel@themaw.net> <1462443706.3011.15.camel@themaw.net>
In-Reply-To: <1462443706.3011.15.camel@themaw.net>

--bCXdDe2aajsHsGnBrxRpxorPVHEtAHjJl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/5/16 6:21 AM, Ian Kent wrote:
> On Thu, 2016-05-05 at 16:35 +0800, Ian Kent wrote:
>> On Wed, 2016-05-04 at 20:03 -0400, jeffm@suse.com wrote:
>>> From: Jeff Mahoney <jeffm@suse.com>
>>>
>>> Hi Ian -
>>>
>>> We recently encountered an issue where a client would all of a sudden=

>>> start returning ELOOP for anything involving crossing an autofs mount=
=2E
>>> We tracked it down to two bugs, one which obscured the other.  The
>>> first
>>> is that we were not properly updating the map age for yp maps when we=

>>> retry
>>> the lookup with dots instead of underscores.  The second is that it i=
s
>>> possible under several situations to return success when there was a
>>> failure in lookup_nss_mount.  In this particular case, it was the onl=
y
>>> map in the list and since the age wasn't update, it was skipped.  The=
n
>>> we exit the while loop with ret =3D=3D 0, ultimately returning succes=
s to
>>> the caller.  Autofs would tell the kernel it succeeded, the kernel
>>> would
>>> retry the lookup, and we'd loop until we hit the kernel loop limit
>>> (40).
>>>
>>> These two patches fix each of the issues.
>>
>> OK, that sounds good.
>>
>> I'll have a look at the code to make sure I understand what's going on=

>> before adding these to the list of patches I have.
>>
>> That list is getting a bit large now so I'll likely be committing them=

>> soonish but I can't say yet when I'll release 5.1.2.
>>
>> Up until now I thought that the source of the ELOOP returns that some
>> people have seen were due to incorrect returns of in kernel mounted
>> checks where mounts were present in other namespaces.
>>
>> My most recent attempt at resolving that had a positive response from =
a
>> tester here on the list but another tester experienced file system
>> corruption. I'm totally at mystified by this so I'm a bit stuck at the=

>> moment.=20
>=20
> When importing these I've made a couple of changes I hope you will be o=
k with.
> The content of the patches remains the same (assuming I have no other q=
uestions
> when I properly review them).
>=20
> Due to my convention of trying to always have the patch title the same =
as the
> patch name I had to change the first patch.
>=20
> I changed the patch name (and title with "-" changed to " ") to:
> autofs-5.1.1-fix-yp-map-age-not-updated-during-map-lookup.patch
>=20
> The description remains the same and I think still conveys the intent o=
f the
> change.
>=20
> I changed only autofs: to autofs-5.1.1 in the second patch.
>=20
> Finally I assume your ok with me adding your "Signed-off-by:" to both p=
atches,
> along with mine.

Yep, sounds good to me.

Thanks,

-Jeff


--=20
Jeff Mahoney
SUSE Labs


--bCXdDe2aajsHsGnBrxRpxorPVHEtAHjJl--

--unBscJ35HKLVJE0OEptTx8VWw7OwAOGUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXK0VGAAoJEB57S2MheeWyd+MP/A0Y5CQDkOEoqiRblrgzMm0X
6fyn0Fmn6B7+MFc8yZyJOTB7ELsq/+zJzLqtVTa7rxARdLGHSzgUhjsbaebwNV2t
e8tJFxp3DfL0M8uCpTZJfCH91wZGgp/XP5h18lUnV5+UEUQx3zN71Zlmb+e50YwA
Q6e4sTP9d9TWR6btWcI8h91ghvWq4pywLJlQ0h7Quwq288KnZgQeT/6HpvZxx16m
9iAsNC6IhThogBdT5A93kdvgXu6ubB3o2wF6DH4GSGjxdS7ROoF8RJPHGhnRQ7ad
weByemnrrRHFYZaZlFO9S+BVYQF6GlOBiQ2a8v0kGEsZcZztESkylZ9vBP/ZGygq
ZbEzdv+JEqLwmIeAmx+M10Ax3ibcMAt8Sh/VJZEO8nDbxipHEeBAgEdGE/ozQTCc
ZCKI5a1RwNcCUGciAgcVgUpL1zxJA2ZlKl3WqAOEGok4t0fYZq8Su9xsH0O2fvnU
ALVqXRzI/sOUToVwuib7rot3rUALUe1JttCQcpunFPppzq1BX1p1SGdhRk2IOg6A
Cl2u3oxwZOzZOdJPQ2EX/bO/lW6DmQuLm7ed8VzCk7m5dEeA3cNjyGtbNelz8/GK
cJ/e0nYYLqGidCCONI9v8DPIvFTUxJl4XKY3H9D5qt79/QGKNHUbieONOrRMXuxv
BtyxyPtCJk5f1E9HB+MY
=UWYh
-----END PGP SIGNATURE-----

--unBscJ35HKLVJE0OEptTx8VWw7OwAOGUh--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
