From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs screwed by getopt?
Date: Mon, 23 Jul 2007 11:19:10 -0400
Message-ID: <x491wezqhap.fsf@segfault.boston.devel.redhat.com>
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

Ian pointed out the obvious to me in irc.  From the man page for auto.maste=
r:

      Any remaining command line arguments without leading dashes (-) are t=
aken as  options  (-o)  to
      mount.  Arguments with leading dashes are considered options for the =
maps.

So, remove the '-' character from the options list and things should work a=
s expected.

-Jeff
