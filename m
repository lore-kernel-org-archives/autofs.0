From: Pavel Troller <patrol@sinus.cz>
Subject: automount 4.1.3: unmount timeout not working
Date: Sat, 22 Jan 2005 22:52:28 +0100
Message-ID: <20050122215228.GA14303@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hello to all the list members,
  I decided to write to this list after a lot of time spent by trying to
find an answer for my question, but I didn't find any so I'm trying the luck
here.
  I'm using automount 4.1.3 with kernel 2.6.10, but the problem appeared
formerly, with 2.6.7, and it's not directly related to the kernel, because it
didn't appear with a kernel change, but with some other change in my system
or setup, which I cannot track down.
  The problem itself is that the autoumount doesn't unmount automatically after
the timeout expires. Of course the mounted volume is not used anymore. Manual
umnounting with umount /mnt/volume (by root) works. Forced unmounting by 
sending SIGUSR1 to automount works too.
  When a verbose/debug mode is used, there is no message indicating that
a timeout expired. It simply seems that the timeout is not triggered at all.

I'm inserting an excerpt of the system log made by automount in debug mode:

Jan 22 22:26:51 arcus automount[16106]: starting automounter version 4.1.3, path = /mnt, maptype = file, mapname = /etc/autofs/auto.mnt
Jan 22 22:26:51 arcus automount[16106]: mount(bind): bind_works = 1
Jan 22 22:26:51 arcus automount[16106]: using kernel protocol version 4.05
Jan 22 22:26:51 arcus automount[16106]: using timeout 2 seconds; freq 1 secs
Jan 22 22:26:52 arcus automount[16106]: sig 14 switching from 1 to 2
Jan 22 22:26:52 arcus automount[16106]: get_pkt: state 1, next 2
Jan 22 22:26:52 arcus automount[16106]: st_expire(): state = 1
Jan 22 22:26:52 arcus automount[16106]: expire_proc: exp_proc=16118
Jan 22 22:26:52 arcus automount[16106]: handle_child: got pid 16118, sig 0 (0), stat 0
Jan 22 22:26:52 arcus automount[16106]: sigchld: exp 16118 finished, switching from 1 to 1
Jan 22 22:26:52 arcus automount[16106]: get_pkt: state 2, next 1
Jan 22 22:26:52 arcus automount[16106]: st_ready(): state = 2
Jan 22 22:27:10 arcus automount[16106]: handle_packet: type = 0
Jan 22 22:27:10 arcus automount[16106]: handle_packet_missing: token 24, name udfcd
Jan 22 22:27:10 arcus automount[16106]: attempting to mount entry /mnt/udfcd
Jan 22 22:27:10 arcus automount[16146]: lookup(file): udfcd -> -fstype=udf,rw,noatime,gid=32,umask=002^I:/dev/pktcdvd/0
[Details about parsing map files and output from packet writing driver removed]
Jan 22 22:27:14 arcus kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2004/11/15 17:24 (103c)
Jan 22 22:27:14 arcus automount[16146]: mount(generic): mounted /dev/pktcdvd/0 type udf on /mnt/udfcd
Jan 22 22:27:14 arcus automount[16106]: handle_child: got pid 16146, sig 0 (0), stat 0
Jan 22 22:27:14 arcus automount[16106]: sig_child: found pending iop pid 16146: signalled 0 (sig 0), exit status 0
Jan 22 22:27:14 arcus automount[16106]: send_ready: token=24

The above log was made by starting the automounter and entering "ls /mnt/udfcd".
2 seconds after these messages, another ones indicating expiration of the mount
shoud appear, but they don't, and the volume is still mounted. Now I'm killing
with SIGUSR1:

Jan 22 22:45:09 arcus automount[16106]: sig 10 switching from 1 to 3
Jan 22 22:45:09 arcus automount[16106]: get_pkt: state 1, next 3
Jan 22 22:45:09 arcus automount[16106]: st_prune(): state = 1
Jan 22 22:45:09 arcus automount[16106]: expire_proc: exp_proc=17400
Jan 22 22:45:09 arcus automount[16106]: handle_packet: type = 2
Jan 22 22:45:09 arcus automount[16106]: handle_packet_expire_multi: token 25, name udfcd
Jan 22 22:45:09 arcus automount[17401]: expiring path /mnt/udfcd
Jan 22 22:45:09 arcus automount[17401]: umount_multi: path=/mnt/udfcd incl=1
Jan 22 22:45:09 arcus automount[17401]: umount_multi: unmounting dir=/mnt/udfcd
Jan 22 22:45:13 arcus automount[17401]: rm_unwanted: /mnt/udfcd
Jan 22 22:45:13 arcus automount[17401]: expired /mnt/udfcd
Jan 22 22:45:13 arcus automount[16106]: handle_child: got pid 17401, sig 0 (0), stat 0
Jan 22 22:45:13 arcus automount[16106]: sig_child: found pending iop pid 17401: signalled 0 (sig 0), exit status 0
Jan 22 22:45:13 arcus automount[16106]: send_ready: token=25
Jan 22 22:45:13 arcus automount[16106]: handle_child: got pid 17400, sig 0 (0), stat 0
Jan 22 22:45:13 arcus automount[16106]: sigchld: exp 17400 finished, switching from 3 to 1
Jan 22 22:45:13 arcus automount[16106]: get_pkt: state 3, next 1
Jan 22 22:45:13 arcus automount[16106]: st_ready(): state = 3

I'm really unhappy with this, automount worked for a long time for me and now
such a problem... Any help would be greatly appreciated! And please, Cc: me,
I'm not subscribed to the list. Many thanks in advance!

                               With regards, Pavel Troller
