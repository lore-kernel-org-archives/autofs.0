From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs segfault at startup on x86_64
Date: Tue, 03 Jan 2006 13:48:06 +0100
Message-ID: <43BA7286.50101@inria.fr>
References: <43BA56CF.6050109@inria.fr>
	<1136287828.2350.10.camel@eagle.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1136287828.2350.10.camel@eagle.themaw.net>
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

Ian Kent wrote:
> On Tue, 2006-01-03 at 11:49 +0100, Guillaume Rousse wrote:
>=20
>>I've been instructed to report this here instead of kernel bugzilla:
>>http://bugzilla.kernel.org/show_bug.cgi?id=3D5561
>>
>=20
>=20
> Hi Guillaume,
>=20
> Yes, I'll follow up on this.
>=20
> Perhaps a simple patch for configure would be a good workaround while I
> check out what's required. It appears you have spent a fair bit of time
> on this already but it would help if you could give me a brief
> description of your understanding of the problem and what you have foun=
d
> out so far.
Autofs requires to be compiled with -DLDAP_DEPRECATED on x86_64
platforms when linked against openldap >=3D 2.3, otherwise it
automatically triggers a segfault in openldap library during
initialisation (more exactly, in ldap_set_option() call from
do_connect() in lookup_ldap.c).

OpenLDAP maintainers suggest to either use this flags automatically
during compilation, or to change autofs code to use newest API.

--=20
No flight ever leaves on time unless you are running late and need the
delay to make the flight
		-- Murphy's Laws for Frequent Flyers n=B01
