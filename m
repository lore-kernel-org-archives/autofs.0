From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Mon, 2 May 2016 18:08:10 +0200
Message-ID: <20160502160810.GE6794@bccms.uni-bremen.de>
References: <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
 <20160430113600.GI30271@bccms.uni-bremen.de>
 <1462168902.2983.72.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462205291;
	bh=t823J/ikc7eJV7FCV85u0mb/qDQPD022eI0ZSC7qUsA=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=Tj0J8d+W2A4Gar0nTAPH0moE2SJKe9oPflsRGvWvBc4QsjJPsUTQmdv5ar5jQFPBW
	 gck2k8zmjYUI4OOUxRWKqUuvJvoArG68xp5oomXDftnnG7OmdgedYNDmp9NkJp6PQ4
	 myi3+VlCU05qddHCxzp1U10oyBUNaGZtArJ08rVs=
Content-Disposition: inline
In-Reply-To: <1462168902.2983.72.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I did three tests now, each with my self-built packages and the ones
from tour ppa:

1. multiple IPv6 addresses
2. square bracketed IPv6 address from map
3. new situation, "failover": the server has several IPv6 and one IPv4
   address, but the server exports only to one IPv6 address

There does not appear to be any difference depending on the package versions
used. Log output for each using the packages from your ppa is attached.

In test 1 one address is selected based on response time, in tests 2
there is a successfull mount using the specified address and in the new
test 3 autofs starts with the address with the lowest response time but
once it fails it proceeds trying the others. No user noticeable
delays.

Especially this failover behaviour is very nice. Effectively this makes
steering the address selection towards what I want from a client side
into a server side problem ! I can simply export just to ULAs and autofs
figures this out for me. Is that correct ? If so, this is all I ever
wanted, I can put simply a readable hostname in the map and use the
server's /etc/exports to fix the address. Sorry for not making the connection 
earlier.

On Mon, May 02, 2016 at 02:01:42PM +0800, Ian Kent wrote:
> On Sat, 2016-04-30 at 13:36 +0200, Christof Koehler wrote:
> 
> I'll update the man pages to talk about libtirpc.
> In particular I'll say that libtirpc is required for IPv6.
Thank you. Eventually this will also alert distro maintainers that their
build should change, autofs with the same libtirpc requirement than
nfs-common. May be it goes into debian testing in time for
ubuntu 18.04 LTS :-)

But for now rebuilding appears to work anyway. I should update the bug
report in the ubuntu tracker.

> What I didn't see is trying different addresses over retry on failure
> but mount.nfs(8) has never claimed to do that.

And on top the failover feature in autofs does what I wanted in the
first place. I only was not conciously aware of it.

> I also saw a few mailing list posts that implied the selection had been
> modified over time and there was mention of rfc 6724 in some posts.
I belive the difference is primarily that some address classes were
deprecated in the real world between, see
https://tools.ietf.org/html/rfc6724#appendix-B

> 
> I can help with that if there are any problems.

Works apparently now with test 2 and 3 above. So no changes needed if 2
and 3 are the desired behaviour from your side ! Thank you for your
patience.

> 
> I don't think I require square brackets on IPv6 addresses but they
> shouldn't cause the mount to fail either, if they are present.
Well, apparently the string from the map is passed verbatim to mount.
Without brackets mount is unhappy if I remember my own testing correctly, 
confirm also nfs(5). According to nfs(5) mount needs them.

autofs and mount are both client side programs. So requiring square
brackets appears to be a reasonable convention. /etc/exports is server side 
and does not allow square brackets. I could live with that.

> 
> It's a little hard to work out actually because the parsing code for sun
> format mount maps (but not the master map) is in several different
> locations (a background task I have is to change this to a YACC parser
> and do almost all the parsing in one place).
That I do not know. I see the problem.

But may be related to this:
We are still using NIS and actually we had the autofs map in  NIS
for years. 
If you want I can try what happens if I put an IPv6 address into one of
our nis maps (reactivate one of the autofs maps). The server is a debian 
oldstable.

I removed the autofs maps from nis because I am not sure if NIS is 
supported over IPv6 and so might not be a viable option if we have IPv6
only machines as mentioned earlier. I am looking at openldap/kerberos 
every few months trying to convince myselves that moving to it is worth 
the effort compared to keeping everything in ansible managed local files.

There is http://www.linux-nis.org/nis-ipv6/, but a
ldd /usr/sbin/ypbind|grep rpc comes up empty.

> The list is constructed on the fly at mount time and those that don't
> respond are removed leaving only hosts (or addresses) that need a mount
> to be attempted.
That is test 3 above, right ? Appears to work fine. Thank you for
bringing this up, I got the idea then.

> 
> availability (as there is in amd, but that application will probably
> never support IPv6).
Reminds me:
We used am-utils back around 1998, because we had DEC OSF/1 aka 
True64 on Alpha 21164 based workstations. When we moved to autofs (linux only 
then) about 9 years ago we never looked back. But great CPUs for number crunching.

> 
> > Which option would that be ? I cannot find it ?
> 
> I was going to say, if you specify a sensible value for mount_wait the
Ah, OK !



With the above said: I tried to find out where my bad assumption
regarding the ordering of the list returned by getaddrinfo came from. I
currently believe it was like this.

First I prevented the use of privacy addresses by adding a label to the
source selection list. Doing that I noted that there already was a label
for ULAs. That was the red herring, because after that I completely
ignored the destination address selection step which is the important
step here and for which there is no corresponding preference value in
/etc/gai.conf. If it was just source selection involved my assumtion had
been right ... I believe :-)

Best Regards

Christof

-- 
Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen  

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="log1.txt"

May  2 16:57:35 core400 autofs[10603]:    ...done.
May  2 16:57:35 core400 systemd[1]: Started LSB: Automounts filesystems on demand.
May  2 16:57:42 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:57:42 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:57:42 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 0
May  2 16:57:42 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:57:42 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:57:45 core400 automount[10615]: handle_packet: type = 3
May  2 16:57:45 core400 automount[10615]: handle_packet_missing_indirect: token 5, name core330, request pid 10632
May  2 16:57:45 core400 automount[10615]: attempting to mount entry /local/core330
May  2 16:57:45 core400 automount[10615]: lookup_mount: lookup(program): looking up core330
May  2 16:57:45 core400 automount[10615]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:57:45 core400 automount[10615]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:57:45 core400 automount[10615]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 16:57:45 core400 automount[10615]: parse_mount: parse(sun): dequote("core330:/locals") -> core330:/locals
May  2 16:57:45 core400 automount[10615]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=core330:/locals
May  2 16:57:45 core400 automount[10615]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what core330:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 16:57:45 core400 automount[10615]: mount_mount: mount(nfs): root=/local name=core330 what=core330:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 16:57:45 core400 automount[10615]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 16:57:45 core400 automount[10615]: get_nfs_info: called with host core330(192.168.220.118) proto 6 version 0x40
May  2 16:57:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000113
May  2 16:57:45 core400 automount[10615]: get_nfs_info: host core330 cost 113 weight 0
May  2 16:57:45 core400 automount[10615]: get_nfs_info: called with host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 16:57:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000140
May  2 16:57:45 core400 automount[10615]: get_nfs_info: host core330 cost 139 weight 0
May  2 16:57:45 core400 automount[10615]: get_nfs_info: called with host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
May  2 16:57:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000186
May  2 16:57:45 core400 automount[10615]: get_nfs_info: host core330 cost 185 weight 0
May  2 16:57:45 core400 automount[10615]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 16:57:45 core400 automount[10615]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 16:57:45 core400 automount[10615]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev 192.168.220.118:/locals /local/core330
May  2 16:57:45 core400 automount[10615]: mount_mount: mount(nfs): mounted 192.168.220.118:/locals on /local/core330
May  2 16:57:45 core400 automount[10615]: dev_ioctl_send_ready: token = 5
May  2 16:57:45 core400 automount[10615]: mounted /local/core330
May  2 16:57:46 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:57:46 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:57:46 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:57:46 core400 automount[10615]: 1 remaining in /local
May  2 16:57:46 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:57:46 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:57:46 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:57:50 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:57:50 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:57:50 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:57:50 core400 automount[10615]: 1 remaining in /local
May  2 16:57:50 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:57:50 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:57:50 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:57:54 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:57:54 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:57:54 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:57:54 core400 automount[10615]: 1 remaining in /local
May  2 16:57:54 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:57:54 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:57:54 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:57:58 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:57:58 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:57:58 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:57:58 core400 automount[10615]: 1 remaining in /local
May  2 16:57:58 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:57:58 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:57:58 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:02 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:02 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:02 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:02 core400 automount[10615]: handle_packet: type = 4
May  2 16:58:02 core400 automount[10615]: handle_packet_expire_indirect: token 6, name core330
May  2 16:58:02 core400 automount[10615]: expiring path /local/core330
May  2 16:58:02 core400 automount[10615]: umount_multi: path /local/core330 incl 1
May  2 16:58:02 core400 automount[10615]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 16:58:02 core400 automount[10615]: rm_unwanted_fn: removing directory /local/core330
May  2 16:58:02 core400 automount[10615]: expired /local/core330
May  2 16:58:02 core400 automount[10615]: dev_ioctl_send_ready: token = 6
May  2 16:58:02 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 0
May  2 16:58:02 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:02 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:05 core400 automount[10615]: handle_packet: type = 3
May  2 16:58:05 core400 automount[10615]: handle_packet_missing_indirect: token 7, name core330, request pid 10661
May  2 16:58:05 core400 automount[10615]: attempting to mount entry /local/core330
May  2 16:58:05 core400 automount[10615]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:05 core400 automount[10615]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:05 core400 automount[10615]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 16:58:05 core400 automount[10615]: parse_mount: parse(sun): dequote("core330:/locals") -> core330:/locals
May  2 16:58:05 core400 automount[10615]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=core330:/locals
May  2 16:58:05 core400 automount[10615]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what core330:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 16:58:05 core400 automount[10615]: mount_mount: mount(nfs): root=/local name=core330 what=core330:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 16:58:05 core400 automount[10615]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 16:58:05 core400 automount[10615]: get_nfs_info: called with host core330(192.168.220.118) proto 6 version 0x40
May  2 16:58:05 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000246
May  2 16:58:05 core400 automount[10615]: get_nfs_info: host core330 cost 246 weight 0
May  2 16:58:05 core400 automount[10615]: get_nfs_info: called with host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
May  2 16:58:05 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000288
May  2 16:58:05 core400 automount[10615]: get_nfs_info: host core330 cost 288 weight 0
May  2 16:58:05 core400 automount[10615]: get_nfs_info: called with host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 16:58:05 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000280
May  2 16:58:05 core400 automount[10615]: get_nfs_info: host core330 cost 279 weight 0
May  2 16:58:05 core400 automount[10615]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 16:58:05 core400 automount[10615]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 16:58:05 core400 automount[10615]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev 192.168.220.118:/locals /local/core330
May  2 16:58:05 core400 automount[10615]: mount_mount: mount(nfs): mounted 192.168.220.118:/locals on /local/core330
May  2 16:58:05 core400 automount[10615]: dev_ioctl_send_ready: token = 7
May  2 16:58:05 core400 automount[10615]: mounted /local/core330
May  2 16:58:06 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:06 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:06 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:06 core400 automount[10615]: 1 remaining in /local
May  2 16:58:06 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:06 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:06 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:10 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:10 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:10 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:10 core400 automount[10615]: 1 remaining in /local
May  2 16:58:10 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:10 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:10 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:14 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:14 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:14 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:14 core400 automount[10615]: 1 remaining in /local
May  2 16:58:14 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:14 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:14 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:18 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:18 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:18 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:18 core400 automount[10615]: 1 remaining in /local
May  2 16:58:18 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:18 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:18 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:22 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:22 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:22 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:22 core400 automount[10615]: handle_packet: type = 4
May  2 16:58:22 core400 automount[10615]: handle_packet_expire_indirect: token 8, name core330
May  2 16:58:22 core400 automount[10615]: expiring path /local/core330
May  2 16:58:22 core400 automount[10615]: umount_multi: path /local/core330 incl 1
May  2 16:58:22 core400 automount[10615]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 16:58:22 core400 automount[10615]: rm_unwanted_fn: removing directory /local/core330
May  2 16:58:22 core400 automount[10615]: expired /local/core330
May  2 16:58:22 core400 automount[10615]: dev_ioctl_send_ready: token = 8
May  2 16:58:22 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 0
May  2 16:58:22 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:22 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:24 core400 automount[10615]: handle_packet: type = 3
May  2 16:58:24 core400 automount[10615]: handle_packet_missing_indirect: token 9, name core330, request pid 10688
May  2 16:58:24 core400 automount[10615]: attempting to mount entry /local/core330
May  2 16:58:24 core400 automount[10615]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:24 core400 automount[10615]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:24 core400 automount[10615]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 16:58:24 core400 automount[10615]: parse_mount: parse(sun): dequote("core330:/locals") -> core330:/locals
May  2 16:58:24 core400 automount[10615]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=core330:/locals
May  2 16:58:24 core400 automount[10615]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what core330:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 16:58:24 core400 automount[10615]: mount_mount: mount(nfs): root=/local name=core330 what=core330:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 16:58:24 core400 automount[10615]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 16:58:24 core400 automount[10615]: get_nfs_info: called with host core330(192.168.220.118) proto 6 version 0x40
May  2 16:58:24 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.001811
May  2 16:58:24 core400 automount[10615]: get_nfs_info: host core330 cost 1811 weight 0
May  2 16:58:24 core400 automount[10615]: get_nfs_info: called with host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 16:58:24 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000609
May  2 16:58:24 core400 automount[10615]: get_nfs_info: host core330 cost 608 weight 0
May  2 16:58:24 core400 automount[10615]: get_nfs_info: called with host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
May  2 16:58:24 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000131
May  2 16:58:24 core400 automount[10615]: get_nfs_info: host core330 cost 131 weight 0
May  2 16:58:24 core400 automount[10615]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 16:58:24 core400 automount[10615]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 16:58:24 core400 automount[10615]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev [2001:638:708:1261:2000::118]:/locals /local/core330
May  2 16:58:24 core400 automount[10615]: mount_mount: mount(nfs): mounted [2001:638:708:1261:2000::118]:/locals on /local/core330
May  2 16:58:24 core400 automount[10615]: dev_ioctl_send_ready: token = 9
May  2 16:58:24 core400 automount[10615]: mounted /local/core330
May  2 16:58:26 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:26 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:26 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:26 core400 automount[10615]: 1 remaining in /local
May  2 16:58:26 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:26 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:26 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:30 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:30 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:30 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:30 core400 automount[10615]: 1 remaining in /local
May  2 16:58:30 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:30 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:30 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:34 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:34 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:34 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:34 core400 automount[10615]: 1 remaining in /local
May  2 16:58:34 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:34 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:34 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:38 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:38 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:38 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:38 core400 automount[10615]: 1 remaining in /local
May  2 16:58:38 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:38 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:38 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:42 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:42 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:42 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:42 core400 automount[10615]: handle_packet: type = 4
May  2 16:58:42 core400 automount[10615]: handle_packet_expire_indirect: token 10, name core330
May  2 16:58:42 core400 automount[10615]: expiring path /local/core330
May  2 16:58:42 core400 automount[10615]: umount_multi: path /local/core330 incl 1
May  2 16:58:42 core400 automount[10615]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 16:58:42 core400 automount[10615]: rm_unwanted_fn: removing directory /local/core330
May  2 16:58:42 core400 automount[10615]: expired /local/core330
May  2 16:58:42 core400 automount[10615]: dev_ioctl_send_ready: token = 10
May  2 16:58:43 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 0
May  2 16:58:43 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:43 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:45 core400 automount[10615]: handle_packet: type = 3
May  2 16:58:45 core400 automount[10615]: handle_packet_missing_indirect: token 11, name core330, request pid 10725
May  2 16:58:45 core400 automount[10615]: attempting to mount entry /local/core330
May  2 16:58:45 core400 automount[10615]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:45 core400 automount[10615]: lookup_mount: lookup(program): looking up core330
May  2 16:58:45 core400 automount[10615]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:45 core400 automount[10615]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 16:58:45 core400 automount[10615]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 16:58:45 core400 automount[10615]: parse_mount: parse(sun): dequote("core330:/locals") -> core330:/locals
May  2 16:58:45 core400 automount[10615]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=core330:/locals
May  2 16:58:45 core400 automount[10615]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what core330:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 16:58:45 core400 automount[10615]: mount_mount: mount(nfs): root=/local name=core330 what=core330:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 16:58:45 core400 automount[10615]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 16:58:45 core400 automount[10615]: get_nfs_info: called with host core330(192.168.220.118) proto 6 version 0x40
May  2 16:58:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000123
May  2 16:58:45 core400 automount[10615]: get_nfs_info: host core330 cost 123 weight 0
May  2 16:58:45 core400 automount[10615]: get_nfs_info: called with host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
May  2 16:58:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000140
May  2 16:58:45 core400 automount[10615]: get_nfs_info: host core330 cost 139 weight 0
May  2 16:58:45 core400 automount[10615]: get_nfs_info: called with host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 16:58:45 core400 automount[10615]: get_nfs_info: nfs v4 rpc ping time: 0.000148
May  2 16:58:45 core400 automount[10615]: get_nfs_info: host core330 cost 148 weight 0
May  2 16:58:45 core400 automount[10615]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 16:58:45 core400 automount[10615]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 16:58:45 core400 automount[10615]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev 192.168.220.118:/locals /local/core330
May  2 16:58:45 core400 automount[10615]: mount_mount: mount(nfs): mounted 192.168.220.118:/locals on /local/core330
May  2 16:58:45 core400 automount[10615]: dev_ioctl_send_ready: token = 11
May  2 16:58:45 core400 automount[10615]: mounted /local/core330
May  2 16:58:47 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:47 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:47 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:47 core400 automount[10615]: 1 remaining in /local
May  2 16:58:47 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:47 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:47 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:51 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:51 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:51 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:51 core400 automount[10615]: 1 remaining in /local
May  2 16:58:51 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:51 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:51 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:55 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:55 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:55 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:55 core400 automount[10615]: 1 remaining in /local
May  2 16:58:55 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:55 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:55 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:58:59 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:58:59 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:58:59 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:58:59 core400 automount[10615]: 1 remaining in /local
May  2 16:58:59 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 3
May  2 16:58:59 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:58:59 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local
May  2 16:59:03 core400 automount[10615]: st_expire: state 1 path /local
May  2 16:59:03 core400 automount[10615]: expire_proc: exp_proc = 139681865455360 path /local
May  2 16:59:03 core400 automount[10615]: expire_proc_indirect: expire /local/core330
May  2 16:59:03 core400 automount[10615]: handle_packet: type = 4
May  2 16:59:03 core400 automount[10615]: handle_packet_expire_indirect: token 12, name core330
May  2 16:59:03 core400 automount[10615]: expiring path /local/core330
May  2 16:59:03 core400 automount[10615]: umount_multi: path /local/core330 incl 1
May  2 16:59:03 core400 automount[10615]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 16:59:03 core400 automount[10615]: rm_unwanted_fn: removing directory /local/core330
May  2 16:59:03 core400 automount[10615]: expired /local/core330
May  2 16:59:03 core400 automount[10615]: dev_ioctl_send_ready: token = 12
May  2 16:59:03 core400 automount[10615]: expire_cleanup: got thid 139681865455360 path /local stat 0
May  2 16:59:03 core400 automount[10615]: expire_cleanup: sigchld: exp 139681865455360 finished, switching from 2 to 1
May  2 16:59:03 core400 automount[10615]: st_ready: st_ready(): state = 2 path /local

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="log2.txt"

May  2 17:00:14 core400 autofs[10785]:    ...done.
May  2 17:00:14 core400 systemd[1]: Started LSB: Automounts filesystems on demand.
May  2 17:00:20 core400 automount[10800]: handle_packet: type = 3
May  2 17:00:20 core400 automount[10800]: handle_packet_missing_indirect: token 13, name core330, request pid 10809
May  2 17:00:20 core400 automount[10800]: attempting to mount entry /local/core330
May  2 17:00:20 core400 automount[10800]: lookup_mount: lookup(program): looking up core330
May  2 17:00:20 core400 automount[10800]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev [fd5f:852:a27c:1261:2000::118]:/locals
May  2 17:00:20 core400 automount[10800]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev [fd5f:852:a27c:1261:2000::118]:/locals
May  2 17:00:20 core400 automount[10800]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 17:00:20 core400 automount[10800]: parse_mount: parse(sun): dequote("[fd5f:852:a27c:1261:2000::118]:/locals") -> [fd5f:852:a27c:1261:2000::118]:/locals
May  2 17:00:20 core400 automount[10800]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=[fd5f:852:a27c:1261:2000::118]:/locals
May  2 17:00:20 core400 automount[10800]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what [fd5f:852:a27c:1261:2000::118]:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 17:00:20 core400 automount[10800]: mount_mount: mount(nfs): root=/local name=core330 what=[fd5f:852:a27c:1261:2000::118]:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 17:00:20 core400 automount[10800]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 17:00:20 core400 automount[10800]: get_nfs_info: called with host [fd5f:852:a27c:1261:2000::118](fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 17:00:20 core400 automount[10800]: get_nfs_info: nfs v4 rpc ping time: 0.000132
May  2 17:00:20 core400 automount[10800]: get_nfs_info: host [fd5f:852:a27c:1261:2000::118] cost 132 weight 0
May  2 17:00:20 core400 automount[10800]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 17:00:20 core400 automount[10800]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 17:00:20 core400 automount[10800]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev [fd5f:852:a27c:1261:2000::118]:/locals /local/core330
May  2 17:00:20 core400 automount[10800]: mount_mount: mount(nfs): mounted [fd5f:852:a27c:1261:2000::118]:/locals on /local/core330
May  2 17:00:20 core400 automount[10800]: dev_ioctl_send_ready: token = 13
May  2 17:00:20 core400 automount[10800]: mounted /local/core330
May  2 17:00:21 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:21 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:21 core400 automount[10800]: expire_proc_indirect: expire /local/core330
May  2 17:00:21 core400 automount[10800]: 1 remaining in /local
May  2 17:00:21 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 3
May  2 17:00:21 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:21 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:25 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:25 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:25 core400 automount[10800]: expire_proc_indirect: expire /local/core330
May  2 17:00:25 core400 automount[10800]: 1 remaining in /local
May  2 17:00:25 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 3
May  2 17:00:25 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:25 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:29 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:29 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:29 core400 automount[10800]: expire_proc_indirect: expire /local/core330
May  2 17:00:29 core400 automount[10800]: 1 remaining in /local
May  2 17:00:29 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 3
May  2 17:00:29 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:29 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:33 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:33 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:33 core400 automount[10800]: expire_proc_indirect: expire /local/core330
May  2 17:00:33 core400 automount[10800]: 1 remaining in /local
May  2 17:00:33 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 3
May  2 17:00:33 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:33 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:37 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:37 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:37 core400 automount[10800]: expire_proc_indirect: expire /local/core330
May  2 17:00:37 core400 automount[10800]: handle_packet: type = 4
May  2 17:00:37 core400 automount[10800]: handle_packet_expire_indirect: token 14, name core330
May  2 17:00:37 core400 automount[10800]: expiring path /local/core330
May  2 17:00:37 core400 automount[10800]: umount_multi: path /local/core330 incl 1
May  2 17:00:37 core400 automount[10800]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 17:00:37 core400 automount[10800]: rm_unwanted_fn: removing directory /local/core330
May  2 17:00:37 core400 automount[10800]: expired /local/core330
May  2 17:00:37 core400 automount[10800]: dev_ioctl_send_ready: token = 14
May  2 17:00:37 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 0
May  2 17:00:37 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:37 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:41 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:41 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:41 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 0
May  2 17:00:41 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:41 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local
May  2 17:00:45 core400 automount[10800]: st_expire: state 1 path /local
May  2 17:00:45 core400 automount[10800]: expire_proc: exp_proc = 140215048800000 path /local
May  2 17:00:45 core400 automount[10800]: expire_cleanup: got thid 140215048800000 path /local stat 0
May  2 17:00:45 core400 automount[10800]: expire_cleanup: sigchld: exp 140215048800000 finished, switching from 2 to 1
May  2 17:00:45 core400 automount[10800]: st_ready: st_ready(): state = 2 path /local

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="log3.txt"

May  2 17:02:04 core400 systemd[1]: Stopped LSB: Automounts filesystems on demand.
May  2 17:02:04 core400 systemd[1]: Starting LSB: Automounts filesystems on demand...
May  2 17:02:04 core400 autofs[10881]:  * Starting automount...
May  2 17:02:04 core400 automount[10895]: Starting automounter version 5.1.1, master map /etc/auto.master
May  2 17:02:04 core400 automount[10895]: using kernel protocol version 5.02
May  2 17:02:04 core400 automount[10895]: lookup_nss_read_master: reading master file /etc/auto.master
May  2 17:02:04 core400 automount[10895]: parse_init: parse(sun): init gathered global options: (null)
May  2 17:02:04 core400 automount[10895]: lookup_read_master: lookup(file): read entry /local
May  2 17:02:04 core400 automount[10895]: master_do_mount: mounting /local
May  2 17:02:04 core400 automount[10895]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-local
May  2 17:02:04 core400 automount[10895]: lookup_nss_read_map: reading map file /etc/auto.local
May  2 17:02:04 core400 automount[10895]: parse_init: parse(sun): init gathered global options: (null)
May  2 17:02:04 core400 automount[10895]: mounted indirect on /local with timeout 15, freq 4 seconds
May  2 17:02:04 core400 automount[10895]: st_ready: st_ready(): state = 0 path /local
May  2 17:02:04 core400 autofs[10881]:    ...done.
May  2 17:02:04 core400 systemd[1]: Started LSB: Automounts filesystems on demand.
May  2 17:02:10 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:10 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:10 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:10 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:10 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:14 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:14 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:14 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:14 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:14 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:18 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:18 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:18 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:18 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:18 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:22 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:22 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:22 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:22 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:22 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:26 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:26 core400 systemd[1]: Starting Cleanup of Temporary Directories...
May  2 17:02:26 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:26 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:26 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:26 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:26 core400 systemd-tmpfiles[10908]: [/usr/lib/tmpfiles.d/var.conf:14] Duplicate line for path "/var/log", ignoring.
May  2 17:02:26 core400 systemd[1]: Started Cleanup of Temporary Directories.
May  2 17:02:30 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:30 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:30 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:30 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:30 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:32 core400 automount[10895]: handle_packet: type = 3
May  2 17:02:32 core400 automount[10895]: handle_packet_missing_indirect: token 15, name core330, request pid 10914
May  2 17:02:32 core400 automount[10895]: attempting to mount entry /local/core330
May  2 17:02:32 core400 automount[10895]: lookup_mount: lookup(program): looking up core330
May  2 17:02:32 core400 automount[10895]: lookup_mount: lookup(program): core330 -> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 17:02:32 core400 automount[10895]: parse_mount: parse(sun): expanded entry: -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals
May  2 17:02:32 core400 automount[10895]: parse_mount: parse(sun): gathered options: fstype=nfs4,rw,intr,nosuid,soft,nodev
May  2 17:02:32 core400 automount[10895]: parse_mount: parse(sun): dequote("core330:/locals") -> core330:/locals
May  2 17:02:32 core400 automount[10895]: parse_mount: parse(sun): core of entry: options=fstype=nfs4,rw,intr,nosuid,soft,nodev, loc=core330:/locals
May  2 17:02:32 core400 automount[10895]: sun_mount: parse(sun): mounting root /local, mountpoint core330, what core330:/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): root=/local name=core330 what=core330:/locals, fstype=nfs4, options=rw,intr,nosuid,soft,nodev
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): nfs options="rw,intr,nosuid,soft,nodev", nobind=0, nosymlink=0, ro=0
May  2 17:02:32 core400 automount[10895]: get_nfs_info: called with host core330(192.168.220.118) proto 6 version 0x40
May  2 17:02:32 core400 automount[10895]: get_nfs_info: nfs v4 rpc ping time: 0.000208
May  2 17:02:32 core400 automount[10895]: get_nfs_info: host core330 cost 207 weight 0
May  2 17:02:32 core400 automount[10895]: get_nfs_info: called with host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
May  2 17:02:32 core400 automount[10895]: get_nfs_info: nfs v4 rpc ping time: 0.000129
May  2 17:02:32 core400 automount[10895]: get_nfs_info: host core330 cost 128 weight 0
May  2 17:02:32 core400 automount[10895]: get_nfs_info: called with host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
May  2 17:02:32 core400 automount[10895]: get_nfs_info: nfs v4 rpc ping time: 0.000109
May  2 17:02:32 core400 automount[10895]: get_nfs_info: host core330 cost 109 weight 0
May  2 17:02:32 core400 automount[10895]: prune_host_list: selected subset of hosts that support NFS4 over TCP
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): calling mkdir_path /local/core330
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev [2001:638:708:1261:2000::118]:/locals /local/core330
May  2 17:02:32 core400 automount[10895]: >> mount.nfs4: access denied by server while mounting [2001:638:708:1261:2000::118]:/locals
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev [fd5f:852:a27c:1261:2000::118]:/locals /local/core330
May  2 17:02:32 core400 automount[10895]: mount_mount: mount(nfs): mounted [fd5f:852:a27c:1261:2000::118]:/locals on /local/core330
May  2 17:02:32 core400 automount[10895]: dev_ioctl_send_ready: token = 15
May  2 17:02:32 core400 automount[10895]: mounted /local/core330
May  2 17:02:34 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:34 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:34 core400 automount[10895]: expire_proc_indirect: expire /local/core330
May  2 17:02:34 core400 automount[10895]: 1 remaining in /local
May  2 17:02:34 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 3
May  2 17:02:34 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:34 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:38 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:38 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:38 core400 automount[10895]: expire_proc_indirect: expire /local/core330
May  2 17:02:38 core400 automount[10895]: 1 remaining in /local
May  2 17:02:38 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 3
May  2 17:02:38 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:38 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:42 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:42 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:42 core400 automount[10895]: expire_proc_indirect: expire /local/core330
May  2 17:02:42 core400 automount[10895]: 1 remaining in /local
May  2 17:02:42 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 3
May  2 17:02:42 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:42 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:46 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:46 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:46 core400 automount[10895]: expire_proc_indirect: expire /local/core330
May  2 17:02:46 core400 automount[10895]: 1 remaining in /local
May  2 17:02:46 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 3
May  2 17:02:46 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:46 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:50 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:50 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:50 core400 automount[10895]: expire_proc_indirect: expire /local/core330
May  2 17:02:50 core400 automount[10895]: handle_packet: type = 4
May  2 17:02:50 core400 automount[10895]: handle_packet_expire_indirect: token 16, name core330
May  2 17:02:50 core400 automount[10895]: expiring path /local/core330
May  2 17:02:50 core400 automount[10895]: umount_multi: path /local/core330 incl 1
May  2 17:02:50 core400 automount[10895]: umount_subtree_mounts: unmounting dir = /local/core330
May  2 17:02:50 core400 automount[10895]: rm_unwanted_fn: removing directory /local/core330
May  2 17:02:50 core400 automount[10895]: expired /local/core330
May  2 17:02:50 core400 automount[10895]: dev_ioctl_send_ready: token = 16
May  2 17:02:50 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:50 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:50 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:54 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:54 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:54 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:54 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:54 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:02:58 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:02:58 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:02:58 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:02:58 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:02:58 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local
May  2 17:03:02 core400 automount[10895]: st_expire: state 1 path /local
May  2 17:03:02 core400 automount[10895]: expire_proc: exp_proc = 140129564624640 path /local
May  2 17:03:02 core400 automount[10895]: expire_cleanup: got thid 140129564624640 path /local stat 0
May  2 17:03:02 core400 automount[10895]: expire_cleanup: sigchld: exp 140129564624640 finished, switching from 2 to 1
May  2 17:03:02 core400 automount[10895]: st_ready: st_ready(): state = 2 path /local

--BOKacYhQ+x31HxR3--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
