From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: autofs not mounting from nis maps
Date: Wed, 16 Mar 2005 15:31:21 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0503161515040.7630@xena.cft.ca.us>
References: <1111004718.6120.16.camel@studio.bibu>
Mime-Version: 1.0
In-Reply-To: <1111004718.6120.16.camel@studio.bibu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David <spoel@xray.bmc.uu.se>
Cc: autofs@linux.kernel.org

On Wed, 16 Mar 2005, David wrote:
> [root@appel2 proc]# ypcat -k auto.master
> /home  auto.home
--- snip ---
> [root@appel2 proc]# ypcat -k auto.home | head -8
> magnusa  hirst:/homes/hirst/dsk1/&

We do almost exactly the same thing, except our auto.home map includes the
full path name, i.e.
	prob-mp sonia:/h1/guest/prob-mp
rather than using the &.  But I'm sure this is not your problem.  I 
explicitly specify the map type in /etc/auto.master, i.e. 
	/home           yp:auto.home
but again, I doubt that has anything to do with your problem.

We're using autofs-4.1.3; what version are you using?  

Since automounting works perfectly if it's a file map, I'm inclined to 
blame YP and not look at either NFS mounting or autofs.  (Do log files 
suggest that I'm wrong here?)

Is it always the same users whose homedirs fail to mount?  Or will Mangusa 
mount one day and not the next?  Do all the workstations behave equally?  I 
assume both servers have some failing users.  Does the failure rate vary 
with the time of day or with obvious system activities like backups?  I 
know that our YP wierds out at 2 AM when the backups kick off, because the 
network is overloaded.

YP relies on UDP.  If there were network problems that ate YP packets 
intermittently, it would explain the problem.  If a workstation pings the 
YP server host (at a time of day when automount failures are seen), what's 
the packet loss rate?  Is there any other reason to suspect flakiness in 
the YP server and/or client?  Suppose you do "ypmatch $user auto.home", 
iterating over and over through all your users, do you see any failures?
(We don't, except during backups.)

Good luck; I hope this helps.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
