From: Donald Buczek <buczek@molgen.mpg.de>
Subject: "Too many levels of symbolic links"
Date: Wed, 19 Feb 2014 11:17:27 +0100
Message-ID: <530484B7.6030305@molgen.mpg.de>
References: <52E92627.9050801@molgen.mpg.de>	 <1391139080.2486.19.camel@perseus.fritz.box> <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <52EB7B07.2070707@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

Hello,


On 01/31/14 11:29, Donald Buczek wrote:
> On 01/31/14 11:10, Donald Buczek wrote:
>
>> I'll surly tell you, when the problem is seen again with 8.13.
>
> 3.13
>



now we've seen the "Too many levels of symbolic links" also on latest 
and greatest kernel 3.13.1 (and, btw, 3.10.29  as well)

Debug script session in 
http://www.molgen.mpg.de/~buczek/autofs-demo/typescript.l
System log (excerpt) in 
http://www.molgen.mpg.de/~buczek/autofs-demo/messages.l (16MB!)

Again I've put line numbers into the files for easier reference...

What is different this time is that multiple directories in multiple 
autofs trees exhibit the problem at the same time. Interestingly, the 
crafted dentry nodes have a similar (but not identical) mtime:

44 root:pate:/home/web/buczek/autofs-demo/# .]2;root@pate.ls -l /home /project /package /scratch
45 /home:
46 total 144
47 drwx--x--x 361 buczek users   32768 Feb 19 08:20 buczek  <--- working
48 drwxr-x--x 161 haas   abt_vin 40960 Feb 13 15:41 haas    <--- working
49 drwxr-xrwt 198 root   system  12288 Jan 27 20:26 web     <--- working
50
51 /package:
52 total 0
53 dr-xr-xr-x 2 root system 0 Feb 17 11:03 usr              <---- dead
54
55 /project:
56 total 0
57 dr-xr-xr-x 2 root system 0 Feb 17 11:06 gbrowse          <--- dead
58 dr-xr-xr-x 2 root system 0 Feb 17 11:06 ngs_haas         <--- dead
59 dr-xr-xr-x 2 root system 0 Feb 17 11:03 postgres         <--- dead
60 dr-xr-xr-x 2 root system 0 Feb 17 11:03 splicenest       <--- dead
61
62 /scratch:
63 total 4
64 drwxrwxrwt 24 root system 4096 Sep 18 14:58 ngsvin       <----- working
65 dr-xr-xr-x  2 root system    0 Feb 17 11:03 ngsvin2      <----- dead

dentry flags on one of theses "/project/gbrowse) are 1523840 :

1969 (gdb) print *(struct dentry *) 0xffff88007fd06c50
1970 $3 = {d_flags = 1523840, d_seq = {sequence = 4}, d_hash = {next = 0xffff880214025c98, pprev = 0xffffc9000013d570}, d_parent = 0xffff8800caa66810, d_name = {{{hash = 1876415966, len = 7}, hash_len = 31941187038}, name = 0xffff88007fd06c88 "gbrowse"}, d_inode = 0xffff8800961ad250, d_iname = "gbrowse", '\000' <repeats 24 times>, d_lockref = {{lock_count = 8610971969, {
1971         lock = {{rlock = {raw_lock = {{head_tail = 21037377, tickets = {head = 321, tail = 321}}}}}}, count = 2}}}, d_op = 0xffffffff81c45b40, d_sb = 0xffff880222a33800, d_time = 0, d_fsdata = 0xffff8800ca443b80, d_lru = {next = 0xffff88007fd06cd0, prev = 0xffff88007fd06cd0}, d_u = {d_child = {next = 0xffff88007fc9f420, prev = 0xffff8800caa668b0}, d_rcu = {
1972       next = 0xffff88007fc9f420, func = 0xffff8800caa668b0}}, d_subdirs = {next = 0xffff88007fd06cf0, prev = 0xffff88007fd06cf0}, d_alias = {next = 0x0, pprev = 0xffff8800961ad360}}


which is 0x174080 which is

   DCACHE_RCUACCESS+
   DCACHE_FSNOTIFY_PARENT_WATCHED+
   DCACHE_MOUNTED+
   DCACHE_NEED_AUTOMOUNT+
   DCACHE_MANAGE_TRANSIT+
   DCACHE_DIRECTORY_TYPE

so again we have DCACHE_MOUNTED but no mount ( line 1753ff )

looking just at "grep gbrowse messages.l" the interesting part might be 
here:


1056818 2014-02-17T11:11:09.290343+01:00 pate kernel: [518408.741228] 
pid 15221: autofs4_expire_indirect: checking mountpoint ffff88007fd06c50 
gbrowse
1056819 2014-02-17T11:11:09.290344+01:00 pate kernel: [518408.741229] 
pid 15221: autofs4_mount_busy: dentry ffff88007fd06c50 gbrowse
1056830 2014-02-17T11:11:09.290364+01:00 pate kernel: [518408.741242] 
pid 15221: autofs4_expire_indirect: checking mountpoint ffff88007fd06c50 
gbrowse
1056831 2014-02-17T11:11:09.290371+01:00 pate kernel: [518408.741243] 
pid 15221: autofs4_mount_busy: dentry ffff88007fd06c50 gbrowse
1056885 2014-02-17T11:12:24.290190+01:00 pate kernel: [518483.724082] 
pid 15245: autofs4_expire_indirect: checking mountpoint ffff88007fd06c50 
gbrowse
1056886 2014-02-17T11:12:24.290201+01:00 pate kernel: [518483.724084] 
pid 15245: autofs4_mount_busy: dentry ffff88007fd06c50 gbrowse
1056888 2014-02-17T11:12:24.290204+01:00 pate kernel: [518483.724088] 
pid 15245: autofs4_expire_indirect: returning ffff88007fd06c50 gbrowse
1056889 2014-02-17T11:12:24.290205+01:00 pate kernel: [518483.724093] 
pid 15245: autofs4_wait: new wait id = 0x000017b5, name = gbrowse, nfy=2
1056890 2014-02-17T11:12:24.290206+01:00 pate kernel: [518483.724095] 
pid 15245: autofs4_notify_daemon: wait id = 0x000017b5, name = gbrowse, 
type=4
1056891 2014-02-17T11:12:24+01:00 pate automount[531]: expiring path 
/project/gbrowse
1056892 2014-02-17T11:12:24.291190+01:00 pate kernel: [518483.724971] 
pid 15247: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056893 2014-02-17T11:12:24+01:00 pate automount[531]: expired 
/project/gbrowse
1056894 2014-02-17T11:12:24.311242+01:00 pate kernel: [518483.744358] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056895 2014-02-17T11:12:24.311247+01:00 pate kernel: [518483.744360] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056896 2014-02-17T11:12:24.311248+01:00 pate kernel: [518483.744364] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056897 2014-02-17T11:12:24.311249+01:00 pate kernel: [518483.744365] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056898 2014-02-17T11:12:24.311250+01:00 pate kernel: [518483.744366] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056899 2014-02-17T11:12:24.311251+01:00 pate kernel: [518483.744367] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056900 2014-02-17T11:12:24.311252+01:00 pate kernel: [518483.744368] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056901 2014-02-17T11:12:24.311253+01:00 pate kernel: [518483.744369] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056902 2014-02-17T11:12:24.311254+01:00 pate kernel: [518483.744370] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056903 2014-02-17T11:12:24.311255+01:00 pate kernel: [518483.744372] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056904 2014-02-17T11:12:24.311255+01:00 pate kernel: [518483.744373] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056905 2014-02-17T11:12:24.311256+01:00 pate kernel: [518483.744374] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056906 2014-02-17T11:12:24.311257+01:00 pate kernel: [518483.744375] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056907 2014-02-17T11:12:24.311258+01:00 pate kernel: [518483.744376] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056908 2014-02-17T11:12:24.311259+01:00 pate kernel: [518483.744377] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse
1056909 2014-02-17T11:12:24.311260+01:00 pate kernel: [518483.744378] 
pid 15246: autofs4_d_manage: dentry=ffff88007fd06c50 gbrowse
1056910 2014-02-17T11:12:24.311261+01:00 pate kernel: [518483.744379] 
pid 15246: autofs4_d_automount: dentry=ffff88007fd06c50 gbrowse


where the daemon dismounts /project/gbrowse (but it looks like 
dentry=ffff88007fd06c50 stays in place and has DCACHE_MOUNTED even a day 
later.

The log from the fileserver confirms the unmount at Feb 17 11:12:24 :

root@genome:~# fgrep gbrowse /var/log/messages |grep pate|tail -6
Feb 17 10:53:42 genome mountd[3074]: authenticated mount request from 
pate.molgen.mpg.de:759 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)
Feb 17 10:59:54 genome mountd[3079]: authenticated unmount request from 
pate.molgen.mpg.de:1004 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)
Feb 17 10:59:58 genome mountd[3074]: authenticated mount request from 
pate.molgen.mpg.de:1005 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)
Feb 17 11:06:09 genome mountd[3079]: authenticated unmount request from 
pate.molgen.mpg.de:786 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)
Feb 17 11:06:14 genome mountd[3070]: authenticated mount request from 
pate.molgen.mpg.de:985 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)
Feb 17 11:12:24 genome mountd[3070]: authenticated unmount request from 
pate.molgen.mpg.de:1008 for /amd/genome/0/project/gbrowse 
(/amd/genome/0/project/gbrowse)


The system log on the web server is only

  tail -n +8256 /var/log/messages |egrep "Linux 
version|autofs4|automount" > messages

But of course I had a glimpse at the complete log around these times for 
other messages which might be related. Nothing...


Other hints:

   * Until now we only had a single failure on kernel 3.13.1 (described 
here) and another single failure on kernel 3.10.29. I think the bug 
frequency is lower than it used to be with 3.8
   * The two systems who have problems now belond to the group of 
systems which had problems on kernel 3.8.
   * This time it does looks like a problem during unmount. Previously 
we had some bad dentries on the very first access never received by the 
nfs server.
   * All systems are multicore of course

root:pate:/home/web/buczek/autofs-demo/# gunzip -c /proc/config.gz 
|egrep -i 'preempt|smp'
CONFIG_X86_64_SMP=y
# CONFIG_PREEMPT_RCU is not set
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_SMP=y
# CONFIG_X86_VSMP is not set
# CONFIG_MAXSMP is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PM_SLEEP_SMP=y
CONFIG_SCSI_SAS_HOST_SMP=y



So, who can make head and tail of it?


Regards
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

