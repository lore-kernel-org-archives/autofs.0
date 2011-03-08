From: <hpc.admin@uea.ac.uk>
Subject: autofs problem
Date: Tue, 8 Mar 2011 11:24:20 -0000
Message-ID: <4930.3142507144$1299656706@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Language: en-gb
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
To: autofs@linux.kernel.org
Cc: hpc.admin@uea.ac.uk

Hello,

I am experiencing autofs problems with my Centos 5.5 system. Upon boot, the
mount fails with the following error messages (created by passing the -d
option in the automount):

Mar  8 10:38:19 cn024 automount[6395]: do_notify_state: signal 15
Mar  8 10:38:19 cn024 automount[6395]: master_notify_state_change: sig 15
switching /home from 1 to 5
Mar  8 10:38:19 cn024 automount[6395]: st_prepare_shutdown: state 1 path
/home
Mar  8 10:38:19 cn024 automount[6395]: expire_proc: exp_proc = 1090562368
path /home
Mar  8 10:38:19 cn024 automount[6395]: expire_cleanup: got thid 1090562368
path /home stat 0
Mar  8 10:38:19 cn024 automount[6395]: expire_cleanup: sigchld: exp
1090562368 finished, switching from 5 to 7
Mar  8 10:38:19 cn024 automount[6395]: st_shutdown: state 5 path /home
Mar  8 10:38:19 cn024 smartd[7258]: smartd has fork()ed into background
mode. New PID=7258.
Mar  8 10:38:19 cn024 automount[6395]: umount_multi: path /home incl 0
Mar  8 10:38:19 cn024 automount[6395]: umounted indirect mount /home
Mar  8 10:38:19 cn024 automount[6395]: automount_path_to_fifo: fifo name
/var/run/autofs.fifo-home
Mar  8 10:38:19 cn024 automount[6395]: shut down path /home
Mar  8 10:38:19 cn024 automount[6395]: autofs stopped
Mar  8 10:38:28 cn024 automount[7334]: Starting automounter version
5.0.1-0.rc2.143.el5, master map auto.master
Mar  8 10:38:28 cn024 automount[7334]: using kernel protocol version 5.01
Mar  8 10:38:28 cn024 automount[7334]: lookup_nss_read_master: reading
master files auto.master
Mar  8 10:38:28 cn024 automount[7334]: parse_init: parse(sun): init gathered
global options: (null)
Mar  8 10:38:28 cn024 automount[7334]: lookup_read_master: lookup(file):
read entry /home
Mar  8 10:38:28 cn024 automount[7334]: master_do_mount: mounting /home
Mar  8 10:38:28 cn024 automount[7334]: automount_path_to_fifo: fifo name
/var/run/autofs.fifo-home
Mar  8 10:38:28 cn024 automount[7334]: lookup_nss_read_map: reading map file
/etc/auto.home
Mar  8 10:38:28 cn024 automount[7334]: parse_init: parse(sun): init gathered
global options: rw,intr
Mar  8 10:38:28 cn024 automount[7334]: do_mount_autofs_indirect: failed to
create ioctl fd for autofs path /home
Mar  8 10:38:28 cn024 automount[7334]: handle_mounts: mount of /home failed!
Mar  8 10:38:28 cn024 automount[7334]: master_do_mount: failed to startup
mount
Mar  8 10:38:28 cn024 automount[7334]: no mounts in table

The error messages to note are the last four lines. When I restart the
daemon, the automount works, but fails after a day or two. The version of
autofs I am using is:

Name        : autofs                       Relocations: (not relocatable)
Version     : 5.0.1                        Vendor: CentOS
Release     : 0.rc2.143.el5_5.6             

Any help will be greatly appreciated. Thanks in advance.

----------
Wadud Miah
High Performance Computing Systems Developer
Research Computing Services, University of East Anglia
Telephone: 01603 593856

Information Services
----------
