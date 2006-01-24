From: Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com>
Subject: subdirs trying to be mounted when using ghosting
Date: Tue, 24 Jan 2006 16:40:59 +0000
Message-ID: <43D6589B.6030102@framestore-cfc.com>
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
To: autofs mailing list <autofs@linux.kernel.org>

Hi guys

We're having a problem when trying to access a subdir of an automount 
directory that isn't mounted. Instead of looking up the mount entry for 
the directory, a subdir is looked up instead. If the exact dir of the 
entry is accessed, then it mounts fine.

i.e.

ls /net/alpha/job/xmen3 -> no such file or directory
ls /net/alpha -> lists OK

We use a yp map for auto.net, it's not -host based mounting, heres the 
line from auto.master

/net yp:auto.net --ghost


Here's the entry from auto.net for /net/alpha which seems to be causing 
the problem (but I understand we experienced this for other mount 
points, including nfs servers. alpha is a lustre cluster)

alpha -fstype=lustre mds1a://mdt1a/alpha


We're running autofs 4.1.4-8 from RHEL4 RHN repo rebuilt for Fedora Core 
3. Also kernel-2.6.12-1.1381 from FC3 updates.

We've got debugging turned on the automounter so here you can see the 
logs when running the commands listed above


Jan 24 15:38:49 rj081 automount[3186]: handle_packet: type = 0
Jan 24 15:38:49 rj081 automount[3186]: handle_packet_missing: token 269, 
name alpha/job
Jan 24 15:38:49 rj081 automount[3186]: attempting to mount entry 
/net/alpha/job
Jan 24 15:38:49 rj081 automount[25673]: lookup(yp): looking up alpha/job
Jan 24 15:38:49 rj081 automount[25673]: ret = 8
Jan 24 15:38:49 rj081 automount[25673]: failed to mount /net/alpha/job
Jan 24 15:38:49 rj081 automount[25673]: umount_multi: 
path=/net/alpha/job incl=1
Jan 24 15:38:49 rj081 automount[25673]: umount_multi: no mounts found 
under /net/alpha/job
Jan 24 15:38:51 rj081 automount[3137]: sig 14 switching from 1 to 2
Jan 24 15:38:51 rj081 automount[3137]: get_pkt: state 1, next 2
Jan 24 15:38:51 rj081 automount[3137]: st_expire(): state = 1
Jan 24 15:38:51 rj081 automount[3137]: expire_proc: exp_proc=25674
Jan 24 15:38:51 rj081 automount[3292]: sig 14 switching from 1 to 2
Jan 24 15:38:51 rj081 automount[3292]: get_pkt: state 1, next 2
Jan 24 15:38:51 rj081 automount[3292]: st_expire(): state = 1
Jan 24 15:38:51 rj081 automount[3292]: expire_proc: exp_proc=25675
Jan 24 15:38:51 rj081 automount[3137]: handle_child: got pid 25674, sig 
0 (0), stat 0
Jan 24 15:38:51 rj081 automount[3137]: sigchld: exp 25674 finished, 
switching from 2 to 1
Jan 24 15:38:51 rj081 automount[3137]: get_pkt: state 2, next 1
Jan 24 15:38:51 rj081 automount[3137]: st_ready(): state = 2
Jan 24 15:38:51 rj081 automount[3292]: handle_child: got pid 25675, sig 
0 (0), stat 0
Jan 24 15:38:51 rj081 automount[3292]: sigchld: exp 25675 finished, 
switching from 2 to 1
Jan 24 15:38:51 rj081 automount[3292]: get_pkt: state 2, next 1
Jan 24 15:38:51 rj081 automount[3292]: st_ready(): state = 2
Jan 24 15:38:51 rj081 automount[3186]: handle_child: got pid 25673, sig 
0 (0), stat 1
Jan 24 15:38:51 rj081 automount[3186]: sig_child: found pending iop pid 
25673: signalled 0 (sig 0), exit status 1
Jan 24 15:38:51 rj081 automount[3186]: send_fail: token=269
Jan 24 15:38:51 rj081 automount[3186]: handle_packet: type = 0
Jan 24 15:38:51 rj081 automount[3186]: handle_packet_missing: token 270, 
name alpha
Jan 24 15:38:51 rj081 automount[3186]: attempting to mount entry /net/alpha
Jan 24 15:38:51 rj081 automount[25677]: lookup(yp): looking up alpha
Jan 24 15:38:51 rj081 automount[25677]: ret = 1
Jan 24 15:38:51 rj081 automount[25677]: lookup(yp): alpha -> 
-fstype=lustre mds1a://mdt1a/alpha
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): expanded entry: 
-fstype=lustre mds1a://mdt1a/alpha
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): 
dequote("fstype=lustre") -> fstype=lustre
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): gathered options: 
fstype=lustre
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): 
dequote("mds1a://mdt1a/alpha") -> mds1a://mdt1a/alpha
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): core of entry: 
options=fstype=lustre, loc=mds1a://mdt1a/alpha
Jan 24 15:38:51 rj081 automount[25677]: parse(sun): mounting root /net, 
mountpoint alpha, what mds1a://mdt1a/alpha, fstype lustre, options
Jan 24 15:38:51 rj081 automount[25677]: do_mount mds1a://mdt1a/alpha 
/net/alpha type lustre options  using module generic
Jan 24 15:38:51 rj081 automount[25677]: mount(generic): calling 
mkdir_path /net/alpha
Jan 24 15:38:51 rj081 automount[25677]: mount(generic): calling mount -t 
lustre mds1a://mdt1a/alpha /net/alpha
Jan 24 15:38:52 rj081 automount[25677]: mount(generic): mounted 
mds1a://mdt1a/alpha type lustre on /net/alpha
Jan 24 15:39:31 rj081 automount[3186]: handle_child: got pid 25677, sig 
0 (0), stat 0
Jan 24 15:39:31 rj081 automount[3186]: sig_child: found pending iop pid 
25677: signalled 0 (sig 0), exit status 0



-- 
Johan van den Dorpe
Systems Administrator, Framestore CFC
020 7106 2441
