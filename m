From: Robert Giles <rgiles@arlut.utexas.edu>
Subject: Infinite loop when trying to access nonexistent directory
 (auto.home '&' substitution)
Date: Fri, 15 Oct 2004 19:36:15 -0500 (CDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-ID: <Pine.LNX.4.61.0410151426271.7091@orion.arlut.utexas.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi folks - I'm seeing a really unusual problem when I try to access a 
nonexistent mount under /home - cd'ing into "/home/asdf" causes the 
automounter to get stuck in what appears to be an infinite loop (in the 
example below, something tried to access /home/lock and caused the 
problem):

Oct 15 14:13:55 seneca automount[16767]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16767]: failed to mount /home/lock
Oct 15 14:13:55 seneca automount[16769]: >> mount: brain-nfs:/ldisk/md0/home/lock failed, reason given by server: No such file or directory
Oct 15 14:13:55 seneca automount[16769]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16769]: failed to mount /home/lock
Oct 15 14:13:55 seneca automount[16771]: >> mount: brain-nfs:/ldisk/md0/home/lock failed, reason given by server: No such file or directory
Oct 15 14:13:55 seneca automount[16771]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16771]: failed to mount /home/lock
Oct 15 14:13:55 seneca automount[16773]: >> mount: brain-nfs:/ldisk/md0/home/lock failed, reason given by server: No such file or directory
Oct 15 14:13:55 seneca automount[16773]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16773]: failed to mount /home/lock
Oct 15 14:13:55 seneca automount[16775]: >> mount: brain-nfs:/ldisk/md0/home/lock failed, reason given by server: No such file or directory
Oct 15 14:13:55 seneca automount[16775]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16775]: failed to mount /home/lock
Oct 15 14:13:55 seneca automount[16777]: >> mount: brain-nfs:/ldisk/md0/home/lock failed, reason given by server: No such file or directory
Oct 15 14:13:55 seneca automount[16777]: mount(nfs): nfs: mount failure brain-nfs:/ldisk/md0/home/lock on /home/lock
Oct 15 14:13:55 seneca automount[16777]: failed to mount /home/lock

<...and on and on until /var/log/syslog fills up the disk...>

I'm not sure if this is the same bug mentioned in 
autofs-4.1.3-strict.patch.  ???

Problem surfaced when I upgraded from 2.4.25 to 2.4.27, but it doesn't 
look like there were any autofs4 changes made between 2.4.25 and 2.4.27. 
If it makes any difference, I am using the SNARE C2 auditing patches for 
the kernel, but I don't think those would have any impact on autofs.

I'm seeing this problem regardless of what autofs package I use (SuSE 9.0 
autofs3, autofs4.0.0-pre10, or the latest autofs-4.1.3 + patches from 
kernel.org).

I've upgraded util-linux to 2.12b and nfs-utils to 1.06, no luck.  Have 
also upgraded nfs-utils server-side, no luck.

I also applied the autofs4-2.4.22-20040508.patch to 2.4.27 and haven't 
seen any change in behavior (the autofs-4.1.3-strict.patch mentioned a 
the kernel patch might be required if the problem didn't go away).

More details about my system:

automount:  Linux automount version 4.1.3
mount:  mount-2.12b

uname -a: Linux seneca 2.4.27 #4 Tue Sep 14 14:42:16 CDT 2004 i686 i686 i386 GNU/Linux
   (built again today with the autofs4 kernel patch, no change)

# /etc/auto.master
----
/home   /etc/auto.home
/proj   /etc/auto.proj
/data   /etc/auto.data
/info   /etc/auto.info
/scratch /etc/auto.scratch
----

# /etc/auto.home
----
* -fstype=nfs,rw,soft,intr brain-nfs:/ldisk/md0/home/&
----

Have also tried /etc/auto.home without ANY options, no difference.

Any possible solutions you all could throw out there would be greatly 
appreciated - I'm stumped!

Robert Giles
ARL:UT
