From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: AutoFS5
Date: Tue, 14 Aug 2007 14:35:23 -0500
Message-ID: <46C203FB.5080103@cs.ou.edu>
References: <46C2005D.1090907@cs.ou.edu>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46C2005D.1090907@cs.ou.edu>
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

Jim Summers wrote:
> Hello All,
> 
> Just hit a hiccup with autofs5.  Everything was going along fine and then had 
> a user call and say they could not get their home on a machine.  I did some 
> quick checking and some mounts were working and others not.  below is a bit of 
> the debug log and some other info.  the user, gerardo is the one who called 
> me.  entries in the debug log for him are the same as the tmac user.  in that 
> it get his ldap info tries to mount but then says it is already mounted and 
> then fails????
> 
> client machine is FC6 hand compiled autofs version:
> autofs-5.0.1-20
> autofs-debuginfo-5.0.1-20

the rpms were actually built on a FC7 machine and then installed here.

thanks

> with a patch from Ian.
> 
> Yum still isn't pulling the patched one in for me.
> 
> ==============================
> 
> [root@saturn ~]# ls /home
> amarack  granville
> 
> 
> [root@saturn ~]# who
> amarack  pts/0        2007-08-13 11:27 (pluto.it.ou.edu)
> root     pts/5        2007-08-13 14:49 (redear.it.ou.edu)
> gerardo  pts/2        2007-08-14 13:26 (dave.it.ou.edu)
> root     pts/3        2007-08-14 13:44 (redear.it.ou.edu)
> 
> [root@saturn ~]# su - tmac
> su: warning: cannot change directory to /home/tmac: No such file or directory
> 
> sun_mount: parse(sun): mounting root /home, mountpoint tmac, what 
> topdawg:/raid/ds9/tmac, fstype nfs, options 
> rw,actimeo=60,rsize=32768,wsize=32768,nocto
> Aug 14 14:02:10 saturn automount[2743]: mount_mount: mount(nfs): root=/home 
> name=tmac what=topdawg:/raid/ds9/tmac, fstype=nfs, 
> options=rw,actimeo=60,rsize=32768,wsize=32768,nocto
> Aug 14 14:02:10 saturn automount[2743]: mount_mount: mount(nfs): nfs 
> options="rw,actimeo=60,rsize=32768,wsize=32768,nocto", nosymlink=0, ro=0
> Aug 14 14:02:10 saturn automount[2743]: mount_mount: mount(nfs): calling 
> mkdir_path /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: mount_mount: mount(nfs): calling mount 
> -t nfs -s -o rw,actimeo=60,rsize=32768,wsize=32768,nocto 
> topdawg:/raid/ds9/tmac /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: >> mount.nfs: /home/tmac is already 
> mounted or busy
> Aug 14 14:02:10 saturn automount[2743]: mount(nfs): nfs: mount failure 
> topdawg:/raid/ds9/tmac on /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: send_fail: token = 284
> Aug 14 14:02:10 saturn automount[2743]: failed to mount /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: handle_packet: type = 3
> Aug 14 14:02:10 saturn automount[2743]: handle_packet_missing_indirect: token 
> 285, name tmac, request pid 21166
> Aug 14 14:02:10 saturn automount[2743]: attempting to mount entry /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: lookup_mount: lookup(ldap): looking up 
> tmac
> Aug 14 14:02:10 saturn automount[2743]: send_fail: token = 285
> Aug 14 14:02:10 saturn automount[2743]: failed to mount /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: handle_packet: type = 3
> Aug 14 14:02:10 saturn automount[2743]: handle_packet_missing_indirect: token 
> 286, name tmac, request pid 21166
> Aug 14 14:02:10 saturn automount[2743]: attempting to mount entry /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: lookup_mount: lookup(ldap): looking up 
> tmac
> Aug 14 14:02:10 saturn automount[2743]: send_fail: token = 286
> Aug 14 14:02:10 saturn automount[2743]: failed to mount /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: handle_packet: type = 3
> Aug 14 14:02:10 saturn automount[2743]: handle_packet_missing_indirect: token 
> 287, name tmac, request pid 21166
> Aug 14 14:02:10 saturn automount[2743]: attempting to mount entry /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: lookup_mount: lookup(ldap): looking up 
> tmac
> Aug 14 14:02:10 saturn automount[2743]: send_fail: token = 287
> Aug 14 14:02:10 saturn automount[2743]: failed to mount /home/tmac
> Aug 14 14:02:10 saturn automount[2743]: handle_packet: type = 3
> ===========
> 
> ideas /  suggestions??
> 
> tia
> 

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
