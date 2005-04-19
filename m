From: ramana <ramana@intraperson.com>
Subject: Re: mount -o bind
Date: Tue, 19 Apr 2005 18:35:07 +0530
Message-ID: <42650203.10904@intraperson.com>
References: <200504182056.j3IKutJ30896@mail.velociti.us>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504182056.j3IKutJ30896@mail.velociti.us>
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
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Lucas Peet <lpeet@velociti.us>
Cc: autofs@linux.kernel.org

Lucas Peet wrote:
> Hello,
>=20
> =20
>=20
> Does autofs / automount have the ability to bind one directory to=20
> another like =91mount =96o bind dir1 dir2=92?  And if so, can this be h=
andled=20
> by using wildcards in the maps?  Here is my situation:
>=20
> =20
>=20
> I have a large directory of user=92s home directories.  These are in a=20
> chroot jail, so making soft links isn=92t an option, and hard links won=
=92t=20
> work for directories.  I need to bind (mount) a directory that lives=20
> outside the chroot jail to a directory / mount point inside each home=20
> directory.  The users will only be accessing this directory for short=20
> periods (to copy a file or two), and I think it would be more practical=
=20
> to have autofs mount it whenever they needed access to it, and unmount=20
> it when they=92re done.
>=20
> =20
>=20
> I=92m not sure on the exact number of mounted filesystems Linux can han=
dle=20
> (or if a directory mounded via =96o bind counts towards that, though I=92=
d=20
> assume it would), but I would think that using automount instead of=20
> putting hundreds of entries into fstab would be more the Linux way of=20
> doing things.  Even if I had to put an entry for each user in a map,=20
> that would be a better solution to me than using fstab, since they all=20
> wouldn=92t be mounted at the same time, all the time.
>=20
> =20
>=20
> Dir to be accessed by all users:  /home/stuff/everyone
>=20
> =20
>=20
> Mounted to: /home/users/*/everyone
>=20
> =20
>=20
> Is this even possible?
>=20
> =20
>

To be honest I could not understand 100%.

But still something close to what you are asking is here http://www.intra=
person.com/autodir/.

If something else that you want is missing let me know.

Regards
ramana
--=20
http://www.intraperson.com
