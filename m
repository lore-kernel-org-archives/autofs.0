From: Ian Kent <raven@themaw.net>
Subject: Re: Help with ldap + autofs please
Date: Thu, 25 Mar 2004 08:58:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403250852420.10492@wombat.indigo.net.au>
References: <200403181118.34039.ndbecker2@verizon.net>
 <Pine.LNX.4.58.0403212326530.4690@raven.themaw.net>
 <Pine.LNX.4.58.0403241636220.19787@lucy.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403241636220.19787@lucy.dcs.qmul.ac.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="utf-8"
To: Matt Bernstein <mb/autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org, Neal Becker <ndbecker2@verizon.net>

On Wed, 24 Mar 2004, Matt Bernstein wrote:

> On Mar 21 Ian Kent wrote:
>=20
> >On Thu, 18 Mar 2004, Neal Becker wrote:
> >
> >> Can anyone help me with migrating autofs to ldap?
> >>=20
> >> To test, I added this line to /etc/auto.master:
> >>=20
> >> /test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dad=
g,dc=3Dhns,dc=3Dcom=C2=A0
> >
> >Try
> >
> >/test	ldap //rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dc=
om
>=20
> Hi, I get the same problem--this doesn't help (a space after "ldap" mak=
es=20
> it think it's a yp map called "ldap").

OK. My mistake.

Doesn't look to good.

I'll run up a Fedora install on the weekend and try to duplicate it.

Ian
