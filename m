From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: When ghosting is enabled, failed mounts by AutoFS leave broken directories
Date: Tue, 25 Sep 2012 18:42:19 -0300
Message-ID: <CAEySpB4v9riQgq5Hy4g-u=rdbZQEYxwQrEm3KaYsT0hW+VjEXA@mail.gmail.com>
References: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
	<1348539229.2307.26.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EDrG/5/vVQL3mu6p2yHVELuUxd+yCD5ijpmO4RVUAxI=;
        b=VQcSSYZQM0g0ztHI2Gfx2j1mTXGsa24yXa3Z+dQxGh36ubcfdMrDsRV1Coa7tIAVXj
         jpK7nK6lRPWo2yEcDDSDFzzHEe/KN4JRXwbxMu3RzZVT/sSGwYeiylcvXtijs87N4GaZ
         VIUZeexyPKNpylG8R/z7TXk7qskXj63SaTR5HLdx0FbgtUdAvFuwNepC0I5nT+Lic/+Q
         Lmiwg60Ee2be6BJCCrhCNogLqxgrELoIM1Sw41WEasYLE3cpE0npx1G0tr2sytv9aebE
         pTFyPRLSKcbbF7oFWKxWv+kOUsnVcmwVNN8sweX3OUCRczBm9dD59Tg0yR2PICJzbjRT
         jGIg==
In-Reply-To: <1348539229.2307.26.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu

On Mon, Sep 24, 2012 at 11:13 PM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2012-09-24 at 17:14 -0300, Leonardo Chiquitto wrote:
>> Hi,
>>
>> If you try to access an automounted directory and the mount operation fails,
>> the attributes of the directory (owner, group, mode, access time) are lost.
>> This happens only when AutoFS' browse mode (ghosting) is enabled.
>>
>> How to reproduce the problem:
>>
>> Make sure you have BROWSE_MODE="yes" in /etc/sysconfig/autofs.
>>
>> 1. Add a simple indirect mount map (it's required that the server does NOT
>>    export the /notexported directory):
>>
>> # cat /etc/auto.master
>> /nfs    /etc/auto.nfs
>>
>> # cat /etc/auto.nfs
>> v2      server:/notexported
>>
>> 2. Restart AutoFS and try to access the directory:
>>
>> # cd /nfs/v2
>> -bash: cd: /nfs/v2: No such file or directory
>>
>> # ls -la /nfs
>> ls: cannot access /nfs/v2: No such file or directory
>> total 4
>> drwxr-xr-x  3 root root    0 Sep 24 21:43 .
>> drwxr-xr-x 28 root root 4096 Sep 24 21:25 ..
>> d?????????  ? ?    ?       ?            ? v2
>>
>> This problem is reproducible on recent upstream kernels such as 3.6.0-rc6.
>> I found out that the last kernel version that does not exhibit the bug is
>> 2.6.37. Between 2.6.37 and 2.6.38 there were quite some changes in
>> AutoFS/VFS and my attempts to bisect the problem were frustrated by
>> early crashes.
>>
>> Any ideas?
>
> Not really.
>
> It would be best to start with an full autofs debug log so we can see
> what is happening within automount and work back from there. We'll
> probably need to look at the dentry itself as well to see if we can get
> any info about where it came from possibly, with a kernel dump.
>
> Ian

Hi Ian,

Here are the debug logs from automount and a snapshot of the dentry
and inode of the "broken" directory (running 2.6.38).

I tried to compare it with 2.6.37 (which works), but the structures
changed a lot between these kernels.

## starting up

Sep 25 13:44:30 n1 automount[2337]: Starting automounter version
5.0.7, master map auto.master
Sep 25 13:44:30 n1 automount[2337]: using kernel protocol version 5.02
Sep 25 13:44:30 n1 automount[2337]: lookup_nss_read_master: reading
master files auto.master
Sep 25 13:44:30 n1 automount[2337]: parse_init: parse(sun): init
gathered global options: (null)
Sep 25 13:44:30 n1 automount[2337]: spawn_mount: mtab link detected,
passing -n to mount
Sep 25 13:44:30 n1 automount[2337]: spawn_umount: mtab link detected,
passing -n to mount
Sep 25 13:44:30 n1 automount[2337]: lookup_read_master: lookup(file):
read entry /nfs
Sep 25 13:44:30 n1 automount[2337]: master_do_mount: mounting /nfs
Sep 25 13:44:30 n1 automount[2337]: automount_path_to_fifo: fifo name
/run/autofs.fifo-nfs
Sep 25 13:44:30 n1 automount[2337]: lookup_nss_read_map: reading map
file /etc/auto.nfs
Sep 25 13:44:30 n1 automount[2337]: parse_init: parse(sun): init
gathered global options: (null)
Sep 25 13:44:30 n1 automount[2337]: spawn_mount: mtab link detected,
passing -n to mount
Sep 25 13:44:30 n1 automount[2337]: spawn_umount: mtab link detected,
passing -n to mount
Sep 25 13:44:30 n1 automount[2337]: mounted indirect on /nfs with
timeout 60, freq 15 seconds
Sep 25 13:44:30 n1 automount[2337]: st_ready: st_ready(): state = 0 path /nfs
Sep 25 13:44:30 n1 automount[2337]: ghosting enabled

## ls /nfs/v2

Sep 25 13:44:44 n1 automount[2337]: handle_packet: type = 3
Sep 25 13:44:44 n1 automount[2337]: handle_packet_missing_indirect:
token 6, name v2, request pid 2352
Sep 25 13:44:44 n1 automount[2337]: attempting to mount entry /nfs/v2
Sep 25 13:44:44 n1 automount[2337]: lookup_mount: lookup(file): looking up v2
Sep 25 13:44:44 n1 automount[2337]: lookup_mount: lookup(file): v2 ->
server:/nfs
Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): expanded
entry: server:/nfs
Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): gathered options:
Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun):
dequote("server:/nfs") -> server:/nfs
Sep 25 13:44:44 n1 automount[2337]: parse_mount: parse(sun): core of
entry: options=, loc=server:/nfs
Sep 25 13:44:44 n1 automount[2337]: sun_mount: parse(sun): mounting
root /nfs, mountpoint v2, what server:/nfs, fstype nfs, options (null)
Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): root=/nfs
name=v2 what=server:/nfs, fstype=nfs, options=(null)
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: called with host
server(10.1.1.4) proto tcp version 0x30
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v3 rpc ping time: 0.000214
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v2 rpc ping time: 0.000114
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: host server cost 164 weight 0
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: called with host
server(10.1.1.4) proto udp version 0x30
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v3 rpc ping time: 0.001836
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: nfs v2 rpc ping time: 0.000095
Sep 25 13:44:44 n1 automount[2337]: get_nfs_info: host server cost 965 weight 0
Sep 25 13:44:44 n1 automount[2337]: prune_host_list: selected subset
of hosts that support NFS3 over TCP
Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): calling
mkdir_path /nfs/v2
Sep 25 13:44:44 n1 automount[2337]: mount_mount: mount(nfs): calling
mount -t nfs server:/nfs /nfs/v2
Sep 25 13:44:44 n1 automount[2337]: spawn_mount: mtab link detected,
passing -n to mount
Sep 25 13:44:44 n1 checkproc: checkproc: Empty pid file
/var/run/rpc.statd.pid for /usr/sbin/rpc.statd
Sep 25 13:44:44 n1 start_daemon: start_daemon: Empty pid file
/var/run/rpc.statd.pid for /usr/sbin/rpc.statd
Sep 25 13:44:44 n1 rpc.statd[2369]: Version 1.2.6 starting
Sep 25 13:44:44 n1 rpc.statd[2369]: Flags: TI-RPC
Sep 25 13:44:44 n1 automount[2337]: >> Starting rpc.statd .....done
Sep 25 13:44:44 n1 automount[2337]: >> mount.nfs: access denied by
server while mounting server:/nfs
Sep 25 13:44:44 n1 automount[2337]: mount(nfs): nfs: mount failure
server:/nfs on /nfs/v2
Sep 25 13:44:44 n1 automount[2337]: dev_ioctl_send_fail: token = 6
Sep 25 13:44:44 n1 automount[2337]: failed to mount /nfs/v2
Sep 25 13:44:54 n1 automount[2337]: st_expire: state 1 path /nfs
Sep 25 13:44:54 n1 automount[2337]: expire_proc: exp_proc =
140484187907840 path /nfs
Sep 25 13:44:54 n1 automount[2337]: expire_cleanup: got thid
140484187907840 path /nfs stat 0
Sep 25 13:44:54 n1 automount[2337]: expire_cleanup: sigchld: exp
140484187907840 finished, switching from 2 to 1
Sep 25 13:44:54 n1 automount[2337]: st_ready: st_ready(): state = 2 path /nfs
Sep 25 13:45:09 n1 automount[2337]: st_expire: state 1 path /nfs
Sep 25 13:45:09 n1 automount[2337]: expire_proc: exp_proc =
140484187907840 path /nfs
Sep 25 13:45:09 n1 automount[2337]: expire_cleanup: got thid
140484187907840 path /nfs stat 0
Sep 25 13:45:09 n1 automount[2337]: expire_cleanup: sigchld: exp
140484187907840 finished, switching from 2 to 1
Sep 25 13:45:09 n1 automount[2337]: st_ready: st_ready(): state = 2 path /nfs

## ls -la /nfs

Sep 25 13:45:12 n1 automount[2337]: handle_packet: type = 3
Sep 25 13:45:12 n1 automount[2337]: handle_packet_missing_indirect:
token 7, name v2, request pid 2397
Sep 25 13:45:12 n1 automount[2337]: dev_ioctl_send_fail: token = 7

dentry and inode (/nfs/v2) from a v2.6.38 kernel, after triggering
the mount:

struct dentry {
  d_flags = 393216,
  d_seq = {
    sequence = 4
  },
  d_hash = {
    next = 0x0,
    pprev = 0xffffc900011f5680
  },
  d_parent = 0xffff880478fcb0c0,
  d_name = {
    hash = 238128,
    len = 2,
    name = 0xffff880478fcb3f8 "v2"
  },
  d_inode = 0xffff8804944693e0,
  d_iname = "v2\000\000\065\060\066\062\061\062fb\000Q\246\357\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
  d_count = 1,
  d_lock = {
    {
      rlock = {
        raw_lock = {
          slock = 8650884
        }
      }
    }
  },
  d_op = 0xffffffffa01f0940,
  d_sb = 0xffff880496c8f400,
  d_time = 0,
  d_fsdata = 0xffff880497262540,
  d_lru = {
    next = 0xffff880478fcb440,
    prev = 0xffff880478fcb440
  },
  d_u = {
    d_child = {
      next = 0xffff880478fcb2d0,
      prev = 0xffff880478fcb160
  },
  d_u = {
    d_child = {
      next = 0xffff880478fcb2d0,
      prev = 0xffff880478fcb160
    },
    d_rcu = {
      next = 0xffff880478fcb2d0,
      func = 0xffff880478fcb160
    }
  },
  d_subdirs = {
    next = 0xffff880478fcb460,
    prev = 0xffff880478fcb460
  },
  d_alias = {
    next = 0xffff880494469478,
    prev = 0xffff880494469478
  }
}


struct inode {
  i_mode = 16749,
  i_uid = 0,
  i_gid = 0,
  i_op = 0xffffffffa01f0880,
  i_sb = 0xffff880496c8f400,
  i_lock = {
    {
      rlock = {
        raw_lock = {
          slock = 65537
        }
      }
    }
  },
  i_flags = 0,
  i_mutex = {
    count = {
      counter = 1
    },
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            slock = 0
          }
        }
      }
    },
    wait_list = {
      next = 0xffff880494469410,
      prev = 0xffff880494469410
    },
    owner = 0x0
  },
  i_state = 0,
  dirtied_when = 0,
  i_hash = {
    next = 0x0,
    pprev = 0x0
  },
  i_wb_list = {
    next = 0xffff880494469448,
    prev = 0xffff880494469448
  },
  i_lru = {
    next = 0xffff880494469458,
    prev = 0xffff880494469458
  },
  i_sb_list = {
    next = 0xffff8804944a68d8,
    prev = 0xffff880496c8f4c0
  },
  {
    i_dentry = {
      next = 0xffff880478fcb470,
      prev = 0xffff880478fcb470
    },
    i_rcu = {
      next = 0xffff880478fcb470,
      func = 0xffff880478fcb470
    }
  },
  i_ino = 120539,
  i_count = {
    counter = 1
  },
  i_nlink = 2,
  i_rdev = 0,
  i_blkbits = 10,
  i_version = 0,
  i_size = 0,
  i_atime = {
    tv_sec = 1348605652,
    tv_nsec = 807650231
  },
  i_mtime = {
    tv_sec = 1348605652,
    tv_nsec = 807650231
  },
  i_ctime = {
    tv_sec = 1348605652,
    tv_nsec = 807650231
  },
  i_blocks = 0,
  i_bytes = 0,
  i_alloc_sem = {
    count = 0,
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            slock = 0
          }
        }
      }
    },
    wait_list = {
      next = 0xffff880494469500,
      prev = 0xffff880494469500
    }
  },
  i_fop = 0xffffffffa01f07a0,
  i_flock = 0x0,
  i_mapping = 0xffff880494469528,
  i_data = {
    host = 0xffff8804944693e0,
    page_tree = {
      height = 0,
      gfp_mask = 32,
      rnode = 0x0
    },
    tree_lock = {
      {
        rlock = {
          raw_lock = {
            slock = 0
          }
        }
      }
    },
    i_mmap_writable = 0,
    i_mmap = {
      prio_tree_node = 0x0,
      index_bits = 1,
      raw = 1
    },
    i_mmap_nonlinear = {
      next = 0xffff880494469558,
      prev = 0xffff880494469558
    },
    i_mmap_lock = {
      {
        rlock = {
          raw_lock = {
            slock = 0
          }
        }
      }
    },
    truncate_count = 0,
    nrpages = 0,
    writeback_index = 0,
    a_ops = 0xffffffff81d79300,
    flags = 131290,
    backing_dev_info = 0xffffffff81a261c0,
    private_lock = {
      {
        rlock = {
          raw_lock = {
            slock = 0
          }
        }
      }
    },
    private_list = {
      next = 0xffff8804944695a0,
      prev = 0xffff8804944695a0
    },
    assoc_mapping = 0x0,
    unmap_mutex = {
      count = {
        counter = 1
      },
      wait_lock = {
        {
          rlock = {
            raw_lock = {
              slock = 0
            }
          }
        }
      },
      wait_list = {
        next = 0xffff8804944695c0,
        prev = 0xffff8804944695c0
      },
      owner = 0x0
    }
  },
  i_dquot = {0x0, 0x0},
  i_devices = {
    next = 0xffff8804944695e8,
    prev = 0xffff8804944695e8
  },
  {
    i_pipe = 0x0,
    i_bdev = 0x0,
    i_cdev = 0x0
  },
  i_generation = 0,
  i_fsnotify_mask = 0,
  i_fsnotify_marks = {
    first = 0x0
  },
  i_writecount = {
    counter = 0
  },
  i_security = 0x0,
  i_acl = 0xffffffffffffffff,
  i_default_acl = 0xffffffffffffffff,
  i_private = 0x0
}

Thanks,
Leonardo
