From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Mounts not happening for "remote" processes
Date: Thu, 13 Apr 2006 15:36:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0604131511070.6043@simba.math.ucla.edu>
References: <20060413013629.GH19971@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060413013629.GH19971@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Wed, 12 Apr 2006, Mike Marion wrote:

> One of the last problems we're having with autofs4 is the fact that we
> see a lot of cases where a "remote" job can't see files in nfs.  
...snip...
> programs they run will stat a file looking for it's input, or binary, or
> whatever, then it's like the mount doesn't happen, or isn't atomic
> enough, and the program will fail.  If we immediately log into the host
> and do something like ls the same file.. it works fine.

From the log file you showed, it looks like autofs tried to do the right
thing, but NFS mounting was attempted and failed, after a 20 second 
timeout.  So that's the tree I'm barking up.  

A.  At night when we do backups, we overload our network (despite various 
off-topic mitigation strategies), and we regularly get autofs/NFS mount 
failures similar to what you describe.  I'd estimate that the probability 
of a mount failing, during stormy network conditions, is 0.5% to 1%.  Maybe 
less.  It's time for some more mitigation $trategies.

B.  Most machines are using a not-too-ancient distro release (SuSE 9.2, 
same as yours), and NFS transport is by TCP by default.  But some have not 
yet been upgraded, and are using the traditional UDP.  I have the 
impression that those are a lot more likely to have a mount failure.  With 
UDP the only way to detect a trashed packet is by a timeout, typically 30 
secs unless you've reduced it, whereas with TCP the timeouts are much 
shorter and auditing is more strict so a trashed packet is often recognized 
without a timeout.

Not to say that your problem is surely the same as ours, but it would be 
worth looking into these two issues.  We're using autofs-4.1.3 and 
kernel-smp-2.6.8-24.20 -- wasn't 2.6.5 used in SuSE 9.1 rather than 9.2? 
Anyway, your and our setup are very similar, and we have very reliable 
performance (except sometimes) from autofs/NFS in the same general usage 
style as yours, i.e. "power users" execute on their workstations with 
homedirs on servers, and a Load Sharing Facility (Sun Grid Engine) without 
the user actually logging into the compute node.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
