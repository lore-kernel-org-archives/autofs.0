From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: autofs not mounting directories
Date: Thu, 18 Mar 2004 09:34:17 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403180910140.7853@simba.math.ucla.edu>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
	<Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
	<Pine.LNX.4.58.0403180924490.28728@wombat.indigo.net.au>
	<Pine.LNX.4.58.0403181439100.1741@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403181439100.1741@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Michael Blandford <mlblandf@sedona.ch.intel.com>

On Thu, 18 Mar 2004, Ian Kent wrote:
> One consequence of this is that when cd'ing to a directory we will have to 
> trigger the mount. To do it any other way will mean, essentially, 
> rewriting autofs4 from the ground up....

Am I missing something here?  If your process "cd"s to a directory, you
aren't changing to the mount point, you're changing to the referent.  That
is only allowed if you have X permission, and the only way the local kernel
can know that is to first mount the referent, and subsequently stat the
mount-root.

So it doesn't bother me that "cd" triggers mounting, even though in 0.1% of
the cases the process might "cd" elsewhere immediately without looking at
any files within the mount-root.  In most cases the very next system call
will be either to list the directory content or to open a file already
known to be in that directory, using a relative path.  So the mount is
hardly ever wasted.

I wonder if "cd"ing to the mount point, then mounting something over it, 
might trigger subtle bugs.  Example: the (nonexistent) content of the mount 
point dir is cached, and when you enumerate the directory you get the 
cached nothingness rather than the content of the referent, which you 
aren't even "cd"d to.   Hmmm, does this sound familiar?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
