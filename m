From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Sat, 22 Oct 2005 18:28:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0510221821470.8952@xena.cft.ca.us>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
	<200510210907.20809.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510212347440.2069@donald.themaw.net>
	<17241.6728.530111.716756@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510221111420.2069@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510221111420.2069@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 22 Oct 2005, Ian Kent wrote:

> It appears that there is a situation in which autofs thinks the lock 
> is still held when it is not. A race (no doubt) or maybe a missing test in 
> the wait. So my feeling of wanting to eliminate the locking returns again. 
> Sorry.

Agreed that problems in mount's lock should be fixed, but my diagnosis of 
the autofs situation went like this: it acquires its lock, then it tries to 
do a nested automount, and the nested instance can't get the lock.  I 
suggested statting the referent in advance, to trigger the nested mount 
ahead of time.  Autofs might do this: if it decides (before acquiring the 
mount) that it's going to do a bind mount, then it stats the referent, 
triggering nested automount(s) if any.  Would it disrupt the logic too much 
to recognize the bind mount before getting the lock?

If we trust mount's lock, and don't do locking in autofs, I wonder if 
nested automounts would put mount into exactly the same deadlock that 
autofs is getting into now?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
