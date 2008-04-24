From: Ian Kent <raven@themaw.net>
Subject: Re: (no subject)
Date: Thu, 24 Apr 2008 11:10:53 +0800
Message-ID: <1209006653.3250.5.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<x4963u8ibhf.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x4963u8ibhf.fsf@segfault.boston.devel.redhat.com>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Wed, 2008-04-23 at 16:04 -0400, Jeff Moyer wrote:
> jimc@math.ucla.edu (Jim Carter) writes:
> 
> > Our two webservers serve UserDirs that are automounted (NFS) from other
> > hosts.  Every few days we discover a catatonic webserver (Apache2) with
> > $ServerLimit child processes (150 of them), and many but not all home
> > directories cannot be accessed manually (ls -d ~$user, which hangs).
> > This started immediately after we upgraded the server host from SuSE
> > 10.1 to SuSE 10.3; autofs version changed from 4.1.4 to 5.0.2.
> 
> That's a big jump!
> 
> > I was hoping to include debug output from autofs, but when I set
> > DEFAULT_LOGGING=debug and started the test program it totally locked up
> > the machine and I haven't been able to get on it since (because I'm
> > working from home).  Update: a co-worker rebooted it for me and I was
> > able to clear the debug switch and recover the syslog output (attached).
> > But evidently the test program also seized up; I don't see a lot of
> > actual mounting going on.  Anyway I've included it, for what it's worth.
> 
> That's strange.  Given the number of mounts you're talking about,
> though, it may just be that you overcommitted the boxes memory.  It will
> be hard to say without further digging.
> 
> > I was hoping to include useful strace output, and I have 80 Mbytes of
> > turgid information (on a different machine), but I have a feeling that
> > it's going to be more useful to include the test program and let 
> > someone overload their own testbed system.  Here's my impression of the
> > traces:  
> 
> Or, you could just give us a backtrace of the automount process when
> things go pear-shaped.  See below.
> 
> > /bin/mount used to have notorious problems locking /etc/mtab.  But I
> > compare /etc/mtab with /proc/mounts before forking the directory access
> > process, and it was the same on several thousand comparisons with only
> > two unequal comparisons; in both cases the filesystem about to be
> > accessed (remounted) was in mtab and not /proc/mounts, and at most 8
> > seconds later it was in both and the content had been read.  2 minutes
> > after the second such event, and 38 minutes into the test run, client
> > processes started to hang.
> 
> This is less of a problem these days, due to the fact that we've fixed
> the bugs we've found in util-linux and the fact that we don't use mtab
> anymore.  ;)

v5 still does, but much less so than previously.

> 
> >
> > Here are the particulars of our autofs setup.
> >
> > Distro:		OpenSuSE 10.3
> > Kernel:		2.6.22.17 (kernel-default-2.6.22.17-0.1)
> > Autofs:		5.0.2-30.2 (recompiled with the DNS timeout mitigation 
> > 		patch that Ian Kent made for us) (and identical behavior 
> > 		without the patch)
> > Mount program:	util-linux-2.12r+2.13rc2+git20070725-24.2 (/bin/mount)
> > NFS:		nfs-client-1.1.0-8 (/sbin/mount.nfs)
> >
> > =-- auto.master --- (comments omitted in all conf files)
> > /net            /etc/auto.net		<== giving trouble
> > /home           yp:auto.home
> >
> > =-- auto.net ---
> > *       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=&    file:/etc/auto.net.generic
> 
> A ha!  Submounts!  We're currently chasing a couple of issues in this
> area.
> 
> > =------------- Output from DEFAULT_LOGGING=debug -------
> [snip]
> 
> Jim, I'm not sure I see anything out of the ordinary in this snippet of
> the debug log.  Can you search your logs for a message that contains,
> "ask umount returned busy"?  If you see that, then we're looking at the
> same problem.  If you don't, well, we'll have to get more information
> from you.

Also, we don't know what patches have been included in the SuSE release.
Any chance of providing a source rpm?

> 
> For starters, can you install the autofs debuginfo package and attach to
> the running automounter (when in a bad state) and get the output from:
> 
> gdb> thr a a bt
> 
> ?  That would be a great help.

I don't know if SuSE provide debuginfo packages but the thread trace is
useless without debug info.

The backtrace is the most effective way to identify a few known
problems. It's really important.

Ian
