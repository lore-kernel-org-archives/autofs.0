From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs screwed by getopt?
Date: Mon, 23 Jul 2007 10:08:29 -0400
Message-ID: <x49y7h7qkki.fsf@segfault.boston.devel.redhat.com>
References: <87vecbxmzt.fsf@lrde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <87vecbxmzt.fsf@lrde.org> (=?iso-8859-1?Q?=22Micha=EBl?=
	Cadilhac"'s message of "Mon\, 23 Jul 2007 15\:34\:14 +0200")
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
To: =?iso-8859-1?Q?Micha=EBl?= Cadilhac <michael@cadilhac.name>
Cc: autofs@linux.kernel.org

=3D=3D> On Mon, 23 Jul 2007 15:34:14 +0200, michael@cadilhac.name (Micha=EB=
l Cadilhac) said:

Micha=EBl> Hi guys!
Micha=EBl> I have a NIS based automount configuration that reads like that=
=A0:

Micha=EBl> lri4-154 linux # ypcat -k auto.master
Micha=EBl> /special auto.special  -rw,intr,soft
Micha=EBl> /servers auto.servers  -rw,intr,soft
Micha=EBl> /local auto.local    -rw,intr,soft
Micha=EBl> /u auto.u            -rw,intr,soft,nosuid
Micha=EBl> /tmpsim auto.tmpsim     -rw,intr,soft
Micha=EBl> /users auto.users    -rw,intr,hard,nosuid,tcp,nfsvers=3D3,timeo=
=3D600,retrans=3D2

Micha=EBl> Didn't seem like a badly formatted one. So I launched autofs, an=
d here's
Micha=EBl> what it said=A0:

Micha=EBl>  * Starting automounter ...
Micha=EBl>  /special/usr/sbin/automount: option -t requires a numeric argum=
ent, got r,soft
Micha=EBl>  * Failure on /special
Micha=EBl>  /servers/usr/sbin/automount: option -t requires a numeric argum=
ent, got r,soft
Micha=EBl>  * Failure on /servers
Micha=EBl>  /local/usr/sbin/automount: option -t requires a numeric argumen=
t, got r,soft
Micha=EBl>  * Failure on /local
Micha=EBl>  /u/usr/sbin/automount: option -t requires a numeric argument, g=
ot r,soft,nosuid
Micha=EBl>  * Failure on /u
Micha=EBl>  /tmpsim/usr/sbin/automount: option -t requires a numeric argume=
nt, got r,soft
Micha=EBl>  * Failure on /tmpsim
Micha=EBl>  /users/usr/sbin/automount: option -t requires a numeric argumen=
t, got r,hard,nosuid,tcp,nfsvers=3D3,timeo=3D600,retrans=3D2
Micha=EBl>  * Failure on /users

Micha=EBl> Point is that the `-rw,int' is interpreted by the getopt like a =
bunch of
Micha=EBl> not understood options then a `t', as in `timeout'. So the next =
part,
Micha=EBl> e.g. `r,soft', is considered as the argument of `timeout' which =
is not
Micha=EBl> quite good.

Micha=EBl> What I did is that I removed the short opts for getopt in the in=
it.d
Micha=EBl> script, but I'm not quite sure it's The Right Thing to Do.

Micha=EBl> Maybe the config got from nis is faulty, if so, just tell me, I'=
ll
Micha=EBl> despise my sysadmin.

Micha=EBl> Thanks!

Micha=EBl> PS: In fact, it seems that the mount options are not applied at
Micha=EBl> all. Don't have a clue why.

Micha=EBl> lri4-154 linux # automount --version
Micha=EBl> Linux automount version 4.1.3

You are most likely running into a bug in the parsing done in the init
script.  What does '/etc/init.d/autofs status' show?

I have a couple of patches to fix that up.  I don't have a gentoo
source tree, though.  If you can point me at one, I can likely send
you a patch to try.

-Jeff
