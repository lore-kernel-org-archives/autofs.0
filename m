From: Peter Astrand <peter@cendio.se>
Subject: umount fails with NFS mounts
Date: Tue, 14 Sep 2004 15:10:51 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0409141459270.6694-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


We are using autofs for mounting home directories, but are experiencing
two major problems wrt unmounting NFS mounts:

1) The umount command indicates that the umount succeeded, but even so,=20
the NFS export is still mounted. This can be confirmed by looking in=20
/etc/mtab and /proc/mounts.=20

2) Home directories are not umounted after the specified idle time.=20

We are running autofs-3.1.7-36 on RedHat 9, with kernel 2.4.20-30.9smp. =20
The mount version is 2.11y. The NFS server is Novell Netware 6.0sp3. Our
auto.master looks like:

/home   program:/opt/thinlinc/libexec/tl-nds-mountpath nfsvers=3D2,hard,i=
ntr

(tl-nds-mountpath is a small program which returns the path to the Netwar=
e=20
server that has the users home directory.)

Any ideas? This is a major problem for us, since it's not possible to hav=
e=20
more than 800 NFS mounts or so.=20


--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00
