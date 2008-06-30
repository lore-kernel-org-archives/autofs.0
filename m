From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: More autofs problems
Date: Mon, 30 Jun 2008 10:08:11 +0200
Message-ID: <4868946B.7050801@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

Hi again,

last weekend went quite bad for our nodes and autofs seem to die quite often. 
Caveat: We had some networking problems during the weekend as well so this might
be triggered by failing network connections:

Jun 28 01:05:17 n1035 mountd[32688]: authenticated mount request from 10.10.11.47:603 for /local (/local)
Jun 28 01:05:24 n1035 mountd[32665]: authenticated mount request from 10.10.10.33:644 for /local (/local)
Jun 28 01:05:32 n1035 kernel: [1956924.510009] Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
Jun 28 01:05:32 n1035 kernel: [1956924.510027]  [<ffffffff802710c4>] fput+0x0/0x11
Jun 28 01:05:32 n1035 kernel: [1956924.510466] PGD d0a52067 PUD d0841067 PMD 0
Jun 28 01:05:32 n1035 kernel: [1956924.510621] Oops: 0002 [1] SMP
Jun 28 01:05:32 n1035 kernel: [1956924.510773] CPU 3
Jun 28 01:05:32 n1035 kernel: [1956924.510919] Modules linked in: nfs nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs autofs4 ipmi_si ipmi_devintf i
pmi_watchdog ipmi_poweroff ipmi_msghandler i2c_i801 8250_pnp 8250 i2c_core e1000 serial_core
Jun 28 01:05:32 n1035 kernel: [1956924.511407] Pid: 25000, comm: get_file Not tainted 2.6.24.4-nodes #1
Jun 28 01:05:32 n1035 kernel: [1956924.511567] RIP: 0010:[<ffffffff802710c4>]  [<ffffffff802710c4>] fput+0x0/0x11
Jun 28 01:05:32 n1035 kernel: [1956924.511862] RSP: 0018:ffff8100e792b950  EFLAGS: 00010246
Jun 28 01:05:32 n1035 kernel: [1956924.512014] RAX: 0000000000000001 RBX: ffff81020f26d180 RCX: ffff810216941408
Jun 28 01:05:32 n1035 kernel: [1956924.512307] RDX: fffffffffffffe00 RSI: 0000000000000206 RDI: 0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.512608] RBP: 0000000000000000 R08: ffff8100e792a000 R09: 0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.512902] R10: 0000000000000000 R11: ffff810216ae2e80 R12: ffff81020b2a8a80
Jun 28 01:05:32 n1035 kernel: [1956924.513197] R13: ffff8100e792b9e8 R14: ffff810000000000 R15: 0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.513492] FS:  0000000040401960(0063) GS:ffff810217c771c0(0000) knlGS:0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.513791] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 28 01:05:32 n1035 kernel: [1956924.513945] CR2: 0000000000000028 CR3: 00000000e4c85000 CR4: 00000000000006e0
Jun 28 01:05:32 n1035 kernel: [1956924.514239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.514535] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jun 28 01:05:32 n1035 kernel: [1956924.514831] Process get_file (pid: 25000, threadinfo ffff8100e792a000, task ffff8100d3005850)
Jun 28 01:05:32 n1035 kernel: [1956924.515128] Stack:  ffffffff8806dc26 ffff81020f26d180 ffff81012d1db5c0 0000000000000110
Jun 28 01:05:32 n1035 kernel: [1956924.515433]  ffffffff8806e222 000000011781cb40 ffff81020b2a8a80 ffff81021781cb40
Jun 28 01:05:32 n1035 kernel: [1956924.515734]  ffff810217c2d680 ffff8100e792ba18 0000000000000000 0000000000000000
Jun 28 01:05:32 n1035 kernel: [1956924.515895] Call Trace:
Jun 28 01:05:32 n1035 kernel: [1956924.516186]  [<ffffffff8806dc26>] :autofs4:autofs4_catatonic_mode+0x5e/0x6c
Jun 28 01:05:32 n1035 kernel: [1956924.516346]  [<ffffffff8806e222>] :autofs4:autofs4_wait+0x5a2/0x76d
Jun 28 01:05:32 n1035 kernel: [1956924.516509]  [<ffffffff8027ec71>] dput+0x1c/0x10b
Jun 28 01:05:32 n1035 kernel: [1956924.516667]  [<ffffffff8806ccfd>] :autofs4:try_to_fill_dentry+0x6d/0xf1
Jun 28 01:05:32 n1035 kernel: [1956924.516826]  [<ffffffff8806cf7b>] :autofs4:autofs4_revalidate+0xa6/0x17e
Jun 28 01:05:32 n1035 kernel: [1956924.516983]  [<ffffffff8031ef47>] xfs_vn_permission+0x0/0x17
Jun 28 01:05:32 n1035 kernel: [1956924.517139]  [<ffffffff8806d35f>] :autofs4:autofs4_lookup+0x289/0x33e
Jun 28 01:05:32 n1035 kernel: [1956924.517297]  [<ffffffff80276cc6>] do_lookup+0xc2/0x1b8
Jun 28 01:05:32 n1035 kernel: [1956924.517452]  [<ffffffff8027725e>] __link_path_walk+0x365/0xd0a
Jun 28 01:05:32 n1035 kernel: [1956924.517627]  [<ffffffff8811abc6>] :nfs:nfs_writepages_callback+0x0/0x1e
Jun 28 01:05:32 n1035 kernel: [1956924.517785]  [<ffffffff80277c52>] link_path_walk+0x4f/0xcb
Jun 28 01:05:32 n1035 kernel: [1956924.517941]  [<ffffffff8026f7cc>] get_unused_fd_flags+0x77/0x112
Jun 28 01:05:32 n1035 kernel: [1956924.518097]  [<ffffffff80277e6f>] do_path_lookup+0x1a1/0x1c5
Jun 28 01:05:32 n1035 kernel: [1956924.518252]  [<ffffffff80277fa8>] __path_lookup_intent_open+0x50/0x8d
Jun 28 01:05:32 n1035 kernel: [1956924.518409]  [<ffffffff802787e2>] open_namei+0x86/0x606
Jun 28 01:05:32 n1035 kernel: [1956924.518568]  [<ffffffff8026f652>] do_filp_open+0x1c/0x3d
Jun 28 01:05:32 n1035 kernel: [1956924.518723]  [<ffffffff8026f7cc>] get_unused_fd_flags+0x77/0x112
Jun 28 01:05:32 n1035 kernel: [1956924.518880]  [<ffffffff8026f979>] do_sys_open+0x46/0xca
Jun 28 01:05:32 n1035 kernel: [1956924.519034]  [<ffffffff8020be0e>] system_call+0x7e/0x83
Jun 28 01:05:32 n1035 kernel: [1956924.519187]
Jun 28 01:05:32 n1035 kernel: [1956924.519331]
Jun 28 01:05:32 n1035 kernel: [1956924.519332] Code: f0 ff 4f 28 0f 94 c0 84 c0 74 05 e9 92 fe ff ff c3 65 48 8b
Jun 28 01:05:32 n1035 kernel: [1956924.519813] RIP  [<ffffffff802710c4>] fput+0x0/0x11
Jun 28 01:05:32 n1035 kernel: [1956924.519967]  RSP <ffff8100e792b950>
Jun 28 01:05:32 n1035 kernel: [1956924.520115] CR2: 0000000000000028
Jun 28 01:05:32 n1035 kernel: [1956924.521139] ---[ end trace 436b46a0e9d6c8a6 ]---

We get several of these after one antoher. A little bit later we get:

Jun 28 01:05:32 n1035 rpc.idmapd[2133]: nfsopen: open(/var/lib/nfs/rpc_pipefs/nfs/clnt32d3/idmap): Too many open files
Jun 28 01:05:32 n1035 last message repeated 2 times
Jun 28 01:05:35 n1035 mountd[32665]: authenticated unmount request from 10.10.8.70:867 for /local (/local)
Jun 28 01:05:50 n1035 mountd[32627]: authenticated unmount request from 10.10.13.37:600 for /local (/local)
Jun 28 01:05:52 n1035 rpc.idmapd[2133]: nfsopen: open(/var/lib/nfs/rpc_pipefs/nfs/clnt32d3/idmap): Too many open files
Jun 28 01:05:52 n1035 last message repeated 2 times
Jun 28 01:05:52 n1035 automount[18299]: AUTOFS_IOC_READY: Invalid argument
Jun 28 01:05:52 n1035 last message repeated 5 times
Jun 28 01:05:52 n1035 rpc.idmapd[2133]: nfsopen: open(/var/lib/nfs/rpc_pipefs/nfs/clnt32d3/idmap): Too many open files
Jun 28 01:05:53 n1035 last message repeated 10 times
Jun 28 01:05:53 n1035 automount[31737]: >> mount: n1037:/local failed, reason given by server: Permission denied
Jun 28 01:05:53 n1035 automount[31756]: >> mount: n0197:/local failed, reason given by server: Permission denied
Jun 28 01:05:53 n1035 automount[31743]: >> nfs bindresvport: Address already in use
Jun 28 01:05:53 n1035 automount[31766]: >> mount: n0365:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31754]: >> mount: n0717:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31778]: >> mount: n0986:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31739]: >> mount: n1315:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31774]: >> mount: n0919:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31781]: >> mount: n0006:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31741]: >> mount: n0592:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31753]: >> mount: n1080:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31757]: >> mount: n0168:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[18299]: AUTOFS_IOC_READY: Invalid argument
Jun 28 01:05:53 n1035 automount[31787]: >> mount: n0677:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31785]: >> mount: n0806:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31760]: >> mount: n0868:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31756]: mount(nfs): nfs: mount failure n0197:/local on /atlas/node/n0197
Jun 28 01:05:53 n1035 automount[31737]: mount(nfs): nfs: mount failure n1037:/local on /atlas/node/n1037
Jun 28 01:05:53 n1035 automount[31745]: >> mount: n1105:/local: can't read superblock
Jun 28 01:05:53 n1035 automount[31743]: mount(nfs): nfs: mount failure n0937:/local on /atlas/node/n0937
Jun 28 01:05:53 n1035 rpc.idmapd[2133]: nfsopen: open(/var/lib/nfs/rpc_pipefs/nfs/clnt32d3/idmap): Too many open files
Jun 28 01:05:53 n1035 automount[31753]: mount(nfs): nfs: mount failure n1080:/local on /atlas/node/n1080


I guess since the mounts are not umounted anymore that should explain why we run out of ports.

Any suggestions? Do you know this error?

Again these boxes are all Debian Etch with 2.6.24.4 kernel (vanilla). and autof  4.1.4-13 on amd64.

TIA

Carsten
