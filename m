From: peter.a.harris@exgate.tek.com
Subject: RE: csh/cd not getting the right cwd at the mount point
Date: Mon, 12 Jul 2004 10:25:15 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: raven@themaw.net, jmoyer@redhat.com
Cc: autofs@linux.kernel.org

Ian/Jeff,

I just tried your test below and I **was** able to touch the file
successfully, even though I was seeing my problem.  The problem I am seei=
ng
seems to be limited to what the system thinks is the cwd.  Let me try to
restate the problem...

If I cd from directory to directory using a relative path for the argumen=
t
to cd, AND one of the cd's causes an automount to happen, AND I am runnin=
g
(t)cshell, then once I have entered a subdirectory of the mount point pwd=
 is
incorrect in that it is missing the mount point directory - that is it on=
ly
contains the fa=E7ade and the subdirectory of the mount point.  Not only =
does
pwd return the wrong value, but the /proc/$$/cwd symbolic link points to =
a
non-existent location.  Conversely, if you are running under /bin/sh or a
derivative, OR you jump directly past the mount point into the file syste=
m
in one cd, OR the file system is already mounted (i.e. the cd into the mo=
unt
point did not need to make the mount), all is well.  This happens with bo=
th
indirect and direct mounts; more of the path is missing if you have a dir=
ect
map entry that is more than one level down (e.g. /fa=E7ade/a/mnt_pt).

Here is an example.  I want to get to /fa=E7ade/mnt_pt/foo:
> cd /fa=E7ade
> pwd
/fa=E7ade
> cd mnt_pt
> pwd
/fa=E7ade/mnt_pt
> cd foo
> pwd
/fa=E7ade/foo

In fact if I do an "ls ../..", I get the correct listing of /fa=E7ade eve=
n
though according to pwd I should see the contents of /.

I sent this in mostly as a "have you seen this in the latest" just in cas=
e
it had not been fixed.

I know I am behind.  I have resisted compiling the kernel because the too=
l
vendors latch on to that as the cause of any problem you report and won't
talk to you until you can duplicate it on vanilla system, which, since al=
l
the files and programs are automounted becomes something of a catch-22; n=
ot
insurmountable, but a royal pain none the less.  I will be rolling forwar=
d
soon when we apply RHEL 3 Update 2.  Did I read Jeff's note correctly tha=
t
the kernel patch will be in Update 3??  That would make my summer (I know=
, I
should get out more)!


Pete Harris
Tektronix, Inc. / Central Engineering / Technical Computing
Phone:	1-503-627-3989
Fax:	1-503-627-5587


-----Original Message-----
From: raven@themaw.net [mailto:raven@themaw.net]=20
Sent: Monday, July 12, 2004 08:59
To: Jeff Moyer
Cc: Harris, Peter A; autofs mailing list
Subject: Re: [autofs] csh/cd not getting the right cwd at the mount point


<snip>

I had some trouble understanding the problem dscription but thought it=20
sounded like below.

The easiest way to demonstrate the problem that this fixes is to cd to=20
an autofs directory and attempt to touch a file. It failed, a cd away and=
=20
back sees the touch work OK. I was able to made this badness happen fairl=
y=20
easily.

<snip>
