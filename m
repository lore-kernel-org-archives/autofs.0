From: Brian Long <brilong@cisco.com>
Subject: direct map shut down?
Date: Thu, 19 Feb 2004 12:16:55 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

I'm just starting to mess around with autofs4 on RHEL 3.  I've installed
the autofs4.o module from kernel-unsupported and added the appropriate
modules.conf entry.  When autofs starts, it reads my auto.master
properly, but immediately shuts down the /- entry.  Why?

/etc/auto.master:
/misc  /etc/auto.misc  --timeout 60
/tools nisplus:auto_tools rw,hard,intr,noquota,timeo=15
/auto /etc/auto.indirect rsize=32768,wsize=32768,tcp
/users nisplus:auto_home rw,hard,intr,rsize=32768,wsize=32768,tcp
/- /etc/auto.direct rsize=32768,wsize=32768,tcp

/etc/auto.direct
/netapp/rtp-filer01a    rtp-filer01a:/vol/vol0

Also, is there a version of the kernel module or user utils that would
support multiple direct mounts under the same mount point?  For example,
I want to mount rtp-filer01a:/vol/local1 under
/netapp/rtp-filer01a/vol/local1  :)

Thanks!

/Brian/
-- 
       Brian Long                      |         |           |
       Americas IT Hosting Sys Admin   |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
