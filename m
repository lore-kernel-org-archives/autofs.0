From: David Meleedy <david.meleedy@analog.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Wed, 12 Jan 2005 19:37:23 -0500
Message-ID: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
References: <41E55688.9070107@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Wed, 12 Jan 2005 11:55:36 EST."
	<41E55688.9070107@sun.com> 
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
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>


Mike,
	I just recompiled my kernel with your xprt-sharing.patch.
Although this did fix the port error problems, it did not fix
the automounter problem.  So I think your patch should be incorporated
into Redhat Enterprise 3 (2.4 kernel) because it appears to work.

I think the problem is that the automounter just cannot unmount
the /net/aflac directory, and ends up trying to remount it instead,
here are the log files after the port patch that Mike gave me:
(this is during the reboot after cd'ing to /net/aflac/vol/vol2)

Jan 12 19:23:36 codered automount[5396]: can't shutdown: filesystem /net still 
busy
Jan 12 19:23:38 codered autofs: automount -USR2 succeeded
Jan 12 19:23:41 codered automount[5396]: can't shutdown: filesystem /net still 
busy
... those lines keep repeating until ....

Jan 12 19:24:08 codered automount[16092]: >> mount table full
Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure 
aflac:/vol/vol3/cad_archive on /net/aflac/vol/vol3/cad_archive
Jan 12 19:24:08 codered automount[16092]: >> mount table full
Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure 
aflac:/vol/vol3/design on /net/aflac/vol/vol3/design
... those lines repeart for each subdirectory of the volumes ...

Jan 12 19:24:09 codered autofs: automount shutdown failed

As you can see, it keeps trying to unmount /net, and eventually
fills up the mount table because it instead remounts it.  Before,
when the port issue was a problem, it wouldn't get far enough to
fill the mount table, but now it can (thanks Mike!)

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
