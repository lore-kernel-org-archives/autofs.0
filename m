From: raven@themaw.net
Subject: Re: csh/cd not getting the right cwd at the mount point
Date: Sat, 10 Jul 2004 13:43:22 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407101248510.1378@donald.themaw.net>
References: <BA0E4392AD99D040885C414D992C24BE08264B56@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE08264B56@us-bv-m11.bv.tek.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: peter.a.harris@exgate.tek.com
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 9 Jul 2004 peter.a.harris@exgate.tek.com wrote:

I'm having difficulty understanding the problem you describe.

> We have a problem.  Here are the conditions:
>=20
> 1. Shell is (t)csh (does not happen under (ba)sh)
> 2. cd to an autofs fa=E7ade (e.g. /tools in our case)
> 3. cd relatively to the subdirectory that is the mount point. =20
>    NOTE: The mount must not yet be made. (e.g. perl5.8.3)
> 4. cd relatively to a subdirectory in the mounted files system=20
>    (e.g. bin or lib)

Sorry, but the cd must cause a mount to happen. This is the case with the=
=20
latest autofs and must be the case for correct operation of autofs.

What is the reasoning here?

>=20
> Pertinent stats:
>   * Red Hat EL 3.0 (no update) 2.4.21-4.ELhugemem=20
>   * All available Red Hat updates have been applied EXCEPT for kernel
>     autofs, and lpr updates
>   * autofs: autofs-4.1.0-2 from January 04
>   * autofs4: autofs4-2.4-module-20031201

These autofs versions are old. There are known problems fixed after these=
=20
releases that sound similar to the problem you describe.

I recommend you try autofs4 release 20040508. Unfortuneately this release=
=20
requires a kernel rebuild as there is a small mandatory change outside of=
=20
the autofs4 module needed for correct operation. This release is the one=20
that should be used as it addresses all known problems and works best wit=
h=20
the latest autofs release.

You should be using autofs-4.1.3. There is an additional patch that I hav=
e=20
recommened a couple of times now, without adverse feedback, that my fix=20
your problem. I've uploaded it to kernel.org and it can be found at:

http://www.kernel.org/pub/linux/daemons/autofs/v4

named

autofs-4.1.3-bad_chdir.patch

Additionally, I recommend applying:

autofs-4.1.3-mtab_lock.patch

found with the above patch. It fixes an obvios stupid mistake in=20
the definition of mount(8)s' lock file name.

As a RHEL user visiting Jeff Moyers autofs page is a must as there are=20
patches included their that have not yet been included in an autofs=20
release:

http://people.redhat.com/~jmoyer

Jeff, would it be possible to include the two patches mentioned above in=20
your rpms please.

Ian
