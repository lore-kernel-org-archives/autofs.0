From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: umount fails with NFS mounts
Date: Tue, 14 Sep 2004 11:47:07 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409141122080.3425@xena.cft.ca.us>
References: <Pine.LNX.4.44.0409141459270.6694-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409141459270.6694-100000@maggie.lkpg.cendio.se>
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
> We are running autofs-3.1.7-36 on RedHat 9, with kernel 2.4.20-30.9smp.  
> The mount version is 2.11y. The NFS server is Novell Netware 6.0sp3. Our
> auto.master looks like:

Can you upgrade to autofs-4.1.x?  An awful lot of development and bug fixes 
have come out since version 3, and that version is now officially retired.
Also, at UCLA-Mathnet we've been running SuSE 9.1 with kernel 2.6.5 
(uniprocessor and SMP variants) since May and we've had no problems at all 
attributable to the kernel.  Does Red Hat have a new release with the new 
kernel?

You have an interesting product (
http://www.thinlinc.com/index.phtml?action=view&page=19
http://www.cendio.com/
) and I can see the need for reliable automounter / NFS service at the 
server interconnect cluster.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
