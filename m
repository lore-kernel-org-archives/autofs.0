From: Dirk Heinrichs <ext-dirk.heinrichs@nokia.com>
Subject: Re: Program maps - examples?
Date: Tue, 18 Nov 2003 15:31:31 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA2D43.9030609@nokia.com>
References: <B9F4645CD7B0D511BE8300508B68C327025EADB0@tnscapp02.pcacorp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <B9F4645CD7B0D511BE8300508B68C327025EADB0@tnscapp02.pcacorp.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: autofs@linux.kernel.org

Stuckless, Colin wrote:
>  > Hello,

>  > Local:        /level1/level2/home/username
>  > Server: /prefix/homestore_[:a-z:]/username
 >  >
>  > This means when I want to mount my own home I have to mount
>  > server:/prefix/homestore_d/dheinric to /level1/level2/home/dheinric.=
 I
>  > guess there's no other way than using a program map, but there's not
>  > much documentation/examples about this in the package. Can
>  > someone sched
>  > some light on this, please.
>=20
> You can create an auto.home map on the server which has all the
> pathnames and mount points. For example, your auto_master would
> say:
>=20
> /level1/level2/home auto_home
>=20
> and then your auto_home map would have entries like:
>=20
> dheinric server:/prefix/homestore_d/&
Tried this, but did not quite succeed. The problem is that this would=20
require entries for every single user. But the following auto.home then=20
worked for me:

#!/bin/bash
FIRST_LETTER=3D`echo $1|cut -c 1`
echo server:/prefix/homestore_${FIRST_LETTER}/$1

This returns the correct path.

> This would result in the client automounting /level1/level2/home/dheinr=
ic
> from server:/prefix/homestore_d/dheinric when you cd'd into the directo=
ry.
>=20
> =20
>  > I've also looked onto our Solaris machines. They seem to cascade the
>  > maps, which I guess is not possible on linux, right?
>=20
>=20
> I'm not sure what you mean by cascade, but their is a syntax I've
> seen referred to as 'multimount' where you have multiple subdirectories
> undr a single mount point, each seperated by a "\" continuation charact=
er.
> These exist on HP-UX and Solaris. The newest autofs does support this,
> I'm using the autofs-4.1 beta with these type of maps and it's working
> fine.
In auto_master they have a line "/level1 auto_level1", then in=20
auto_level1, there is "level2 -fstype=3Dautofs auto_level2", this is what=
=20
I mean with cascading. Meanwhile, I found another Linux box here which=20
does the same, but the syntax is different: "level2 -fstype=3Dautofs=20
file:/full/path/to/map"

Bye...

	Dirk
--=20
Dirk Heinrichs          | Tel:  +49 (0)151 1513 6954
Configuration Manager   | Fax:  +49 (0)211 47068 111
Cap Gemini Ernst & Young| Mail: dirk.heinrichs@cgey.com
Hambornerstra=DFe 55      | Web:  http://www.cgey.com
D-40472 D=FCsseldorf      | ICQ#: 110037733
GPG Public Key C2E467BB | Keyserver: www.keyserver.net
