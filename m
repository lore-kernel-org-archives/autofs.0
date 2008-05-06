From: Stef Bon <stef@bononline.nl>
Subject: Re: Some reload problems.
Date: Tue, 06 May 2008 11:49:16 +0200
Message-ID: <4820299C.7000907@bononline.nl>
References: <481F1623.1050505@bononline.nl>
	<1209999972.2768.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1209999972.2768.8.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Mon, 2008-05-05 at 16:13 +0200, Stef Bon wrote:
>   
>>
>> It's also ok when a line is added. But there are some problems when 
>> stopping.
>> When stopping a session (by logging out), the line in 
>> /var/run/autofs/auto.master is removed and the
>> daemon gets a reload. Now, when there are no other lines here, and there 
>> also no other mountpoints in the main mastermap, the daemon stops.
>>     
>
> You'll need to provide a debug log as well as the explanation, ensure
> you are capturing all the output to syslog.
>
>   
OK, I've added the debug option. Now I show you what happens.

First at boottime the automount daemon is started, with an empty masterfile:

May  6 10:54:46 localhost automount[5773]: Starting automounter version 
5.0.3, master map /etc/autofs/auto.master
May  6 10:54:46 localhost automount[5773]: using kernel protocol version 
5.00
May  6 10:54:46 localhost automount[5773]: lookup_nss_read_master: 
reading master file /etc/autofs/auto.master
May  6 10:54:46 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 10:54:46 localhost automount[5773]: lookup_read_master: 
lookup(file): read entry +/var/run/autofs/auto.master
May  6 10:54:46 localhost automount[5773]: lookup_nss_read_master: 
reading master file /var/run/autofs/auto.master
May  6 10:54:46 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 10:54:46 localhost automount[5773]: no mounts in table
May  6 10:54:46 localhost bootlog:  Starting automount... [  OK  ]

Ok it detects the master file is empty, but it keeps on running.
I can test it with:
[root ~]# /etc/rc.d/init.d/autofs status
automount is running with pid 5773 and map /etc/autofs/auto.master

Then, when a session starts, an entry is added to the 
/var/run/autofs/auto.master file:
KDM runs a script after login of sbon:

/etc/session.d/scripts/start/add_network_mountpoint.sh sbon

This command adds a line to the /var/run/autofs/auto.master file and 
gives the running daemon a reload signal:
[root ~]# cat /var/run/autofs/auto.master
/home/sbon/Global\ Network     /etc/autofs/session/auto.network.sbon -browse

And the logfile gives:


May  6 11:02:40 localhost bootlog:  Reloading automount with map 
/etc/autofs/auto.master.[  OK  ]
May  6 11:02:40 localhost automount[5773]: re-reading master map 
/etc/autofs/auto.master
May  6 11:02:40 localhost automount[5773]: lookup_nss_read_master: 
reading master file /etc/autofs/auto.master
May  6 11:02:40 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 11:02:40 localhost automount[5773]: lookup_read_master: 
lookup(file): read entry +/var/run/autofs/auto.master
May  6 11:02:40 localhost automount[5773]: lookup_nss_read_master: 
reading master file /var/run/autofs/auto.master
May  6 11:02:40 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 11:02:40 localhost automount[5773]: lookup_read_master: 
lookup(file): read entry /home/sbon/Global\ Network
May  6 11:02:40 localhost automount[5773]: master_do_mount: mounting 
/home/sbon/Global Network
May  6 11:02:40 localhost automount[5773]: automount_path_to_fifo: fifo 
name /var/run/autofs.fifo-home-sbon-Global Network
May  6 11:02:40 localhost automount[5773]: lookup_nss_read_map: reading 
map file /etc/autofs/session/auto.network.sbon
May  6 11:02:40 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 11:02:40 localhost automount[5773]: mounted indirect mount on 
/home/sbon/Global Network with timeout 300, freq 75 seconds
May  6 11:02:40 localhost automount[5773]: ghosting enabled

Now checking the contents of /proc/mounts:
[root ~]# cat /proc/mounts
..
..
..
/etc/autofs/session/auto.network.sbon /home/sbon/Global\040Network 
autofs rw,fd=5,pgrp=5773,timeout=300,minproto=5,maxproto=5,indirect 0 0

This is the only autofs related line here.

The networkservices are not yet visible to sbon:

[root ~]# ls -A /home/sbon/Global\ Network

(no output here)
 so there is another script which activates the networks (it needs to be 
run with permissions of the user logging in:

[sbon ~]$ /opt/kde-4.0/env/50activate_networks.sh
: Activating network Windows Network
: Activating network SSH hosts

Now the log file:

May  6 11:13:42 localhost automount[5773]: expire_cleanup: got thid 
3083566000 path /home/sbon/Global Network stat 0
May  6 11:13:42 localhost automount[5773]: expire_cleanup: sigchld: exp 
3083566000 finished, switching from 2 to 1
May  6 11:13:42 localhost automount[5773]: st_ready: st_ready(): state = 
2 path /home/sbon/Global Network
May  6 11:14:46 localhost : Activating network Windows Network.
May  6 11:14:46 localhost automount[5773]: handle_packet: type = 3
May  6 11:14:46 localhost automount[5773]: 
handle_packet_missing_indirect: token 16, name Windows Network, request 
pid 6924
May  6 11:14:46 localhost automount[5773]: attempting to mount entry 
/home/sbon/Global Network/Windows Network
May  6 11:14:46 localhost automount[5773]: lookup_mount: 
lookup(program): looking up Windows Network
May  6 11:14:47 localhost automount[5773]: lookup_mount: 
lookup(program): Windows Network -> 
-fstype=cifs,credentials=/home/sbon/.autofssession/smb/mount.cred  
/BONONLINE/LFS20060812/bononline -rw,ip=192.168.0.2 
://LFS20060812/bononline  /BONONLINE/LFS20060812/ftp -rw,ip=192.168.0.2 
://LFS20060812/ftp  /BONONLINE/LFS20060812/sbon -rw,ip=192.168.0.2 
://LFS20060812/sbon  /BONONLINE/LFS20060812/video 
-rw,ip=192.168.0.2://LFS20060812/video   
/CWWERKGROEP/ROUTER/cwdocumenten -rw,ip=192.168.0.1 
://ROUTER/cwdocumenten  /CWWERKGROEP/ROUTER/public -rw,ip=192.168.0.1 
://ROUTER/public  /CWWERKGROEP/ROUTER/sbon -rw,ip=192.168.0.1 ://ROUTER/sbon


A lot more messages about parse_mapent: gathered options, 
mount_multi-triggers.
Futher in the log file:

May  6 11:14:47 localhost : Activating network SSH hosts.
May  6 11:14:47 localhost automount[5773]: handle_packet: type = 3
May  6 11:14:47 localhost automount[5773]: 
handle_packet_missing_indirect: token 17, name SSH hosts, request pid 7052
May  6 11:14:47 localhost automount[5773]: attempting to mount entry 
/home/sbon/Global Network/SSH hosts
May  6 11:14:47 localhost automount[5773]: lookup_mount: 
lookup(program): looking up SSH hosts
May  6 11:14:47 localhost automount[5773]: lookup_mount: 
lookup(program): SSH hosts -> -fstype=sshfs  /151.1.143.116 
-rw,nodev,nonempty,noatime ://sbon@151.1.143.116:/  /192.168.0.3 
-rw,nodev,nonempty,noatime ://sbon@192.168.0.3:/  /192.168.0.1 
-rw,nodev,nonempty,noatime ://sbon@192.168.0.1:/  /192.168.0.15 
-rw,nodev,nonempty,noatime ://sbon@192.168.0.15:/  /195.243.111.226 
-rw,nodev,nonempty,noatime ://sbon@195.243.111.226:/  /192.168.0.10 
-rw,nodev,nonempty,noatime ://sbon@192.168.0.10:/  /192.168.0.2 
-rw,nodev,nonempty,noatime ://sbon@192.168.0.2:/  
/87.212.7.82-rw,nodev,nonempty,noatime ://sbon@87.212.7.82:/

Also here a lot of messages like mount_autofs_offset, 
mount_multi_triggers, but that's normal I guess.

The networks are now visible:

[sbon ~]$ ls -A ~/Global\ Network
SSH hosts  Windows Network

and I can browse it. When I do not do that, I get messages like:

May  6 11:19:47 localhost automount[5773]: cache_delete_offset_list: 
deleting offset key /home/sbon/Global Network/Windows 
Network/CWWERKGROEP/ROUTER/public
May  6 11:19:47 localhost automount[5773]: cache_delete_offset_list: 
deleting offset key /home/sbon/Global Network/Windows 
Network/CWWERKGROEP/ROUTER/sbon
May  6 11:19:47 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/Windows Network/CWWERKGROEP/ROUTER
May  6 11:19:47 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/Windows Network/CWWERKGROEP
May  6 11:19:47 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/Windows Network/BONONLINE/LFS20060812
May  6 11:19:47 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/Windows Network/BONONLINE
May  6 11:19:47 localhost automount[5773]: expired /home/sbon/Global 
Network/Windows Network

So far so good, this is to be expected, the timeout (5 min) has expired.
But the toplevel directories still exists:

[sbon ~]$ ls -A ~/Global\ Network
SSH hosts  Windows Network

But when I (sbon) logout, another script is run by KDM. It removes the 
line from the /var/run/autofs/auto.master file and gives the running 
daemon a reload signal (HUP):

[root ~]# /etc/session.d/scripts/stop/stop_automount_session.sh sbon
:Reloading the automount daemon.
Reloading automount with map /etc/autofs/auto.master
[root ~]# ps aux | grep automount
root      8186  0.0  0.0   3764   604 pts/1    S+   11:32   0:00 grep 
automount

The /var/run/autofs/auto.master file is indeed empty:

root ~]# ls -al /var/run/autofs/auto.master
-rw-r--r-- 1 root root 0 2008-05-06 11:32 auto.master

The logfile:
May  6 11:32:15 localhost : Reloading the automount daemon.
May  6 11:32:15 localhost bootlog:  Reloading automount with map 
/etc/autofs/auto.master.[  OK  ]
May  6 11:32:15 localhost automount[5773]: re-reading master map 
/etc/autofs/auto.master
May  6 11:32:15 localhost automount[5773]: lookup_nss_read_master: 
reading master file /etc/autofs/auto.master
May  6 11:32:15 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 11:32:15 localhost automount[5773]: lookup_read_master: 
lookup(file): read entry +/var/run/autofs/auto.master
May  6 11:32:15 localhost automount[5773]: lookup_nss_read_master: 
reading master file /var/run/autofs/auto.master
May  6 11:32:15 localhost automount[5773]: parse_init: parse(sun): init 
gathered global options: (null)
May  6 11:32:15 localhost automount[5773]: shutdown_entry: 
/home/sbon/Global Network
May  6 11:32:15 localhost automount[5773]: st_prepare_shutdown: state 1 
path /home/sbon/Global Network
May  6 11:32:15 localhost automount[5773]: expire_proc: exp_proc = 
3080784816 path /home/sbon/Global Network
May  6 11:32:15 localhost automount[5773]: expire_cleanup: got thid 
3080784816 path /home/sbon/Global Network stat 0
May  6 11:32:15 localhost automount[5773]: expire_cleanup: sigchld: exp 
3080784816 finished, switching from 5 to 7
May  6 11:32:15 localhost automount[5773]: umount_multi: path 
/home/sbon/Global Network incl 0
May  6 11:32:15 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/Windows Network
May  6 11:32:15 localhost automount[5773]: rm_unwanted_fn: removing 
directory /home/sbon/Global Network/SSH hosts
May  6 11:32:15 localhost automount[5773]: umounted indirect mount 
/home/sbon/Global Network
May  6 11:32:15 localhost automount[5773]: automount_path_to_fifo: fifo 
name /var/run/autofs.fifo-home-sbon-Global Network
May  6 11:32:15 localhost automount[5773]: shut down path 
/home/sbon/Global Network
May  6 11:32:15 localhost automount[5773]: autofs stopped

So this is what happens.
The messages the init script gives are maybe not very familiar. I've 
written this script myself. But it's sure
it gives the right signal.

Futher I've compiled autofs with the following options:

./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc 
--without-sasl --without-hesiod --enable-force-shutdown

I hope this helps.

Cheers,

Stef Bon
