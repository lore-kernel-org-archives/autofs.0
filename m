From: peter.a.harris@exgate.tek.com
Subject: RE: unacceptable bug in autofs kernel module
Date: Fri, 4 Feb 2005 10:58:17 -0800
Message-ID: <C147DE5CF1A13D42B560879D6D212E63D0948E@us-bv-m21.global.tektronix.net>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: mmarion@qualcomm.com

Hello, all,

Funny you should mention - I was just getting ready to ask about this.

We are doing the same thing, i.e. submitting jobs via LSF.  What we see are
file not found errors when trying to access a file somewhere down in the
tree of an automounted file system.  For instance, a job will execute a Perl
script that starts with "#!/tools/perl5.8.3/bin/perl", which fails because
it cannot find the Perl executable.  I log into the machine and do "ls
/tools/perl5.8.3/bin/perl" and get a file not found.  I check /etc/mnttab or
/proc/mounts and /tools/perl5.8.3 is not mounted.  So then I do an ls of
/tools/perl5.8.3 and the mount is made.  Once I do that, the mount point is
generally well behaved for some random period of time when we will go
through all this again.

At first we thought it was networking problems because we were also seeing
some "server not responding" errors on our Solaris boxes.  We found that if
the mount failed with an RPC timeout, then the automounter would not try
again until you did an ls of the mount point directory (or in some cases,
you would have to cd to the directory to get the mount to happen).  We have
fixed some networking problems that we found and the number of these kinds
of error messages has gone way down.  Now we only see them when the 10 boxes
all run a cron job at 10PM and try to mount the same file system at the same
time.  Some win but most lose.

Testing (60 second expiry, multiple jobs accessing files every 2 to 3
minutes; caused lots of expirations and remounts) showed that we could also
lose track of a mount if the mount expired and then immediately remounted.
Well, it would not remount but the automounter thought it had.  Similarly to
the above, and ls or cd would fix the problem.

Occasionally, the automounter fails to mount without any indication that I
can find in /var/log/messages.  And, again, an ls or cd of the directory
will cause the mount to happen.

Most of the machines are running Red Hat EL 3 U4 (automount 4.1.3-47,
2.4.21-27.0.1ELhugemem/smp kernel).  One is running 4.1.3-12.  A couple are
running RHEL 3 U0, 2.4.21-4EL kernel, 4.1.0-2 automouunt.  We have several
IBM blades with P4's and mostly 4GB of memory.  We also have one HP DL585
running AMD64 with 16GB of memory.  Most run with a 10 minute expiry, but
one is set to 30 minutes and one to 1 hour.  That does not seem to affect
the error rate.  Some are running soft mounts to the tools (which should be
read only) and some are running hard mounts - this too does not seem to make
a difference.

And, oh yes, these mounts are all from NetApp Filers.

Anybody else see this and/or have any ideas?


Pete Harris
Tektronix, Inc.
Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Phone:	1-503-627-3989
Fax:	1-503-627-5587
----------------------------------------------------------------------
--          Any opinions expressed are those of the author          --
--             and may not be those of Tektronix, Inc.              --

=-----Original Message-----
=From: autofs-bounces@linux.kernel.org [mailto:autofs-
=bounces@linux.kernel.org] On Behalf Of mmarion@qualcomm.com
=Sent: Thursday, February 03, 2005 4:39 PM
=To: ramana@intraperson.com
=Cc: autofs@linux.kernel.org
=Subject: Re: [autofs] unacceptable bug in autofs kernel module
=
=On 28 Dec, ramana wrote:
=
=> Here is the bug in autofs3 module which causing so much pain. It simply
=> stopped me from adding much more interesting features to Autodir
=> http://www.intraperson.com/autodir/
=[snip]
=> Because of this, user space test program reporting like this:
=>
=> fail : /test/t944 : No such file or directory
=> fail : /test/t4187 : No such file or directory
=
=Hmm.. I wonder if this might be related to a weirdness we're seeing.
=Running
=autofs-4.1.3 with previous latest patch to kernel (pre-2005 release) and
=users
=use LSF to submit batch jobs to hosts.  On linux hosts, user level
=programs
=will sometimes exit quickly with a "file does not exist" error, even
=though you
=can login to the host and see the file/dir just fine.  As a hacked
=work-around, we have a pre-exec script that tries to stat all the
=directories
=they need to force the mounts to happen before their program touches the
=files.
=
=I didn't see any attempts to patch this bit.. did you have any ideas on
=how to
=patch that particular piece of code?   Or just comment it out?
=
=--
=Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
=Groundskeeper Willie: "oooh.. Me mule wouldn't walk in the mud.  So I had
=to
=put 17 bullets in 'em." ==> Simpsons
=
=_______________________________________________
=autofs mailing list
=autofs@linux.kernel.org
=http://linux.kernel.org/mailman/listinfo/autofs
