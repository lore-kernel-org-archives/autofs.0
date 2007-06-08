From: Jeff Weber <jweber@amsuper.com>
Subject: unmount immediately followed by remount
Date: Fri, 8 Jun 2007 14:29:02 -0500
Message-ID: <200706081429.02284.jweber@amsuper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

I have 2 WinXP servers, I am automounting using smbs.  For one server, the 
automounter unmounts the smbfs after inactivity as expected.  For the other 
server, supermad2, the automounter expires and unmounts the 4 shares after 
approx the 60sec timeout, as expected.  However, the shares are then 
immediately remounted.  Thus, the shares from the server are effectively 
continuously mounted.  Here's some sample automount debug output:

Jun  8 14:09:36 quetzal automount[31118]: handle_packet: type = 2
Jun  8 14:09:36 quetzal automount[31118]: handle_packet_expire_multi: token 
297,
 name supermad2
Jun  8 14:09:36 quetzal automount[31651]: expiring path /smb/supermad2
Jun  8 14:09:36 quetzal automount[31651]: umount_multi: path=/smb/supermad2 
incl
=1
Jun  8 14:09:36 quetzal automount[31651]: umount_multi: unmounting 
dir=/smb/supermad2/TRANSFER
Jun  8 14:09:36 quetzal automount[31651]: umount_multi: unmounting 
dir=/smb/supermad2/MDUsers
Jun  8 14:09:36 quetzal automount[31651]: umount_multi: unmounting 
dir=/smb/supermad2/CAD
Jun  8 14:09:36 quetzal automount[31651]: umount_multi: unmounting 
dir=/smb/supermad2/ENG
Jun  8 14:09:36 quetzal automount[31651]: rm_unwanted: /smb/supermad2/TRANSFER
Jun  8 14:09:36 quetzal automount[31651]: rm_unwanted: /smb/supermad2/MDUsers
Jun  8 14:09:36 quetzal automount[31651]: rm_unwanted: /smb/supermad2/ENG
Jun  8 14:09:36 quetzal automount[31651]: rm_unwanted: /smb/supermad2/CAD
Jun  8 14:09:36 quetzal automount[31651]: expired /smb/supermad2
Jun  8 14:09:36 quetzal automount[31118]: handle_child: got pid 31651, sig 0 
(0)
, stat 0
Jun  8 14:09:36 quetzal automount[31118]: sig_child: found pending iop pid 
31651
: signalled 0 (sig 0), exit status 0
Jun  8 14:09:36 quetzal automount[31118]: send_ready: token=297
Jun  8 14:09:36 quetzal automount[31118]: handle_packet: type = 0
Jun  8 14:09:36 quetzal automount[31118]: handle_packet_missing: token 298, 
name
 supermad2
Jun  8 14:09:36 quetzal automount[31118]: attempting to mount 
entry /smb/supermad2

lsof and fuser show the mounted filesystems are not busy.  I would think if 
the filesystems were busy, they would not be unmounted.  I can't imagine why 
the automounter would cycle with mount, unmount, mount, ...
with effectively zero unmounted time.

my config:
SuSE 10.1
Linux kernel 2.6.16.27-0.9-default
Linux automount version 4.1.4

	thanks,
	Jeff
-- 
Jeff Weber
American Superconductor Corp.
