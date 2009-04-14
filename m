From: Sergei Zhirikov <sfzhi@yahoo.com>
Subject: Strange behavior of autofs with reiserfs on expire
Date: Tue, 14 Apr 2009 20:26:57 +0200
Message-ID: <gs2khi$f5$1@ger.gmane.org>
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

Hi,

I'm observing the following strange behavior. If I try to auto-mount a 
reiserfs partition via autofs it does not get unmounted when the mount 
expires. I have tried a few other filesystems (ext3, tmpfs, fuse) and 
the problem appears only with reiserfs and only when automount is using 
/dev/autofs. There are no error messages in the log. The reiserfs mount 
remains mounted as if it was busy, but I'm pretty sure it is not busy, 
because lsof reports no open handles and I can unmount it at any moment 
with 'umount'. If I configure automount to run without /dev/autofs then 
everything is unmounted as expected.

Here is a sequence of commands to reproduce the problem. It should be 
run as root and bash shell is assumed. The automount daemon must be 
using /dev/autofs.

cd /tmp/

mkdir autofs-test

cd autofs-test/

dd if=/dev/zero of=e3.img bs=1024 count=131072

cp e3.img r3.img

modprobe loop # if necessary

losetup /dev/loop0 /tmp/autofs-test/e3.img

losetup /dev/loop1 /tmp/autofs-test/r3.img

mkfs -t ext3 /dev/loop0

mkfs -t reiserfs /dev/loop1

echo \
$'e3 -fstype=ext3,ro :/dev/loop0\nr3 -fstype=reiserfs,ro :/dev/loop1' \
	> auto.test

mkdir test

echo '/tmp/autofs-test/test /tmp/autofs-test/auto.test --ghost' \
  	>> ${wherever_the_master_map_is}/auto.master

/etc/init.d/autofs reload

ls test/{e3,r3}

These commands create two filesystem images attached to loop devices. 
One is formatted with ext3 an the other one with reiserfs. The last 
command triggers automounting of both of them. After that one should 
wait a bit longer than the expiry timeout and then run 'mount' or 'cat 
/proc/mounts' to see that ext3 has been unmounted, while reiserfs hasn't.

Can anyone, please, try to reproduce the problem?

I'm using vanilla kernel 2.6.28.9 and autofs 5.0.4 (with all 36 patches 
available at the moment). I did not install any kernel patches, since I 
understood from this message: http://lkml.org/lkml/2008/11/3/383 that 
none are necessary (is that correct?).

I appreciate any help to figure out if it is a bug or something is wrong 
with my system.

--
Sergei.
