From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 08:29:36 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403290829.43397.krienke@uni-koblenz.de>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<Pine.LNX.4.53.0403271550420.3141@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12439147198075995=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403271550420.3141@xena.cft.ca.us>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Jim Carter <jimc@krienke.org>
Cc: autofs@linux.kernel.org


--===============12439147198075995==
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_WJ8ZAvQfVzKdfAg";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit


--Boundary-02=_WJ8ZAvQfVzKdfAg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 28. M=E4rz 2004 01:35, Jim Carter wrote:
> On Fri, 26 Mar 2004, Rainer Krienke wrote:
> > I am looking on the exact format that a executable map has to echo to
> > stadout in order to automount something.
>
> As far as I can tell, it's supposed to send out what would have been in a
> "file" map, minus the key and following whitespace.  For example, I have =
an
> executable map that creates an appropriate file map and then emits a line
> to tell the automounter to create a submount with that map.  The script
> ends with:
>
Where did you find the information that the format should be like a filemap=
=20
without the key? I searched the manuals but the only information I was able=
=20
to find, was that an executable map has to echo a "map" to stdout. A map=20
would have been the key, then optinal options as well as the=20
server:/filesystem entry. But exactly this does not work. So you are probab=
ly=20
right that one should omit the key but its not documented as far as I can=20
see.

> > # This seems to work, but is it correct?
> > --bind -soft,retry=3D6 / server:/export/user/foo
>
> As I read the man page, it isn't.  You need 2 or 3 whitespace separated
> fields.  (For the executable map the key has to be omitted, meaning 1 or 2
> fields.)  This example has 4 fields.  The separate operand "--bind" is
> going to be real hard to make to work, and the isolated slash (converted =
to
> an out-of-order key in other examples) is not wanted.  If the autofs daem=
on
> were to take the last field as the mount referent and the first field
> (--bind) as the mount options, it might just ignore the middle fields, not
> bothering to reject the line for illegal format.
>
> Are you actually getting bind mounts?  I thought the referent had to
> already be mounted before you could do a bind mount, and the "olddir" has

The example I gave was not complete because my focus was on the syntax an=20
executable map has to echo to stdout and less on a complete example. In=20
reality there is another autmount map that mounts the parent directory of a=
ll=20
users from the user-server. The map looks like this:

user		server:/export/user   # Map on /import

So when /import/user is reffered to then the parentdirectory with all users=
 is=20
mouted below /import/user. The auto.home map from above contains enries lik=
e=20

krienke	server:/export/user/krienke

Since server:/export/user on the client machine is already mounted=20
under /import/user autofs placed a bind mount. Well because of what you sai=
d=20
about the problems specifying --bind as an option in the executable map I=20
guess in between, that my --bind option did not have any effect it was auto=
fs=20
itself that did the right thing. =20

>
> > My problem is that after a while on my real server which uses lots of
> > user automounts like described here after shutting down autofs (switchi=
ng
> > to single user) I am unable to umount the user filesystem with the users
> > on it since it claims to be busy. But there are no more processes (like
> > automount, nfsd, user processes) that could make it busy.  So I suspect
> > that a wrong format of the executable map might confuse the kernel.
>
> I doubt the kernel is confused; more likely there really is a process
> "cd'd" to that directory.  Try this (on the machine that refuses to
> unmount) -- I'm using my own homedir as the example of what might have to
> be unmounted.
>
> [root tupelo /tmp/root.jimc 2] fuser -mv /h1/maint/jimc

Yes already did this and the output (in single user mode) is empty.=20
Nevertheless I cannot umount the filesystem.  fuser -v /export/user says,=20
that there is a kernel mount:
                     USER        PID ACCESS COMMAND
/export/user             root     kernel mount  /export/user

but there are no user processes left. Even lsof /export/user does not echo=
=20
anything. Here you can see all processes left:

http://www.uni-koblenz.de/~krienke/tmp/processes.txt

The data lie on an xfs filesystem. Below this there is LVM2 and below LVM2=
=20
there is a md software raid and below this a md multipath device and then=20
finally two hardware raids (connected to the host by fibrechannel via two=20
fc-switches).


Thanks
Rainer Krienke
=2D-=20
=2D------------------------------------------------------------------------=
=2D-
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
=2D------------------------------------------------------------------------=
=2D-

--Boundary-02=_WJ8ZAvQfVzKdfAg
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAZ8JWaldtjc/KDEoRAs4ZAJ9eBZfmp7OdLfdn3Da2pAwagHhnPQCg+Gdk
eFQ5PfAAeVduazD34TaVjFM=
=U53/
-----END PGP SIGNATURE-----

--Boundary-02=_WJ8ZAvQfVzKdfAg--


--===============12439147198075995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============12439147198075995==--

