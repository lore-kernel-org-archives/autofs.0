From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Mon, 30 Dec 2013 15:38:20 +0800
Message-ID: <CAF1ZMEd5iBqbR4aH84v==HyUH6x=17mbmVTVdsv_WM9Zbox1NA@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
	<CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	<CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	<CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
	<1388134613.2623.7.camel@perseus.fritz.box>
	<1388198519.13774.4.camel@perseus.fritz.box>
	<CAF1ZMEcOgg2DA++12XHnBRue58-W_HmeByNfbs80HjmnFsZ0dA@mail.gmail.com>
	<1388315678.26021.4.camel@perseus.fritz.box>
	<1388316386.26021.6.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DfLbrk7uCpZ6mNBM4YvKSfCEnSM9MX0xNPYUNA6rVgo=;
        b=0VOPPLYWT5zypLBPHkouD3iE1vD5/tjYK8CLpXt6kxkTYwBCB6kE6nHx4pYHSaeQlV
         SKtrWl4dXDt+2zuTjkLF6BTWsUiiwfDG+8tuQ6If35Ry9c4vXrtChPQookNh2yljbVqC
         ww0NmpYlAoyxV2BwPlAvlDkBX/Kp3AQ58pNPH0tSo5tQ4oVn9IgXyB1AYL/phJS53SmV
         LEDPQ0qFOdT91KiGo9jLa23Ckb+o2C38xLYX0gJxHAtVwoZCzv+eL7mTxSXBcLLJkUvX
         J6vSdltMqzORM5tocoECTbsncgfZbQbfC5CTMfQq5Jfy99YAORwaF2Xne7/bC+6b5wvC
         FGGw==
In-Reply-To: <1388316386.26021.6.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Sun, Dec 29, 2013 at 7:26 PM, Ian Kent <raven@themaw.net> wrote:
> On Sun, 2013-12-29 at 19:14 +0800, Ian Kent wrote:
>> On Sat, 2013-12-28 at 20:09 +0800, Dennis Lan (dlan) wrote:
>> > On Sat, Dec 28, 2013 at 10:41 AM, Ian Kent <raven@themaw.net> wrote:
>> >
>> > >> > using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
>> > > I've updated the autofs-5.0.public branch.
>> > > Can you test it please.
>> > >
>> > > Ian
>> > >
>> > Hi Ian:
>> >  Did you only fix the problem while libtirpc is disabled, as I looking
>> > at your commits?
>> > I've tested the case with libtirpc disabled, all works fine (test both
>> > nfs mount with nfsvers=3,4)
>> >
>> > but with libtirpc enabled, fail as same previous error
>>
>> I'm not able to reproduce those problems with the current source.
>> Tell me more (maybe again) about the server side.
>
what more do you want to know?
it's also a gentoo system, using kernel 3.10.9-gentoo, server nfs-utils-1.2.9

> Perhaps you could send a gdb backtrace, that might give ne a clue.
> Run gdb on the core and capture the output of "thr a a bt".
>
yes,  here it is

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ff0baf78700 (LWP 23483)]
0x0000000000000000 in ?? ()
(gdb) backtrace
#0  0x0000000000000000 in ?? ()
#1  0x00007ff0b7898d16 in clnt_vc_call (cl=0x7ff0bafed200, proc=3,
xdr_args=0x7ff0b78a1974 <xdr_rpcb>,
    args_ptr=0x7ff0baf6fe50, xdr_results=0x7ff0ba0c6a10
<xdr_wrapstring>, results_ptr=0x7ff0baf6fdd8, timeout=...)
    at clnt_vc.c:372
#2  0x00007ff0b67f4952 in rpc_rpcb_getport (client=0x7ff0bafed200,
parms=0x7ff0baf6fe50, timeout=...,
    port=0x7ff0baf700f8) at rpc_subs.c:505
#3  0x00007ff0b67f4b7e in rpc_getport (info=0x7ff0baf6fef0,
parms=0x7ff0baf70020, client=0x7ff0bafed200,
    port=0x7ff0baf700f8) at rpc_subs.c:579
#4  0x00007ff0b67f562d in rpc_portmap_getport (info=0x7ff0baf70140,
parms=0x7ff0baf70020, port=0x7ff0baf700f8)
    at rpc_subs.c:927
#5  0x00007ff0b67f1c13 in get_nfs_info (logopt=1, host=0x7ff0bafdd600,
pm_info=0x7ff0baf70140,
    rpc_info=0x7ff0baf700e0, proto=6, version=32, port=0) at replicated.c:535
#6  0x00007ff0b67f2303 in get_vers_and_cost (logopt=1,
host=0x7ff0bafdd600, version=35, port=-1)
    at replicated.c:686
#7  0x00007ff0b67f2ba0 in prune_host_list (logopt=1,
list=0x7ff0baf70348, vers=35, port=-1) at replicated.c:910
#8  0x00007ff0b67f0319 in mount_mount (ap=0x7ff0bafd9600,
root=0x7ff0bafeaeb0 "/mnt/misc",
    name=0x7ff0baf71500 "mkynfs1", name_len=7, what=0x7ff0baf714d0
"192.168.90.12:/home/dennis",
    fstype=0x7ff0b6a3ff8e "nfs", options=0x7ff0baf71520
"ro,soft,intr,nfsvers=3", context=0x7ff0bafe2e00)
    at mount_nfs.c:233
#9  0x00007ff0b6a26029 in sun_mount (ap=0x7ff0bafd9600,
root=0x7ff0bafeaeb0 "/mnt/misc",
    name=0x7ff0baf75940 "mkynfs1", namelen=7, loc=0x7ff0bafe2780
"192.168.90.12:/home/dennis", loclen=26,
    options=0x7ff0baf71520 "ro,soft,intr,nfsvers=3",
ctxt=0x7ff0bafe2de0) at parse_sun.c:657
#10 0x00007ff0b6a291c8 in parse_mount (ap=0x7ff0bafd9600,
name=0x7ff0baf75940 "mkynfs1", name_len=7,
    mapent=0x7ff0baf71930
"-ro,soft,intr,nfsvers=3\t\t192.168.90.12:/home/dennis",
context=0x7ff0bafe2de0)
    at parse_sun.c:1595
#11 0x00007ff0b6c5619b in lookup_mount (ap=0x7ff0bafd9600,
name=0x7ff0baf76eb0 "mkynfs1", name_len=7,
    context=0x7ff0bafe2e20) at lookup_file.c:1142
#12 0x00007ff0bb011d52 in do_lookup_mount (ap=0x7ff0bafd9600,
map=0x7ff0bafddd80, name=0x7ff0baf76eb0 "mkynfs1",
    name_len=7) at lookup.c:688
#13 0x00007ff0bb011f09 in lookup_name_file_source_instance
(ap=0x7ff0bafd9600, map=0x7ff0bafdda80,
    name=0x7ff0baf76eb0 "mkynfs1", name_len=7) at lookup.c:728
#14 0x00007ff0bb01269c in lookup_nss_mount (ap=0x7ff0bafd9600,
source=0x0, name=0x7ff0baf76eb0 "mkynfs1",
    name_len=7) at lookup.c:920
#15 0x00007ff0bb007c2e in do_mount_indirect (arg=0x7ff0bae75000) at
indirect.c:776
#16 0x00007ff0babbd013 in start_thread () from /lib64/libpthread.so.0
#17 0x00007ff0ba0989dd in clone () from /lib64/libc.so.6


>>
>> Commit ec267c2c deals with a libtirpc failure that would result in the
>> "no hosts found" message and I'm not sure you had commit 7f7b730e either
>> which also caused failures.
>>
I'm testing autofs-5.0.public branch (commit:
3d4c9d156c065afd0b38491cec4367b1ecbae24a)
previous report based on (e7ada505a83871922a588d50da06d02000325f1a)
so, yes, they all include ec267c2c  and 7f7b730e
0
>> Ian
>>
>
>



On Sun, Dec 29, 2013 at 7:36 PM, Ian Kent <raven@themaw.net> wrote:
> On Fri, 2013-12-27 at 15:30 +0800, Dennis Lan (dlan) wrote:
>> sorry, I was not accurate about the failure cases.
>>
>> using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
>>
>> snip from file /etc/autofs/auto.misc
>> mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
>> mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
>>
>> with libtirpc enabled (all other features disabled),[1]
>> "ls /mnt/misc/mkynfs" lead to automount segfault
>> "ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"
>>
>> with libtirpc disabled (all other features disabled)[2]
>> "ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
>> "ls /mnt/misc/mkydns" works fine
>
> What exactly does "all other features disabled" mean from a configure
> POV. I always use --disable-mount-locking and --enable-ignore-busy,
> always.
>
> Maybe that's something to do with the problem your seeing .....
>
> Ian
