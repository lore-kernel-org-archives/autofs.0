From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 4/8] fs: introduce simple_new_inode
Date: Tue, 14 Apr 2020 14:42:58 +0200
Message-ID: <20200414124304.4470-5-eesposit@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tavltWqAXguW1IUT8gdmgc7HLJ0xDyyeBnJXOx9vPk=;
 b=ZmfWXjT5ArAZVCG4IMNARWvxeljpHykCy/M0RyO/72fdqCb8Wpanf3k8gL4S7LCkQN7wdK
 h4kYhWsa0D3ZfDe33wEsI8bE7URxO4eUVtH44oeL2e2mh8XYO2/UJ6fHUabT/AhFsZspXv
 c1u1KPa2m3a4L71RgGY8V11oGUIvhJc=
In-Reply-To: <20200414124304.4470-1-eesposit@redhat.com>
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

It is a common special case for new_inode to initialize the
time to the current time and the inode to get_next_ino().
Introduce a core function that does it and use it throughout
Linux.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c |  4 +---
 arch/s390/hypfs/inode.c                   |  4 +---
 drivers/infiniband/hw/qib/qib_fs.c        |  6 +-----
 drivers/misc/ibmasm/ibmasmfs.c            |  8 +++-----
 drivers/oprofile/oprofilefs.c             |  8 +++-----
 drivers/usb/gadget/function/f_fs.c        |  8 +-------
 fs/autofs/inode.c                         |  4 +---
 fs/binfmt_misc.c                          | 16 ++--------------
 fs/debugfs/inode.c                        | 19 ++++---------------
 fs/efivarfs/inode.c                       |  4 +---
 fs/fuse/control.c                         |  4 +---
 fs/hugetlbfs/inode.c                      |  8 ++------
 fs/libfs.c                                | 12 ++++++++++++
 fs/ocfs2/dlmfs/dlmfs.c                    |  8 ++------
 fs/proc/base.c                            |  4 +---
 fs/proc/proc_sysctl.c                     |  5 +----
 fs/pstore/inode.c                         | 14 ++------------
 fs/ramfs/inode.c                          |  4 +---
 fs/tracefs/inode.c                        | 14 ++------------
 include/linux/fs.h                        |  1 +
 ipc/mqueue.c                              |  4 +---
 kernel/bpf/inode.c                        |  7 +------
 mm/shmem.c                                |  4 +---
 net/sunrpc/rpc_pipe.c                     |  4 +---
 security/apparmor/apparmorfs.c            |  8 ++------
 security/inode.c                          |  4 +---
 26 files changed, 50 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platf=
orms/cell/spufs/inode.c
index 25390569e24c..5167b11d41ed 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -77,15 +77,13 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 {
 =09struct inode *inode;
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09goto out;
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
 =09inode->i_uid =3D current_fsuid();
 =09inode->i_gid =3D current_fsgid();
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 out:
 =09return inode;
 }
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 5c97f48cea91..97d11561f35c 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -93,15 +93,13 @@ static void hypfs_delete_tree(struct dentry *root)
=20
 static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode=
)
 {
-=09struct inode *ret =3D new_inode(sb);
+=09struct inode *ret =3D simple_new_inode(sb);
=20
 =09if (ret) {
 =09=09struct hypfs_sb_info *hypfs_info =3D sb->s_fs_info;
-=09=09ret->i_ino =3D get_next_ino();
 =09=09ret->i_mode =3D mode;
 =09=09ret->i_uid =3D hypfs_info->uid;
 =09=09ret->i_gid =3D hypfs_info->gid;
-=09=09ret->i_atime =3D ret->i_mtime =3D ret->i_ctime =3D current_time(ret)=
;
 =09=09if (S_ISDIR(mode))
 =09=09=09set_nlink(ret, 2);
 =09}
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib=
/qib_fs.c
index e336d778e076..d402c3b1c552 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -53,21 +53,17 @@ static int qibfs_mknod(struct inode *dir, struct dentry=
 *dentry,
 =09=09       void *data)
 {
 =09int error;
-=09struct inode *inode =3D new_inode(dir->i_sb);
+=09struct inode *inode =3D simple_new_inode(dir->i_sb);
=20
 =09if (!inode) {
 =09=09error =3D -EPERM;
 =09=09goto bail;
 =09}
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
 =09inode->i_uid =3D GLOBAL_ROOT_UID;
 =09inode->i_gid =3D GLOBAL_ROOT_GID;
 =09inode->i_blocks =3D 0;
-=09inode->i_atime =3D current_time(inode);
-=09inode->i_mtime =3D inode->i_atime;
-=09inode->i_ctime =3D inode->i_atime;
 =09inode->i_private =3D data;
 =09if (S_ISDIR(mode)) {
 =09=09inode->i_op =3D &simple_dir_inode_operations;
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.=
c
index 35fec1bf1b3d..72aa02505f45 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -134,13 +134,11 @@ static int ibmasmfs_fill_super(struct super_block *sb=
, struct fs_context *fc)
=20
 static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 {
-=09struct inode *ret =3D new_inode(sb);
+=09struct inode *ret =3D simple_new_inode(sb);
=20
-=09if (ret) {
-=09=09ret->i_ino =3D get_next_ino();
+=09if (ret)
 =09=09ret->i_mode =3D mode;
-=09=09ret->i_atime =3D ret->i_mtime =3D ret->i_ctime =3D current_time(ret)=
;
-=09}
+
 =09return ret;
 }
=20
diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index 0875f2f122b3..a903dff693c9 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -26,13 +26,11 @@ DEFINE_RAW_SPINLOCK(oprofilefs_lock);
=20
 static struct inode *oprofilefs_get_inode(struct super_block *sb, int mode=
)
 {
-=09struct inode *inode =3D new_inode(sb);
+=09struct inode *inode =3D simple_new_inode(sb);
=20
-=09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
+=09if (inode)
 =09=09inode->i_mode =3D mode;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
-=09}
+
 =09return inode;
 }
=20
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/functi=
on/f_fs.c
index c81023b195c3..d5ca23682f28 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1385,18 +1385,12 @@ ffs_sb_make_inode(struct super_block *sb, void *dat=
a,
=20
 =09ENTER();
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
=20
 =09if (likely(inode)) {
-=09=09struct timespec64 ts =3D current_time(inode);
-
-=09=09inode->i_ino=09 =3D get_next_ino();
 =09=09inode->i_mode    =3D perms->mode;
 =09=09inode->i_uid     =3D perms->uid;
 =09=09inode->i_gid     =3D perms->gid;
-=09=09inode->i_atime   =3D ts;
-=09=09inode->i_mtime   =3D ts;
-=09=09inode->i_ctime   =3D ts;
 =09=09inode->i_private =3D data;
 =09=09if (fops)
 =09=09=09inode->i_fop =3D fops;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 9edf243713eb..26710b7d5ade 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -359,7 +359,7 @@ int autofs_fill_super(struct super_block *s, void *data=
, int silent)
=20
 struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 {
-=09struct inode *inode =3D new_inode(sb);
+=09struct inode *inode =3D simple_new_inode(sb);
=20
 =09if (inode =3D=3D NULL)
 =09=09return NULL;
@@ -369,8 +369,6 @@ struct inode *autofs_get_inode(struct super_block *sb, =
umode_t mode)
 =09=09inode->i_uid =3D d_inode(sb->s_root)->i_uid;
 =09=09inode->i_gid =3D d_inode(sb->s_root)->i_gid;
 =09}
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
-=09inode->i_ino =3D get_next_ino();
=20
 =09if (S_ISDIR(mode)) {
 =09=09set_nlink(inode, 2);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 475096a02a1a..cd27039ffbdf 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -586,19 +586,6 @@ static void entry_status(Node *e, char *page)
 =09}
 }
=20
-static struct inode *bm_get_inode(struct super_block *sb, int mode)
-{
-=09struct inode *inode =3D new_inode(sb);
-
-=09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
-=09=09inode->i_mode =3D mode;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D
-=09=09=09current_time(inode);
-=09}
-=09return inode;
-}
-
 static void bm_evict_inode(struct inode *inode)
 {
 =09Node *e =3D inode->i_private;
@@ -711,12 +698,13 @@ static ssize_t bm_register_write(struct file *file, c=
onst char __user *buffer,
 =09if (d_really_is_positive(dentry))
 =09=09goto out2;
=20
-=09inode =3D bm_get_inode(sb, S_IFREG | 0644);
+=09inode =3D simple_new_inode(sb);
=20
 =09err =3D -ENOMEM;
 =09if (!inode)
 =09=09goto out2;
=20
+=09inode->i_mode =3D S_IFREG | 0644;
 =09err =3D simple_pin_fs(&bm_fs, &bm_fs_type);
 =09if (err) {
 =09=09iput(inode);
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index ea54efc74c0d..834b5872ca0d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -61,17 +61,6 @@ static const struct inode_operations debugfs_symlink_ino=
de_operations =3D {
 =09.setattr=09=3D debugfs_setattr,
 };
=20
-static struct inode *debugfs_get_inode(struct super_block *sb)
-{
-=09struct inode *inode =3D new_inode(sb);
-=09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
-=09=09inode->i_atime =3D inode->i_mtime =3D
-=09=09=09inode->i_ctime =3D current_time(inode);
-=09}
-=09return inode;
-}
-
 struct debugfs_mount_opts {
 =09kuid_t uid;
 =09kgid_t gid;
@@ -383,7 +372,7 @@ static struct dentry *__debugfs_create_file(const char =
*name, umode_t mode,
 =09if (IS_ERR(dentry))
 =09=09return dentry;
=20
-=09inode =3D debugfs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode)) {
 =09=09pr_err("out of free dentries, can not create file '%s'\n",
 =09=09       name);
@@ -539,7 +528,7 @@ struct dentry *debugfs_create_dir(const char *name, str=
uct dentry *parent)
 =09if (IS_ERR(dentry))
 =09=09return dentry;
=20
-=09inode =3D debugfs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode)) {
 =09=09pr_err("out of free dentries, can not create directory '%s'\n",
 =09=09       name);
@@ -581,7 +570,7 @@ struct dentry *debugfs_create_automount(const char *nam=
e,
 =09if (IS_ERR(dentry))
 =09=09return dentry;
=20
-=09inode =3D debugfs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode)) {
 =09=09pr_err("out of free dentries, can not create automount '%s'\n",
 =09=09       name);
@@ -639,7 +628,7 @@ struct dentry *debugfs_create_symlink(const char *name,=
 struct dentry *parent,
 =09=09return dentry;
 =09}
=20
-=09inode =3D debugfs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode)) {
 =09=09pr_err("out of free dentries, can not create symlink '%s'\n",
 =09=09       name);
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 96c0c86f3fff..f8f459f43920 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -16,12 +16,10 @@ struct inode *efivarfs_get_inode(struct super_block *sb=
,
 =09=09=09=09const struct inode *dir, int mode,
 =09=09=09=09dev_t dev, bool is_removable)
 {
-=09struct inode *inode =3D new_inode(sb);
+=09struct inode *inode =3D simple_new_inode(sb);
=20
 =09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode->i_mode =3D mode;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09inode->i_flags =3D is_removable ? 0 : S_IMMUTABLE;
 =09=09switch (mode & S_IFMT) {
 =09=09case S_IFREG:
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index c23f6f243ad4..6a9f35aca480 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -232,17 +232,15 @@ static struct dentry *fuse_ctl_add_dentry(struct dent=
ry *parent,
 =09if (!dentry)
 =09=09return NULL;
=20
-=09inode =3D new_inode(fuse_control_sb);
+=09inode =3D simple_new_inode(fuse_control_sb);
 =09if (!inode) {
 =09=09dput(dentry);
 =09=09return NULL;
 =09}
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
 =09inode->i_uid =3D fc->user_id;
 =09inode->i_gid =3D fc->group_id;
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 =09/* setting ->i_op to NULL is not allowed */
 =09if (iop)
 =09=09inode->i_op =3D iop;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 991c60c7ffe0..4064389c2c23 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -739,13 +739,11 @@ static struct inode *hugetlbfs_get_root(struct super_=
block *sb,
 {
 =09struct inode *inode;
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode->i_mode =3D S_IFDIR | ctx->mode;
 =09=09inode->i_uid =3D ctx->uid;
 =09=09inode->i_gid =3D ctx->gid;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09inode->i_op =3D &hugetlbfs_dir_inode_operations;
 =09=09inode->i_fop =3D &simple_dir_operations;
 =09=09/* directory inodes start off with i_nlink =3D=3D 2 (for "." entry) =
*/
@@ -780,16 +778,14 @@ static struct inode *hugetlbfs_get_inode(struct super=
_block *sb,
 =09=09=09return NULL;
 =09}
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (inode) {
 =09=09struct hugetlbfs_inode_info *info =3D HUGETLBFS_I(inode);
=20
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode_init_owner(inode, dir, mode);
 =09=09lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 =09=09=09=09&hugetlbfs_i_mmap_rwsem_key);
 =09=09inode->i_mapping->a_ops =3D &hugetlbfs_aops;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09inode->i_mapping->private_data =3D resv_map;
 =09=09info->seals =3D F_SEAL_SEAL;
 =09=09switch (mode & S_IFMT) {
diff --git a/fs/libfs.c b/fs/libfs.c
index 26ec729f7bcd..20bdee9361d5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -595,6 +595,18 @@ int simple_write_end(struct file *file, struct address=
_space *mapping,
 }
 EXPORT_SYMBOL(simple_write_end);
=20
+struct inode *simple_new_inode(struct super_block *sb)
+{
+=09struct inode *inode =3D new_inode(sb);
+=09if (inode) {
+=09=09inode->i_ino =3D get_next_ino();
+=09=09inode->i_atime =3D inode->i_mtime =3D
+=09=09=09inode->i_ctime =3D current_time(inode);
+=09}
+=09return inode;
+}
+EXPORT_SYMBOL(simple_new_inode);
+
 /*
  * the inodes created here are not hashed. If you use iunique to generate
  * unique inode values later for this filesystem, then you must take care
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 8e4f1ace467c..6285c174f9f2 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -371,13 +371,11 @@ static void dlmfs_evict_inode(struct inode *inode)
=20
 static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 {
-=09struct inode *inode =3D new_inode(sb);
+=09struct inode *inode =3D simple_new_inode(sb);
 =09umode_t mode =3D S_IFDIR | 0755;
=20
 =09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode_init_owner(inode, NULL, mode);
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09inc_nlink(inode);
=20
 =09=09inode->i_fop =3D &simple_dir_operations;
@@ -392,15 +390,13 @@ static struct inode *dlmfs_get_inode(struct inode *pa=
rent,
 =09=09=09=09     umode_t mode)
 {
 =09struct super_block *sb =3D parent->i_sb;
-=09struct inode * inode =3D new_inode(sb);
+=09struct inode * inode =3D simple_new_inode(sb);
 =09struct dlmfs_inode_private *ip;
=20
 =09if (!inode)
 =09=09return NULL;
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode_init_owner(inode, parent, mode);
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
=20
 =09ip =3D DLMFS_I(inode);
 =09ip->ip_conn =3D DLMFS_I(parent)->ip_conn;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 74f948a6b621..3ef16f4f14c9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1856,15 +1856,13 @@ struct inode *proc_pid_make_inode(struct super_bloc=
k * sb,
=20
 =09/* We need a new inode */
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09goto out;
=20
 =09/* Common stuff */
 =09ei =3D PROC_I(inode);
 =09inode->i_mode =3D mode;
-=09inode->i_ino =3D get_next_ino();
-=09inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D current_time(i=
node);
 =09inode->i_op =3D &proc_def_inode_operations;
=20
 =09/*
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d459b087..3464ab94cf79 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -434,12 +434,10 @@ static struct inode *proc_sys_make_inode(struct super=
_block *sb,
 =09struct inode *inode;
 =09struct proc_inode *ei;
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09return ERR_PTR(-ENOMEM);
=20
-=09inode->i_ino =3D get_next_ino();
-
 =09ei =3D PROC_I(inode);
=20
 =09spin_lock(&sysctl_lock);
@@ -454,7 +452,6 @@ static struct inode *proc_sys_make_inode(struct super_b=
lock *sb,
 =09head->count++;
 =09spin_unlock(&sysctl_lock);
=20
-=09inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D current_time(i=
node);
 =09inode->i_mode =3D table->mode;
 =09if (!S_ISDIR(table->mode)) {
 =09=09inode->i_mode |=3D S_IFREG;
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d99b5d39aa90..d6cad315a839 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -208,16 +208,6 @@ static const struct inode_operations pstore_dir_inode_=
operations =3D {
 =09.unlink=09=09=3D pstore_unlink,
 };
=20
-static struct inode *pstore_get_inode(struct super_block *sb)
-{
-=09struct inode *inode =3D new_inode(sb);
-=09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
-=09}
-=09return inode;
-}
-
 enum {
 =09Opt_kmsg_bytes, Opt_err
 };
@@ -316,7 +306,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_re=
cord *record)
 =09=09return rc;
=20
 =09rc =3D -ENOMEM;
-=09inode =3D pstore_get_inode(root->d_sb);
+=09inode =3D simple_new_inode(root->d_sb);
 =09if (!inode)
 =09=09goto fail;
 =09inode->i_mode =3D S_IFREG | 0444;
@@ -394,7 +384,7 @@ static int pstore_fill_super(struct super_block *sb, vo=
id *data, int silent)
=20
 =09parse_options(data);
=20
-=09inode =3D pstore_get_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (inode) {
 =09=09inode->i_mode =3D S_IFDIR | 0750;
 =09=09inode->i_op =3D &pstore_dir_inode_operations;
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ee179a81b3da..cf2ce7bc4c9d 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -63,15 +63,13 @@ static const struct address_space_operations ramfs_aops=
 =3D {
 struct inode *ramfs_get_inode(struct super_block *sb,
 =09=09=09=09const struct inode *dir, umode_t mode, dev_t dev)
 {
-=09struct inode * inode =3D new_inode(sb);
+=09struct inode * inode =3D simple_new_inode(sb);
=20
 =09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode_init_owner(inode, dir, mode);
 =09=09inode->i_mapping->a_ops =3D &ramfs_aops;
 =09=09mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 =09=09mapping_set_unevictable(inode->i_mapping);
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09switch (mode & S_IFMT) {
 =09=09default:
 =09=09=09init_special_inode(inode, mode, dev);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 40ccfe737c3a..a30837a8e1d4 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -124,16 +124,6 @@ static const struct inode_operations tracefs_dir_inode=
_operations =3D {
 =09.rmdir=09=09=3D tracefs_syscall_rmdir,
 };
=20
-static struct inode *tracefs_get_inode(struct super_block *sb)
-{
-=09struct inode *inode =3D new_inode(sb);
-=09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
-=09}
-=09return inode;
-}
-
 struct tracefs_mount_opts {
 =09kuid_t uid;
 =09kgid_t gid;
@@ -403,7 +393,7 @@ struct dentry *tracefs_create_file(const char *name, um=
ode_t mode,
 =09if (IS_ERR(dentry))
 =09=09return NULL;
=20
-=09inode =3D tracefs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode))
 =09=09return failed_creating(dentry);
=20
@@ -424,7 +414,7 @@ static struct dentry *__create_dir(const char *name, st=
ruct dentry *parent,
 =09if (IS_ERR(dentry))
 =09=09return NULL;
=20
-=09inode =3D tracefs_get_inode(dentry->d_sb);
+=09inode =3D simple_new_inode(dentry->d_sb);
 =09if (unlikely(!inode))
 =09=09return failed_creating(dentry);
=20
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 55b679b89c8a..6136f5ba2680 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3088,6 +3088,7 @@ extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
+extern struct inode *simple_new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 49a05ba3000d..74c4f852a688 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -296,15 +296,13 @@ static struct inode *mqueue_get_inode(struct super_bl=
ock *sb,
 =09struct inode *inode;
 =09int ret =3D -ENOMEM;
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09goto err;
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
 =09inode->i_uid =3D current_fsuid();
 =09inode->i_gid =3D current_fsgid();
-=09inode->i_mtime =3D inode->i_ctime =3D inode->i_atime =3D current_time(i=
node);
=20
 =09if (S_ISREG(mode)) {
 =09=09struct mqueue_inode_info *info;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 95087d9f4ed3..532a733c474a 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -112,15 +112,10 @@ static struct inode *bpf_get_inode(struct super_block=
 *sb,
 =09=09return ERR_PTR(-EINVAL);
 =09}
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09return ERR_PTR(-ENOSPC);
=20
-=09inode->i_ino =3D get_next_ino();
-=09inode->i_atime =3D current_time(inode);
-=09inode->i_mtime =3D inode->i_atime;
-=09inode->i_ctime =3D inode->i_atime;
-
 =09inode_init_owner(inode, dir, mode);
=20
 =09return inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index f47347cb30f6..50ca377464e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2246,12 +2246,10 @@ static struct inode *shmem_get_inode(struct super_b=
lock *sb, const struct inode
 =09if (shmem_reserve_inode(sb))
 =09=09return NULL;
=20
-=09inode =3D new_inode(sb);
+=09inode =3D simple_new_inode(sb);
 =09if (inode) {
-=09=09inode->i_ino =3D get_next_ino();
 =09=09inode_init_owner(inode, dir, mode);
 =09=09inode->i_blocks =3D 0;
-=09=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
 =09=09inode->i_generation =3D prandom_u32();
 =09=09info =3D SHMEM_I(inode);
 =09=09memset(info, 0, (char *)inode - (char *)info);
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 39e14d5edaf1..fa48b8f55ba9 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -467,12 +467,10 @@ struct rpc_filelist {
 static struct inode *
 rpc_get_inode(struct super_block *sb, umode_t mode)
 {
-=09struct inode *inode =3D new_inode(sb);
+=09struct inode *inode =3D simple_new_inode(sb);
 =09if (!inode)
 =09=09return NULL;
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 =09switch (mode & S_IFMT) {
 =09case S_IFDIR:
 =09=09inode->i_fop =3D &simple_dir_operations;
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.=
c
index 75d70e6ba0a0..1a8afe9d7110 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -212,7 +212,7 @@ static int __aafs_setup_d_inode(struct inode *dir, stru=
ct dentry *dentry,
 =09=09=09       const struct file_operations *fops,
 =09=09=09       const struct inode_operations *iops)
 {
-=09struct inode *inode =3D new_inode(dir->i_sb);
+=09struct inode *inode =3D simple_new_inode(dir->i_sb);
=20
 =09AA_BUG(!dir);
 =09AA_BUG(!dentry);
@@ -220,9 +220,7 @@ static int __aafs_setup_d_inode(struct inode *dir, stru=
ct dentry *dentry,
 =09if (!inode)
 =09=09return -ENOMEM;
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 =09inode->i_private =3D data;
 =09if (S_ISDIR(mode)) {
 =09=09inode->i_op =3D iops ? iops : &simple_dir_inode_operations;
@@ -2540,15 +2538,13 @@ static int aa_mk_null_file(struct dentry *parent)
 =09=09error =3D PTR_ERR(dentry);
 =09=09goto out;
 =09}
-=09inode =3D new_inode(parent->d_inode->i_sb);
+=09inode =3D simple_new_inode(parent->d_inode->i_sb);
 =09if (!inode) {
 =09=09error =3D -ENOMEM;
 =09=09goto out1;
 =09}
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D S_IFCHR | S_IRUGO | S_IWUGO;
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 =09init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
 =09=09=09   MKDEV(MEM_MAJOR, 3));
 =09d_instantiate(dentry, inode);
diff --git a/security/inode.c b/security/inode.c
index 0fcd03299e0d..8a1a7f73ee9c 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -136,15 +136,13 @@ static struct dentry *securityfs_create_dentry(const =
char *name, umode_t mode,
 =09=09goto out1;
 =09}
=20
-=09inode =3D new_inode(dir->i_sb);
+=09inode =3D simple_new_inode(dir->i_sb);
 =09if (!inode) {
 =09=09error =3D -ENOMEM;
 =09=09goto out1;
 =09}
=20
-=09inode->i_ino =3D get_next_ino();
 =09inode->i_mode =3D mode;
-=09inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(i=
node);
 =09inode->i_private =3D data;
 =09if (S_ISDIR(mode)) {
 =09=09inode->i_op =3D &simple_dir_inode_operations;
--=20
2.25.2

