From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: autofs not unmounting mount points?
Date: Fri, 12 Mar 2004 09:52:44 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403120937370.1177@simba.math.ucla.edu>
References: <4051DB39.4060905@astro.wisc.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4051DB39.4060905@astro.wisc.edu>
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
To: jansen <jansen@astro.wisc.edu>
Cc: autofs@linux.kernel.org

On Fri, 12 Mar 2004, jansen wrote:

> I've been struggling to figure out why autofs does not appear
> to unmount many mount points...  

I also had this problem with autofs4-4.0.0pre10-504 from SuSE 8.2/9.0.
I upgraded to the latest version (4.1.0 when I upgraded; now I think it's 
4.1.2), and not only are filesystems unmounted as expected, but other 
alarming symptoms in the logs are gone.  

As for /net/home (this is the map you were complaining about, right?),
possibly Nautilus has a compulsion to check for something at the top level
of every mounted filesystem.  If /net/home were "browsable", i.e. if you do
"ls /net/home" and get all 150 loginIDs, likely it would proceed to stat
those names (e.g. /net/home/jimc), requiring that they be actually mounted.  
It doesn't have to stat them just to see the names, but if it wants to know
if they are directories, or if they are owned by you, then it needs to do
the stat, and therefore the mount.

See if you can forbid browsability on the "home" map.  To turn it on, I
believe the correct syntax is to put "--ghost" (or -g?  Or just "ghost"?)
among the mount options in /etc/auto.master, so that command line arg will
be passed to the submount.  (Someone please correct this if wrong.)  So you
would be looking for that option and removing it.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
