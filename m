From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 0/8] Simplefs: group and simplify linux fs code
Date: Tue, 14 Apr 2020 14:42:54 +0200
Message-ID: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/POKEOLp9vZEVM8oe9bfw+hku4DjEqFg+cEEJO5a6SA=;
 b=LwitRFAFFlR74gfPd73DxycdvFXay5jMKwrMvyMY50osO/WaIg1ABFklrCKyfQTu5z0HQb
 YKKHPgoT4kVStMDd/b7L1XMdSrX3HS3dibV1Q3OAoT8jJZnfQwZS7YhyVWJRb+3ahWfC23
 TRSEwRC+i1vxtbM+L1tdkGXnDLfsdro=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-nfs@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.>

This series of patches introduce wrappers for functions,
arguments simplification in functions calls and most importantly
groups duplicated code in a single header, simplefs, to avoid redundancy
in the linux fs, especially debugfs and tracefs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

Emanuele Giuseppe Esposito (8):
  apparmor: just use vfs_kern_mount to make .null
  fs: extract simple_pin/release_fs to separate files
  fs: wrap simple_pin_fs/simple_release_fs arguments in a struct
  fs: introduce simple_new_inode
  simplefs: add alloc_anon_inode wrapper
  simplefs: add file creation functions
  debugfs: switch to simplefs inode creation API
  tracefs: switch to simplefs inode creation API

 arch/powerpc/platforms/cell/spufs/inode.c |   4 +-
 arch/s390/hypfs/inode.c                   |   4 +-
 drivers/gpu/drm/Kconfig                   |   1 +
 drivers/gpu/drm/drm_drv.c                 |  13 +-
 drivers/infiniband/hw/qib/qib_fs.c        |   6 +-
 drivers/misc/cxl/Kconfig                  |   1 +
 drivers/misc/cxl/api.c                    |  14 +-
 drivers/misc/ibmasm/ibmasmfs.c            |   8 +-
 drivers/misc/ocxl/Kconfig                 |   1 +
 drivers/oprofile/oprofilefs.c             |   8 +-
 drivers/scsi/cxlflash/ocxl_hw.c           |  15 +-
 drivers/usb/gadget/function/f_fs.c        |   8 +-
 fs/Kconfig                                |   3 +
 fs/Kconfig.binfmt                         |   1 +
 fs/Makefile                               |   1 +
 fs/autofs/inode.c                         |   4 +-
 fs/binfmt_misc.c                          |  27 +--
 fs/configfs/Kconfig                       |   1 +
 fs/configfs/mount.c                       |  12 +-
 fs/debugfs/inode.c                        | 171 +++----------------
 fs/efivarfs/inode.c                       |   4 +-
 fs/fuse/control.c                         |   4 +-
 fs/hugetlbfs/inode.c                      |   8 +-
 fs/libfs.c                                |  48 ++----
 fs/ocfs2/dlmfs/dlmfs.c                    |   8 +-
 fs/proc/base.c                            |   4 +-
 fs/proc/proc_sysctl.c                     |   5 +-
 fs/pstore/inode.c                         |  14 +-
 fs/ramfs/inode.c                          |   4 +-
 fs/simplefs.c                             | 194 ++++++++++++++++++++++
 fs/tracefs/inode.c                        | 108 ++----------
 include/linux/fs.h                        |   3 +-
 include/linux/simplefs.h                  |  36 ++++
 ipc/mqueue.c                              |   4 +-
 kernel/bpf/inode.c                        |   7 +-
 lib/Kconfig.debug                         |  16 +-
 mm/shmem.c                                |   4 +-
 net/sunrpc/rpc_pipe.c                     |   4 +-
 security/Kconfig                          |   1 +
 security/apparmor/apparmorfs.c            |  48 +++---
 security/inode.c                          |  17 +-
 41 files changed, 385 insertions(+), 459 deletions(-)
 create mode 100644 fs/simplefs.c
 create mode 100644 include/linux/simplefs.h

--=20
2.25.2

