From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 6/8] simplefs: add file creation functions
Date: Tue, 14 Apr 2020 14:43:00 +0200
Message-ID: <20200414124304.4470-7-eesposit@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkKDvUy87926CmAT32HsWjLbIxTbOhqOTHC/vd3O4C0=;
 b=hAZxlAFxPLBTZ0dZUK4vWmZD8OQC0vEPD1D5Ti07Q295SOclUBU1cdsylWqNDhd+afa7Zu
 /u0YipRUapWRy/lzMPbv29GK625zc6Eh844BSGMWWkdJMS8daFK6z7+22pgPttM9KCJ0JA
 /VATwRhULj47dLjREHC+wvgoL2712WI=
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

A bunch of code is duplicated between debugfs and tracefs, unify it to the
simplefs library.

The code is very similar, except that dentry and inode creation are unified
into a single function (unlike start_creating in debugfs and tracefs, which
only takes care of dentries).  This adds an output parameter to the creatio=
n
functions, but pushes all error recovery into fs/simplefs.c.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/simplefs.c            | 150 +++++++++++++++++++++++++++++++++++++++
 include/linux/simplefs.h |  19 +++++
 2 files changed, 169 insertions(+)

diff --git a/fs/simplefs.c b/fs/simplefs.c
index c59eb8d996be..3e48a288beb3 100644
--- a/fs/simplefs.c
+++ b/fs/simplefs.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/simplefs.h>
 #include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/fsnotify.h>
=20
 static DEFINE_SPINLOCK(pin_fs_lock);
=20
@@ -42,3 +44,151 @@ struct inode *simple_alloc_anon_inode(struct simple_fs =
*fs)
 =09return alloc_anon_inode(fs->mount->mnt_sb);
 }
 EXPORT_SYMBOL(simple_alloc_anon_inode);
+
+static struct dentry *failed_creating(struct simple_fs *fs, struct dentry =
*dentry)
+{
+=09inode_unlock(d_inode(dentry->d_parent));
+=09dput(dentry);
+=09simple_release_fs(fs);
+=09return ERR_PTR(-ENOMEM);
+}
+
+struct dentry *simplefs_create_dentry(struct simple_fs *fs, struct file_sy=
stem_type *type,
+=09=09=09=09      const char *name, struct dentry *parent,
+=09=09=09=09      struct inode **inode)
+{
+=09struct dentry *dentry;
+=09int error;
+
+=09pr_debug("creating file '%s'\n", name);
+
+=09if (IS_ERR(parent))
+=09=09return parent;
+
+=09error =3D simple_pin_fs(fs, type);
+=09if (error) {
+=09=09pr_err("Unable to pin filesystem for file '%s'\n", name);
+=09=09return ERR_PTR(error);
+=09}
+
+=09/* If the parent is not specified, we create it in the root.
+=09 * We need the root dentry to do this, which is in the super
+=09 * block. A pointer to that is in the struct vfsmount that we
+=09 * have around.
+=09 */
+=09if (!parent)
+=09=09parent =3D fs->mount->mnt_root;
+
+=09inode_lock(d_inode(parent));
+=09dentry =3D lookup_one_len(name, parent, strlen(name));
+=09if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
+=09=09if (d_is_dir(dentry))
+=09=09=09pr_err("Directory '%s' with parent '%s' already present!\n",
+=09=09=09       name, parent->d_name.name);
+=09=09else
+=09=09=09pr_err("File '%s' in directory '%s' already present!\n",
+=09=09=09       name, parent->d_name.name);
+=09=09dput(dentry);
+=09=09dentry =3D ERR_PTR(-EEXIST);
+=09}
+
+=09if (IS_ERR(dentry)) {
+=09=09inode_unlock(d_inode(parent));
+=09=09simple_release_fs(fs);
+=09}
+
+
+=09if (IS_ERR(dentry))
+=09=09return dentry;
+
+=09*inode =3D simple_new_inode(fs->mount->mnt_sb);
+=09if (unlikely(!(*inode))) {
+=09=09pr_err("out of free inodes, can not create file '%s'\n",
+=09=09       name);
+=09=09return failed_creating(fs, dentry);
+=09}
+
+=09return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_dentry);
+
+struct dentry *simplefs_create_file(struct simple_fs *fs, struct file_syst=
em_type *type,
+=09=09=09=09    const char *name, umode_t mode,
+=09=09=09=09    struct dentry *parent, void *data,
+=09=09=09=09    struct inode **inode)
+{
+=09struct dentry *dentry;
+
+=09WARN_ON((mode & S_IFMT) && !S_ISREG(mode));
+=09mode |=3D S_IFREG;
+
+=09dentry =3D simplefs_create_dentry(fs, type, name, parent, inode);
+
+=09if (IS_ERR(dentry))
+=09=09return dentry;
+
+=09(*inode)->i_mode =3D mode;
+=09(*inode)->i_private =3D data;
+
+=09return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_file);
+
+struct dentry *simplefs_finish_dentry(struct dentry *dentry, struct inode =
*inode)
+{
+=09d_instantiate(dentry, inode);
+=09if (S_ISDIR(inode->i_mode)) {
+=09=09inc_nlink(d_inode(dentry->d_parent));
+=09=09fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
+=09} else {
+=09=09fsnotify_create(d_inode(dentry->d_parent), dentry);
+=09}
+=09inode_unlock(d_inode(dentry->d_parent));
+=09return dentry;
+}
+EXPORT_SYMBOL(simplefs_finish_dentry);
+
+struct dentry *simplefs_create_dir(struct simple_fs *fs, struct file_syste=
m_type *type,
+=09=09=09=09   const char *name, umode_t mode, struct dentry *parent,
+=09=09=09=09   struct inode **inode)
+{
+=09struct dentry *dentry;
+
+=09WARN_ON((mode & S_IFMT) && !S_ISDIR(mode));
+=09mode |=3D S_IFDIR;
+
+=09dentry =3D simplefs_create_dentry(fs, type, name, parent, inode);
+=09if (IS_ERR(dentry))
+=09=09return dentry;
+
+=09(*inode)->i_mode =3D mode;
+=09(*inode)->i_op =3D &simple_dir_inode_operations;
+=09(*inode)->i_fop =3D &simple_dir_operations;
+
+=09/* directory inodes start off with i_nlink =3D=3D 2 (for "." entry) */
+=09inc_nlink(*inode);
+=09return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_dir);
+
+struct dentry *simplefs_create_symlink(struct simple_fs *fs, struct file_s=
ystem_type *type,
+=09=09=09=09       const char *name, struct dentry *parent,
+=09=09=09=09       const char *target, struct inode **inode)
+{
+=09struct dentry *dentry;
+=09char *link =3D kstrdup(target, GFP_KERNEL);
+=09if (!link)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09dentry =3D simplefs_create_dentry(fs, type, name, parent, inode);
+=09if (IS_ERR(dentry)) {
+=09=09kfree_link(link);
+=09=09return dentry;
+=09}
+
+=09(*inode)->i_mode =3D S_IFLNK | S_IRWXUGO;
+=09(*inode)->i_link =3D link;
+=09(*inode)->i_op =3D &simple_symlink_inode_operations;
+=09return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_symlink);
diff --git a/include/linux/simplefs.h b/include/linux/simplefs.h
index c62ab526414e..cc53eed0bc3d 100644
--- a/include/linux/simplefs.h
+++ b/include/linux/simplefs.h
@@ -14,4 +14,23 @@ extern void simple_release_fs(struct simple_fs *);
=20
 extern struct inode *simple_alloc_anon_inode(struct simple_fs *fs);
=20
+extern struct dentry *simplefs_create_dentry(struct simple_fs *fs,
+=09=09=09=09=09     struct file_system_type *type,
+=09=09=09=09=09     const char *name, struct dentry *parent,
+=09=09=09=09=09     struct inode **inode);
+struct dentry *simplefs_finish_dentry(struct dentry *dentry, struct inode =
*inode);
+
+extern struct dentry *simplefs_create_file(struct simple_fs *fs,
+=09=09=09=09=09   struct file_system_type *type,
+=09=09=09=09=09   const char *name, umode_t mode,
+=09=09=09=09=09   struct dentry *parent, void *data,
+=09=09=09=09=09   struct inode **inode);
+extern struct dentry *simplefs_create_dir(struct simple_fs *fs, struct fil=
e_system_type *type,
+=09=09=09=09=09  const char *name, umode_t mode, struct dentry *parent,
+=09=09=09=09=09  struct inode **inode);
+extern struct dentry *simplefs_create_symlink(struct simple_fs *fs, struct=
 file_system_type *type,
+=09=09=09=09=09      const char *name, struct dentry *parent,
+=09=09=09=09=09      const char *target, struct inode **inode);
+
+
 #endif
--=20
2.25.2

