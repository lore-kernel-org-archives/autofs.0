From: Peter Astrand <peter@cendio.se>
Subject: Re: umount fails with NFS mounts
Date: Tue, 14 Sep 2004 21:00:44 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0409142055270.2455-100000@maggie.lkpg.cendio.se>
References: <Pine.LNX.4.58.0409141122080.3425@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409141122080.3425@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

> > We are running autofs-3.1.7-36 on RedHat 9, with kernel 2.4.20-30.9sm=
p. =20
> > The mount version is 2.11y. The NFS server is Novell Netware 6.0sp3. =
Our
> > auto.master looks like:
>=20
> Can you upgrade to autofs-4.1.x? =20

Perhaps. Can I expect it to work good on a standard RH9 kernel?


> attributable to the kernel.  Does Red Hat have a new release with the
> new kernel?

Fedora Core contains autofs-4, but I haven't seen such packages for RH9.=20


> You have an interesting product (
> http://www.thinlinc.com/index.phtml?action=3Dview&page=3D19
> http://www.cendio.com/
> ) and I can see the need for reliable automounter / NFS service at the=20
> server interconnect cluster.

Thanks. Now if only Netware NFS could be little more stable... :)

--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00
