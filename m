From: Ian Kent <raven@themaw.net>
Subject: Re: Help with ldap + autofs please
Date: Thu, 25 Mar 2004 20:42:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403252037070.4796@raven.themaw.net>
References: <200403181118.34039.ndbecker2@verizon.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403181118.34039.ndbecker2@verizon.net>
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
To: Neal Becker <ndbecker2@verizon.net>
Cc: autofs@linux.kernel.org

On Thu, 18 Mar 2004, Neal Becker wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Can anyone help me with migrating autofs to ldap?

Think so. Ive checked the Fedora package out and ...
>=20
> To test, I added this line to /etc/auto.master:
>=20
> /test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,d=
c=3Dhns,dc=3Dcom=C2=A0

I see Jeff has added a patch to handle this syntax.
I like it, I'm going to add it to 4.1.2.

But

/test	ldap://rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
				 ^^
should also work. However there seems to be an inconsistency with the dn

>=20
> Here is the corresponding ldif:
> dn: nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
here  ^^^^^^^^^^

So

/test	ldap:rpppc1.md.hns.com:nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3D=
com

should work.

Let me know how you go with this.

Ian
