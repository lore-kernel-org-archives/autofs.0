From: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Subject: Re: AFS + LDAP
Date: Sun, 9 Jul 2006 14:59:24 +0200
Message-ID: <20060709125924.GC27033@uranos.quantum.physik.uni-potsdam.de>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
	<20060708075345.GA7333@mail.iSKUNK.ORG>
	<1152373694.2814.54.camel@raven.themaw.net>
	<20060709053504.GF7333@mail.iSKUNK.ORG>
Reply-To: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060709053504.GF7333@mail.iSKUNK.ORG>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

On Sun, Jul 09, 2006 at 01:35:04AM -0400, Daniel Richard G. wrote:
>=20
> On Sat, 2006 Jul 08 23:48:13 +0800, Ian Kent wrote:
> > >=20
> > > 	automountKey: qux
> > > 	automountType: device
> > > 	automountFormat: xfs
> > > 	automountPath: /dev/sda5
> > > 	automountWritable: yes
> >=20
> > We would probably need a couple of other attributes, say for mount
> > options other than read/write.
>=20
> This is why you want your standards written by some greybeard at Sun=20
> instead of a rabble-rouser like me :-)  Certainly here, there'd be a lo=
t of=20
> ground to cover, corner cases and the like.

Sorry for bursting into your conversation and bringing up an old
issue again, but it seems to be quite related to this discussion:

A while ago I did suggest a generalized syntax for LDAP map names,
by implementing an already existing standard: LDAP URLs as in rfc2255.
This would be more a "meta"-standard, as it does not enforce any
specific schema, but allow one to use arbitrary schemas, encoded
into the map name. So far, I used to think in terms of schemas with
just two relevant attributes (automount key and information), but I
actually start to like the idea of splitting automountInformation
into several attributes.

The current map name format would be subset of the URL syntax, so
compatibility could be preserved.

I submitted a patch for autofs4 (http://timof.qipc.org/autofs), which
however didn't make it into autofs5. I understand that this would be
an ambitious change, and bringing other parts of autofs up to standard
was probably more urgent; however, it could give plenty of room for
future improvements (like the evolution of a new standard schema), while
staying compatible with traditional schemas (at least, I don't see any
fundamental issues here), so I would still like to hear your opinions
about implementing this in a future version?

...btw:

On Thu, Jul 06 2006 at 15:40:24 -0400, Daniel Richard G. wrote:
>
> I was hoping for something more along the lines of an extension to the=AF=
=AB
> standard NIS schema. (It's common for AFS sites to have each user's hom=
e=AF=AB
> directory be a separately mountable volume, so having some sort of=AF=AB
> user-volume equivalence in LDAP is reasonable.)=AB

If I understand this correctly (I'm not familiar with AFS), this is prett=
y
much the reason why I started to patch lookup_ldap.c in the first place:
to pull automount information from user account entries (rather than from
an independent hierarchy), with the "uid" attribute used as the autmountK=
ey,
when mounting user directories. Seems the natural way of doing it to me.


Best Regards,

Timo Felbinger


--=20
Timo Felbinger                  http://www.felbinger.net
Quantum Physics Group           Phone:  +49 331 977 1793   Fax: -1767
Institut fuer Physik            Mobile: +49 177 735 1936
Universitaet Potsdam, Germany   PGP key-id: E92567B2
