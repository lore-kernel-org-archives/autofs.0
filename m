From: Martin Vogt <vogt@itwm.fraunhofer.de>
Subject: more than 1024 mounts ==>hangs
Date: Thu, 04 Dec 2008 14:13:56 +0100
Message-ID: <4937D794.6040908@itwm.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org



Hello list,

I'm currently experimenting with autofs on SuSE 11.1 rc1

-autofs-5.0.3-82.19

Around the 1024th mount, autofs hangs and the machine needs a reboot -f.

I have here >2000 mount points which usually look like this:

/homes/vogt0001 --fstype=bind :/net/fsA/home/user/vogt0001
/homes/vogt0002 --fstype=bind :/net/fsB/home/user/vogt0002
[..]
/homes/vogt2000 --fstype=bind :/net/fsC/home/user/vogt2000


Further debugging revealed:

pxe1:/home/demo1 # lsof -p <automount pid>
[...]
automount 5111 root 1022r   DIR  0,228        0  13029 /u/itwm/hinojosa
automount 5111 root 1023r   DIR  0,561        0  13362 /u/itwm/andrejs
automount 5111 root 1024r  FIFO    0,7      0t0  26910 pipe

The 1024 really looks like some limit, which is hit by the automount
process.

I checked ulimit -a:

pxe1:/home/demo1 # ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 16117
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) 1717680
open files                      (-n) 4096
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 16117
virtual memory          (kbytes, -v) 2455520
file locks                      (-x) unlimited


The I checked ulimit under /proc:

pxe1:/proc/5111 # cat limits
Limit                     Soft Limit           Hard Limit           Units
Max cpu time              unlimited            unlimited
Max file size             unlimited            unlimited
Max data size             unlimited            unlimited
Max stack size            8388608              unlimited
Max core file size        unlimited            unlimited
Max resident set          1758904320           unlimited
Max processes             16117                16117
Max open files            10240                10240
Max locked memory         65536                262144
Max address space         2514452480           unlimited
Max file locks            unlimited            unlimited
Max pending signals       16117                16117
Max msgqueue size         819200               819200
Max nice priority         0                    0
Max realtime priority     0                    0
Max realtime timeout      unlimited            unlimited


==> At least the Max file desc. looks ok, but somewho it hangs.
Ah, the behavoir by autofs is:

- It hangs on duing a mount operation:

root      5111  0.0  0.1  97200  2936 pts/0    Sl+  13:30   0:01
/usr/sbin/automount -d -f -t 600 -p /var/run/automount.pid -O ro
root      9541  0.0  0.0      0     0 pts/0    Z+   13:31   0:00 [mount]
<defunct>

stopping automount is not possible it needs a reboot -f

I have search a bit for this problem, but found no solution yet.


regards,

Martin


PS: I havent found a way to do it without bind mounts
