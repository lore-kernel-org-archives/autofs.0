From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: softlink creation on startup
Date: Thu, 20 Jan 2005 15:29:28 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0501201504290.8094@xena.cft.ca.us>
References: <B845DD7107659345A6436D4BCF0BDF130AB97BA8@xcgil006.northgrum.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <B845DD7107659345A6436D4BCF0BDF130AB97BA8@xcgil006.northgrum.com>
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
To: "Dege, Robert C." <robert.dege@ngc.com>
Cc: autofs@linux.kernel.org

On Thu, 20 Jan 2005, Dege, Robert C. wrote:

> I'm trying to integrate a linux box into a TRU64 UNIX network, and am 
> seeking some insight with automounting.  Our TRU64 network uses NIS to 
> propagate data among our client systems.  The systems have been 
> configured to use the NIS auto.master map to establish automount links.

I've never dealt with TRU64, but it looks like they use a quite different
philosophy than we do, coming from a Sun-Solaris background.  To answer 
your question, I don't see a native way to make the desired symlinks 
appear, but you can do pretty arbitrary things with a programmatic map. 
I've attached UCLA-Mathnet's programmatic host map as an example that you
might modify to both make the links happen and manage the autofs 
subprocesses.

If your requirement is to imitate closely the TRU64 paradigm then the 
following advice is useless, but...  I don't like a lot of random stuff in 
my root directory.  Much better I like the Solaris-style structure: 
/net/$host/$mountpoint, with an indirect map for the host, not a direct map 
as apparently you use in TRU64.  With the attached map file, any machine 
can mount any exported filesystem from any other machine, not needing any 
per machine configuration of automount files, and no NIS table listing each 
exported filesystem.  (Access is controlled by the exporter, not through 
automount visibility.)  The only limitation is that the exported 
filesystems have to be in a consistent directory across machines, which for 
us is the root directory, e.g. /home1, /home2, ...

Sun implements a map like this intrinsically, calling it the "hosts" map 
type.  If any reader notices that I've missed a feature, so that the 
programmatically generated indirect map file could be replaced by a single 
generic file with a substitutable argument, or something like that, I would 
very much appreciate a heads-up, which would let me replace this kludge, 
with something really elegant.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


#!/bin/sh
# Equivalent of the "hosts" map on Sun's automounter.
# Copyright (c) 2001 by The Regents of the University of California
# Author: Jim Carter, UCLA-Mathnet <jimc@math.ucla.edu>, 2001-08-23

# This is an executable map file, mounted on /net.  When the automounter sees 
# /net/$host/restof/path, it runs this script with $1 = hostname ($host).
# This program creates a generic file map in /rete/$host, then emits a map 
# line which induces the caller to spawn a separate automount process to
# serve that map (which will presumably be able to mount the filesystem
# titled "restof" in this example). 

# Specify -d for debug mode.
if [ X$1 != X-d ] ; then
	# If you want to customize the name of the secondary mount directory
    rete=/rete
	# Minimum time in minutes between purging unused host maps
    purgetime=60
	# autobase is the basename of the automount program
    autobase=automount
else
    shift
    opt_d=DEBUG
    rete=./rete
    purgetime=1
    autobase=sleep
fi

# Idiotproof for testing
if [ -z "$1" ] ; then 
    echo "Usage: $0 hostname (hostname required)" 1>&2
fi

		# Purge unused host-specific map files.  This occurs
		# at most once an hour.  
		# find: -mmin is true if the file's mtime is N minutes old.
		# There's a race condition here, though we've never been 
		# bitten.  Should be improved.
stamp=`find $rete/TIMESTAMP -mmin -$purgetime -print 2> /dev/null`
if [ -z "$stamp" ] ; then
	mkdir $rete/KEEP
	for f in /net/* ; do
	    bn=`basename $f`
	    if [ -f "$rete/$bn" ] ; then mv "$rete/$bn" $rete/KEEP ; fi
	done
	rm -f $rete/[a-z]*
	mv $rete/KEEP/* $rete 2> /dev/null
	rmdir $rete/KEEP
    date "+host map files last purged at %Y-%m-%d %H:%M:%S" > $rete/TIMESTAMP
fi

		# Create map file for the host-specific automount process.
		# Example: requesting /net/redwood/h1/whatever, map file says
		# "* redwood:/&" causing "mount -t nfs redwood:/h1 \
		# /net/redwood/h1".
echo "*	$1:/&" > $rete/$1 

		# Emit map row to cause an autofs submount to be spawned.
		# Don't want key, just "-options,fstype=autofs type:mapfile".
		# Resulting command line is:
		# /usr/sbin/automount --submount /net/$1 file $rete/$1
		# followed by map options if any were specified.
echo "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs	file:$rete/$1"
exit 0
