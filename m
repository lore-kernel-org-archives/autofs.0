From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs v4 releases, at last
Date: Wed, 1 Oct 2003 00:46:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309302028550.2982-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

It's not a perfect world and there are still problems with the code but I 
need to get them out to a broader audience. So I have put these releases 
together. I hope that you will find them useful.

The tars mentioned below are located at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4

autofs-4.0.0-1.tar.[gz|bz2]
===========================

Largely the autofs-4.0.0pre10 with:

	1) Some patches that I did ages ago to improve submounts.
	   This includes correcting the double slash in mount
	   points. Changes to the init script to improve the 
	   shutdown when submounts are involved.
	2) Merged some small patches from the Debian and SuSE autofs v4
	   packages.
	3) A simple work around to allow tree mounts to work with
	   RedHat 2.4.20, and above, kernels.


autofs-4.1.0-beta1.tar.[gz|bz2]
===============================

This is a restructuring and improvement of my original v4 patch. I am 
releasing it as a beta so that it can be tested in a broader range of 
environments. Please try it and let me know how it goes (he said as he 
ducked waiting for the stream of complaints).

As well the considerable restructure and tidy up of my original patch it 
includes:

	1) Merge of all the RedHat autofs v3 patches. This includes
	   the RedHat init script and LDAP improvements. See the 
	   README files in the package for more info.
	2) Add LDAP direct mount support to complement the file
	   and NIS map direct mount support already present.
	3) Merged some patches from the Debian and SuSE autofs v4
	   packages.
	4) Found a bunch of bugs and fixed them. This was largely
	   due to the huge efforts made by Aaron Ogden in testing
	   a never ending stream of attempted corrections.
	   Thanks Aaron.

What has not yet been done:

	1) Work on multiple distribution startup.
	   I'm still thinking about how best to do this.
	2) Merge of patches supplied by Mark Fasheh. Sorry Mark.
	   This work has been started and you will see some of
	   the code present, but as yet unused. I want to
	   generalize these patches and that is going to
	   take awhile.
	3) Fix the handling busy mount points at exit.
	   I have tried to improve this often but it is still
	   not the best.


And finally

autofs4-2.4-module-20030929.tar.[gz|bz2]
========================================

The purpose of the autofs4 kernel module update is to provide support
for browsing (ghosting) of the autofs file system. The daemon can do this 
for file, NIS and LDAP maps.

The kit is for the kernel version 2.4 autofs4 module. It includes patches 
that can be applied separately to a kernel source tree (they are also 
present in autofs-4.1.0 tar). People that want to compile autofs4 into 
the kernel or just want to patch the kernel can use them. But the kit is 
really intended to be used to build the autofs4 module without having to 
build a kernel. The only requirement is that a kernel source tree that 
matches the running kernel be present along with a corresponding kernel 
config file. Please check the README for more info.

This is new and I'm not sure about the quality of the documentation so 
feedback is needed, or better, updates and patches.


Hope some of you find these useful.
Ian

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
