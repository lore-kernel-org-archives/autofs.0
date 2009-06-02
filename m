From: Stef Bon <stef@bononline.nl>
Subject: again: automounters stops after reload signal
Date: Tue, 02 Jun 2009 14:33:18 +0200
Message-ID: <4A251C0E.7020908@bononline.nl>
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

Hello,

again I'm having trouble with reloading the automounter.

After removing an usb device, the map for local devices is corrected: 
the line for this device is removed.
Then, a reload signal to the automounter should make this effective.

in detail:

my auto.master looks like:

/mnt/sd /etc/autofs/auto.sd --timeout=50

+/var/run/autofs/auto.master


before removing the usb device:


/var/run/autofs/auto.master:

/home/sbon/Connections/Devices   
/var/run/autofs/session/auto.local.map.sbon --ghost --timeout=0
/home/sbon/Connections/Network   
/var/run/autofs/session/auto.network.map.sbon --ghost
/root/Connections/Network   
/var/run/autofs/session/auto.network.map.root --ghost

/var/run/autofs/session/auto.local.map.sbon:

"USB Flash Memory" -fstype=auto :/dev/sdb1

Now after removing, the scripts first unmount /dev/sdb1, then remove 
this line from the mapfile, then correct the auto.master and the do a 
reload:

after removing the usb device:

/var/run/autofs/auto.master:

/home/sbon/Connections/Network   
/var/run/autofs/session/auto.network.map.sbon --ghost
/root/Connections/Network   
/var/run/autofs/session/auto.network.map.root --ghost

the /var/run/autofs/session/auto.local.map.sbon file is empty.

The reload signal makes the automounter stop. I've applied al the latest 
patches.

Stef Bon

logfile:

2009-06-02T13:46:37.670526+02:00 lfs20080510 : Reloading the automounter.
2009-06-02T13:46:37.681826+02:00 lfs20080510 automount[14339]: 
re-reading master map /etc/autofs/auto.master
2009-06-02T13:46:37.681877+02:00 lfs20080510 automount[14339]: 
lookup_nss_read_master: reading master file /etc/autofs/auto.master
2009-06-02T13:46:37.681929+02:00 lfs20080510 automount[14339]: 
parse_init: parse(sun): init gathered global options: (null)      
2009-06-02T13:46:37.682002+02:00 lfs20080510 automount[14339]: 
lookup_read_master: lookup(file): read entry /mnt/sd              
2009-06-02T13:46:37.682069+02:00 lfs20080510 automount[14339]: 
lookup_read_master: lookup(file): read entry +/var/run/autofs/auto.master
2009-06-02T13:46:37.682100+02:00 lfs20080510 automount[14339]: 
lookup_nss_read_master: reading master file /var/run/autofs/auto.master 
2009-06-02T13:46:37.682138+02:00 lfs20080510 automount[14339]: 
parse_init: parse(sun): init gathered global options: (null)            
2009-06-02T13:46:37.682180+02:00 lfs20080510 automount[14339]: 
lookup_read_master: lookup(file): read entry /home/sbon/Connections/Network
2009-06-02T13:46:37.682234+02:00 lfs20080510 automount[14339]: 
lookup_read_master: lookup(file): read entry /root/Connections/Network    
2009-06-02T13:46:37.682314+02:00 lfs20080510 automount[14339]: 
st_readmap: state 1 path /home/sbon/Connections/Network                   
2009-06-02T13:46:37.682360+02:00 lfs20080510 automount[14339]: 
re-reading map for /home/sbon/Connections/Network                         
2009-06-02T13:46:37.682364+02:00 lfs20080510 automount[14339]: 
st_readmap: state 1 path /mnt/sd                                          
2009-06-02T13:46:37.682368+02:00 lfs20080510 automount[14339]: 
re-reading map for /mnt/sd                                                
2009-06-02T13:46:37.682372+02:00 lfs20080510 automount[14339]: 
st_prepare_shutdown: state 1 path /home/sbon/Connections/Devices          
2009-06-02T13:46:37.682429+02:00 lfs20080510 automount[14339]: 
lookup_nss_read_map: reading map file 
/var/run/autofs/session/auto.network.map.sbon
2009-06-02T13:46:37.682455+02:00 lfs20080510 automount[14339]: 
expire_proc: exp_proc = 3058047888 path 
/home/sbon/Connections/Devices            
2009-06-02T13:46:37.682508+02:00 lfs20080510 automount[14339]: 
st_readmap: state 1 path 
/root/Connections/Network                                
2009-06-02T13:46:37.682716+02:00 lfs20080510 automount[14339]: 
parse_init: parse(sun): init gathered global options: 
(null)                      
2009-06-02T13:46:37.682876+02:00 lfs20080510 automount[14339]: 
lookup_nss_read_map: reading map file 
/etc/autofs/auto.sd                         
2009-06-02T13:46:37.682922+02:00 lfs20080510 automount[14339]: 
re-reading map for 
/root/Connections/Network                                      
2009-06-02T13:46:37.682974+02:00 lfs20080510 automount[14339]: 
parse_init: parse(sun): init gathered global options: 
(null)                      
2009-06-02T13:46:37.682979+02:00 lfs20080510 automount[14339]: 
lookup_nss_read_map: reading map file 
/var/run/autofs/session/auto.network.map.root
2009-06-02T13:46:37.682998+02:00 lfs20080510 automount[14339]: 
parse_init: parse(sun): init gathered global options: 
(null)                      
2009-06-02T13:46:37.683065+02:00 lfs20080510 automount[14339]: st_ready: 
st_ready(): state = 4 path /mnt/sd                                      
2009-06-02T13:46:37.683070+02:00 lfs20080510 automount[14339]: 
expire_cleanup: got thid 3058047888 path /home/sbon/Connections/Devices 
stat 0    
2009-06-02T13:46:37.683074+02:00 lfs20080510 automount[14339]: 
expire_cleanup: sigchld: exp 3058047888 finished, switching from 5 to 
7           
2009-06-02T13:46:37.683078+02:00 lfs20080510 automount[14339]: 
st_shutdown: state 5 path 
/home/sbon/Connections/Devices                          
2009-06-02T13:46:37.683149+02:00 lfs20080510 automount[14339]: st_ready: 
st_ready(): state = 4 path /root/Connections/Network                    
2009-06-02T13:46:37.683199+02:00 lfs20080510 automount[14339]: st_ready: 
st_ready(): state = 4 path /home/sbon/Connections/Network               
2009-06-02T13:46:37.883206+02:00 lfs20080510 automount[14339]: 
umount_multi: path /home/sbon/Connections/Devices incl 
0                          
2009-06-02T13:46:37.883339+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory 
/home/sbon/Connections/Devices/USB_Flash_Memory
2009-06-02T13:46:37.883397+02:00 lfs20080510 automount[14339]: umounted 
indirect mount /home/sbon/Connections/Devices                            
2009-06-02T13:46:37.883431+02:00 lfs20080510 automount[14339]: 
automount_path_to_fifo: fifo name 
/var/run/autofs.fifo-home-sbon-Connections-Devices
2009-06-02T13:46:37.883479+02:00 lfs20080510 automount[14339]: shut down 
path /home/sbon/Connections/Devices                                      
2009-06-02T13:46:37.883587+02:00 lfs20080510 automount[14339]: 
do_notify_state: signal 
15                                                         
2009-06-02T13:46:37.883627+02:00 lfs20080510 automount[14339]: 
master_notify_state_change: sig 15 switching /mnt/sd from 1 to 
5                   
2009-06-02T13:46:37.883663+02:00 lfs20080510 automount[14339]: 
st_prepare_shutdown: state 1 path /mnt/sd
2009-06-02T13:46:37.883702+02:00 lfs20080510 automount[14339]: 
expire_proc: exp_proc = 3045063568 path /mnt/sd
2009-06-02T13:46:37.883818+02:00 lfs20080510 automount[14339]: 
master_notify_state_change: sig 15 switching 
/home/sbon/Connections/Network from 1 to 5
2009-06-02T13:46:37.883852+02:00 lfs20080510 automount[14339]: 
expire_cleanup: got thid 3045063568 path /mnt/sd stat 0
2009-06-02T13:46:37.883883+02:00 lfs20080510 automount[14339]: 
expire_cleanup: sigchld: exp 3045063568 finished, switching from 5 to 7
2009-06-02T13:46:37.883912+02:00 lfs20080510 automount[14339]: 
st_shutdown: state 5 path /mnt/sd
2009-06-02T13:46:37.883954+02:00 lfs20080510 automount[14339]: 
master_notify_state_change: sig 15 switching /root/Connections/Network 
from 1 to 5
2009-06-02T13:46:37.883995+02:00 lfs20080510 automount[14339]: 
st_prepare_shutdown: state 1 path /root/Connections/Network
2009-06-02T13:46:37.884035+02:00 lfs20080510 automount[14339]: 
expire_proc: exp_proc = 3055942544 path /root/Connections/Network
2009-06-02T13:46:37.884125+02:00 lfs20080510 automount[14339]: 
st_prepare_shutdown: state 1 path /home/sbon/Connections/Network
2009-06-02T13:46:37.884160+02:00 lfs20080510 automount[14339]: 
expire_proc: exp_proc = 3045063568 path /home/sbon/Connections/Network
2009-06-02T13:46:37.884248+02:00 lfs20080510 automount[14339]: 
expire_cleanup: got thid 3055942544 path /root/Connections/Network stat 0
2009-06-02T13:46:37.884280+02:00 lfs20080510 automount[14339]: 
expire_cleanup: sigchld: exp 3055942544 finished, switching from 5 to 7
2009-06-02T13:46:37.884309+02:00 lfs20080510 automount[14339]: 
st_shutdown: state 5 path /root/Connections/Network
2009-06-02T13:46:37.884351+02:00 lfs20080510 automount[14339]: 
expire_cleanup: got thid 3045063568 path /home/sbon/Connections/Network 
stat 0
2009-06-02T13:46:37.884381+02:00 lfs20080510 automount[14339]: 
expire_cleanup: sigchld: exp 3045063568 finished, switching from 5 to 7
2009-06-02T13:46:37.884410+02:00 lfs20080510 automount[14339]: 
st_shutdown: state 5 path /home/sbon/Connections/Network
2009-06-02T13:46:38.084061+02:00 lfs20080510 automount[14339]: 
umount_multi: path /mnt/sd incl 0
2009-06-02T13:46:38.084168+02:00 lfs20080510 automount[14339]: umounted 
indirect mount /mnt/sd
2009-06-02T13:46:38.084405+02:00 lfs20080510 automount[14339]: 
automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-sd
2009-06-02T13:46:38.084455+02:00 lfs20080510 automount[14339]: shut down 
path /mnt/sd
2009-06-02T13:46:38.284446+02:00 lfs20080510 automount[14339]: 
umount_multi: path /root/Connections/Network incl 0
2009-06-02T13:46:38.284552+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory /root/Connections/Network/SSH access
2009-06-02T13:46:38.284597+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory /root/Connections/Network/FTP
2009-06-02T13:46:38.284647+02:00 lfs20080510 automount[14339]: umounted 
indirect mount /root/Connections/Network
2009-06-02T13:46:38.284855+02:00 lfs20080510 automount[14339]: 
automount_path_to_fifo: fifo name 
/var/run/autofs.fifo-root-Connections-Network
2009-06-02T13:46:38.284901+02:00 lfs20080510 automount[14339]: shut down 
path /root/Connections/Network
2009-06-02T13:46:38.484935+02:00 lfs20080510 automount[14339]: 
umount_multi: path /home/sbon/Connections/Network incl 0
2009-06-02T13:46:38.485036+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory 
/home/sbon/Connections/Network/Windows Network
2009-06-02T13:46:38.485082+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory /home/sbon/Connections/Network/SSH access
2009-06-02T13:46:38.485124+02:00 lfs20080510 automount[14339]: 
rm_unwanted_fn: removing directory /home/sbon/Connections/Network/FTP
2009-06-02T13:46:38.485173+02:00 lfs20080510 automount[14339]: umounted 
indirect mount /home/sbon/Connections/Network
2009-06-02T13:46:38.485368+02:00 lfs20080510 automount[14339]: 
automount_path_to_fifo: fifo name 
/var/run/autofs.fifo-home-sbon-Connections-Network
2009-06-02T13:46:38.485413+02:00 lfs20080510 automount[14339]: shut down 
path /home/sbon/Connections/Network
2009-06-02T13:46:38.485532+02:00 lfs20080510 automount[14339]: autofs 
stopped
