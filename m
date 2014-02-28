From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Fri, 28 Feb 2014 13:12:58 +0100
Message-ID: <53107D4A.90904@molgen.mpg.de>
References: <52E92627.9050801@molgen.mpg.de>		 <1391139080.2486.19.camel@perseus.fritz.box>		 <1391145206.2486.25.camel@perseus.fritz.box>	 <52EB7694.20707@molgen.mpg.de>	 <52EB7B07.2070707@molgen.mpg.de>	 <530484B7.6030305@molgen.mpg.de>		 <1392896501.2508.16.camel@perseus.fritz.box>	 <1392898704.2508.26.camel@perseus.fritz.box>	 <530625D0.7020808@molgen.mpg.de> <1392946952.2495.3.camel@perseus.fritz.box> <53076D91.7050703@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <53076D91.7050703@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Alexander Viro <aviro@redhat.com>

Hello,

bug hit again with new gcc.

(one of my added) debug is

> *** namespace.c 2014/02/21 14:41:22 1.1
> --- namespace.c 2014/02/21 14:49:25
> ***************
> *** 665,674 ****
> --- 665,677 ----
>
>   static void put_mountpoint(struct mountpoint *mp)
>   {
> +       DPRINTK("mp=%p");
> +
>         if (!--mp->m_count) {
>                 struct dentry *dentry = mp->m_dentry;
>                 spin_lock(&dentry->d_lock);
>                 dentry->d_flags &= ~DCACHE_MOUNTED;
> +               DPRINTK("cleared mounted on dentry=%p %.*s",dentry, 
> dentry->d_name.len, dentry->d_name.name);
>                 spin_unlock(&dentry->d_lock);
>                 list_del(&mp->m_hash);
>                 kfree(mp);
>
>


Here is an extract from the logfile from a successful dismount of 
/package/sequencer:

> 939 2014-02-24T07:54:30.278237+01:00 kasslerbraten kernel: [  
> 695.352155] pid 1425: autofs4_expire_indirect: checking mountpoint 
> ffff8800c2433c90 sequencer
> 940 2014-02-24T07:54:30.278238+01:00 kasslerbraten kernel: [ 
> 695.352157] pid 1425: autofs4_mount_busy: dentry ffff8800c2433c90 
> sequencer
> 941 2014-02-24T07:54:30.278239+01:00 kasslerbraten kernel: [ 
> 695.352159] pid 1425: autofs4_mount_busy: returning = 0
> 942 2014-02-24T07:54:30.278240+01:00 kasslerbraten kernel: [ 
> 695.352160] pid 1425: autofs4_expire_indirect: returning 
> ffff8800c2433c90 sequencer
> 943 2014-02-24T07:54:30.278241+01:00 kasslerbraten kernel: [ 
> 695.352161] pid 1425: autofs4_wait: new wait id = 0x0000000a, name = 
> sequencer, nfy=2
> 944 2014-02-24T07:54:30.278242+01:00 kasslerbraten kernel: [ 
> 695.352162] pid 1425: autofs4_notify_daemon: wait id = 0x0000000a, 
> name = sequencer, type=4
>
> 969 2014-02-24T07:54:30.312515+01:00 kasslerbraten kernel: [ 
> 695.386185] pid 1433: put_mountpoint: mp=ffff8800c9e215d0
> 970 2014-02-24T07:54:30.312527+01:00 kasslerbraten kernel: [ 
> 695.386188] pid 1433: put_mountpoint: cleared mounted on 
> dentry=ffff8800c2433c90 sequencer
>
> 971 2014-02-24T07:54:30+01:00 kasslerbraten automount[626]: expired 
> /package/sequencer
>
> 972 2014-02-24T07:54:30.324519+01:00 kasslerbraten kernel: [ 
> 695.398095] pid 1428: autofs4_dir_open: file=ffff880126f43ec0 
> dentry=ffff8800c2433c90 sequencer
> 973 2014-02-24T07:54:30.324531+01:00 kasslerbraten kernel: [ 
> 695.398105] pid 1428: autofs4_dentry_release: releasing ffff8800ad2d4a50
> 974 2014-02-24T07:54:30.324534+01:00 kasslerbraten kernel: [ 
> 695.398109] pid 1428: autofs4_dir_rmdir: dentry ffff8800c2433c90, 
> removing sequencer
>
> 975 2014-02-24T07:54:30.324536+01:00 kasslerbraten kernel: [ 
> 695.398157] pid 1425: autofs4_dentry_release: releasing ffff8800c2433c90

Here is an extract from the logfile from a  failed dismount of 
/package/sequencer:

> 91779 2014-02-26T14:13:16.157522+01:00 kasslerbraten kernel: 
> [196176.289030] pid 8739: autofs4_expire_indirect: checking mountpoint 
> ffff880046a45810 sequencer
> 91780 2014-02-26T14:13:16.157523+01:00 kasslerbraten kernel: 
> [196176.289033] pid 8739: autofs4_mount_busy: dentry ffff880046a45810 
> sequencer
> 91781 2014-02-26T14:13:16.157524+01:00 kasslerbraten kernel: 
> [196176.289034] pid 8739: autofs4_mount_busy: returning = 0
> 91782 2014-02-26T14:13:16.157525+01:00 kasslerbraten kernel: 
> [196176.289036] pid 8739: autofs4_expire_indirect: returning 
> ffff880046a45810 sequencer
> 91783 2014-02-26T14:13:16.157526+01:00 kasslerbraten kernel: 
> [196176.289039] pid 8739: autofs4_wait: new wait id = 0x00000085, name 
> = sequencer, nfy=2
> 91784 2014-02-26T14:13:16.157527+01:00 kasslerbraten kernel: 
> [196176.289040] pid 8739: autofs4_notify_daemon: wait id = 0x00000085, 
> name = sequencer, type=4
>
> 91785 2014-02-26T14:13:16.178496+01:00 kasslerbraten kernel: 
> [196176.310371] pid 8742: put_mountpoint: mp=ffff8800c9e215d0
>
> 91786 2014-02-26T14:13:16+01:00 kasslerbraten automount[626]: expired 
> /package/sequencer
>
> 91787 2014-02-26T14:13:16.183536+01:00 kasslerbraten kernel: 
> [196176.314881] pid 8740: autofs4_d_automount: dentry=ffff880046a45810 
> sequencer
> 91788 2014-02-26T14:13:16.183542+01:00 kasslerbraten kernel: 
> [196176.314883] pid 8740: autofs4_d_automount: dentry=ffff880046a45810 
> sequencer
> 91789 2014-02-26T14:13:16.183544+01:00 kasslerbraten kernel: 
> [196176.314884] pid 8740: autofs4_d_automount: dentry=ffff880046a45810 
> sequencer
> 91790 2014-02-26T14:13:16.183545+01:00 kasslerbraten kernel: 
> [196176.314885] pid 8740: autofs4_d_automount: dentry=ffff880046a45810 
> sequencer

( Full file from boot to shutdown with  egrep 
'automount|autofs|d_set_mounted|put_mountpoint'  in 
http://owww.molgen.mpg.de/~buczek/autofs-demo/kasslerbraten.2014-02-26.l )

Obviously, "cleared mounted on dentry" is missing.

It looks like we enter put_mountpoint() but don't get to dentry->d_flags 
&= ~DCACHE_MOUNTED;

mp->m_count is not zero probably.

What does it mean? The mount is still locked but not in the mount hash?
Alas, the user has rebootet the system, I can not look at the mountpoint 
struct in memory.

I don't understand the vfs models. Anyone? Ideas?

Regards
   Donald



On 02/21/14 16:15, Donald Buczek wrote:
> Hello,
>
> I've taken your idea "Apart from a really odd compiler optimization or 
> bug" and compiled with gcc 4.8.2 (instead of 4.7.3)
>
> Also I've put some additional DPRINTKs into the routines setting or 
> clearing DCACHE_MOUNTED
>
> So lets wait for the next event .....
>
> Regards
>   Donald
>
>
>
> On 02/21/14 02:42, Ian Kent wrote:
>> On Thu, 2014-02-20 at 16:57 +0100, Donald Buczek wrote:
>>> On 02/20/14 13:18, Ian Kent wrote:
>>>> On Thu, 2014-02-20 at 19:41 +0800, Ian Kent wrote:
>>>>>> 1969 (gdb) print *(struct dentry *) 0xffff88007fd06c50
>>>>>> 1970 $3 = {d_flags = 1523840, d_seq = {sequence = 4}, d_hash = 
>>>>>> {next = 0xffff880214025c98, pprev = 0xffffc9000013d570}, d_parent 
>>>>>> = 0xffff8800caa66810, d_name = {{{hash = 1876415966, len = 7}, 
>>>>>> hash_len = 31941187038}, name = 0xffff88007fd06c88 "gbrowse"}, 
>>>>>> d_inode = 0xffff8800961ad250, d_iname = "gbrowse", '\000' 
>>>>>> <repeats 24 times>, d_lockref = {{lock_count = 8610971969, {
>>>>>> 1971         lock = {{rlock = {raw_lock = {{head_tail = 21037377, 
>>>>>> tickets = {head = 321, tail = 321}}}}}}, count = 2}}}, d_op = 
>>>>>> 0xffffffff81c45b40, d_sb = 0xffff880222a33800, d_time = 0, 
>>>>>> d_fsdata = 0xffff8800ca443b80, d_lru = {next = 
>>>>>> 0xffff88007fd06cd0, prev = 0xffff88007fd06cd0}, d_u = {d_child = 
>>>>>> {next = 0xffff88007fc9f420, prev = 0xffff8800caa668b0}, d_rcu = {
>>>>>> 1972       next = 0xffff88007fc9f420, func = 
>>>>>> 0xffff8800caa668b0}}, d_subdirs = {next = 0xffff88007fd06cf0, 
>>>>>> prev = 0xffff88007fd06cf0}, d_alias = {next = 0x0, pprev = 
>>>>>> 0xffff8800961ad360}}
>>>> I wonder if there's a struct mount for which this dentry is
>>>> mnt_mountpoint and if so what the value of m_count is for the struct
>>>> mountpoint of the struct mount?
>>> No there isn't. Already checked in
>>> http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript.l lines 1795ff
>> Oh right, I forgot about that, must have been the seemingly endless list
>> of dentrys above it, ;)
>>
>> LOL, and if there was a mount that's unlinked we'd never find it, but
>> yes, a ref counting problem would most likely leave it on the list.
>>
>>> Regards
>>>     Donald
>>>
>>
>
>


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

