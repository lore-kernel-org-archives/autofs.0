From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 24 Apr 2008 09:52:47 -0700 (PDT)
Message-ID: <20080424165247.CEF7F2111B0@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x4963u8ibhf.fsf@segfault.boston.devel.redhat.com>
	(Jeff Moyer "Wed, 23 Apr 2008 16:04:44 -0400")
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Wed, 23 Apr 2008 16:04:44 -0400 Jeff Moyer writes:
> jimc@math.ucla.edu (Jim Carter) writes:
> > This started immediately after we upgraded the server host from SuSE
> > 10.1 to SuSE 10.3; autofs version changed from 4.1.4 to 5.0.2.

> That's a big jump!

SuSE 10.1 is now 2 years old.  We try to get 18 months of use out of
each release we put into production, and it typically takes 6 months
from when the distro is issued until we get it into full production.

> > =-- auto.net ---
> > *       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=& \
> >	    file:/etc/auto.net.generic

> A ha!  Submounts!  We're currently chasing a couple of issues in this
> area.

And almost all of our automounts are in this form.  Since the hanging
mode has not [yet] been seen on workstations or shared execution servers
[update: detected this morning on Koala, our Koolu, with the least
frequent automounting of all our machines due to its role as a kiosk
:-)], I'm guessing that the rate of getting messed up is proportional to
the square of the rate of automounting; in other words, a race condition
is involved: when a filesystem expires (and is unmounted) and
simultaneously a client refers to it causing automounting, something bad
happens.

> > =------------- Output from DEFAULT_LOGGING=debug -------
> [snip]

> Jim, I'm not sure I see anything out of the ordinary in this snippet of
> the debug log.  Can you search your logs for a message that contains,
> "ask umount returned busy"?  If you see that, then we're looking at the
> same problem.  If you don't, well, we'll have to get more information
> from you.

Yes!  These are seen on both machines that I ran tests on.  They are
seen with DEFAULT_LOGGING=none -- none occurred when I had debug turned
on, though I believe that the test program was locked up and not
actually mounting anything at that time.  Each one refers to the
per-host submount, not to a NFS mounted filesystem.  They are isolated
without preceeding or following automount messages.  They are seen both
when I was running the test program, and when I wasn't.  My impression
is that the probability of having one of these messages is the same per
automount.  Here are a few, happening during the test program.

debug.1:Apr 21 20:56:14 simba automount[12865]: umount_autofs_indirect: ask umount returned busy /net/nemo01 
debug.1:Apr 21 22:18:26 simba automount[459]: umount_autofs_indirect: ask umount returned busy /net/naseberry
debug.1:Apr 21 22:20:08 simba automount[459]: umount_autofs_indirect: ask umount returned busy /net/bamboo33 
debug.1:Apr 22 22:44:19 simba automount[3059]: umount_autofs_indirect: ask umount returned busy /net/daggett

Interesting: When I rebooted one of the machines, I got one of these
messages for the /home YP map (not involving submounts) during shutdown:

Apr 20 17:51:51 serval mountd[2843]: Caught signal 15, un-registering and exitin
g.
Apr 20 17:51:51 serval sshd[3053]: Received signal 15; terminating.
Apr 20 17:51:51 serval xinetd[3050]: Exiting...
Apr 20 17:52:04 serval automount[2795]: umount_autofs_indirect: ask umount returned busy /home
Apr 20 17:52:13 serval kernel: Kernel logging (proc) stopped.
etc.

On Thu, 24 Apr 2008 11:10:53 +0800 Ian Kent writes:

> I don't know if SuSE provide debuginfo packages but the thread trace is
> useless without debug info.

> The backtrace is the most effective way to identify a few known
> problems. It's really important.

I'm at work today and I'll make this happen.  I think SuSE has debuginfo
packages in their archive, but if not I'll recompile autofs, setting the
-g switch in the spec file.  I'll also provide the URL of the source RPM
and a list of applied patches.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
