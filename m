From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Re: Automount/NFS issues causing executables to appear
  corrupted
Date: Tue, 20 Apr 2004 18:17:41 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0404201803380.3764@xena.cft.ca.us>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
 <40853517.71EB10A9@ssa.crane.navy.mil>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40853517.71EB10A9@ssa.crane.navy.mil>
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
To: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Cc: autofs@linux.kernel.org

Sorry to continue a non-automount issue, but this is where it was posted...

On Tue, 20 Apr 2004, Todd Denniston wrote:

> question,
> Is the file system mounted with the 'soft' option?
> i.e. on the systems that are causing problems try
> mount | grep -i soft

> We had a problem that caused me headaches for 6 months to track down...

> ...probability of an IO error during normal operations went from 0 towards
> certainty by the time the file was 650 MBytes, generally would happen by
> ~100MBytes.
>
> My server was a sun ultra 2 running solaris 2.6, the clients were Linux
> running 2.[02].X and a mix of autofs-3 and autofs-4 (which ever was installed
> with the distros, RH6-9 & Slack7-9.1).

We have Solaris 2.6, Solaris 8 (not tested), SuSE 8.2 (kernel 2.4.20) and
SuSE 9.0 (kernel 2.4.21, not tested).  I just ran some tests as follows:
Write one file of 1.3 Gb into the partner's NFS-exported filesystem.  Read
it back comparing bit-for-bit.  Delete the NFS file.  This was tried twice
with a Solaris 2.6 partner and twice with a Linux (2.4.20) partner.  The
local machine has Linux (2.4.20).  Both partners were on a different
subnet, but traffic was light and dropped UDP packets probably were very
few.  All NFS mounts were courtesy of the automounter.  All were soft,
specifically: -rsize=8192,wsize=8192,retry=1,soft.

There were no errors whatsoever.  Execution times were identical on
repeat trials (meaning no erratic network timeouts).  At Mathnet,
historically we do not see any of the described symptoms.

I wonder what's going on at your end.  If it's going to jump up and bite us
in the future...

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
