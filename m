From: Jim Carter <jimc@math.ucla.edu>
Subject: RE: csh/cd not getting the right cwd at the mount point
Date: Mon, 12 Jul 2004 21:34:59 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407122058410.3238@xena.cft.ca.us>
References: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
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
To: peter.a.harris@exgate.tek.com
Cc: autofs@linux.kernel.org, raven@themaw.net

On Mon, 12 Jul 2004 peter.a.harris@exgate.tek.com wrote:

> If I cd from directory to directory using a relative path for the argument
> to cd, AND one of the cd's causes an automount to happen, AND I am running
> (t)cshell, then once I have entered a subdirectory of the mount point pwd is
> incorrect in that it is missing the mount point directory - 

Light illuminates a dark recess of my brain...  Back in SunOS-4.x we had 
issues with Sun's automounter, whereby when you do "cd /x/y/z" in Bourne 
shell, PWD=/x/y/z, but C-shell would actually do "pwd".  The consequences 
were nasty if an automounted server had died (and we made it worse by 
arranging the mounts stupidly, but that's another story) because to do 
"pwd" it would do this algorithm:

Having done the "cd" system call, it's in /x/y/z.  Find its inode number.
Open /x/y/z/.. by name (with the O_DIRECTORY flag on Linux).  Read entries;
for each one...  You would like to believe that you could just look for the
inode number in the directory entry, but suppose it's a mount point?  You
have to actually stat /x/y/item1, /x/y/item2... by name until you hit the
one, "z", that matches your target inode number.  Possibly there's an
optimization to read through the directory once, but if no match is found,
to do the stat thing, but the interesting cases need stat.

So symbolic links get purged, confusing the users because the old
automounter generated fake symlinks.  But worse, half the time you're going
to stat the filesystem mounted from the dead server, and suffer a 30 second
timeout, and there were 3 or 4 cd's and pwd's in our default login scripts,
which was the minimum we could manage.

Now here's what I'm thinking: with Linux autofs the inode returned by stat
isn't quite right, or changes at just the wrong time, or something like
that.  If the pwd algorithm can't find the target, the behavior is
implementation defined, and a very likely behavior is to skip that
directory component with no error message.  I know that the pwd command is
implemented internally in csh and tcsh -- it just prints $pwd -- and I
wouldn't be surprised if the shell does the research with its own code
rather than forking /bin/pwd.

So that's a possible explanation of why (t)csh shows the behavior and
(ba)sh doesn't.  Hope this helps.

I wonder what would break if autofs were super-smart and returned the inode 
number of what was on the mount point, as long as it was still mounted.  It 
would save a bunch of otherwise wasted NFS traffic and would avoid the kind
of hangs that troubled us (and still trouble us) when a server goes down.  
But lying about inode numbers probably has baleful consequences in some 
bizarre circumstance.  Like keeping use counts up to date.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
