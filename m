From: Jim Davis <jdavis@cs.arizona.edu>
Subject: Debugging hung autofs /home?
Date: Tue, 10 Jan 2006 16:16:43 -0700
Message-ID: <43C4405B.7050706@cs.arizona.edu>
References: <43C29C28.5090407@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43C29C28.5090407@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

[root@lectura /]# ps ax | grep auto
 2709 ?        Ss     0:00 /usr/sbin/automount --timeout=3600 --verbose 
--debug /home file /etc/auto_home -rw,intr,nosuid
 2763 ?        Ss     0:00 /usr/sbin/automount --timeout=3600 --verbose 
--debug /cs file /etc/auto_cs -rw,intr,nosuid
 3776 ?        S      0:00 kalarmd --autostart
21284 pts/16   S+     0:00 grep automount
21827 pts/28   S+     0:00 grep auto
[root@lectura /]# kill -HUP 2709
[root@lectura /]# strace -f -p 2709
Process 2709 attached - interrupt to quit
futex(0x2aaaaaefd840, FUTEX_WAIT, 2, NULL

That process doesn't respond to kill -HUP, USR1, USR2,  or /sbin/service 
autofs reload.  (The other automount process associated with /cs seems 
to be fine.)   New mounts under /home just hang.  Mounting the 
directories by hand from the NFS server works.

This is on a 4-processor AMD system running FC4:

Linux lectura.cs.arizona.edu 2.6.14-1.1656_FC4smp #1 SMP Thu Jan 5 
22:26:33 EST 2006 x86_64 x86_64 x86_64 GNU/Linux
