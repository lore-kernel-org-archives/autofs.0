From: raven@themaw.net
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Wed, 12 Jan 2005 22:50:22 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501122158560.8199@donald.themaw.net>
References: <200501112122.j0BLMmET002446@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200501112122.j0BLMmET002446@jetcar.spd.analog.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

On Tue, 11 Jan 2005, David Meleedy wrote:

>
> Hi Ian & Jeff,
> 	I am trying to track down an autofs issue that has been
> plaguing us.  It seems to be caused by the interaction of autofs version
> 4 with a Network Appliance server, and cd'ing to /net directories
> on the Netapp server.
>
> A similar issue was seen in Analog Devices in Redhat 8, and apparently
> the problem was worked around by Dwight Marzolf working with Ian Kent's
> help.  So following what Dwight did I have been trying to recreate the fix
> for Redhat Enterprise 3 update 3, and so far have not met with success.
>
> THE PROBLEM DESCRIPTION:
>
> Autofs hangs and refuses to mount any directories for a period of time
> after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
> The only way to clear this is to reboot the client.

OK.

This is interesting to me as your description below indicates that autofs 
is poorly behaved in this hostile evironment (aka. it's not dealing with 
this unusual situation at all well).

Also I'd like to add I've been seeing these symptoms in testing my new 
version on FC with a good number of entries in a master map (ie. >50).

It was clear from a "netstat --inet" that mount was causing several 
connections for each mount attempt. autofs, in this case, doesn't do 
any probing or opening of connections, it just calls mount.

This, and Mikes' comments regarding RPC transport multiplexing, has caused 
me to dig out a patch that I worked on some time ago. It was originally 
written by the NFS maintainer but never completed or tested.

Unfortuneately, I gave up on it when I tried to merge it into a RedHat 
kernel. The patches that had been appled to the RH kernel made it very 
difficult to apply, largely because my understanding of the RPC subsystem 
is just not good enough.

The patch that I worked on is very different to the one Mike proposed but 
achieves the same thing. There are other obstacles to having an RPC 
multiplexing patch accepted as well, but, maybe later.

So there are some options here.

>
> Initially we started using the following software (Redhat Enterprise 3 update
> 3)
> autofs 4.1.3-12
> kernel 2.4.21-20
> nfs-utils 1.0.6-31EL

I don't have access to these kernel sources.
That will be a problem as I don't know what autofs4 patches have been 
applied. Jeff?

You really should add util-linux to the list of packages to consider in 
the investigation. It may contain a patch which probes NFS servers and 
opens a number of connections for each mount.

>
> WHAT HAS BEEN TRIED SO FAR:
>
> Mike Waychison, after seeing the messages from our log file said,
>
> "These messages are due to starvation for reserved ports (< 1024).
> Specifically, the kernel will only use ports < 800.  Currently, the
> kernel uses one port per nfs filesystem.  If you mount filesystems very
> fast, then you can also run out of reserved ports as the local (mountd
> iirc?) will close tcp sessions and each must wait 2 minutes before being
> released.
>
> One solution is to try out the patch I posted last week that allows nfs
> mounts to share tcp/udp connections:
>
> http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2
> "
>
> The problem is we are using a different version of the kernel 2.4,
> and his patch was for the 2.6 kernel.  Also, although his patch
> might make the number of ports available increase, I think it does
> not really solve the problem, it just gives more breathing room.

I'm not sure about that.

The multiplexing of the RPC transport would probably provide a solid 
solution to your problem by the sound of things. The patches I mentioned 
above were done against 2.4.22 and 2.6.0.

Problem here is that to get a working patch will probably take a while, so 
we probably need a workaround in the mean time.

>
> After talking with Jeff Moyer about the issue, I updated autofs to
> autofs-4.1.3-67.  This was supposed to incorporate a patch that fixes
> the port leak problem.

Certainly a bug, but not the heart of your problem I'm afraid.

>
> This did not solve the problem, but it did seem to improve things a bit.
>
> After looking at Dwight Marzolf's document on his workaround I found
> the following information (this is exactly the same sort of thing we
> are seeing too):
>
> "
> we quickly found that if you did a cd via /net to one of our Network
> Appliance filers (all our other netapp filers worked correctly when
> unmounting /net mounts), the port release issue still existed.  In
> fact, the mountpoints actively took more ports.  This meant that if you
> mounted this filer with /net, your workstation could be rendered
> useless in less than 24 hours.  It also became evident that this active
> taking of ports by this filer was not limited to just autofs-4.1.3-28
> but also earlier versions of autofs  ...  Further
> research revealed the ports were being taken at the point of automount
> timeout.  When the automounter had declared these mountpoints to be
> timed out and ready to be unmounted and attempted to umount them, in
> fact, it ended up remounting them, using new ports for the remount ...
> "

Do you have any messages on in the log on the server side like:

Jan 10 22:01:36 budgie-wl rpc.mountd: refused unmount request from 
raven-wl.themaw.net for /usr/local/sbin (/usr/local/sbin): illegal port 
36233

This indicates that the client has been patched to use non-priveledged 
ports to increase the number of available ports but the NFS server has 
not.

Just wondering?

>
> HOW TO REPRODUCE THE PROBLEM:
>
> Actually in our case we can render a machine useless in just about an
> hour or two, and this happens for all of our Netapp filers.  The procedure
> to do this is reproducible.
>
> 1) You cd to a /net directory on the filer.
> 2) Leave the shell in that /net directory for about 15 minutes-> 1/2 an hour.
> and watch the "BUG" messages in the /var/log/messages file.
>
> 3) Log out. (so the automounter tries to unmount everything that was mounted).
> 4) Log in again, after 30 minutes and by then you won't be about to
> mount anything anymore
>
> You can replace steps 3 and 4 with "init 6".  When the automounter process
> is stopped by init, you will see the port messages scroll up the console
> screen.
>
> EXAMPLE OF REPRODUCING THE PROBLEM:
>
> codered-51: cd /net/aflac/vol/vol2
> ( I can't help but wonder if this BUG message that shows up once a minute
> is indicative of a problem )
>
> codered-52: tail -f /var/log/messages
> Jan 11 15:32:37 codered automount[6214]: attempting to mount entry /net/aflac
> Jan 11 15:33:41 codered automount[7915]: BUG: /net/aflac/vol/vol2 already
> mounted
> Jan 11 15:34:42 codered automount[8049]: BUG: /net/aflac/vol/vol2 already
> mounted
> Jan 11 15:36:42 codered automount[8311]: BUG: /net/aflac/vol/vol2 already
> mounted
> Jan 11 15:37:43 codered automount[8441]: BUG: /net/aflac/vol/vol2 already
> mounted

Seen that lately. Definutely want to get to the bottom of this.

I don't yet understand why autofs is getting requests to mount an already 
mounted file system. Even in a hostile situation autofs needs to deal 
with this properly.

In the past I observed that this might have been somehow related to 
corruption in /etc/mtab.

> ... (continues once a minute to print out this bug) ...
> codered-53: sudo init 6
> (after reboot log in to see error messages)
>
> THE REALLY WEIRD PART:
> Now the interesting thing here is that the machine is rebooting, so
> there is no program requesting additional mounts, yet here in the log
> files you can see that almost every subdirectory of /vol/vol2, /vol/vol3
> and /vol/vol3 are attempted to be mounted, even though the only
> thing that should be happening is an unmount of the directory aflac:/vol/vol2
>
> jetcar-189: cd /net/aflac/vol/vol3
> jetcar-190: ls
> ad1983/      cad_archive/ emerald/     layout_old/  ta/
> archive/     design/      is_013std/   lx3/
> jetcar-191: cd ../vol2
> jetcar-192: ls
> 9xcores/         danube/          nwd_layout/      ulc3/
> DSPS_Finance/    gpdsp_PLD/       nwd_testmgr/     win2k/
> WWM/             gpdsp_marketing/ pc_backups/
> bitpower/        india_mirror/    sh/
> bluetooth/       nile/            spitfire/
> jetcar-194: cd ../vol1
> etcar-195: ls
> IssueManager/ diablo/       is_013std/    ras/          tigersharc/
> admin/        ed/           jordan/       soft/
> archive/      fsp/          nwd_fsp@      teton_lite/
> cpd/          herc_eval/    pe_workspace/ thor/
>
>
> codered-54: less /var/log/messages
> Jan 11 15:51:14 codered automount[6214]: can't shutdown: filesystem /net still
> busy
> Jan 11 15:51:17 codered autofs: automount -USR2 succeeded
> Jan 11 15:51:19 codered automount[6214]: can't shutdown: filesystem /net still
> busy
> Jan 11 15:51:20 codered autofs: automount -USR2 succeeded
> Jan 11 15:51:23 codered autofs: automount -USR2 succeeded
> Jan 11 15:51:26 codered autofs: automount -USR2 succeeded
> Jan 11 15:51:26 codered automount[6214]: can't shutdown: filesystem /net still
> busy
> Jan 11 15:51:28 codered automount[14708]: >> mount: wrong fs type, bad option,
> bad superblock on aflac:/vol/vol2/spitfire,
> Jan 11 15:51:28 codered automount[14708]: >>        or too many mounted file
> sys
> tems
> Jan 11 15:51:28 codered automount[14708]: mount(nfs): nfs: mount failure
> aflac:/
> vol/vol2/spitfire on /net/aflac/vol/vol2/spitfire
> Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
> Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
> Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
> Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
> Jan 11 15:51:28 codered kernel: nfs_read_super: get root inode failed
> Jan 11 15:51:28 codered kernel: nfs warning: mount version older than kernel
> Jan 11 15:51:28 codered kernel: RPC: Can't bind to reserved port (98).
> Jan 11 15:51:28 codered kernel: nfs_get_root: getattr error = 5
> Jan 11 15:51:28 codered kernel: nfs_read_super: get root inode failed

Looks like you've run out of priviledged port space here, at least the 
ones that RPC is trying to use.

snip ...

>
> HOW IT WAS FIXED IN REDHAT 8:
>
> Dwight had implemented his fix in 3 steps for Redhat 8:
> 1) He updated his autofs to autofs-4.1.3-28 which had the port leak fix
> 2) He patched his kernel with the autofs4-2.4.20-20040508.patch
> (is some equivalent patch needed for Redhat 3 Enterprise 3 which uses
> kernel 2.4.21-20 ?
> 3) He changed the way he exported filesystems from the Netapp:
>
> "The last issue was the matter of how /vol/vol0 is exported from a
> Network Appliance filer.  We found that the following exports broke
> autofs4:
>
> /vol/vol0     -root=node1:node2:node3:node4
> /vol/vol0     -rw,root=node1:node2:node3
> /vol/vol0     -anon=0
>
> The export syntax that worked was:
>
> /vol/vol0       -rw=node1:node2,root=node1,node2
> "

This is a bug in the option parsing. I'll need to fix that.

>
> WHAT HAPPENED WHEN I TRIED THE REDHAT 8 WORKAROUND:
>
> Now when I tried to do something similar, I found that if you weren't
> on node1 or node2, the filesystem was read-only, so I had to do this:
>
> /vol/vol1	-rw=node1:node2,root=node1,node2
> /vol/vol1/foo1	-root=node1:node2
> /vol/vol1/foo2  -root=node1:node2
>
> This way if you cd /net/filer/vol/vol1 it was read-only for most machines
> but if you cd'd to /net/filer/vol/vol1/foo1 it was read-write.
>
> So using that Netapp export workaround that fixed the Redhat 8 autofs4 problem,
> plus using autofs-4.1.3-67 has not yet solved the problem yet for our
> Redhat Enterprise 3 clients.
>
> CONCLUSION:
>
> I hope this is enough info to track down this problem.  It appears
> as though the interaction of using /net with a Netapp is causing
> spurious mounts, and unmounting is not working.  I will assist with
> any patch tests that you require, so let me know, and I will be able
> to verify any fixes.

Might be a bit of a long road here but we'll have to see how we go.

btw, on average, how many exports do you have on a filer?

Regards
Ian
