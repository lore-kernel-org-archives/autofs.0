From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: mount -oaddr=<ipaddr> ?
Date: Tue, 5 Apr 2016 09:18:32 -0400
Message-ID: <5703BB28.9000508@suse.com>
References: <57030D04.7010805@suse.com> <1459825949.4090.10.camel@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6pEhbi8P1CJgreOfDxjkAHspNpPkg5i2U"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1459825949.4090.10.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6pEhbi8P1CJgreOfDxjkAHspNpPkg5i2U
Content-Type: multipart/mixed; boundary="Ix0vnW4t6BoF6v7TS3b2Sh6B4c4OWupOj"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Message-ID: <5703BB28.9000508@suse.com>
Subject: Re: mount -oaddr=<ipaddr> ?
References: <57030D04.7010805@suse.com> <1459825949.4090.10.camel@themaw.net>
In-Reply-To: <1459825949.4090.10.camel@themaw.net>

--Ix0vnW4t6BoF6v7TS3b2Sh6B4c4OWupOj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/4/16 11:12 PM, Ian Kent wrote:
> On Mon, 2016-04-04 at 20:55 -0400, Jeff Mahoney wrote:
>> Hi all -
>>
>> I'm investigating an issue where our user updated from SLE11 to SLE12
>> and the hostname for autofs mounts stopped appearing in the 'mount'
>> output.  I know why this happens, what the reason for it being this
>> way
>> is, and that it can be overridden by setting the
>> use_hostname_for_mounts=3Dyes option (and the side effects).  Before I=

>> go
>> and write up the patch implementing it, is there a reason why autofs
>> doesn't pass the hostname in the mount source and specify the ip
>> address
>> using the -oaddr=3D<ipaddr> option?  Was this tried and found to be
>> wanting somehow?
>=20
> TBH I didn't even consider doing that.
>=20
> But the daemon needs to be conservative in the options it uses because
> maps may be used with other platforms and unknown or non-standard
> options can cause mount failures.
>=20
> While Linux mount.nfs(8) has the sloppy option (which maintainers seem
> to try and remove from time to time) other platforms probably don't.
>=20
> The addr=3D<address> option isn't listed as a valid option in nfs(5) an=
d
> neither is it listed in on-line Solaris documentation that I could find=

> so I'm not sure making the daemon use it is a good idea.
>=20
> Maybe there's another way...
>=20
> Note that I do need to be able to mount to a specific IP address while
> specifying the host name in the mount command but don't know of a way t=
odo it.

After looking at it again, the kernel supports doing this but nfs-utils
explicitly doesn't.

A closer look at nfs-utils also shows that, given a hostname, mount.nfs
will iterate over all available addresses matching the specification
(e.g. constrained by proto=3D) and try to mount using each one.  It will
properly pass an addr=3D field to the kernel but it ignores the one passe=
d
on the mount command line.  It will use getaddrinfo() to get the list of
addresses for the remote host and then iterate over them, retrying until
it finds one that works.  So that part of it works, but the
prioritization implemented by the replicated modules isn't.  I wonder if
it would make sense to move that to nfs-utils instead.  It seems like it
would be generally useful.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--Ix0vnW4t6BoF6v7TS3b2Sh6B4c4OWupOj--

--6pEhbi8P1CJgreOfDxjkAHspNpPkg5i2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXA7srAAoJEB57S2MheeWyq7wP/1h1rDVD7CslQQIWXUM/CuWm
ztK5opWeEchSya9MmmQQedg4pplumKNgdxDpMNL05NYcA02p0W5P5FCVXOZoib+n
oijSpgnps8Bbwydvuo+KQYYNZlwiVc+J8FVVASF/nwh35n53vmW0pfkZqx9OBmwn
l7C11YxlAAnyc2Q1tiaym464elykQJ50wNGdhM7W5xd67DklvsUArztPz4Wy9qf3
T8wE8bnEkCWfujQ6AjSl0B4TQjzIe2YuhN14PW5HKNWC6gS6FrWiZ6tj+8qDIzd1
K5OOcFwzw6f0VIR3VwPVAo57u9/vuMr83a8v7jJ8vgey7bBbq2wPux3EjPB78j9H
K6cfgaRR4OCk6G0ae7Vv8ZEV9XK+epSgeIIyMGe4Vvk25rTy3AYHqfrbd7xBhqQN
5ywSdoKfun+SYGwLueryrYDz3khH4WXlgZCfaveduqbY59ghbFH+w3YcoV6DD5Wr
uaLY1pRXg4MgL2fomGjj1OjOdKcYl3K57sE0MFiUHc/YULrLlfxQGpgYUirYfL5l
RZQub9Th0CVRl9SD2vn/rGmkp4KwpCWGizDA/izXCIBnYEPLvDhEIqKlLdzFvZTq
LjLEiftwhsEiJMFo7hUUg8GSY3KseQMtKKwJYdhzR1eJ6KcRBgXTh8NOaoJqdd+S
f0Q4gNrXEesuhdxwoDHl
=T7/I
-----END PGP SIGNATURE-----

--6pEhbi8P1CJgreOfDxjkAHspNpPkg5i2U--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
