From: raven@themaw.net
Subject: Re: autofs dont keep running in slackware
Date: Wed, 30 Jun 2004 22:14:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406302203090.1811@donald.themaw.net>
References: <20040629204829.M71473@fabriciolima.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040629204829.M71473@fabriciolima.com.br>
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
To: Fabricio Lima <listas@fabriciolima.com.br>
Cc: autofs mailing list <autofs@linux.kernel.org>


I'm not really familiar with embedded systems so ...

On Wed, 30 Jun 2004, Fabricio Lima wrote:

> The libs were copied correctly to /usr/lib/autofs/*,  and the autofs.o =
module=20
> is loaded at the startup.

What versions of kernel and autofs are you using?
Any autofs patches been applied to the kernel?
Are you using kernel module versioning?
If so does the autofs module version match the kernel version?
Have you tried compiling autofs into the kernel?
Does that work?

>=20
> I had made a modified version of rc.autofs (see below) to make it work =
with=20
> slackware, but even if I type 'automount /mnt file /etc/auto.misc' it s=
tops=20
> running and when I type '/etc/rc.d/rc.autofs status' it shows:
> Mount points configured:
> ------------------------
> /usr/sbin/automount /mnt file /etc/auto.misc
>=20
> Active mount points:
> --------------------
> #

What do you mean it stops running?
No process or just no mounts?

>=20
> Some interesting observations about my enviroment:
> -The root filesystem is readonly (cramfs!) I boot the system from /boot=
=20
> (ext2) and /var and /tmp is mounted using /dev/ram0. (/mnt resides at m=
y read-
> only root file system)
>=20
> /etc/fstab:
> /dev/hda1        /boot            ext2        ro               1   0
> /dev/hda2        /                cramfs      ro               1   0
> /dev/hda3        /Data/Files   ext3    sync,data=3Djournal       1   0
> devpts           /dev/pts         devpts      gid=3D5,mode=3D620   0   =
0
> proc             /proc            proc        defaults         0   0
>=20
> As the /etc/mtab is never updated (readonly filesystem) that=B4s what i=
s=20

But autofs expects the mtab to be up to date.
What mount are you using?
Is it modified to not update mtab?
You might try linking it to /proc/mounts.

> mounted at run-time:
> #cat /proc/mounts:
> rootfs / rootfs ro 0 0
> /dev/root / cramfs ro 0 0
> /dev/hda1 /boot ext2 ro 0 0
> /dev/hda3 /root/2m2b/Data/Files ext3 rw,sync 0 0
> devpts /dev/pts devpts rw 0 0
> proc /proc proc rw 0 0
> /dev/ram2 /var ext2 rw 0 0
> /dev/ram2 /var/tmp/autofs-bind-40e28eec-5c/dir2\040(deleted) ext2 rw 0 =
0
> automount(pid92) /mnt autofs rw 0 0
>=20
> main part of rc.sysinit:
> dd if=3D/var.fs of=3D/dev/ram2
> mount -n /dev/ram2 /var
> (tmp is linked to /var/tmp)
> /etc/rc.d/rc.autofs start
>=20
> /etc/auto.master:
> /mnt    /etc/auto.misc
>=20
> /etc/auto.misc:
> usb   -fstype=3Dvfat,sync,nodev,nosuid   :/dev/sda1
>=20

To work out what's happenng we need more info.

How about using autofs-4.1.3 and using the --debug option to get debug=20
output.

Is the syslog you use able to send output to a loghost?

Ian
