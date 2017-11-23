From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 11:04:06 +0800
Message-ID: <fc518261-eaba-2172-d50e-b117f09442fa@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <87375520qy.fsf@notabene.neil.brown.name>
 <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=aUgwhFtrsYVyXN5UC0Eonbk2L5b1Z
        oR8B3uZSeWYEgc=; b=MwzySNU/K19Pf3jnVqHJDc6p8+FSCPpMtJxT5/rJKBntM
        IFIh8brUgXN0GWhtT1J7vZuTlb6kZxq1N1XgpQSZqiIjGc81l2uQ+SDHRxpTF3sf
        poAen+yHDOg3P6r6KucVbQEoNFgb1ItbC7xdnex7KxH7cWkN8w7I5VtEnwQzfq+I
        MaPbdfvHN1Kl08LwmAvGQ1TUFZ225WgQ59JSlqB4Q4zWAjhHVO95HXDq8iASD0iD
        BRxOZiikuOBz2jlqq59zm8/xlv23IF1SmVD7qymHsOK4sfTwYDynVoM5T5Ry5C7C
        ZHpPfv8mP/b4gEOCqZr+ayeKEpm+RMOVDdfsPerYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aUgwhF
        trsYVyXN5UC0Eonbk2L5b1ZoR8B3uZSeWYEgc=; b=KXjFDCacNI4X+aC567ZTQx
        LM8rgKWN5gfydPzBtIRrB1tS5UwQiAATFBv4nG3hHY+8+ygN+82BuVzaLy1DlVDW
        gcGBhXtn+ZQPEmRed2YETwubNaBp0OkuBInSG4WxiYNgFXxDDbPPtrZ6e+gOhX54
        Zm/fh3wf+AScFnIcqcFwirfQ5Rnqg6tkUAlCykn9VgfnqQcR5BcbAYMFqufcWCVn
        m1aJisS9IarUXH1tZAMumtXueYV5c/zfvH3yH3Nszdd4WY7Gk8YNxqMwAwC2NVK2
        QHTM5xQCKNqCN2vSjedyz2cPSf5sRrJROxwrNCHO9Z+DlpnZ2dOK7EqEN1HW47Sw
        ==
In-Reply-To: <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 23/11/17 10:46, Ian Kent wrote:
> On 23/11/17 10:21, NeilBrown wrote:
>> On Thu, Nov 23 2017, Ian Kent wrote:
>>
>>>
>>> Hey Neil, I'm looking at this again because RH QE have complained about
>>> a regression test failing with a kernel that has this change.
>>>
>>> Maybe I'm just dumb but I though a "find <base directory> <options>"
>>> would, well, just look at the contents below <base directory> but an
>>> strace shows that it reads and calls fstatat() on "every entry in the
>>> mount table" regardless of the path.
>>
>> weird ... I can only get find to look at the mount table if given the
>> -fstyp option, and even then it doesn't fstatat anything that isn't in
>> the tree it is searching.
> 
> It's probably the -xautofs (exclude autofs fs'es) that was used in
> the test that requires reading the mount table to get info about
> excluding autofs mounts but the fstatat() on all the entries,
> regardless of path, that was a surprise to me.
> 
> find did use AT_SYMLINK_NOFOLLOW which historically behaved like
> AT_NO_AUTOMOUNT.

Check this simple reproducer out:

[root@intel-mahobay-02 ~]# uname -r
4.14.0-0.rc8.2.el7a.x86_64
[root@intel-mahobay-02 ~]# cat /etc/exports
/exportdir-bz1482065 *(rw,no_root_squash)
[root@intel-mahobay-02 ~]# cat /etc/auto.master
/- /etc/auto.direct
[root@intel-mahobay-02 ~]# cat /etc/auto.direct 
/mnt/autofs/test localhost:/exportdir-bz1482065
[root@intel-mahobay-02 ~]# ls /mnt/autofs/
bz1482065  test
[root@intel-mahobay-02 ~]# ls /exportdir-bz1482065
bz1482065
[root@intel-mahobay-02 ~]# find /mnt/autofs -xautofs  -name '*bz1482065*'
[root@intel-mahobay-02 ~]# find /mnt/autofs -xautofs  -name '*bz1482065*'
/mnt/autofs/bz1482065
/mnt/autofs/test/bz1482065

The first find mounts the direct mount /mnt/autofs/test/bz1482065 which causes the
second to list /mnt/autofs/bz1482065 (not sure yet where this comes from, it must
be a plain directory within /mnt/autofs) and the now mounted bind mount (ie. the
localhost: host name in the map entry) /mnt/autofs/test/bz1482065.

The strace is:
execve("/usr/bin/find", ["find", "/mnt/autofs", "-xautofs", "-name", "*bz1482065*"], [/* 45 vars */]) = 0

snip ...

newfstatat(AT_FDCWD, "/mnt/autofs", {st_mode=S_IFDIR|0755, st_size=35, ...}, AT_SYMLINK_NOFOLLOW) = 0
open("/etc/mtab", O_RDONLY|O_CLOEXEC)   = 4
futex(0x7efec9ba55b0, FUTEX_WAKE_PRIVATE, 2147483647) = 0
fstat(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7efeca2ea000
read(4, "sysfs /sys sysfs rw,seclabel,nos"..., 1024) = 1024
read(4, "oup/net_cls,net_prio cgroup rw,n"..., 1024) = 1024
read(4, "ges hugetlbfs rw,seclabel,relati"..., 1024) = 594
read(4, "", 1024)                       = 0
close(4)                                = 0
munmap(0x7efeca2ea000, 4096)            = 0
newfstatat(AT_FDCWD, "/sys", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/proc", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/dev", {st_mode=S_IFDIR|0755, st_size=3280, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/kernel/security", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/dev/shm", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=40, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/dev/pts", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/run", {st_mode=S_IFDIR|0755, st_size=1020, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup", {st_mode=S_IFDIR|0755, st_size=340, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/systemd", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/pstore", {st_mode=S_IFDIR|0750, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/blkio", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/cpu,cpuacct", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/pids", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/net_cls,net_prio", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/devices", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/freezer", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/perf_event", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/cpuset", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/memory", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/cgroup/hugetlb", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/kernel/config", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/", {st_mode=S_IFDIR|0555, st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/fs/selinux", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/proc/sys/fs/binfmt_misc", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/sys/kernel/debug", {st_mode=S_IFDIR|0700, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/dev/mqueue", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=40, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/dev/hugepages", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/proc/fs/nfsd", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/boot", {st_mode=S_IFDIR|0555, st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/home", {st_mode=S_IFDIR|0755, st_size=18, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/var/lib/nfs/rpc_pipefs", {st_mode=S_IFDIR|0555, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/run/user/0", {st_mode=S_IFDIR|0700, st_size=40, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/proc/sys/fs/binfmt_misc", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/mnt/autofs/test", {st_mode=S_IFDIR|0755, st_size=23, ...}, AT_SYMLINK_NOFOLLOW) = 0
fchdir(3)                               = 0
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
exit_group(0)                           = ?

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
