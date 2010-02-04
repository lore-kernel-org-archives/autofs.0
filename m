From: Jon Forrest <jlforrest@berkeley.edu>
Subject: Transient Automount Problems in CentOS 5.3
Date: Wed, 03 Feb 2010 16:16:01 -0800
Message-ID: <4B6A11C1.3080005@berkeley.edu>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I have a new cluster running CentOS 5.3.
The cluster uses a Sun 7310 storage server
that provides NFS service over a private
1Gb/s ethernet with 9K jumbo frames to the
cluster.

We've noticed that a number of the compute
nodes sometimes generate the

automount[15023]: umount_autofs_indirect: ask umount returned busy /home

message. When this happens the program running on the
node dies. This has happened between 10 and 20 times.
We're not sure what's going on on a node when this
happens. Most of the time everything is fine and
the home directories are automounted without problem.

I've googled for this problem and I see that other people
have seen it too, but I've never seen a resolution,
especially not for RHEL5.

The auto.master line for this mount is

/home  /etc/auto.home  --timeout=1200 
noatime,nodiratime,rw,noacl,rsize=32768,wsize=32768

The network interface configuration is

eth0      Link encap:Ethernet  HWaddr 00:30:48:B9:F6:52
           inet addr:10.1.255.233  Bcast:10.1.255.255  Mask:255.255.0.0
           inet6 addr: fe80::230:48ff:feb9:f652/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
           RX packets:32999308 errors:0 dropped:0 overruns:0 frame:0
           TX packets:27468315 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:24225053296 (22.5 GiB)  TX bytes:73313582546 (68.2 GiB)
           Interrupt:74 Base address:0x2000

The automount is

Linux automount version 5.0.1-0.rc2.102

Directories:
         config dir:     /etc/sysconfig
         maps dir:       /etc
         modules dir:    /usr/lib64/autofs

Compile options:
   DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP
   WITH_SASL

The kernel is 2.6.18-128.1.14.el5.

Any advice on what to do?

Cordially,
-- 
Jon Forrest
Research Computing Support
College of Chemistry
173 Tan Hall
University of California Berkeley
Berkeley, CA
94720-1460
510-643-1032
