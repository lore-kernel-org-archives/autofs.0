From: Peter Astrand <peter@cendio.se>
Subject: RE: [autofs] umount fails with NFS mounts
Date: Thu, 23 Sep 2004 15:49:17 +0200 (CEST)
Sender: nfs-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0409231438370.23756-100000@maggie.lkpg.cendio.se>
References: <482A3FA0050D21419C269D13989C611302B07E14@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <nfs-admin@lists.sourceforge.net>
In-Reply-To: <482A3FA0050D21419C269D13989C611302B07E14@lavender-fe.eng.netapp.com>
Errors-To: nfs-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: "Lever, Charles" <cel@netapp.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net, Erik Forsberg <forsberg@cendio.se>


> > We are using autofs for mounting home directories, but are=20
> > experiencing two major problems wrt unmounting NFS mounts:
> >=20
> > 1) The umount command indicates that the umount succeeded,=20
> > but even so,=20
> > the NFS export is still mounted. This can be confirmed by looking in=20
> > /etc/mtab and /proc/mounts.=20
>=20
> in other words, you are able to replicate this problem without autofs
> (ie, using only static mount points)?

Sorry for the delay. This is a production system, so we cannot experiment=20
with it very much. It's a bit hard to use to reproduce this problem.=20

Usually, it happens when we are running a script which sets correct=20
permissions for the users home directories. It does, basically:

stat /home/theuser
chown theuser /home/theuser
umount /home/theuser

It iterates through several thousands of users. After that, there are=20
usually several hundreds home directory mounts which cannot be umounted.=20

Today, I've managed to reproduce the problem by doing several
mounts/umounts for the same user. I've used the following shell script:

#!/bin/sh
while true; do
    usleep 50000
    echo statting
    stat /home/94azajmi >/dev/null
    echo umounting
    umount /home/94azajmi
    echo checking mounts
    mount | grep 94azajmi
done

First, I've ran it for about a minut, then terminated. No problems. Then I =

ran it for another minute. No problems. Then I recieved a phone call.=20
After that, I started the script again, and now it immediately failed to=20
umount the home directory:

# ./foo.sh
statting
umounting
checking mounts
10.201.1.10:/VOL1/Arb/94AZAJMI on /home/94azajmi type nfs (rw,nfsvers=3D2,h=
ard,intr,addr=3DX.X.X.X)

When this happened, I did a static mount on /mnt/floppy. It could be=20
umounted without problems.=20

I've noticed one very interesting thing: Each time I do a "umount=20
/home/94azajmi", this ends up in the system logg:

Sep 23 15:03:38 foobar last message repeated 3 times
Sep 23 15:03:42 foobar automount[1565]: attempting to mount entry /home/94a=
zajmi
Sep 23 15:03:42 foobar automount[6586]: >> mount: 10.201.1.10:/VOL1/Arb/94a=
zajmi failed, reason given by server: No such file or directory
Sep 23 15:03:42 foobar automount[1565]: attempting to mount entry /home/94a=
zajmi
Sep 23 15:03:42 foobar automount[6591]: >> mount: 10.201.1.10:/VOL1/Arb/94a=
zajmi failed, reason given by server: No such file or directory

At this point, I need to mention that our script tl-nds-mountpath is
slightly modified on this system: Because Netware is case sensitive when
speaking mount/nfs, tl-nds-mountpath does a test-mount (in another
directory) before returning the mount path. So, during the automount, the=20
script calls the mount command. Perhaps this confuses automount?

Of course, the question is why a umount triggers a mount in the first=20
place...


>   sudo sysctl -w sunrpc.rpc_debug=3D32767
=20
Is this safe to run on a production system?


--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00








-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
