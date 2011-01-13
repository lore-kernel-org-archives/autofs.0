From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 0/8] Patches to autofs 4.1.4
	daemon to speed some things up and increase robustness
Date: Thu, 13 Jan 2011 16:09:23 +1300
Message-ID: <cover.1294888163.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: 

I'm releasing these patches for anyone still using the old autofs 4.1.4
daemon.

We still use autofs 4.1.4 where I work. 

We have over 4,000 nfs clients using automounter (maps held in LDAP). We use
simple indirect maps. In other words I've only tested LDAP with simple
maps on nfs.

We have found many ways to make fileservers suffer from major performance problems. 

Our preferred behaviour is for the automounter to keep trying to mount
a location until the fileserver becomes less busy. Otherwise we have
to deal with the fallout from EEXIST errors. 

Along the way I've found other stuff which I've included (some of
which only matters because the 4.1.4 daemon forks full processes
rather than using threads).

I have included some other people's patches and have attributed
them to the person I think did the patch in the first place. Apologies
if I've got it wrong!

This published set is meant to clearly publish the work I've done -
but include the bare minimum patches to autofs-4.1.4.tar.gz (from
http://www.kernel.org/pub/linux/daemons/autofs/v4/) 
so that my stuff works and so it's clear what my patches do.

I've included CHANGELOG entries for each patch which hopefully
explains what I've done for each patch.

However,  I use a bunch more patches from the redhat rpms and some
from kernel.org. A current picture of what I really use is available from
https://github.com/bryder/bryder_autofs414

So if you wanted to try this out - github is the place to get it from.


Bill Ryder (8):
  Added the dumpmap option and updated manpage - I didn't write this
  Set LDAP_DEPRECATED to prevent coredumps with modern ldap libraries
  Added function names to some debug/crit messages, changed some crits
    to debug
  reinstated the jmoyer ldap-cleanup patch and included man etc updates
  Added option to ignore some highly unlikely paths before forking
    daemon
  Adds options to retry nfs mounts on certain nfs errors
  Ian Kent's reentrant syslog patch
  Fix race which would stop a daemon under high mount rates with
    failures
