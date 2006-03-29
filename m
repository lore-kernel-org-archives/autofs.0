From: Mi <mi.lists@alma.ch>
Subject: Autofs wrongly tries to use NFS for a program map
Date: Wed, 29 Mar 2006 20:13:16 +0200
Message-ID: <442ACE3C.5020600@alma.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hello,

I'm trying to use a program map for external Firewire drives, but autofs 
seems to think it's supposed to be a NFS map, and fails.

I simplified things to a minimum to show the problem.
/etc/auto.test1 is a normal map which works.
/etc/auto.test2 is a program map which outputs the exact same content as 
is in auto.test1, yet it fails:

    # grep test /etc/auto.master
    /test1           /etc/auto.test1 --timeout=60
    /test2           /etc/auto.test2 --timeout=60

    # cat /etc/auto.test1
    sdb7         -fstype=ext3                        :/dev/sdb7

    # cat /etc/auto.test2
    #!/bin/bash
    echo "sdb7         -fstype=ext3                        :/dev/sdb7"


The test2 program fails:

    # ls /test2/sdb7
    ls: /test2/sdb7: No such file or directory

While test1 works as expected:

    # ls /test1/sdb7
    lost+found

The error in /var/log/daemon.log shows the mount is wrongly attempted as 
an nfs mount:

    Mar 29 18:37:36 gc automount[22081]: mount(nfs): host sdb7: lookup 
failure
    Mar 29 18:37:36 gc automount[22081]: >> mount: directory to mount 
not in host:dir format
    Mar 29 18:37:36 gc automount[22081]: mount(nfs): nfs: mount failure 
sdb7 on /test2/sdb7
    Mar 29 18:37:36 gc automount[22081]: failed to mount /test2/sdb7


# automount -V
Linux automount version 4.1.4_beta2

# uname -a
Linux gc 2.6.8-2-686 #1 Tue Aug 16 13:22:48 UTC 2005 i686 GNU/Linux



Thanks fo any help.

MI

PS: In case you are curious why I want a program map for an external 
drive, it is to be able to wake a sleeping drive. See 
http://sourceforge.net/mailarchive/forum.php?thread_id=10069902&forum_id=5389 
for details.
