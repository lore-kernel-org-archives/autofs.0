From: "Ilyas Yildirim" <ilyildirim@hotmail.com>
Subject: autofs mounts the servers but I cannot see them in my
	machine
Date: Sat, 05 Jan 2008 03:15:17 -0500
Message-ID: <BAY137-F3257E1CF5E4EC1DD00C84ACD4D0@phx.gbl>
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

Dear autofs users,

I am having a very annoying problem with autofs. I am using RedHat 
Enterprise W4 Linux. My machine is a Dell Precision 490n Intel xeon two 
dual-core system.

The versions of autofs I am using are as follows (I have the same problem in 
both versions)

[root@malatya01 init.d]# rpm -q autofs
autofs-4.1.3-231
[root@malatya01 init.d]# rpm -q autofs5
autofs5-5.0.1-0.rc2.55.el4_6.2

The kernel I am using is

[root@malatya01 init.d]# uname -r
2.6.9-67.0.1.ELsmp

So, here is the problem: Here are what I have in auto.master and auto.misc 
files:
=============== auto.master ===========================
#
# $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc  /etc/auto.misc --timeout=60
/misc   /etc/auto.misc

=======================================================
=============== auto.misc =======================
*           -fstype=nfs,soft,intr           
malatya02.chem.rochester.edu:/malatya02b
==============================================
Restarting autofs with 'autofs restart' does not give any error message.

[root@malatya01 init.d]# autofs restart
Stopping automount:                                        [  OK  ]
Starting automount:                                        [  OK  ]

It looks like that autofs has mounted the nfs filesystem. When I do 'ls -l 
/misc/linux' I dont see anything.

[root@malatya01 init.d]# ls -l /misc
total 0

But, when I enter something like 'ls -l /misc/deneme', I see the filesystems 
in /misc/deneme. Do I make something wrong here? I want the data to be seen 
in /misc and I cannot make it using autofs. Thanks a lot in advance.

Best regards,
---
--- Ilyas Yildirim
--- http://www.pas.rochester.edu/~yildirim/
--- "Carpe Diem!"
