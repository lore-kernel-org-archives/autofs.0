From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Unable to mount with autofs-4.1.4: aquire_lock: can't lock
	lock file timed out: /var/lock/autofs
Date: Tue, 18 Oct 2005 13:21:08 +0200
Message-ID: <200510181321.08443.krienke@uni-koblenz.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Hello,

using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4 
kernel module, Kernel2.6.13-15) NFS mounts of user directories fail when using indirect mounts. 
The problem can be reproduced in a certrain setup describes below. Because of this, the description 
is a bit lenghty.

The maps for automount are taken from  NIS. To mount a users directory via NFS eg. /home/krienke on a 
client entries from the NIS-maps auto.home and auto.vol are used.  auto.master is  
configured like this:  
  
/home auto.home         -intr  
/import auto.vol        -intr  
  
In auto.home there is this entry for each user like "krienke":  
  
krienke localhost:/import/user2/krienke  
  
In auto.vol you find another entry to handle the "user2" key starting at /import from above 
(there are more than one nfsservers exporting user1, user2, ... each with about 2000 users):  
  
user2 nfssrv2:/export/user2  
  
nfssrv2 ist one of our NFS servers for home directories. So basically we nfs mount a volume containing 
all the users on this server on /import/user2 on the client and then we mount /home/krienke on 
/import/user2/krienke  on the client (the advantage of this indirect 2 layer mount is that we 
avoid problems with too many mounts for users on one client since bind mounts are used for the 
users home). This mount was (up to 9.3) automatically mounted as a bind mount by automount. 
Up to suse9.3 (using autofs4-4.1.3) this worked without problems and if I replace the suse10 
autofs rpm by the suse9.3 autofs4 rpm it again does work. I can also manually issue the mount 
command logged by automunt 
below (mount -t nfs -s  -o intr nfssrv2:/export/user2 /import/user2) and it works without any problems. 
   
When trying to mount a user like "krienke" saying eg ls ~krienke the following log appears 
in /var/log/messages (autmount is running with -d -v): 
 
Oct 18 12:41:59 rzinstal1 automount[16770]: handle_packet: type = 0 
Oct 18 12:41:59 rzinstal1 automount[16770]: handle_packet_missing: token 49, name krienke 
Oct 18 12:41:59 rzinstal1 automount[16770]: attempting to mount entry /home/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: lookup(yp): looking up krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: ret = 1 
Oct 18 12:41:59 rzinstal1 automount[16791]: lookup(yp): krienke -> localhost:/import/user2/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: parse(sun): expanded entry: localhost:/import/user2/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: parse(sun): gathered options: intr 
Oct 18 12:41:59 rzinstal1 automount[16791]: parse(sun): dequote("localhost:/import/user2/krienke") -> localhost:/import/user2/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: parse(sun): core of entry: options=intr, loc=localhost:/import/user2/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: parse(sun): mounting root /home, mountpoint krienke, what localhost:/import/user2/krienke, fstype nfs, 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(nfs): root=/home name=krienke what=localhost:/import/user2/krienke, fstype=nfs, options=intr 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(nfs): nfs options="intr", nosymlink=0, ro=0 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(nfs): winner = localhost local = 1 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(nfs): from localhost:/import/user2/krienke elected /import/user2/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(nfs): krienke is local, doing bind 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(bind): calling mkdir_path /home/krienke 
Oct 18 12:41:59 rzinstal1 automount[16791]: mount(bind): calling mount --bind -s  -o defaults /import/user2/krienke /home/krienke 
Oct 18 12:41:59 rzinstal1 automount[16772]: handle_packet: type = 0 
Oct 18 12:41:59 rzinstal1 automount[16772]: handle_packet_missing: token 50, name user2 
Oct 18 12:41:59 rzinstal1 automount[16772]: attempting to mount entry /import/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: lookup(yp): looking up user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: ret = 1 
Oct 18 12:41:59 rzinstal1 automount[16793]: lookup(yp): user2 -> nfssrv2:/export/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: parse(sun): expanded entry: nfssrv2:/export/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: parse(sun): gathered options: intr 
Oct 18 12:41:59 rzinstal1 automount[16793]: parse(sun): dequote("nfssrv2:/export/user2") -> nfssrv2:/export/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: parse(sun): core of entry: options=intr, loc=nfssrv2:/export/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: parse(sun): mounting root /import, mountpoint user2, what nfssrv2:/export/user2, fstype nfs, options intr 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): root=/import name=user2 what=nfssrv2:/export/user2, fstype=nfs, options=intr 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): nfs options="intr", nosymlink=0, ro=0 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): winner = nfssrv2 local = 0 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): from nfssrv2:/export/user2 elected nfssrv2:/export/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): calling mkdir_path /import/user2 
Oct 18 12:41:59 rzinstal1 automount[16793]: mount(nfs): calling mount -t nfs -s  -o intr nfssrv2:/export/user2 /import/user2 
Oct 18 12:42:30 rzinstal1 automount[16793]: aquire_lock: can't lock lock file timed out: /var/lock/autofs 
Oct 18 12:42:30 rzinstal1 automount[16793]: mount(nfs): nfs: mount failure nfssrv2:/export/user2 on /import/user2 
Oct 18 12:42:30 rzinstal1 automount[16793]: failed to mount /import/user2 
Oct 18 12:42:30 rzinstal1 automount[16793]: umount_multi: path=/import/user2 incl=1 
Oct 18 12:42:30 rzinstal1 automount[16793]: umount_multi: no mounts found under /import/user2 
Oct 18 12:42:30 rzinstal1 automount[16772]: handle_child: got pid 16793, sig 0 (0), stat 1 
Oct 18 12:42:30 rzinstal1 automount[16772]: sig_child: found pending iop pid 16793: signalled 0 (sig 0), exit status 1 
Oct 18 12:42:30 rzinstal1 automount[16772]: send_fail: token=50 
 
Then after 2 more retries to mount /import/user2 the whole mount fails. 
 
Oct 18 12:44:04 rzinstal1 automount[16798]: aquire_lock: can't lock lock file timed out: /var/lock/autofs 
Oct 18 12:44:04 rzinstal1 automount[16798]: mount(nfs): nfs: mount failure nfssrv2:/export/user2 on /import/user2 
Oct 18 12:44:04 rzinstal1 automount[16798]: failed to mount /import/user2 
Oct 18 12:44:04 rzinstal1 automount[16798]: umount_multi: path=/import/user2 incl=1 
Oct 18 12:44:04 rzinstal1 automount[16798]: umount_multi: no mounts found under /import/user2 
Oct 18 12:44:04 rzinstal1 automount[16772]: handle_child: got pid 16798, sig 0 (0), stat 1 
Oct 18 12:44:04 rzinstal1 automount[16772]: sig_child: found pending iop pid 16798: signalled 0 (sig 0), exit status 1 
Oct 18 12:44:04 rzinstal1 automount[16772]: send_fail: token=54 
Oct 18 12:44:04 rzinstal1 automount[16795]: >> mount: special device /import/user2/krienke does not exist 
Oct 18 12:44:04 rzinstal1 automount[16795]: failed to mount /home/krienke 
Oct 18 12:44:04 rzinstal1 automount[16795]: umount_multi: path=/home/krienke incl=1 
Oct 18 12:44:04 rzinstal1 automount[16795]: umount_multi: no mounts found under /home/krienke 
Oct 18 12:44:04 rzinstal1 automount[16770]: handle_child: got pid 16795, sig 0 (0), stat 1 
Oct 18 12:44:04 rzinstal1 automount[16770]: sig_child: found pending iop pid 16795: signalled 0 (sig 0), exit status 1 
Oct 18 12:44:04 rzinstal1 automount[16770]: send_fail: token=52 


Any idea why or how to fix this?

Thanks
Rainer
-- 
---------------------------------------------------------------------------
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
---------------------------------------------------------------------------
