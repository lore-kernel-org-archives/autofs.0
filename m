From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Thu, 8 Apr 2004 10:31:16 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404081009540.546@simba.math.ucla.edu>
References: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
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
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Wed, 7 Apr 2004, Raymond Prach wrote:
> We have a script that accesses resources all over the network. To this 
> end, it mounts, via autofs, a large number of remote filesystems. Whenever 
> this script is run, the following alarming message appears in the system 
> log:
> 
> kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have 
> a nice day...

No big sweat, any I.T. professional knows to just blow off all error 
messages :-)

This happens with autofs4-4.0.0pre10 from SuSE 8.2 and 9.0.  That's with 
module version... um, well, whatever SuSE is giving us.  expire.c says
 *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
 *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
This is definitely not the version of December 2003; I didn't install it.

When I installed the autofs-4.1.2 daemon, the message stopped appearing. 
This is with the same module, so the finger of blame points to userspace.
On 4.0.0pre10, the message appears whenever you shut down autofs, as well 
as on some (but not all?) automatic dismounts, which were not happening 
reliably (but dismounting does happen with 4.1.2).  I'm pretty sure that 
4.1.0 also avoided the "self destruct" messages entirely, and I know it 
fixed the dismount problems.

v4.1.2 seems happy with the back-version module.  However, being unable to
do "ghost mounts", it (seems to) mount every exported filesystem from the
target host (and they expire normally if unused).  That could be a problem
if many filesystems are exported.  4.1.0 would complain and bypass the
ghost mounts.  My preference would be for it to not complain and to mount
only the requested filesystem.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
