From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Debugging hung autofs /home?
Date: Tue, 10 Jan 2006 18:51:11 -0500
Message-ID: <17348.18543.789713.377209@segfault.boston.redhat.com>
References: <43C29C28.5090407@deragon.biz>
	<43C4405B.7050706@cs.arizona.edu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43C4405B.7050706@cs.arizona.edu>
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
Content-Type: text/plain; charset="us-ascii"
To: Jim Davis <jdavis@cs.arizona.edu>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Debugging hung autofs /home?; Jim Davis <jdavis@cs.arizona.edu> adds:

jdavis> [root@lectura /]# ps ax | grep auto
jdavis>  2709 ?        Ss     0:00 /usr/sbin/automount --timeout=3600 --verbose 
jdavis> --debug /home file /etc/auto_home -rw,intr,nosuid
jdavis>  2763 ?        Ss     0:00 /usr/sbin/automount --timeout=3600 --verbose 
jdavis> --debug /cs file /etc/auto_cs -rw,intr,nosuid
jdavis>  3776 ?        S      0:00 kalarmd --autostart
jdavis> 21284 pts/16   S+     0:00 grep automount
jdavis> 21827 pts/28   S+     0:00 grep auto
jdavis> [root@lectura /]# kill -HUP 2709
jdavis> [root@lectura /]# strace -f -p 2709
jdavis> Process 2709 attached - interrupt to quit
jdavis> futex(0x2aaaaaefd840, FUTEX_WAIT, 2, NULL

jdavis> That process doesn't respond to kill -HUP, USR1, USR2,  or /sbin/service 
jdavis> autofs reload.  (The other automount process associated with /cs seems 
jdavis> to be fine.)   New mounts under /home just hang.  Mounting the 
jdavis> directories by hand from the NFS server works.

jdavis> This is on a 4-processor AMD system running FC4:

jdavis> Linux lectura.cs.arizona.edu 2.6.14-1.1656_FC4smp #1 SMP Thu Jan 5 
jdavis> 22:26:33 EST 2006 x86_64 x86_64 x86_64 GNU/Linux

And you left off the version of autofs you're running.  Most likely it's
older, and does not have the reentrant syslog patches.  I think an upgrade
will fix your wagon.  ;)

-Jeff
