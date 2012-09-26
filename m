From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: When ghosting is enabled, failed mounts by AutoFS leave broken directories
Date: Wed, 26 Sep 2012 16:39:45 -0300
Message-ID: <CAEySpB4duT0r6xJTrvkS+YK4-qhVFCyxzJfF0sQdUaSmVfDfuA@mail.gmail.com>
References: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
	<1348539229.2307.26.camel@perseus.themaw.net>
	<CAEySpB4v9riQgq5Hy4g-u=rdbZQEYxwQrEm3KaYsT0hW+VjEXA@mail.gmail.com>
	<1348650908.2281.21.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qF1zrG4g4zL8Qqx/cw8lue5bFl+RGUc763fuJx/aTs4=;
        b=lv+ry23dmM0nrW2R+9f6jYZ3WGJfy/YoptmGypoQ+OOFD+T9sWN9os/y/q6WEiEj1V
         wrTqZzMn6yVRW5LOXQM5sVBytJhaFfqq3FVMDS7Wv12NVm5a3cA7U7YWBU4+7deKpJea
         z7sF8oEofZpMEVIf3DDsfy0SbDJYDtZYcYzhazZD8rTj28uwT/hX9ILz7JeFzdKecC1R
         Z+QosBA/a4FZuz9KA33koPnn53+O1RpvQ+uQeOikNdC+AFvLGi1MTog6Tm5cLx7oGJxU
         ++8Z3J5FAmcxVt9s8ypnfq6XJ47GdDnpV8NsUEZRxC3Uy7dCW5OELIwh/2+7DJiV6JBA
         o2QQ==
In-Reply-To: <1348650908.2281.21.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu

On Wed, Sep 26, 2012 at 6:15 AM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2012-09-25 at 18:42 -0300, Leonardo Chiquitto wrote:
>> On Mon, Sep 24, 2012 at 11:13 PM, Ian Kent <raven@themaw.net> wrote:
>> > On Mon, 2012-09-24 at 17:14 -0300, Leonardo Chiquitto wrote:
>> >> Hi,
>> >>
>> >> If you try to access an automounted directory and the mount operation fails,
>> >> the attributes of the directory (owner, group, mode, access time) are lost.
>> >> This happens only when AutoFS' browse mode (ghosting) is enabled.
>> >>
>> >> How to reproduce the problem:
>> >>
>> >> Make sure you have BROWSE_MODE="yes" in /etc/sysconfig/autofs.
>> >>
>> >> 1. Add a simple indirect mount map (it's required that the server does NOT
>> >>    export the /notexported directory):
>> >>
>> >> # cat /etc/auto.master
>> >> /nfs    /etc/auto.nfs
>> >>
>> >> # cat /etc/auto.nfs
>> >> v2      server:/notexported
>> >>
>> >> 2. Restart AutoFS and try to access the directory:
>> >>
>> >> # cd /nfs/v2
>> >> -bash: cd: /nfs/v2: No such file or directory
>> >>
>> >> # ls -la /nfs
>> >> ls: cannot access /nfs/v2: No such file or directory
>> >> total 4
>> >> drwxr-xr-x  3 root root    0 Sep 24 21:43 .
>> >> drwxr-xr-x 28 root root 4096 Sep 24 21:25 ..
>> >> d?????????  ? ?    ?       ?            ? v2
>> >>
>> >> This problem is reproducible on recent upstream kernels such as 3.6.0-rc6.
>> >> I found out that the last kernel version that does not exhibit the bug is
>> >> 2.6.37. Between 2.6.37 and 2.6.38 there were quite some changes in
>> >> AutoFS/VFS and my attempts to bisect the problem were frustrated by
>> >> early crashes.
>> >>
>> >> Any ideas?
>> >
>> > Not really.
>> >
>> > It would be best to start with an full autofs debug log so we can see
>> > what is happening within automount and work back from there. We'll
>> > probably need to look at the dentry itself as well to see if we can get
>> > any info about where it came from possibly, with a kernel dump.
>> >
>> > Ian
>>
>> Hi Ian,
>>
>> Here are the debug logs from automount and a snapshot of the dentry
>> and inode of the "broken" directory (running 2.6.38).
>>
>> I tried to compare it with 2.6.37 (which works), but the structures
>> changed a lot between these kernels.
>
> A great deal changed in 2.6.38 in the VFS.
>
> You really can't use 2.6.38 because there were a number of fixes that
> went in after this and I think the VFS code up to around 3.0 or 3.1
> could have had this problem anyway.

I'm using 3.6.0-rc6 here. I collected the data from 2.6.38 because this
is the first kernel that shows the bug and I thought it would be easier
to isolate the fix this way (smaller distance).

> What your looking for is kernels with fs/namei.c:follow_automount() with
> this near the top of the function, which shouldn't cause this type of
> problem:
>
>        /* We don't want to mount if someone's just doing a stat -
>          * unless they're stat'ing a directory and appended a '/' to
>          * the name.
>          *
>          * We do, however, want to mount if someone wants to open or
>          * create a file of any type under the mountpoint, wants to
>          * traverse through the mountpoint or wants to open the
>          * mounted directory.  Also, autofs may mark negative dentries
>          * as being automount points.  These will need the attentions
>          * of the daemon to instantiate them before they can be used.
>          */
>         if (!(flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
>                      LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>             path->dentry->d_inode)
>                 return -EISDIR;
>
> But I'm seeing this with 3.4.9-2.fc16 which does have this in
> follow_automount() so that's a puzzle.
>
>>
>> ## starting up
>>
>> Sep 25 13:44:30 n1 automount[2337]: Starting automounter version
>> 5.0.7, master map auto.master
>> Sep 25 13:44:30 n1 automount[2337]: using kernel protocol version 5.02
>> Sep 25 13:44:30 n1 automount[2337]: lookup_nss_read_master: reading
>> master files auto.master
>> Sep 25 13:44:30 n1 automount[2337]: parse_init: parse(sun): init
>> gathered global options: (null)
>> Sep 25 13:44:30 n1 automount[2337]: spawn_mount: mtab link detected,
>> passing -n to mount
>> Sep 25 13:44:30 n1 automount[2337]: spawn_umount: mtab link detected,
>> passing -n to mount
>> Sep 25 13:44:30 n1 automount[2337]: lookup_read_master: lookup(file):
>> read entry /nfs
>> Sep 25 13:44:30 n1 automount[2337]: master_do_mount: mounting /nfs
>> Sep 25 13:44:30 n1 automount[2337]: automount_path_to_fifo: fifo name
>> /run/autofs.fifo-nfs
>> Sep 25 13:44:30 n1 automount[2337]: lookup_nss_read_map: reading map
>> file /etc/auto.nfs
>> Sep 25 13:44:30 n1 automount[2337]: parse_init: parse(sun): init
>> gathered global options: (null)
>> Sep 25 13:44:30 n1 automount[2337]: spawn_mount: mtab link detected,
>> passing -n to mount
>> Sep 25 13:44:30 n1 automount[2337]: spawn_umount: mtab link detected,
>> passing -n to mount
>> Sep 25 13:44:30 n1 automount[2337]: mounted indirect on /nfs with
>> timeout 60, freq 15 seconds
>> Sep 25 13:44:30 n1 automount[2337]: st_ready: st_ready(): state = 0 path /nfs
>> Sep 25 13:44:30 n1 automount[2337]: ghosting enabled
>>
>> ## ls /nfs/v2
>>
>> Sep 25 13:44:44 n1 automount[2337]: handle_packet: type = 3
>> Sep 25 13:44:44 n1 automount[2337]: handle_packet_missing_indirect:
>> token 6, name v2, request pid 2352
>> Sep 25 13:44:44 n1 automount[2337]: attempting to mount entry /nfs/v2
>> Sep 25 13:44:44 n1 automount[2337]: lookup_mount: lookup(file): looking up v2
>> Sep 25 13:44:44 n1 automount[2337]: lookup_mount: lookup(file): v2 ->
>> server:/nfs
>> Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): expanded
>> entry: server:/nfs
>> Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): gathered options:
>> Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun):
>> dequote("server:/nfs") -> server:/nfs
>> Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): core of
>> entry: options=, loc=server:/nfs
>> Sep 25 13:44:44 n1 automount[2337]: sun_mount: parse(sun): mounting
>> root /nfs, mountpoint v2, what server:/nfs, fstype nfs, options (null)
>> Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): root=/nfs
>> name=v2 what=server:/nfs, fstype=nfs, options=(null)
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: called with host
>> server(10.1.1.4) proto tcp version 0x30
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v3 rpc ping time: 0.000214
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v2 rpc ping time: 0.000114
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: host server cost 164 weight 0
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: called with host
>> server(10.1.1.4) proto udp version 0x30
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v3 rpc ping time: 0.001836
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v2 rpc ping time: 0.000095
>> Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: host server cost 965 weight 0
>> Sep 25 13:44:44 n1 automount[2337]: prune_host_list: selected subset
>> of hosts that support NFS3 over TCP
>> Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): calling
>> mkdir_path /nfs/v2
>> Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): calling
>> mount -t nfs server:/nfs /nfs/v2
>> Sep 25 13:44:44 n1 automount[2337]: spawn_mount: mtab link detected,
>> passing -n to mount
>> Sep 25 13:44:44 n1 checkproc: checkproc: Empty pid file
>> /var/run/rpc.statd.pid for /usr/sbin/rpc.statd
>> Sep 25 13:44:44 n1 start_daemon: start_daemon: Empty pid file
>> /var/run/rpc.statd.pid for /usr/sbin/rpc.statd
>> Sep 25 13:44:44 n1 rpc.statd[2369]: Version 1.2.6 starting
>> Sep 25 13:44:44 n1 rpc.statd[2369]: Flags: TI-RPC
>> Sep 25 13:44:44 n1 automount[2337]: >> Starting rpc.statd .....done
>> Sep 25 13:44:44 n1 automount[2337]: >> mount.nfs: access denied by
>> server while mounting server:/nfs
>> Sep 25 13:44:44 n1 automount[2337]: mount(nfs): nfs: mount failure
>> server:/nfs on /nfs/v2
>> Sep 25 13:44:44 n1 automount[2337]: dev_ioctl_send_fail: token = 6
>> Sep 25 13:44:44 n1 automount[2337]: failed to mount /nfs/v2
>> Sep 25 13:44:54 n1 automount[2337]: st_expire: state 1 path /nfs
>> Sep 25 13:44:54 n1 automount[2337]: expire_proc: exp_proc =
>> 140484187907840 path /nfs
>> Sep 25 13:44:54 n1 automount[2337]: expire_cleanup: got thid
>> 140484187907840 path /nfs stat 0
>> Sep 25 13:44:54 n1 automount[2337]: expire_cleanup: sigchld: exp
>> 140484187907840 finished, switching from 2 to 1
>> Sep 25 13:44:54 n1 automount[2337]: st_ready: st_ready(): state = 2 path /nfs
>> Sep 25 13:45:09 n1 automount[2337]: st_expire: state 1 path /nfs
>> Sep 25 13:45:09 n1 automount[2337]: expire_proc: exp_proc =
>> 140484187907840 path /nfs
>> Sep 25 13:45:09 n1 automount[2337]: expire_cleanup: got thid
>> 140484187907840 path /nfs stat 0
>> Sep 25 13:45:09 n1 automount[2337]: expire_cleanup: sigchld: exp
>> 140484187907840 finished, switching from 2 to 1
>> Sep 25 13:45:09 n1 automount[2337]: st_ready: st_ready(): state = 2 path /nfs
>>
>> ## ls -la /nfs
>>
>> Sep 25 13:45:12 n1 automount[2337]: handle_packet: type = 3
>> Sep 25 13:45:12 n1 automount[2337]: handle_packet_missing_indirect:
>> token 7, name v2, request pid 2397
>> Sep 25 13:45:12 n1 automount[2337]: dev_ioctl_send_fail: token = 7
>
> This callback shouldn't happen.
>
>>
>> dentry and inode (/nfs/v2) from a v2.6.38 kernel, after triggering
>> the mount:
>
> This certainly looks like an autofs dentry.
>
>>
>> struct dentry {
>>   d_flags = 393216,
>>   d_seq = {
>>     sequence = 4
>>   },
>>   d_hash = {
>>     next = 0x0,
>>     pprev = 0xffffc900011f5680
>>   },
>
> This looks a bit odd but I don't think it is the cause of the problem.
>
> Other than that these look ok.
>
> snip ...
>
> I setup a simple map, auto.test, with a single key "this" to check this
> out and did an "strace -ff -o ls.trace /bin/ls --color=auto /test"
> against the 3.4.9-2.fc16 I currently have installed.
>
> Ignoring all the cruft, near the bottom we see:
> stat64("/test", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> openat(AT_FDCWD, "/test", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
> getdents64(3, /* 3 entries */, 32768)   = 72
> lstat64("/test/this", 0x95aba40)        = -1 ENOENT (No such file or directory)

This happens only after there was an attempt to mount /test/this
and the directory is already in the "incomplete" state, right?

> This is the problem I think, it should not attempt a mount and should
> return 0.

My theory about the root cause is that when the mount fails, the
kernel forgets to "reset" the state of that dentry. Makes any sense?

> I've only looked at the current upstream source so far and I can't see
> why this is happening.
>
> I've built upstream 3.5.4 so I can look at the actual source of the
> kernel I'm using to test.

Thanks for your help
Leonardo
