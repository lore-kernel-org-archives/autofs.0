From: Jason Brooks <jason.brooks@windriver.com>
Subject: RE: automount
Date: Tue, 03 Feb 2004 14:55:55 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <402026FB.7080509@windriver.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Ian Kent <raven@themaw.net>, =?ISO-8859-1?Q?J=F6rg_Fichter?= <Joerg.Fichter@gmx.de>
Cc: autofs@linux.kernel.org

Hello,

You could instead use sudo to unmount the filesystems as necessary.
An entry in the sudoers file such as:

<useralias> <hostalias> =3D <password options>:/bin/umount -t nfs /misc/*

Will allow the users in question to run:
	sudo /bin/umount -t nfs /misc/tempfs

And of course, it will fail if the filesystem's in use.

In my mind, this may be a better place to implement commands requiring ro=
ot.

--jason


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jason Brooks ~ (503) 641-3440 x1861
       Direct ~ (503) 924-1861
Email to: jason.brooks@windriver.com
Twiki: http://twiki.wrs.com/do/view/Main/JasonBrooks

Senior Systems Administration Analyst
Wind River Systems
8905 SW Nimbus ~ Suite 255=09
Beaverton, Or 97008


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org=20
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> Sent: Tuesday, February 03, 2004 4:41 AM
> To: J=F6rg Fichter
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] automount
>=20
> On Mon, 2 Feb 2004, [iso-8859-1] J=F6rg Fichter wrote:
>=20
> > Dear Sirs,
> >=20
> > I've installed the automount system on my PC. Different=20
> user works on=20
> > this terminal! So I modified the auto.master file like this:
> >=20
> > /misc	/etc/auto.misc		user, exec, uid=3D700, gid=3D500
>=20
> Can't at the moment.
>=20
> The user option is only supported by mount when present in the fstab.
>=20
> I posted a message to the util-linux list but haven't=20
> followed up on this.=20
> I've been to busy.
>=20
> Ian
>=20
>=20
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>=20
