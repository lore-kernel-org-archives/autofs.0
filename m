From: David Meleedy <david.meleedy@analog.com>
Subject: Re: Intermittant problems mounting with automounter
Date: Tue, 30 Nov 2004 15:07:16 -0500
Message-ID: <200411302007.iAUK7GjH020588@jetcar.spd.analog.com>
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


Well, in order to troubleshoot this issue further, autofs on Redhat
Enterprise 3, update 3

I removed all options from the /etc/auto.master file:

from:

/cpd            /etc/auto.cpd  hard,intr,rsize=8192,wsize=8192

to:

/cpd            /etc/auto.cpd 


After this change, the following errors seemed to go away:

====
Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
Nov 19 11:27:38 codered kernel: nfs warning: mount version older than kernel
Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
Nov 19 11:27:38 codered automount[3623]: >> mount: wrong fs type, bad option, 
bad superblock on aflac:/vol/vol1/cpd/nwd_usr,
Nov 19 11:27:38 codered automount[3623]: >>        or too many mounted file 
systems
Nov 19 11:27:38 codered automount[3623]: mount(nfs): nfs: mount failure 
aflac:/vol/vol1/cpd/nwd_usr on /cpd/usr
Nov 19 11:27:38 codered automount[3623]: failed to mount /cpd/usr
=====

So whatever it is might be caused by the options?

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
