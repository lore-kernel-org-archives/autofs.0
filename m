From: David Meleedy <david.meleedy@analog.com>
Subject: Intermittant problems mounting with automounter
Date: Thu, 18 Nov 2004 15:53:41 -0500
Message-ID: <200411182053.iAIKrgEO013759@jetcar.spd.analog.com>
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


codered-70: cat /etc/redhat-release 
Red Hat Enterprise Linux WS release 3 (Taroon Update 3)
codered-71: uname -a
Linux codered.spd.analog.com 2.4.21-20.EL #1 Wed Aug 18 20:48:55 EDT 2004 
x86_64
 x86_64 x86_64 GNU/Linux


We are mounting from a netapp filer:
aflac> version
NetApp Release 6.4.2: Mon Sep 15 12:35:28 PDT 2003

Here are the versions of the automounter and kernel we are
using:

codered-65: rpm -qa | grep autofs
autofs-4.1.3-12
codered-66: rpm -qa | grep kernel
kernel-2.4.21-20.EL

We set up automounter variables in the following way:

codered-67: more /etc/sysconfig/autofs
LOCALOPTIONS="-DSITE=nwd_ -DARCH=x86_64 -DOSREL=redhat3"

We have an /etc/auto.master file that invokes a perl script
that returns the value of the mount location given a key.

codered-130: cat /etc/auto.master | grep cpd
/cpd            /etc/auto.cpd   hard,intr,rsize=8192,wsize=8192,vers=3

Here is some sample output from that script:
codered-131: /etc/auto.cpd X11R6
aflac,aflac-171:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&
codered-132: /etc/auto.cpd inet
aflac,aflac-171:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&

I should also mention that I simplified the output from our
perl script, removing one of the host names that was separated
by a comma, and the problem still occurred:

codered-132: /etc/auto.cpd inet
aflac:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&


Now during the problem this is what it looks like... first
one of the directories can be mounted:

codered-133: cd /cpd/X11R6
codered-134: df .
Filesystem           1K-blocks      Used Available Use% Mounted on
aflac:/vol/vol1/cpd/nwd_x86_64_redhat3/X11R6
                      47185920  41362456   5823464  88% /cpd/X11R6


and then another one from the same filer, same export permissions,
same directory permissions gets the following error:

codered-135: cd /cpd/inet
/cpd/inet: No such file or directory

then later.... it mysteriously starts working.

codered-137: cd /cpd/inet
codered-138: df .
Filesystem           1K-blocks      Used Available Use% Mounted on
aflac:/vol/vol1/cpd/nwd_x86_64_redhat3/inet
                      47185920  41362456   5823464  88% /cpd/inet


Here's one that uses less automounter variables:

codered-61: /etc/auto.cpd usr
aflac,aflac-171:/vol/vol1/cpd/${SITE}&  
codered-62: cd /cpd/usr
/cpd/usr: No such file or directory.

and later it works again:

codered-68: cd /cpd/usr
codered-69: df .
Filesystem           1K-blocks      Used Available Use% Mounted on
aflac:/vol/vol1/cpd/nwd_usr
                      47185920  41362456   5823464  88% /cpd/usr


Any ideas what is going on here?

Thanks,

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
