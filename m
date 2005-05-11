From: =?ISO-8859-1?Q?Xisco_Fern=E1ndez?= <fjfernandez@riu.com>
Subject: autofs and dollar sign in hidden NT volumes
Date: Wed, 11 May 2005 18:32:57 +0200
Message-ID: <428233B9.8080401@riu.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: autofs@linux.kernel.org

Hello list,

I'm having some sort of problem w/ automount. I'm trying to automount
hidden windows volumes (volume$), but the dollar sign isn't being
recognized by autofs.

I am able to mount that share manually with mount.smbfs.
I am able to mount other non hidden shares with automount.

It's not a credentials problem:

auto.master:

/mnt/auto       /etc/auto.sgil --timeout=3D2

auto.sgil:

cdrom -fstype=3Diso9660,ro,nosuid,nodev :/dev/cdrom
sgil  -fstype=3Dsmbfs,username=3Druben,password=3Dtosidad,codepage=3Dcp85=
0=20
://192.168.2.57/SGIL$


LOG:

May 11 17:35:26 localhost automount[20971]: >> 20973: tree connect=20
failed: ERRDOS - ERRnosuchshare (You specified an invalid share name)
May 11 17:35:26 localhost automount[20971]: >> SMB connection failed
May 11 17:35:26 localhost automount[20971]: mount(generic): failed to=20
mount //192.168.2.57/SGIL (type smbfs) on /mnt/auto/sgil
May 11 17:35:26 localhost automount[20971]: failed to mount /mnt/auto/sgi=
l

Thanks in advanced.

--=20
Francisco Jos=E9 Fern=E1ndez Rivera
Departamento de Tecnolog=EDa (Redes)
Riu Hotels & Resorts
Palma de Mallorca
Espa=F1a
