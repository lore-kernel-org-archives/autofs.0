From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: submount vs automount
Date: Fri, 25 Jun 2004 14:31:32 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40DC6F84.5020701@sun.com>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
 <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
 <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jim Carter wrote:
> SuSE 9.1 includes a thing called submount (subfs.ko, /sbin/submountd)
which
> looks to me to be very similar to autofs.  It may or may not also be in
> Gentoo.  They use it to control removeable media, i.e. CD or floppy.
> Here's the Sourceforge project page:
>
> http://sourceforge.net/projects/submount/
>
> (Hiss, boo: SuSE forgot to include the source in their hacked kernel,
so if
> you recompile the kernel yourself, the default subfs mounts stop
working.
> Get the source from Sourceforge if you're in that situation.)
>

IIRC, SuSE has this module as an external rpm: km_submount.  You'd have
to rebuild that rpm.

> As far as I can see, the differences between autofs and subfs are:
>
> A.  submountd is spawned by the kernel module when someone accesses a
subfs
> directory.  It then mounts the media.  It doesn't start at boot time and
> persist.
>
> B.  The program is designed to unmount very fast -- I'd say it polls
once a
> second.  This makes it act like Windoze.  (No flame wars, please, about
> whether this is good or bad.)  The timeout can be set differently for
> different filesystems.  Automount has the same timeout for all
filesystems.
>
> C.  There is the option to use a different program to do the mount.  A
NFS
> mounter is provided, although the docs say that "autofs is, and will
> continue to be, the preferred solution for complex NFS installations".
>
> D.  There is an option to mount the filesystem (floppy or CD) with the
> UID-GID of the originally requesting user.  With automount, the UID or GID
> option can be passed to mount, if the UID is known when the system is
> configured, or if all relevant users are in the group (and it has write
> permission).

This is just semantically racy.  If someone ssh'es into you laptop and
accesses the mount before you do, you can't access it.  A better
approach IMHO is to mount with the UID of the user on :0, unmounting it
on logout if possible. Thoughts?

>
> It would seem to me that the main differences between submount and
> automount are in per-filesystem options which are relatively easy to
> implement, but which are essential for the role submount is designed to
> fill.  Personally, I would rather have only one automounter to manage
and I
> don't think submount is the preferred one.
>
> On the issue of the alternative mount script: I've been thinking of a
> crypto thingy which is mounted on demand (by automount), but it would have
> to pop a dialog box to get the passphrase for the crypto filesystem.  So
> here's a case needing an arbitrary script to mount the filesystem.

Sure,  I'd like to see this eventually as fstype=other, with the real
fstype handled by the script/program that mounts it.  Make it
configurable by saying fstype=other:/path/to/mounter.

It
> would also need a "never unmount" option, e.g. timeout=0.

We would first have to allow per-mount timeouts..

The idea is that
> when you suspend a laptop, the suspend script explicitly unmounts the
> crypto filesystem.

How is this possible?  When you suspend, you'll still have open files to
the file system.


Now the enemy agent steals the laptop.  (It's much
> harder to steal the thing when it's on James Bond's lap and he's typing on
> it.)  Oooo, lots of hot unencrypted secret keys!  But when he tries to
read
> them, he's asked for the passphrase, which he doesn't have.

A better approach would have the loop backed device (I'm assuming you
are using this for the crypto) flush the keys, and have *it* ask you to
refresh them.  It will however have to remember who to ask :)

Another problem with this is that you can end up easily deadlocking your
machine.  For example, consider the situation where your home directory
is encrypted (being the mount with the most security critical data).

If the 'dialog' uses any communication channel in the homedir (unix
socket?), then it will deadlock the machine.  The alternative is to
force all communication channels into something like /tmp (which itself
is probably the second most important fs you'd want to encrypt).  So
you'd have to be extremely careful and put it in something like
/var/run/crypto/sockets and ensure that it never gets encrypted.

But even in this case, all your desktop processes would probably be
uninterruptble while you are being queried for passcodes.  So you could
deadlock cause your window manager can't display the prompt.

Sounds pessimistic, I know, but this leads to the conclusion that you
should encrypt your entire homedir.. :\

>
> It sounds like I'm proposing a few more mount options that the autmount
> daemon is going to have to identify and remove.  To avoid name collisions
> we ought to have a distinctive format for automount options.  One idea:
> they all begin with upper case A.  Another idea: A=timeout=0, i.e. a
single
> "A" is the name of the (only) automount option, but the "value" is
> potentially a key=value pair.

This is deviating even more from the options understood by other unices'
automounters.  Please don't.

>
> Here's a spiffy redesign: when the user hits the eject button on the CD,
> autofs.ko is aware of it (probably the hardest part) and signals the
daemon
> to unmount if possible.  If that could be made to work, it would
eliminate
> the stupid Windoze-style polling.  But floppies work differently.
>

This won't work and has been discussed at length before on
linux-hotplug-devel.  A lot of removeable medias don't have any way for
the system to know you are ejecting them.  A good example is CF media.
It was determined that polling was the only way to have this work.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3G+DdQs4kOxk3/MRAv8GAJ4yC2MybmIwCYLy77rJrDZ6lqK9QACcCgpY
A4JFk9XixG2lNeDX6zuyl/k=
=C7uC
-----END PGP SIGNATURE-----
