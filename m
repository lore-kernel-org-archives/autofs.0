From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 25 Apr 2016 17:06:38 +0200
Message-ID: <20160425150638.GC30271@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
 <1460166126.3073.20.camel@themaw.net>
 <20160409095659.GB15153@bccms.uni-bremen.de>
 <1461559248.3012.24.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461596800;
	bh=v/Not8EhZJ5Ue2SumMvuhMOTJHRf5VPVLAfhwTF4jAY=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=dChzRX7eK8Wq9C0F8PbusJLtjQAaOCNoq2vQiv03qVV6Uf9x+ogjpHagQ1dMZj85I
	 n6sk6z4jmb910VKMW1MVDkUKlbtQI5G+fkr46gwNV+L4pka7JJ4THEompbtN/SwVQR
	 6pQbibdnINc4tMzXUAH8mVYvidGxM3yIeUuOdQqc=
Content-Disposition: inline
In-Reply-To: <1461559248.3012.24.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

that is bad news overall, but thank you very much for testing and tryin=
g
it.  I had just installed 16.04 into a vm last week and would have made
first attempts with autofs this week. So you saved me quite some work
discovering that it is broken in an interesting way (I assume the SEGV
refers to 16.04).

A very complicated and confusing situation. This is basically the same=20
I was in when I first asked about IPv6 support on this list. Not knowin=
g=20
what to do and whom to ask about what in which order.

I fear I can be of no actual help with the segfault, I am not a=20
C programmer at all. =20

However, if I understand the difference between direct and
indirect maps correctly what I am using is an indirect map ? The
auto.master line is "/local  /etc/auto.local --timeout=3D150" and
/etc/auto.local is an executable map which prints [1]
# /etc/auto.local core330
-fstype=3Dnfs4,rw,intr,nosuid,soft,nodev core330:/locals

So re-building and testing autofs on 16.04 with IPv6 could still be
useful assuming the segfault is a separable problem (which might not be
the case of course) ?

I can also offer to try to do it with debian testing in a vm. If it als=
o
segfaults I could file a bug report hoping to get the maintainer
interested, especially if there are no problems with fedora. Shall I tr=
y
that ? Instead or in addition to the test with IPv6 mentioned above ?

As far as I can see the ubuntu stuff is an import from debian
testing with no actual maintainer.

Best Regards

Christof

[1] I am using executable maps to force a bind mount if accessing
something in /local/$hostname from the same machine $hostname, i.e. on
core330 a call to /etc/auto.local prints "-fstype=3Dbind
:/nfs4exports/locals". Without autofs would use nfs4 even if a faster=20
and light-weight bind mount would do the same job.

On Mon, Apr 25, 2016 at 12:40:48PM +0800, Ian Kent wrote:
> On Sat, 2016-04-09 at 11:56 +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > yes, indeed the 5.0.7 source deb rebuild is very strange. I also
> > checked
> > the libraries under debian/usr/lib/... in the build directory and t=
hey
> > do not contain a libtirpc reference.
>=20
> I had a look at this and found a few things.
>=20
> The 5.0.7 Ubuntu build is sensitive to the library link order, seems
> sensible enough, although I don't understand why I don't see this
> problem with Fedora.
>=20
> Adding the dependency to the build and adding a patch to fix the
> Makefiles link order gets binaries with the libtirpc dependency.
>=20
> The clean target of the Makefile in the modules directory doesn't rem=
ove
> the yacc generated files and causes the Ubuntu build system to compla=
in
> on a second an subsequent runs of the build.
>=20
> The autofs-5.0.6-fix-libtirpc-name-clash.patch of 5.0.7 needs to be
> reverted in 14.04.4 for both the 5.0.7 and 5.1.1 builds to get rid of
> the get_auth problem. That's due to the old libtirpc.
>=20
> Once built the resulting package always fails when probing proximity =
and
> availability (ie. calling into libtirpc).
>=20
> The same thing happens with the 5.1.1 built on 14.04.4 with the above
> changes.
>=20
> I added the Makefile link order change, the Makefile clean change, an=
d
> added the libtirpc dependency to a Ubuntu 16.04 install and built the
> package.
>=20
> I tried a couple of simple indirect mounts and it was able to mount
> them, so it seems the 14.04.4 problem is due to the old libtirpc
> version.
>=20
> But it SEGVed in libtirpc when using a -hosts mount.
> I had a look at that and can't see any reason for the SEGV so that's =
a
> puzzle.
>=20
> I use standard tirpc calls and they function fine in Fedora, so the
> seemingly innocent calls where it crashes are very strange.
>=20
> If there was something that looked remotely like it could cause a
> problem at least I'd have something to follow up on.
>=20
> This isn't good and I'm not sure where to go from here.
>=20
> Ian
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
