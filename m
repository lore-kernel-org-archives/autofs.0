From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 13:48:40 +1100
Message-ID: <87tvxdx0jb.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net> <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net> <20171127160147.GA27613@qualcomm.com> <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net> <20171128002935.GC27898@qualcomm.com> <87a7z5yjbs.fsf@notabene.neil.brown.name> <20171129021354.GB2873@qualcomm.com> <1be75afb-8702-d60c-5ecb-10ddd2edc062@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1be75afb-8702-d60c-5ecb-10ddd2edc062@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Mike Marion <mmarion@qualcomm.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29 2017, Ian Kent wrote:

> On 29/11/17 10:13, Mike Marion wrote:
>> On Wed, Nov 29, 2017 at 12:17:27PM +1100, NeilBrown wrote:
>>=20
>>> How big do people see /proc/self/mount* getting?  What size reads
>>> does 'strace' show the various programs using to read it?
>>=20
>> We already have line counts into 5 figures.  This wasn't an issue until=
=20
>> the change of /etc/mtab to a link.  The large count is due to our large
>> direct automount maps.
>>=20

So .... 90,000 lines with a length of may 120 chars or about 10Meg.
Presumably these machines would have so many gigabytes of RAM that
caching a 10M mountinfo file would go unnoticed?

Reading that in 128K chunks without generating bits on the fly will help
a lot I suspect.

We could probably ensure proper alignment by searching backwards for
'\n' when deciding how much to return for a read.

>
> And, admittedly, the testing I was doing was with 15k+ size maps.
>
> Of course it's necessary to have this number of mounts to see serious
> problems which is easiest to do with large direct mount maps.
>
> The thing that's different now is that before applications started
> using /proc directly for mount table information using mount(2)
> instead of mount(8) was enough to prevent the mount entries from
> being added to the table seen by applications.

I wonder who would notice if untriggered direct mounts quietly disappeared =
from
/proc/mounts...  I suspect systemd would, but there is a good chance it
would fail-safe: assume that the mount worked.
Alternately we could introduce /proc/self/mountinfo2 which doesn't list
direct automounts and encourage problematic programs to use that where
available.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloeIAkACgkQOeye3VZi
gblTzQ//b3PjudlIfPqtG9M1iyxn8+PECMQ0GZ9dS7FOltznTXG99+3nc8pTE/9x
eHEl7XlcPKzEvK3jPfY9SDSIfV/ri4N4/wZY6Iz8r3qJKMpO3e8hUt8mlXWJcbw2
GcbPGHovXNP9FBTwBaYFNSyYx1CqiLKjUdYO7taoJvyPeAKNfqNwzm+NSs4BRadg
mF1m1pV7LhHkn/1y8gVQFcfrGyHT4n+GnREypotHg59S8I4zKtlDje1OUjZNXK/A
EstN/kotHnw6cX79/xrB7AV9Wtvwhas/JbkuMsi/ylgHB7JnD5jxxAzS2N/baN+U
T4Xs02EJpLAqIj1RBlxvrlNGAPZFN1tlr10UhwJwQwh0CQLJ4ZcMfcTQxsGDMDaB
zV8GKnUtmif9LVkM3BlW9YfKfvKCfWytNRllInQSXbcV1q0819jWsKPLWOfeQ+J2
ymXZPCMB/7TLh2GermrgiWy+daDORdhJYWWNMFpmv5RgmAFlUDguY4SmBPdMtm6a
HjFkVuDXCBWfxnDUvVGn1bkQsRHLMpDJj7C0/wluZCPict3Nw/7WTcK2tZopF21a
bp65BocweSjsv6NRFykaLA3KcrRYTtlFv/XUhYX0bVki2XOq8WwoumNBTJse41ek
6pQElOLkzehmV+CwD0v64cS6BYJwsHqsYlQJqYe95GyGSWhtn4c=
=ezZM
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
