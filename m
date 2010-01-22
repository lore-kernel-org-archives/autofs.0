From: Paul Smith <paul@mad-scientist.net>
Subject: Issues with failed bind mounts in autofs 5.0.5
Date: Fri, 22 Jan 2010 15:02:33 -0500
Message-ID: <1264190553.23526.148.camel@psmith-ubeta.netezza.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

I couldn't find any reference to how to access autofs latest source (is
it available in git or CVS or somewhere?  It would be nice if there were
some webpage, even minimal, dedicated to autofs development that was
findable, either via Google or in the README files in the source or
whatever) so I'm not sure this hasn't been fixed.


There are a number of issues I see when I try to use autofs inside an
initrd, where the mount point is on the ramdisk.  The rootfs partition
type does not support bind mounts, so automount's attempt to use them
fails.  This prints scary messages to the syslog, which is unfortunate,
but things eventually do work.  The comments below are based on an hour
or so of investigation so if I'm wrong, mea culpa!!

The way this works is that mount_bind.c:mount_init() creates temporary
directories then invokes spawn.c:spawn_mount() with --bind option.  

The first problem is we're testing bind mounts in /tmp, which I think is
not right, because whether bind mounts are supported depends on the
filesystem where the mount will happen.  Just because mount --bind works
in /tmp does not mean it will work for the actual mount point in
question.  Conversely, if bind mounts don't work in /tmp that doesn't
mean they wouldn't work in the real filesystem.

The second annoyance is that we're testing bind mounts twice: I have one
file entry in auto.master, and that file has one entry in it, but
mount_bind.c:mount_init() is called twice.  Either the previous point
should be addressed and we invoke it once for each mount point, or it
should be invoked only one time, I'd imagine.

The next problem is in spawn.c:spawn_mount() itself.  This function
invokes do_spawn() and gets a return value.  It then checks the return
value with & MTAB_NOTUPDATED (0x1000) to see if the mtab was updated.
This is tied very tightly to the Linux standard mount(8) which defines
the exit code 16 (0x10) to be "problems locking or writing the mtab
file".  But other implementations of mount may not use these exit codes:
busybox mount, for example, exits with -1 (255) if you run mount --bind
on a filesystem where it isn't supported.

Even in do_spawn() it returns -1 for various errors such as fork() or
waitpid() failing.  I think the tests in spawn.c like:

	if (ret & MTAB_NOTUPDATED) {

should at least be modified to:

	if (ret & 0xff00 != 0xff00 && ret & MTAB_NOTUPDATED) {

or possibly:

	if (ret & 0xff00 < 0x8000 && ret & MTAB_NOTUPDATED) {

Otherwise, it actually retries the bind mount 3 times (for each
invocation, or 6 times total) waiting 3s between each one if do_spawn()
is returning -1 (or mount is exiting with 255).

One last minor thing: the return code from spawn_mount() doesn't tell us
whether the mount happened or not.  If it did, we could avoid trying the
umount if the mount didn't work.  But that's a minor point (except that
this also has the same retry/timeout issues as above).


Ultimately what I'd really like is some command line or configuration
option that suppressed the bind mount check in the first place, since I
already know it won't work.


Thanks for listening!
