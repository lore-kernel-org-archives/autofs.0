From: <EAGOMEZC@REPSOLYPF.COM>
Subject: RE: auto direct
Date: Wed, 21 Jul 2004 10:31:22 -0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200407211332.i6LDWPmh030349@ns4.ypf.com.ar>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: raven@themaw.net, dbahi@enterasys.com
Cc: autofs@linux.kernel.org

ok,

but why not ?

is it not posible ?

is it not implemented yet ?

Can I help you ?

Thanks.

-----Mensaje original-----
De: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org]En nombre de raven@themaw.net
Enviado el: martes, 20 de julio de 2004 13:37
Para: D. Bahi
CC: autofs@linux.kernel.org
Asunto: Re: [autofs] auto direct


On Tue, 20 Jul 2004, D. Bahi wrote:

> well - to be helpful - direct mounts are supported if you have
> a non-root mount point (a mount point other than '/')
>=20
> /etc/auto.direct (works):
>=20
> /mount/auto  -options server:/path/to/mount/point
>=20
> but
>=20
> /etc/auto.direct (won't work):
>=20
> /mountauto  -options server:/path/to/mount/point
>

That's right and it is still a problem.

>=20
> Ian Kent wrote:
>=20
> > On Fri, 16 Jul 2004 EAGOMEZC@REPSOLYPF.COM wrote:
> >=20
> >=20
> >>Hi,=20
> >>
> >>i=B4ll need to setup direct maps in a linux box using a nis server on=
 Solaris 8.=20
> >>This option is not supported in autofs 4.
> >>
> >>I don=B4t know why is not supported, why ? is not implemented, or are=
 there any security tip ?=20
> >>
> >>Are there another way to mount direct maps ?
> >>
> >=20
> >=20
> > Your not entirely correct.
> >=20
> > Maybe you should investigate a bit before making these assumptions.
> >=20
> > Ian
> >=20
> >=20
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
>=20
> --=20
> db
>=20
>=20


_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs


AVISO LEGAL:

Esta informaci=F3n es privada y confidencial y est=E1 dirigida =FAnicamen=
te a su destinatario. Si usted no es el destinatario original de este men=
saje y por este medio pudo acceder a dicha informaci=F3n por favor elimin=
e el mensaje. La distribuci=F3n o copia de este mensaje est=E1 estrictame=
nte prohibida. Esta comunicaci=F3n es s=F3lo para prop=F3sitos de informa=
ci=F3n y no debe ser considerada como propuesta, aceptaci=F3n ni como una=
 declaraci=F3n de voluntad oficial de REPSOL YPF S.A. y/o subsidiarias y/=
o afiliadas. La transmisi=F3n de e-mails no garantiza que el correo elect=
r=F3nico sea seguro o libre de error. Por consiguiente, no manifestamos q=
ue esta informaci=F3n sea completa o precisa. Toda informaci=F3n est=E1 s=
ujeta a alterarse sin previo aviso.=20

This information is private and confidential and intended for the recipie=
nt only. If you are not the intended recipient of this message you are he=
reby notified that any review, dissemination, distribution or copying of =
this message is strictly prohibited. This communication is for informatio=
n purposes only and shall not be regarded neither as a proposal, acceptan=
ce nor as a statement of will or official statement from REPSOL YPF S.A. =
and/or subsidiaries and/or affiliates. Email transmission cannot be guara=
nteed to be secure or error-free. Therefore, we do not represent that thi=
s information is complete or accurate and it should not be relied upon as=
 such. All information is subject to change without notice.
