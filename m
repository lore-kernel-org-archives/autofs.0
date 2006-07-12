From: =?utf-8?B?5aec5Zu95Lyf?= <jianggw@bsw.net.cn>
Subject: Re: about mainboard driver
Date: Wed, 12 Jul 2006 09:22:41 +0800
Message-ID: <034201c6a551$ab6efef0$4d74a8c0@jiangguowei2>
References: <04cd01c69fe2$d2044bc0$4d74a8c0@jiangguowei2>
	<Pine.LNX.4.64.0607051137470.24272@simba.math.ucla.edu>
	<028d01c6a183$66f1fb00$4d74a8c0@jiangguowei2>
	<Pine.LNX.4.64.0607071000360.32493@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="utf-8"
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

Thank you for your patience,Jim.You are so kind.

----- Original Message -----=20
From: "Jim Carter" <jimc@math.ucla.edu>
To: "=C3=A5=C2=A7=C5=93=C3=A5=E2=80=BA=C2=BD=C3=A4=C2=BC=C5=B8" <jianggw@=
bsw.net.cn>
Cc: <autofs@linux.kernel.org>
Sent: Saturday, July 08, 2006 1:16 AM
Subject: Re: [autofs] about mainboard driver


> On Fri, 7 Jul 2006, ??? wrote:
>=20
> > > I don't think Linux has a specific "mainboard driver" like Windows =
does;=20
> > > hardware initialization is done with the subsystems (e.g. memory=20
> > > management) to which it's relevant, and where necessary the actions=
 are=20
> > > conditional on the chipset, with both run-time tests and the possib=
ility to=20
> > > exclude a whole class of processors/chipsets at compile time.
> >=20
> > Hi,Jim .I don't understand your meaning.Could you explain more partic=
ularly?
>=20
> The kernel (.config) has a collection of configuration options so you c=
an=20
> pick which architecture, and which variants of that architecture, you w=
ant=20
> to compile the kernel for.  These are used to turn on and configure var=
ious=20
> features.  For example, in the x86_64 architecture, you tell it you wan=
t=20
> to support AMD Opteron or Athlon64 and it will define MK8, whereas for =
an=20
> Intel Xeon or Pentium-4 with extended memory you would have MPSC define=
d.
> These are then interrogated to set, for example, the level 1 cache line=
=20
> size (X86_L1_CACHE_BYTES and X86_L1_CACHE_SHIFT).  These are used in=20
> ./arch/x86_64/kernel/vmlinux.lds.S to align some frequently used kernel=
=20
> variables, like "jiffies", for fastest access.  I don't see anyplace el=
se=20
> where these #defines are used.
>=20
> As another example, the Via Centaur processor has an onboard crypto eng=
ine,=20
> and you need to set CRYPTO_DEV_PADLOCK to use it, if your kernel may ru=
n on=20
> a Via Centaur. =20
>=20
> The developers try to avoid special cases for particular processors, bu=
t
> bits and pieces like this are scattered various places around the kerne=
l.=20
> In Windows there is a specific driver file for each processor type, and=
 I=20
> don't know any more about what's in it than anyone else outside of=20
> Microsoft, but I assume that they collect the various special cases in =
that=20
> one file.  That's not what Linux does, and you can't identify a particu=
lar=20
> part of the kernel as the "mainboard driver".
>=20
> I think this discussion is kind of getting off the topic of autofs.
>=20
> James F. Carter          Voice 310 825 2897    FAX 310 206 6673
> UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-=
1555
> Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for P=
GP key)
>=20
