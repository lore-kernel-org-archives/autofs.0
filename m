From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Wed, 18 Jun 2008 17:40:47 -0700 (PDT)
Message-ID: <20080619004048.05EC42111B0@simba.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1213414942.18072.26.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213414942.18072.26.camel@raven.themaw.net>
	(Ian Kent "Sat, 14 Jun 2008 11:42:22 +0800")
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

The edited patch set went on with no problems and compiled cleanly; the
module works normally.  

I rebuilt the daemon with these patches: 
autofs-5.0.2-dns-name-lookup.patch
autofs-5.0.3-dont-fail-on-empty-master-fix-2.patch
autofs-5.0.3-mount-thread-create-cond-handling.patch
autofs-5.0.3-mount-thread-create-cond-handling-fix.patch
autofs-5.0.3-dont-abuse-ap-ghost-field.patch
autofs-5.0.3-submount-shutdown-recovery-7.patch

At first I thought it was still failing as before, but on looking more
closely at the output I see a new behavior which is much better than 
failing.  After 35 minutes and about 1200 mount/unmount cycles, it took
over 25 seconds to mount (and readdir) 12 filesystems distributed over
6 machines.  2 minutes later these all had been mounted, and 4 
filesystems on 2 other machines were stuck.  7 minutes later these were
finished and 5 filesystems on one machine were stuck.  This continued
(12 groups total) until I stopped the test 30 mins later.  Syslog (debug
priority) had not a single line from autofs or NFS for the entire 
period.

I think I need to adjust my test program to accomodate this new behavior. 
I'll report back when that's done.  If you want to see 0.5 Mbyte of 
backtraces from the above test, let me know.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
