From: David Meleedy <david.meleedy@analog.com>
Subject: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port usage
	problems
Date: Tue, 11 Jan 2005 16:22:48 -0500
Message-ID: <200501112122.j0BLMmET002446@jetcar.spd.analog.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


Hi Ian & Jeff,
	I am trying to track down an autofs issue that has been
plaguing us.  It seems to be caused by the interaction of autofs version
4 with a Network Appliance server, and cd'ing to /net directories
on the Netapp server.

A similar issue was seen in Analog Devices in Redhat 8, and apparently
the problem was worked around by Dwight Marzolf working with Ian Kent's
help.  So following what Dwight did I have been trying to recreate the fix
for Redhat Enterprise 3 update 3, and so far have not met with success.

THE PROBLEM DESCRIPTION:

Autofs hangs and refuses to mount any directories for a period of time
after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
The only way to clear this is to reboot the client.

Initially we started using the following software (Redhat Enterprise 3 update 
3)
autofs 4.1.3-12
kernel 2.4.21-20
nfs-utils 1.0.6-31EL

WHAT HAS BEEN TRIED SO FAR:

Mike Waychison, after seeing the messages from our log file said,

"These messages are due to starvation for reserved ports (< 1024).
Specifically, the kernel will only use ports < 800.  Currently, the
kernel uses one port per nfs filesystem.  If you mount filesystems very
fast, then you can also run out of reserved ports as the local (mountd
iirc?) will close tcp sessions and each must wait 2 minutes before being
released.

One solution is to try out the patch I posted last week that allows nfs
mounts to share tcp/udp connections:

http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2
"

The problem is we are using a different version of the kernel 2.4,
and his patch was for the 2.6 kernel.  Also, although his patch
might make the number of ports available increase, I think it does
not really solve the problem, it just gives more breathing room.

After talking with Jeff Moyer about the issue, I updated autofs to 
autofs-4.1.3-67.  This was supposed to incorporate a patch that fixes
the port leak problem.

This did not solve the problem, but it did seem to improve things a bit.

After looking at Dwight Marzolf's document on his workaround I found
the following information (this is exactly the same sort of thing we
are seeing too):

"
we quickly found that if you did a cd via /net to one of our Network
Appliance filers (all our other netapp filers worked correctly when
unmounting /net mounts), the port release issue still existed.  In
fact, the mountpoints actively took more ports.  This meant that if you
mounted this filer with /net, your workstation could be rendered
useless in less than 24 hours.  It also became evident that this active
taking of ports by this filer was not limited to just autofs-4.1.3-28
but also earlier versions of autofs  ...  Further
research revealed the ports were being taken at the point of automount
timeout.  When the automounter had declared these mountpoints to be
timed out and ready to be unmounted and attempted to umount them, in
fact, it ended up remounting them, using new ports for the remount ...
"

HOW TO REPRODUCE THE PROBLEM:

Actually in our case we can render a machine useless in just about an
hour or two, and this happens for all of our Netapp filers.  The procedure
to do this is reproducible.

1) You cd to a /net directory on the filer.
2) Leave the shell in that /net directory for about 15 minutes-> 1/2 an hour.
and watch the "BUG" messages in the /var/log/messages file.

3) Log out. (so the automounter tries to unmount everything that was mounted).
4) Log in again, after 30 minutes and by then you won't be about to 
mount anything anymore

You can replace steps 3 and 4 with "init 6".  When the automounter process
is stopped by init, you will see the port messages scroll up the console
screen.

EXAMPLE OF REPRODUCING THE PROBLEM:

codered-51: cd /net/aflac/vol/vol2
( I can't help but wonder if this BUG message that shows up once a minute
is indicative of a problem )

codered-52: tail -f /var/log/messages
Jan 11 15:32:37 codered automount[6214]: attempting to mount entry /net/aflac
Jan 11 15:33:41 codered automount[7915]: BUG: /net/aflac/vol/vol2 already 
mounted
Jan 11 15:34:42 codered automount[8049]: BUG: /net/aflac/vol/vol2 already 
mounted
Jan 11 15:36:42 codered automount[8311]: BUG: /net/aflac/vol/vol2 already 
mounted
Jan 11 15:37:43 codered automount[8441]: BUG: /net/aflac/vol/vol2 already 
mounted
 ... (continues once a minute to print out this bug) ...
codered-53: sudo init 6
(after reboot log in to see error messages)

THE REALLY WEIRD PART:
Now the interesting thing here is that the machine is rebooting, so
there is no program requesting additional mounts, yet here in the log
files you can see that almost every subdirectory of /vol/vol2, /vol/vol3
and /vol/vol3 are attempted to be mounted, even though the only
thing that should be happening is an unmount of the directory aflac:/vol/vol2

jetcar-189: cd /net/aflac/vol/vol3
jetcar-190: ls
ad1983/      cad_archive/ emerald/     layout_old/  ta/          
archive/     design/      is_013std/   lx3/  
jetcar-191: cd ../vol2
jetcar-192: ls
9xcores/         danube/          nwd_layout/      ulc3/
DSPS_Finance/    gpdsp_PLD/       nwd_testmgr/     win2k/
WWM/             gpdsp_marketing/ pc_backups/      
bitpower/        india_mirror/    sh/              
bluetooth/       nile/            spitfire/        
jetcar-194: cd ../vol1
etcar-195: ls
IssueManager/ diablo/       is_013std/    ras/          tigersharc/
admin/        ed/           jordan/       soft/         
archive/      fsp/          nwd_fsp@      teton_lite/   
cpd/          herc_eval/    pe_workspace/ thor/         


codered-54: less /var/log/messages
Jan 11 15:51:14 codered automount[6214]: can't shutdown: filesystem /net still 
busy
Jan 11 15:51:17 codered autofs: automount -USR2 succeeded
Jan 11 15:51:19 codered automount[6214]: can't shutdown: filesystem /net still 
busy
Jan 11 15:51:20 codered autofs: automount -USR2 succeeded
Jan 11 15:51:23 codered autofs: automount -USR2 succeeded
Jan 11 15:51:26 codered autofs: automount -USR2 succeeded
Jan 11 15:51:26 codered automount[6214]: can't shutdown: filesystem /net still 
busy
Jan 11 15:51:28 codered automount[14708]: >> mount: wrong fs type, bad option, 
bad superblock on aflac:/vol/vol2/spitfire,
Jan 11 15:51:28 codered automount[14708]: >>        or too many mounted file 
sys
tems
Jan 11 15:51:28 codered automount[14708]: mount(nfs): nfs: mount failure 
aflac:/
vol/vol2/spitfire on /net/aflac/vol/vol2/spitfire
Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
Jan 11 15:51:28 codered kernel: nfs_read_super: get root inode failed
Jan 11 15:51:28 codered kernel: nfs warning: mount version older than kernel
Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
Jan 11 15:51:28 codered kernel: nfs_read_super: get root inode failed
Jan 11 15:51:28 codered automount[14708]: >> mount: wrong fs type, bad option, 
bad superblock on aflac:/vol/vol2/ulc3,
Jan 11 15:51:28 codered automount[14708]: >>        or too many mounted file 
systems
Jan 11 15:51:28 codered automount[14708]: mount(nfs): nfs: mount failure 
aflac:/vol/vol2/ulc3 on /net/aflac/vol/vol2/ulc3
...
This same pattern of error messages repeats for (in this order)
aflac:/vol/vol2/win2k
aflac:/vol/vol3/ad1983
aflac:/vol/vol3/archive
aflac:/vol/vol3/cad_archive
aflac:/vol/vol3/design
aflac:/vol/vol3/emerald
aflac:/vol/vol3
aflac:/vol/vol3/is_013std
aflac:/vol/vol3/layout_old
aflac:/vol/vol3/lx3
aflac:/vol/vol3/ta
aflac:/vol/vol2/DSPS_Finance
aflac:/vol/vol2
aflac:/vol/vol2/gpdsp_marketing
aflac:/vol/vol2/gpdsp_PLD
aflac:/vol/vol2/india_mirror
aflac:/vol/vol2/nile
aflac:/vol/vol2/nwd_layout
aflac:/vol/vol2/nwd_testmgr
aflac:/vol/vol2/pc_backups
aflac:/vol/vol2/sh

aflac:/vol/vol2/spitfire (repeats the whole thing again)
eventually gets to vol1:
...
aflac:/vol/vol3/ta
aflac:/vol/vol1/pe_workspace
aflac:/vol/vol1/ras
aflac:/vol/vol1/soft
aflac:/vol/vol1/teton_lite
aflac:/vol/vol1/thor
aflac:/vol/vol1/tigersharc
aflac:/vol/vol2/9xcores
aflac:/vol/vol2/bitpower
aflac:/vol/vol2/bluetooth
aflac:/vol/vol2/danube
aflac:/vol/vol2/DSPS_Finance
... (repeats the whole thing again)...

Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol3/ta 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol3/lx3 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol3/layout_old
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol3/is_013std
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/win2k
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/ulc3
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/spitfire
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol2/sh 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/pc_backups
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/nwd_testmgr
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/nwd_layout
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/nile
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/india_mirror
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/gpdsp_marketing
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol2/gpdsp_PLD
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/tigersharc
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/thor
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/teton_lite
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/soft
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol1/ras 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/pe_workspace
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/jordan
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/is_013std
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/herc_eval
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol1/fsp 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: 
/net/aflac/vol/vol1/IssueManager
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol/vol0 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:37 codered automount[15971]: rm_unwanted: /net/aflac 
Jan 11 15:51:37 codered automount[15971]: expired /net/aflac
Jan 11 15:51:37 codered automount[15974]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:37 codered automount[15974]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:37 codered automount[15974]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:37 codered automount[15974]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:37 codered automount[15974]: rm_unwanted: /net/aflac 
Jan 11 15:51:37 codered automount[15974]: expired /net/aflac
Jan 11 15:51:37 codered automount[15975]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:37 codered automount[15975]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:37 codered automount[15975]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:37 codered automount[15975]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:37 codered automount[15975]: rm_unwanted: /net/aflac 
Jan 11 15:51:37 codered automount[15975]: expired /net/aflac
Jan 11 15:51:37 codered automount[15976]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:37 codered automount[15976]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:37 codered automount[15976]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:37 codered automount[15976]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:37 codered automount[15976]: rm_unwanted: /net/aflac 
Jan 11 15:51:37 codered automount[15976]: expired /net/aflac
Jan 11 15:51:37 codered automount[15977]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:37 codered automount[15977]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:37 codered automount[15977]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:37 codered automount[15977]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:37 codered automount[15977]: rm_unwanted: /net/aflac 
Jan 11 15:51:37 codered automount[15977]: expired /net/aflac
Jan 11 15:51:38 codered automount[15978]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:38 codered automount[15978]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:38 codered automount[15978]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:38 codered automount[15978]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:38 codered automount[15978]: rm_unwanted: /net/aflac 
Jan 11 15:51:38 codered automount[15978]: expired /net/aflac
Jan 11 15:51:38 codered autofs: automount -USR2 succeeded
Jan 11 15:51:38 codered automount[15986]: rm_unwanted: /net/aflac/vol/vol3 
Jan 11 15:51:38 codered automount[15986]: rm_unwanted: /net/aflac/vol/vol2 
Jan 11 15:51:38 codered automount[15986]: rm_unwanted: /net/aflac/vol/vol1 
Jan 11 15:51:38 codered automount[15986]: rm_unwanted: /net/aflac/vol 
Jan 11 15:51:38 codered automount[15986]: rm_unwanted: /net/aflac 
Jan 11 15:51:38 codered automount[15986]: expired /net/aflac
Jan 11 15:51:39 codered automount[6214]: can't shutdown: filesystem /net still 
busy
.... (keeps repeating) ....
Jan 11 15:51:45 codered automount[6214]: can't shutdown: filesystem /net still 
busy
Jan 11 15:51:47 codered autofs: automount shutdown failed



HOW IT WAS FIXED IN REDHAT 8:

Dwight had implemented his fix in 3 steps for Redhat 8:
1) He updated his autofs to autofs-4.1.3-28 which had the port leak fix
2) He patched his kernel with the autofs4-2.4.20-20040508.patch
(is some equivalent patch needed for Redhat 3 Enterprise 3 which uses 
kernel 2.4.21-20 ?
3) He changed the way he exported filesystems from the Netapp:

"The last issue was the matter of how /vol/vol0 is exported from a
Network Appliance filer.  We found that the following exports broke
autofs4:

/vol/vol0     -root=node1:node2:node3:node4
/vol/vol0     -rw,root=node1:node2:node3
/vol/vol0     -anon=0

The export syntax that worked was:

/vol/vol0       -rw=node1:node2,root=node1,node2
"

WHAT HAPPENED WHEN I TRIED THE REDHAT 8 WORKAROUND:

Now when I tried to do something similar, I found that if you weren't
on node1 or node2, the filesystem was read-only, so I had to do this:

/vol/vol1	-rw=node1:node2,root=node1,node2
/vol/vol1/foo1	-root=node1:node2
/vol/vol1/foo2  -root=node1:node2

This way if you cd /net/filer/vol/vol1 it was read-only for most machines
but if you cd'd to /net/filer/vol/vol1/foo1 it was read-write.  

So using that Netapp export workaround that fixed the Redhat 8 autofs4 problem,
plus using autofs-4.1.3-67 has not yet solved the problem yet for our
Redhat Enterprise 3 clients.

CONCLUSION:

I hope this is enough info to track down this problem.  It appears
as though the interaction of using /net with a Netapp is causing
spurious mounts, and unmounting is not working.  I will assist with
any patch tests that you require, so let me know, and I will be able
to verify any fixes.

Thanks,

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
