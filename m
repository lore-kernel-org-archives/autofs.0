From: Jim Carter <jimc@math.ucla.edu>
Subject: submount vs automount
Date: Fri, 25 Jun 2004 10:03:14 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

SuSE 9.1 includes a thing called submount (subfs.ko, /sbin/submountd) which
looks to me to be very similar to autofs.  It may or may not also be in
Gentoo.  They use it to control removeable media, i.e. CD or floppy.  
Here's the Sourceforge project page:

http://sourceforge.net/projects/submount/

(Hiss, boo: SuSE forgot to include the source in their hacked kernel, so if
you recompile the kernel yourself, the default subfs mounts stop working.  
Get the source from Sourceforge if you're in that situation.)

As far as I can see, the differences between autofs and subfs are:

A.  submountd is spawned by the kernel module when someone accesses a subfs 
directory.  It then mounts the media.  It doesn't start at boot time and 
persist.

B.  The program is designed to unmount very fast -- I'd say it polls once a
second.  This makes it act like Windoze.  (No flame wars, please, about
whether this is good or bad.)  The timeout can be set differently for
different filesystems.  Automount has the same timeout for all filesystems.

C.  There is the option to use a different program to do the mount.  A NFS 
mounter is provided, although the docs say that "autofs is, and will 
continue to be, the preferred solution for complex NFS installations".

D.  There is an option to mount the filesystem (floppy or CD) with the
UID-GID of the originally requesting user.  With automount, the UID or GID
option can be passed to mount, if the UID is known when the system is
configured, or if all relevant users are in the group (and it has write
permission).

It would seem to me that the main differences between submount and
automount are in per-filesystem options which are relatively easy to
implement, but which are essential for the role submount is designed to
fill.  Personally, I would rather have only one automounter to manage and I
don't think submount is the preferred one.

On the issue of the alternative mount script: I've been thinking of a
crypto thingy which is mounted on demand (by automount), but it would have
to pop a dialog box to get the passphrase for the crypto filesystem.  So
here's a case needing an arbitrary script to mount the filesystem.  It
would also need a "never unmount" option, e.g. timeout=0.  The idea is that
when you suspend a laptop, the suspend script explicitly unmounts the
crypto filesystem.  Now the enemy agent steals the laptop.  (It's much
harder to steal the thing when it's on James Bond's lap and he's typing on
it.)  Oooo, lots of hot unencrypted secret keys!  But when he tries to read
them, he's asked for the passphrase, which he doesn't have.

It sounds like I'm proposing a few more mount options that the autmount
daemon is going to have to identify and remove.  To avoid name collisions
we ought to have a distinctive format for automount options.  One idea:  
they all begin with upper case A.  Another idea: A=timeout=0, i.e. a single
"A" is the name of the (only) automount option, but the "value" is
potentially a key=value pair.

Here's a spiffy redesign: when the user hits the eject button on the CD, 
autofs.ko is aware of it (probably the hardest part) and signals the daemon 
to unmount if possible.  If that could be made to work, it would eliminate 
the stupid Windoze-style polling.  But floppies work differently.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
