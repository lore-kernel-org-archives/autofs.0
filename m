From: Peter Astrand <peter@cendio.se>
Subject: RE: umount fails with NFS mounts
Date: Fri, 24 Sep 2004 09:45:36 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0409240925460.9368-100000@maggie.lkpg.cendio.se>
References: <Pine.LNX.4.58.0409230902080.9057@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409230902080.9057@simba.math.ucla.edu>
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
Cc: Erik Forsberg <forsberg@cendio.se>, nfs@lists.sourceforge.net

On Thu, 23 Sep 2004, Jim Carter wrote:

> There's an ambiguity whether you're going to stat the mount point with=20
> nothing mounted on it, or the referent of the mount.  Since the automou=
nter=20
> is involved, the mount points could exist without referents, depending =
on=20
> the version you're using and what options you've set for ghost mounts=20
> (browsing).  The automounter *should* finish the mount before releasing=
 the=20
> thread to do the stat, but...  If you stat /home/$user/. then the filen=
ame=20
> resolution code has to actually read the referent directory and look up=
 "."=20
> in it, resolving the ambiguity. =20

I see.=20


> > checking mounts
> > 10.201.1.10:/VOL1/Arb/94AZAJMI on /home/94azajmi type nfs=20
>     (rw,nfsvers=3D2,hard,intr,addr=3DX.X.X.X)
>=20
> The script mentioned further on (programmatic automount map?) changes t=
he
> loginID to upper case, because that is what is on the Novell system, ri=
ght?

Well, we don't know the case for the last component. So, the path can be=20
either 10.201.1.10:/VOL1/Arb/94AZAJMI or 10.201.1.10:/VOL1/Arb/94azajmi.=20
Therefore, tl-nds-mountpath tries to mount the one with uppercase, and if=
=20
that fails, it returns the lowercase variant.=20


> "mount | grep $user" and "grep $user /proc/mounts" normally give the
> same basic answers (a few options appear only in /etc/mtab), and if
> there were a difference between them, it might be a clue.

I didn't check this yesterday, but we have checked it earlier without=20
finding any differences (as far as I can remember).=20


> > I've noticed one very interesting thing: Each time I do a "umount=20
> > /home/94azajmi", this ends up in the system logg:
> >=20
> > Sep 23 15:03:38 foobar last message repeated 3 times
> > Sep 23 15:03:42 foobar automount[1565]: attempting to mount=20
>     entry /home/94azajmi
> > Sep 23 15:03:42 foobar automount[6586]: >> mount:=20
>     10.201.1.10:/VOL1/Arb/94azajmi failed, reason given by server: No s=
uch
>     file or directory
>=20
> The server did not lie, right?  /VOL1/Arb/94AZAJMI is on the server, no=
t
> /VOL1/Arb/94azajmi.  Is it possible that there are *two* automount maps=
,
> one with the programmatic case conversion and one maybe a simple file m=
ap=20
> with a wildcard? =20

No. The auto.master contains only one map, the one I sent in my original=20
posting.=20


> > tl-nds-mountpath does a test-mount (in another
> > directory) before returning the mount path.=20
>=20
> Maybe the message above from process 6586 is the test mount, which need=
ed=20
> case conversion and didn't get it.

As I understand it, pid 1565 is the automount process for /home, while=20
process 6586 is the forked-off child: the programmatic map=20
tl-nds-mountpath.=20


> > Of course, the question is why a umount triggers a mount in the first=
=20
> > place...
>=20
> Let me guess: automount has to consult the map to know the exact hostna=
me
> and options used to mount the filesystem, some of which are needed for =
the
> unmount.  (Well, I always do "umount /mount/point" and it works, but ma=
ybe
> the automounter needs to do more, such as finding and clearing an entry=
 in
> the list of filesystems it is responsible for.)  In your case, the map =
is
> programmatic and includes the test mount.  But under obscure circumstan=
ces
> the necessary case conversion isn't happening.

Can anyone confirm that the automounter actually may call the programmati=
c=20
map upon umount? If so, can the programmatic map detect that a umount is=20
happening, rather than a mount?


> Things would be a lot easier if you didn't have to do the test mount. =20
> Maybe do the Novell equivalent of a YP or Hesiod lookup so you know the
> right loginID without having to do any mounts.

Actually, the problem is not the loginID, but the case of the directory t=
o=20
mount. With home directories, the last component of the mount path is the=
=20
same as the loginID, but this might not be true for other exports, such a=
s=20
common data areas. Also, the case of the loginID (as returned from NDS)=20
might not be the same as the case of the actual directory.=20

Future versions of tl-nds-mountpath will speak the mount protocol=20
directly to verify that we have found the correct case of all components.=
=20

I'm still interested to know if a programmatic map might be called upon=20
umount, though.=20


--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00
