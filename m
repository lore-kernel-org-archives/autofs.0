From: Neal Becker <ndbecker2@verizon.net>
Subject: Re: Help with ldap + autofs please
Date: Thu, 25 Mar 2004 14:57:23 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403251457.24822.ndbecker2@verizon.net>
References: <200403181118.34039.ndbecker2@verizon.net>
	<Pine.LNX.4.58.0403252037070.4796@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403252037070.4796@raven.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: Text/Plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 25 March 2004 7:42 am, Ian Kent wrote:
> On Thu, 18 Mar 2004, Neal Becker wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Can anyone help me with migrating autofs to ldap?
>
> Think so. Ive checked the Fedora package out and ...
>
> > To test, I added this line to /etc/auto.master:
> >
> > /test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg=
,dc=3Dhns,dc=3Dcom=C2=A0
>
> I see Jeff has added a patch to handle this syntax.
> I like it, I'm going to add it to 4.1.2.
>
> But
>
> /test	ldap://rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dco=
m
> 				 ^^
> should also work. However there seems to be an inconsistency with the d=
n
>
> > Here is the corresponding ldif:
> > dn: nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
>
> here  ^^^^^^^^^^
>
> So
>
> /test	ldap:rpppc1.md.hns.com:nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,d=
c=3Dcom
>
> should work.
>
> Let me know how you go with this.
>
> Ian

This one is working:
/test	ldap://rpppc1.md.hns.com/nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,d=
c=3Dcom=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYzmjMDqogpR5tkMRAvV8AJ4pj+89qapSnbcxwbMn0vaZK3h3HQCfRZXG
ymCQAbmBdje3BfUSt2id580=3D
=3DvTMf
-----END PGP SIGNATURE-----
