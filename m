From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Fri, 27 Dec 2013 14:11:43 +0800
Message-ID: <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+vYqyLcx8BlJmyMGiDn6gXajWIbI7394/XwUTwfMmoA=;
        b=qVI9nQk5lcEt7mId8aJDYcSee8lGFVLP3mc8LtRwcjhapcJLNB6SEBdow2VjIdKZiT
         SAQdww0beaHIAKzen3JLsNe+ACEBxzwAaZK1an40/ymDxRfK3a5LigORZ35mh4Ju/1ta
         LHrvSSRCmaz5zHTUScinSTrbFM0fYxKvluGGjUNUPl9hY8PvA6Vbk2n6ASx9dVGv6pgW
         v3/LByva4B/JoCYnFZwTIMdCRjUqMbZ0XIGpZOouovAlP8Cd2lS21iuKMqBbMXOwGz4j
         aAro+noIBI0SQIdbs+JST3XxSPjIk6Cd4X9+6F2a3GNdOndsHPpnguSm88jNvbdRl/wZ
         aHLQ==
In-Reply-To: <1387881262.7351.15.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Dec 24, 2013 at 6:34 PM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-12-24 at 17:42 +0800, Dennis Lan (dlan) wrote:
>> On Tue, Dec 24, 2013 at 5:04 PM, Ian Kent <raven@themaw.net> wrote:
>> > On Tue, 2013-12-24 at 16:38 +0800, Dennis Lan (dlan) wrote:
>> >> Hi Ian:
>> >>   Do you mind push a temporary branch into your git repo (if you =
don't
>> >> want to queue other patches)?
>> >> That would much convenient for me to test.
>> >
>> > Try branch autofs-5.0.public.
>> > As master and autofs-5.0 branches diverge the autofs-5.0 will be t=
he
>> > place for version 5.0.
>> >
>> >
>>
>> Hi Ian
>>  Have problem with branch autofs-5.0.public
>> most obvious error
>> 461:Dec 24 17:29:12 ofire automount[11496]: mount(nfs): no hosts ava=
ilable
>> 462:Dec 24 17:29:12 ofire automount[11496]: dev_ioctl_send_fail: tok=
en =3D 79
>
> Are you sure you're using the autofs-5.0.public branch.
> That's the error I'd expect to see using master.
>
yes. it's commit ec267c2c406256e401540e5bc890b2e0c2ff6c35

# FEATURES=3D"keeptemp keepwork" EGIT_BRANCH=3D"autofs-5.0.public" emer=
ge
--nodeps -q autofs
# cd /var/tmp/portage/net-fs/autofs-9999/work/autofs-9999/ && git log -=
1

commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
Author: Ian Kent <raven@themaw.net>
Date:   Fri Dec 27 08:23:47 2013 +0800

also following features are enabled (dmalloc hesiod ldap libtirpc sasl)

> I put an entry with the same options into a map and tested it.
> Worked fine for me.
>
> What server are you using?
output from the server side:

mickeycn ~ # qlist -ICv nfs-u
net-fs/nfs-utils-1.2.9

> What kernel is on the server?
mickeycn ~ # uname -a
Linux mickeycn 3.10.9-gentoo #1 SMP Fri Aug 23 22:37:04 CST 2013
x86_64 Intel(R) Xeon(R) CPU E5410 @ 2.33GHz GenuineIntel GNU/Linux

> rpcbind or portmap?
I think it=E2=80=98s rpcbind

mickeycn ~ # rc-status |grep rpc
 rpc.pipefs                                                        [  s=
tarted  ]
 rpc.idmapd                                                        [  s=
tarted  ]
 rpc.statd                                                         [  s=
tarted  ]
 rpcbind                                                           [  s=
tarted  ]

>
> Ian
>

HI Ian:
  finally, I have some time to try this..
  I have tested with autofs-5.0.7 and no problem when come to mount
nfs. but with 5.0.8(using branch autofs-5.0.public), automount crashed
(segmentfault)
  could you show me what's your "automount --version" there?

lan


details
ofire ~ # automount --version

Linux automount version 5.0.8

Directories:
        config dir:     /etc/conf.d
        maps dir:       /etc/autofs
        modules dir:    /usr/lib64/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNT=
S
  WITH_HESIOD WITH_LDAP WITH_SASL WITH_DMALLOC LIBXML2_WORKAROUND
  WITH_LIBTIRPC

ofire ~ # rc-service autofs restart
 * Stopping automounter ...
                                      [ ok ]
 * Starting automounter ...
                                      [ ok ]
ofire ~ # echo ""> /var/log/messages
ofire ~ # cat /etc/autofs/auto.misc
cd        -fstype=3Diso9660,ro,nosuid,nodev    :/dev/cdrom

mkynfs        -ro,soft,intr,nfsvers=3D3        192.168.90.12:/home/denn=
is
mkydns        -ro,soft,intr,nfsvers=3D4        mickeycn:/home/dennis
mkyand        -ro,soft,intr,nfsvers=3D3        mickeycn:/home/android

winxp        -fstype=3Dcifs,credentials=3D/etc/autofs/auto.auth
://192.168.90.168/share
ofire ~ # ls /mnt/misc/mkynfs
^Cls: cannot access /mnt/misc/mkynfs: Interrupted system call

(stuck here, since automount crashed, and I have to use "ctrl + c" to
terminate "ls")

ofire ~ # cat /var/log/messages

Dec 27 13:23:43 ofire automount[27788]: st_expire: state 1 path /net
Dec 27 13:23:43 ofire automount[27788]: expire_proc: exp_proc =3D
140379437758208 path /net
Dec 27 13:23:43 ofire automount[27788]: expire_cleanup: got thid
140379437758208 path /net stat 0
Dec 27 13:23:43 ofire automount[27788]: expire_cleanup: sigchld: exp
140379437758208 finished, switching from 2 to 1
Dec 27 13:23:43 ofire automount[27788]: st_ready: st_ready(): state =3D
2 path /net
Dec 27 13:23:51 ofire automount[27788]: st_expire: state 1 path /net
Dec 27 13:23:51 ofire automount[27788]: expire_proc: exp_proc =3D
140379437758208 path /net
Dec 27 13:23:51 ofire automount[27788]: expire_cleanup: got thid
140379437758208 path /net stat 0
Dec 27 13:23:51 ofire automount[27788]: expire_cleanup: sigchld: exp
140379437758208 finished, switching from 2 to 1
Dec 27 13:23:51 ofire automount[27788]: st_ready: st_ready(): state =3D
2 path /net
Dec 27 13:23:59 ofire automount[27788]: st_expire: state 1 path /net
Dec 27 13:23:59 ofire automount[27788]: expire_proc: exp_proc =3D
140379437758208 path /net
Dec 27 13:23:59 ofire automount[27788]: expire_cleanup: got thid
140379437758208 path /net stat 0
Dec 27 13:23:59 ofire automount[27788]: expire_cleanup: sigchld: exp
140379437758208 finished, switching from 2 to 1
Dec 27 13:23:59 ofire automount[27788]: st_ready: st_ready(): state =3D
2 path /net
Dec 27 13:24:01 ofire automount[27788]: handle_packet: type =3D 3
Dec 27 13:24:01 ofire automount[27788]:
handle_packet_missing_indirect: token 42, name mkynfs, request pid
27808
Dec 27 13:24:01 ofire automount[27788]: attempting to mount entry
/mnt/misc/mkynfs
Dec 27 13:24:01 ofire automount[27788]: lookup_mount: lookup(file):
looking up mkynfs
Dec 27 13:24:01 ofire automount[27788]: lookup_mount: lookup(file):
mkynfs -> -ro,soft,intr,nfsvers=3D3        192.168.90.12:/home/dennis
Dec 27 13:24:01 ofire automount[27788]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=3D3
192.168.90.12:/home/dennis
Dec 27 13:24:01 ofire automount[27788]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=3D3
Dec 27 13:24:01 ofire automount[27788]: parse_mount: parse(sun):
dequote("192.168.90.12:/home/dennis") -> 192.168.90.12:/home/dennis
Dec 27 13:24:01 ofire automount[27788]: parse_mount: parse(sun): core
of entry: options=3Dro,soft,intr,nfsvers=3D3,
loc=3D192.168.90.12:/home/dennis
Dec 27 13:24:01 ofire automount[27788]: sun_mount: parse(sun):
mounting root /mnt/misc, mountpoint mkynfs, what
192.168.90.12:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=3D=
3
Dec 27 13:24:01 ofire automount[27788]: mount_mount: mount(nfs):
root=3D/mnt/misc name=3Dmkynfs what=3D192.168.90.12:/home/dennis,
fstype=3Dnfs, options=3Dro,soft,intr,nfsvers=3D3
Dec 27 13:24:01 ofire automount[27788]: mount_mount: mount(nfs): nfs
options=3D"ro,soft,intr,nfsvers=3D3", nobind=3D0, nosymlink=3D0, ro=3D1
Dec 27 13:24:01 ofire automount[27788]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 6 version 0x20
Dec 27 13:24:01 ofire automount[27788]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 17 version 0x20
Dec 27 13:24:01 ofire kernel: [14162.515864] automount[27809]:
segfault at 0 ip           (null) sp 00007faca284ec48 error 14

ofire ~ # mount -t nfs -o nfsvers=3D4 mickeycn:/home/dennis /mnt/nfs/
ofire ~ # grep nfs /proc/mounts
rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
nfsd /proc/fs/nfsd nfsd rw,nosuid,nodev,noexec,relatime 0 0
mickeycn:/home/dennis /mnt/nfs nfs4
rw,relatime,vers=3D4.0,rsize=3D1048576,wsize=3D1048576,namlen=3D255,har=
d,proto=3Dtcp,port=3D0,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D1=
92.168.90.122,local_lock=3Dnone,addr=3D192.168.90.12
0 0
