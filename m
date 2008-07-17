From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Fri, 18 Jul 2008 07:57:21 +0800
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F05192E7D@permls05.wde.woodside.com.au>
References: <487F90B1.1090405@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <487F90B1.1090405@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org


Hi =


I was trying to sanitise the logs a bit and didn't do a good job of it.  /e=
tc/sysconfig/autofs, /etc/ldap.conf and /etc/openldap/ldap.conf all refer t=
o the same LDAP servers.

grep aer /etc/sysconfig/autofs /etc/ldap.conf /etc/openldap/ldap.conf
/etc/sysconfig/autofs:LDAP_URI=3D"ldaps://aether.woodside.com.au:636 ldaps:=
//aer.woodside.com.au:636"
/etc/ldap.conf:uri ldaps://aether.woodside.com.au:636 ldaps://aer.woodside.=
com.au:636
/etc/openldap/ldap.conf:URI ldaps://aether.woodside.com.au:636 ldaps://aer.=
woodside.com.au:636

CC
 =


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org =

> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Guillaume Rousse
> Sent: Friday, 18 July 2008 2:34 AM
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] Autofs doesn't look at second LDAP server
> =

> Ian Kent a =E9crit :
> > I wonder if it's getting the server from the config at all?
> > It should be.
> > =

> > LDAP_URI=3D"ldaps://ldap2.woodside.com.au:636 =

> ldaps://ldap1.woodside.com.au:636"
> If this isn't explicitely set in autofs configuration, are =

> the different =

> servers configured for openldap library used instead ?
> =

> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> =


NOTICE: This email and any attachments are confidential. =

They may contain legally privileged information or =

copyright material. You must not read, copy, use or =

disclose them without authorisation. If you are not an =

intended recipient, please contact us at once by return =

email and then delete both messages and all attachments.
