From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: umount fails with NFS mounts
Date: Tue, 14 Sep 2004 13:04:27 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409141253181.3425@xena.cft.ca.us>
References: <Pine.LNX.4.44.0409142055270.2455-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409142055270.2455-100000@maggie.lkpg.cendio.se>
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
To: Peter Astrand <peter@cendio.se>
Cc: autofs@linux.kernel.org

On Tue, 14 Sep 2004, Peter Astrand wrote:
> > Can you upgrade to autofs-4.1.x?  
> 
> Perhaps. Can I expect it to work good on a standard RH9 kernel?

I have no experience on that -- but I think it's likely to work, i.e. no 
nasty kernel dependencies.  Others on the list may have other opinions.

> > attributable to the kernel.  Does Red Hat have a new release with the
> > new kernel?
> 
> Fedora Core contains autofs-4, but I haven't seen such packages for RH9. 

There's a significant bugfix between 4.0 and 4.1; be sure you install 
4.1.x.  

Since yours is a commercial company, possibly Red Hat Enterprise Linux is 
the way to go (or a different distro).  

> Thanks. Now if only Netware NFS could be little more stable... :)

We've had excellent reliability over about 1.5 years with the Linux kernel 
NFS server (kernel 2.4.20, 2.4.21, 2.6.4, 2.6.5).  The only oddity is that 
the NFS client now tries TCP transport first (good) and complains to 
syslog if the server declines TCP (annoying, ignore it or upgrade the 
server to kernel 2.6.x).  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
