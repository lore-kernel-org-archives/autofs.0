From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: autofs5: multiple entries with wildcards
Date: Thu, 15 Mar 2007 09:39:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703150909200.24470@simba.math.ucla.edu>
References: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
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
To: Sascha Frey <sfrey@acs-software.de>
Cc: autofs@linux.kernel.org

On Wed, 14 Mar 2007, Sascha Frey wrote:

> auto.master:
> /homes		/etc/auto.homes
> 
> auto.homes:
> * -fstype=nfs,rw        homeserver1:/home/&
> * -fstype=nfs,rw        homeserver2:/home/&
> 
> The directories on the first server are mounted. 
> But if I try to access a home which is on the second one I get a 'No
> such file or directory' error.

That's not a bug, that's a feature :-)  If you were to access /homes/jimc 
then autofs would go through /etc/auto.homes until it found a match to the 
wildcard (in the first line), mount homeserver1:/home/jimc, and its job is 
done; it has no reason to look at subsequent lines.  

Several people have suggested using hot failover syntax, so if the mount 
fails it could try additional servers (on the same line).  But that's a 
kludge, not what hot failover is for -- it's intended for when several 
servers have identical data, so (e.g.) the department's favorite software 
package remains available even if its primary residence site goes down.

Here at UCLA-Mathnet we handle the issue actually in two parallel ways: 
first, a user's official homedir would be /net/$hostname/$filesys/$loginID, 
e.g. /net/julia/h1/jimc, and a generic map causes julia:/h1 to be mounted 
on /net/julia/h1.  This has the advantage of requiring one mount per 
filesystem, not one mount per user, so we've never hit the limit on the 
number of mounted filesystems.

On the other hand, the "home" NIS map would have a key of the loginID and a 
value of for example julia:/h1/jimc, and the automounter would mount the 
correct subdirectory of the correct host on /home/jimc (at a cost of one 
mount per user).  We provide this for autonomous scripts where $HOME may 
not have a useable value and where it may be hard to resolve ~$USER, e.g. 
/bin/sh scripts on Solaris.

Conclusion: one way or another, you need to list the server and the 
filesystem explicitly in the NIS or LDAP map that defines the user's home 
directory.

FYI, here are our /etc/auto.* files:

auto.master:
/net            /etc/auto.net.new
/home           yp:auto.home

auto.net.new (all on 1 line):
*       -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs,-DSERVER=& \
    file:/etc/auto.net.generic

auto.net.generic:
*       ${SERVER}:/&


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
