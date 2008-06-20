From: "J.P. King" <jpk28@cam.ac.uk>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 16:49:49 +0100 (BST)
Message-ID: <alpine.LSU.1.10.0806201632560.22566@hermes-1.csi.cam.ac.uk>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
	<1213975734.4975.17.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213975734.4975.17.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, hpa@zytor.com


Anton has just left for the weekend, so since I can answer this I will

> Why do you need to run one instance per user?
> What does it get you that using a single source common global map
> doesn't provide?

Our maps are generated on the fly by extracting information via LDAP from 
a Novel E directory and then a new automounter is started to mount their 
home directory and a number of other filesystems that we want them to have 
access to.

Because of how NCPFS works we need a separate set of mounts per user.

If we have a shared global map then, since we need to modify it each time 
a user logs in then we have a horrible locking problem.

Oh, and we have approximately 30,000 users, mostly not-entirely-trusted 
students.

Even ignoring that, it is a suboptimal situation that any user can stop 
the automounter from restarting by running a process with a particular 
name.  In general the reason daemons don't try and stop you running 
multiple copies is because it is hard to do even remotely approaching 
right.  Normally they rely on a shared resource acting as your lock - such 
as binding to port 80, or, if they must a lock/pid file.

To address a different question that was asked - why don't we maintain our 
own patched version - clearly we could, however wherever possible we like 
to have bugs, and I _think_ you've accepted that the DOS is a bug, fixed 
upstream so that in the future we won't have to patch it again.

For every item of software that we have to patch we have to track the real 
version for security holes and port our patch to this secured version. 
This is a lot of effort at the best of times, and we have to do it enough 
just to work around the infelicitudes with having to deal with Netware 
without adding to them.

Let me try and turn the problem around.  Given that you accept that the 
DOS is something that you'd like to remove, how would you like to see the 
problem being solved?  Off the top of my head I can think of:

1 command line option - only have it check if the option is set.  This has
   to be the simplest solution, but it isn't great.

2 Pid file - have it check if there is a pid in the pid file before
   writing its own pid.

3 Extend it to check not just the name, but the file/inode of the
   programme being executed.  This has a drawback if you upgrade the binary
   then you can start the new version with the old one still running.  It
   also wouldn't solve our particular problem.

I'm prepared to have the code for 1 or 2 written and a patch submitted for 
you.  I wouldn't put work into 3 since it doesn't help us.  If you can 
come up with a different solution I'm probably happy to have that done too, 
and a patch submitted, so long as it addresses our issue.

> Ian

Julian
--
Julian King
Computer Officer, University of Cambridge, Unix Support
