From: David <spoel@xray.bmc.uu.se>
Subject: Re: autofs not mounting from nis maps
Date: Thu, 17 Mar 2005 09:24:19 +0100
Message-ID: <1111047859.5590.37.camel@studio.bibu>
References: <1111004718.6120.16.camel@studio.bibu>
	<Pine.LNX.4.61.0503161515040.7630@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0503161515040.7630@xena.cft.ca.us>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

On Wed, 2005-03-16 at 15:31 -0800, Jim Carter wrote:
> On Wed, 16 Mar 2005, David wrote:
> > [root@appel2 proc]# ypcat -k auto.master
> > /home  auto.home
> --- snip ---
> > [root@appel2 proc]# ypcat -k auto.home | head -8
> > magnusa  hirst:/homes/hirst/dsk1/&
> 
> We do almost exactly the same thing, except our auto.home map includes the
> full path name, i.e.
> 	prob-mp sonia:/h1/guest/prob-mp
> rather than using the &.  But I'm sure this is not your problem.  I 
> explicitly specify the map type in /etc/auto.master, i.e. 
> 	/home           yp:auto.home
> but again, I doubt that has anything to do with your problem.

Neither of these helped, and indeed nothing I found on the net seemed to
have any impact.

> 
> We're using autofs-4.1.3; what version are you using?  
4.1.2 and 4.1.3 depending on Fedora installation.

> 
> Since automounting works perfectly if it's a file map, I'm inclined to 
> blame YP and not look at either NFS mounting or autofs.  (Do log files 
> suggest that I'm wrong here?)
Log files say hardly anything, even when automaount is started with -v
and or -d.

My guess is that autofs misinterprets the YP maps in some way. Could it
be something with spaces versus tabs in the map files?


> 
> Is it always the same users whose homedirs fail to mount?  Or will Mangusa 
> mount one day and not the next?  Do all the workstations behave equally?  I 
> assume both servers have some failing users.  Does the failure rate vary 
> with the time of day or with obvious system activities like backups?  I 
> know that our YP wierds out at 2 AM when the backups kick off, because the 
> network is overloaded.

No it's consistently the same failure and also for different autofs
versions. The auto.home map contains little over 100 entries with 10

> 
> YP relies on UDP.  If there were network problems that ate YP packets 
> intermittently, it would explain the problem.  If a workstation pings the 
> YP server host (at a time of day when automount failures are seen), what's 
> the packet loss rate?  Is there any other reason to suspect flakiness in 
> the YP server and/or client?  Suppose you do "ypmatch $user auto.home", 
> iterating over and over through all your users, do you see any failures?
> (We don't, except during backups.)
The following simple script showed me that 57 out of 105 entries in the
auto.home file actually are not matched, indicating that this is indeed
a YP problem. Are there some cached YP files somewhere? Restarting yp
did not help.

#!/bin/csh -f

foreach user ( `ypcat -k auto.home | awk '{ print $1 }'` )
  ypmatch -k $user auto.home
end


-- 
David.
________________________________________________________________________
David van der Spoel, PhD, Assoc. Prof., Molecular Biophysics group,
Dept. of Cell and Molecular Biology, Uppsala University.
Husargatan 3, Box 596,          75124 Uppsala, Sweden
phone:  46 18 471 4205          fax: 46 18 511 755
spoel@xray.bmc.uu.se    spoel@gromacs.org   http://xray.bmc.uu.se/~spoel
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
