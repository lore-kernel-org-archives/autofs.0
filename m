From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Intermittant problems mounting with automounter
Date: Thu, 18 Nov 2004 16:05:33 -0500
Message-ID: <16797.3741.777092.934210@segfault.boston.redhat.com>
References: <200411182053.iAIKrgEO013759@jetcar.spd.analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200411182053.iAIKrgEO013759@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Intermittant problems mounting with automounter; David Meleedy <david.meleedy@analog.com> adds:

david.meleedy> codered-70: cat /etc/redhat-release Red Hat Enterprise Linux
david.meleedy> WS release 3 (Taroon Update 3) codered-71: uname -a Linux
david.meleedy> codered.spd.analog.com 2.4.21-20.EL #1 Wed Aug 18 20:48:55
david.meleedy> EDT 2004 x86_64 x86_64 x86_64 GNU/Linux


david.meleedy> We are mounting from a netapp filer:
aflac> version
david.meleedy> NetApp Release 6.4.2: Mon Sep 15 12:35:28 PDT 2003

david.meleedy> Here are the versions of the automounter and kernel we are
david.meleedy> using:

david.meleedy> codered-65: rpm -qa | grep autofs autofs-4.1.3-12
david.meleedy> codered-66: rpm -qa | grep kernel kernel-2.4.21-20.EL

david.meleedy> We set up automounter variables in the following way:

david.meleedy> codered-67: more /etc/sysconfig/autofs
david.meleedy> LOCALOPTIONS="-DSITE=nwd_ -DARCH=x86_64 -DOSREL=redhat3"

david.meleedy> We have an /etc/auto.master file that invokes a perl script
david.meleedy> that returns the value of the mount location given a key.

david.meleedy> codered-130: cat /etc/auto.master | grep cpd /cpd
david.meleedy> /etc/auto.cpd hard,intr,rsize=8192,wsize=8192,vers=3

david.meleedy> Here is some sample output from that script: codered-131:
david.meleedy> /etc/auto.cpd X11R6
david.meleedy> aflac,aflac-171:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&
david.meleedy> codered-132: /etc/auto.cpd inet
david.meleedy> aflac,aflac-171:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&

david.meleedy> I should also mention that I simplified the output from our
david.meleedy> perl script, removing one of the host names that was
david.meleedy> separated by a comma, and the problem still occurred:

david.meleedy> codered-132: /etc/auto.cpd inet
david.meleedy> aflac:/vol/vol1/cpd/${SITE}${ARCH}_${OSREL}/&


david.meleedy> Now during the problem this is what it looks like... first
david.meleedy> one of the directories can be mounted:

david.meleedy> codered-133: cd /cpd/X11R6 codered-134: df .  Filesystem
david.meleedy> 1K-blocks Used Available Use% Mounted on
david.meleedy> aflac:/vol/vol1/cpd/nwd_x86_64_redhat3/X11R6 47185920
david.meleedy> 41362456 5823464 88% /cpd/X11R6


david.meleedy> and then another one from the same filer, same export
david.meleedy> permissions, same directory permissions gets the following
david.meleedy> error:

david.meleedy> codered-135: cd /cpd/inet /cpd/inet: No such file or
david.meleedy> directory

david.meleedy> then later.... it mysteriously starts working.

david.meleedy> codered-137: cd /cpd/inet codered-138: df .  Filesystem
david.meleedy> 1K-blocks Used Available Use% Mounted on
david.meleedy> aflac:/vol/vol1/cpd/nwd_x86_64_redhat3/inet 47185920
david.meleedy> 41362456 5823464 88% /cpd/inet


david.meleedy> Here's one that uses less automounter variables:

david.meleedy> codered-61: /etc/auto.cpd usr
david.meleedy> aflac,aflac-171:/vol/vol1/cpd/${SITE}& codered-62: cd
david.meleedy> /cpd/usr /cpd/usr: No such file or directory.

david.meleedy> and later it works again:

david.meleedy> codered-68: cd /cpd/usr codered-69: df .  Filesystem
david.meleedy> 1K-blocks Used Available Use% Mounted on
david.meleedy> aflac:/vol/vol1/cpd/nwd_usr 47185920 41362456 5823464 88%
david.meleedy> /cpd/usr


david.meleedy> Any ideas what is going on here?

Is there any information in the logs?  I would hope so.

-Jeff
