From: =?iso-8859-1?b?RWRq6Q==?= <edosseh@ub.tg>
Subject: Re: Autofs5:master_notify: syntax error in map near
	[	/home ]
Date: Tue, 19 Jun 2007 09:53:22 +0000
Message-ID: <1182246802.4677a792993a5@www.univ-lome.tg>
References: <1181753129.46701f29a6e26@www.univ-lome.tg>
	<x49tztbok9z.fsf@segfault.boston.devel.redhat.com>
	<1181754391.4670241762d0c@www.univ-lome.tg>
	<1181835067.46715f3b7d073@www.univ-lome.tg>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1181835067.46715f3b7d073@www.univ-lome.tg>
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
Content-Type: text/plain; charset="macroman"
To: autofs@linux.kernel.org

Thank you,
That works with followings:

For auto.home:
  dn: ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
  ou: auto.home
  objectClass: top
  objectClass: automountMap

  dn: cn=3D/,ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
  objectClass: automount
  cn: /
  automountInformation: -rw,hard,intr ulns:/home/&

Because i changed organizationalUnit objectClass of
ou:auto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg to automountMap.

  Entry for auto.master stay:

dn: ou=3Dauto.master,ou=3Dpersonnes,o=3Dul,c=3Dtg
ou: auto.master
objectClass: top
objectClass: automountMap

dn: cn=3D/home,ou=3Dauto.master,ou=3Dpersonnes,o=3Dul,c=3Dtg
objectClass: automount
cn: /home
automountInformation: ldap:ulns:ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg

 But System Sessions after authentications have problems to load
desktops(especially gnome). I use a Fedora core 4 on Client and Fedora Core=
 3
on server. The error concerns problem with gdm permissions. According to so=
me
persons it'ld be resolved with enabling nfs lock. But i don't succeed. What=
 can
i do?


> Selon Edj=E9 <edosseh@ub.tg>:
>
> When i put 192.168.210.3:ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg inst=
ead of
> ldap://192.168.210.3/ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
>
> I receive this output in my log file:
>
>  Starting automounter version 5.0.1-1, master map auto.master
> Jun 14 15:32:05 Sersau automount[21813]: using kernel protocol version 5.=
00
> Jun 14 15:32:06 Sersau automount[21813]: master_notify: syntax error in m=
ap
> near
> [ /home ]
>
> What it means?
>
> > Jeff
> > Thank you for the interest
> >
> > Selon Jeff Moyer <jmoyer@redhat.com>:
> >
> > > =3D=3D> On Wed, 13 Jun 2007 16:45:29 +0000, Edj=C3=A9 <edosseh@ub.tg>=
 said:
> > >
> > > Edj=C3=A9> Hello,
> > > Edj=C3=A9> Please help with autofs5 because i tried some advices with=
out
> > success.
> > > Edj=C3=A9> I want to mount users home with autofs5. I tried it before=
 with
> nfs
> > > with
> > > Edj=C3=A9> success.
> > > Edj=C3=A9> My conf is:
> > >
> > > Edj=C3=A9> dn: cn=3D/home,ou=3Dauto.master,ou=3Dpersonnes,o=3Dul,c=3D=
tg
> > > Edj=C3=A9> objectClass: automount
> > > Edj=C3=A9> cn: /home
> > > Edj=C3=A9> automountInformation:
> > > ldap//192.168.210.3/ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
> > >
> > > try ldap://192.168.210.3/ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
> > >         ^
> > > Note the colon between ldap and '//'.
> >
> > But trying give this error:
> > lookup_init: lookup(ldap): failed to get query dn
> > Jun 13 17:12:12 Sersau automount[18249]: mount_autofs_indirect: failed =
to
> > read
> > map for /home
> > Jun 13 17:12:12 Sersau automount[18249]: handle_mounts: mount of /home
> > failed!
> > Jun 13 17:12:12 Sersau automount[18249]: master_do_mount: failed to sta=
rtup
> > mount
> >
> > >
> > > -Jeff
> > >
> >
> >
> > --
> > "Heureux ceux qui sont conscients de leur pauvret=E9 spirituelle." - Mat
> > 5:3(Les
> > Saintes Ecritures - Traduction du monde nouveau).
> >
> > ----------------------------------------------------------------
> > Ce message a =C3=A9t=C3=A9 envoy=C3=A9 depuis le serveur de messagerie =
de l'Universit=C3=A9
> > de
> > Lom=C3=A9.
> > Universit=C3=A9 de Lom=C3=A9
> > BP 1515
> > Lom=C3=A9 TOGO.
> >
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> >
>
>
> --
> "Heureux ceux qui sont conscients de leur pauvret=E9 spirituelle." - Mat
> 5:3(Les
> Saintes Ecritures - Traduction du monde nouveau).
>
> ----------------------------------------------------------------
> Ce message a =C3=A9t=C3=A9 envoy=C3=A9 depuis le serveur de messagerie de=
 l'Universit=C3=A9
> de
> Lom=C3=A9.
> Universit=C3=A9 de Lom=C3=A9
> BP 1515
> Lom=C3=A9 TOGO.
>


--
"Heureux ceux qui sont conscients de leur pauvret=E9 spirituelle." - Mat 5:=
3(Les
Saintes Ecritures - Traduction du monde nouveau).

----------------------------------------------------------------
Ce message a =C3=A9t=C3=A9 envoy=C3=A9 depuis le serveur de messagerie de l=
'Universit=C3=A9 de
Lom=C3=A9.
Universit=C3=A9 de Lom=C3=A9
BP 1515
Lom=C3=A9 TOGO.
