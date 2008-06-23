From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sun, 22 Jun 2008 20:49:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806222024150.18218@xena.cft.ca.us>
References: <20080423185018.122C53C3B1@xena.cft.ca.us> 
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
	<20080619183446.532D82111B1@simba.math.ucla.edu>
	<1213934961.2971.69.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us>
	<1214017944.4975.60.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214017944.4975.60.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, 21 Jun 2008, Ian Kent wrote:

> Ooops, I didn't pay enough attention when I read the pthread barrier man
> page. That isn't actually an error return but now I'm wondering why I
> haven't seen it in my test, very odd.
> 
> Let me fix it and we'll try again.
> 
> There are other problems but I need to know if this is a viable approach
> before going further with it.
> 
> Try this instead.

OK!!!  The test program has been running for 28 hours continuously, 32 
hours total, and is still going, having done 37300 mount-unmount cycles so 
far.  There are normally 244 filesystems mounted from 125 different 
machines.

There have been no hung processes, i.e. automount either mounts the 
filesystem or returns ENOENT in response to readdir(), within 120 secs.  
There have been no omitted unmounts, i.e. every mounted filesystem (that 
was unused) was unmounted within 1800 secs (the default timeout of 300 secs 
is used).

There was one error reported.  I ran the test program, and someone powered 
off a workstation whose filesystem I had mounted.  The resulting NFS 
timeout(s) caused the program to think the test thread was hung, so it 
tried to produce a backtrace, but there was a bug and the trace was spoiled 
(you've seen these spoiled traces before in files I've sent in).  I 
improved the trace procedure and attempted to restart.  I did a forced 
umount by "kill -USR1 $PID", but automount said on syslog:

Jun 21 15:58:47 bustamove automount[2880]: master.c:957: assertion failed: 
ap->state == ST_READY

And it didn't unmount anything.  So I rebooted and started the test on a 
clean machine.  

There is a pattern of failure that may not be automount's fault.  On 
almost exactly 0.1% of the attempted mounts, the readdir eventually fails 
with ENOENT.  The test program leaves these filesystems alone for 1800 
secs, then tries again to mount and test them, which invariably succeeds. I 
don't see any pattern to the type of the machine: workstation, server, 
compute node, heavily loaded, totally idle, etc.  But if multiple 
filesystems from one machine (submount) are unmounted and remounted at the 
"same" time (0.2 secs apart), if any one fails, there is a tendency for 
several others to also fail.

So I think we're closing in on the problem.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
