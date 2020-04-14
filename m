From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 8/8] tracefs: switch to simplefs inode creation API
Date: Tue, 14 Apr 2020 14:43:02 +0200
Message-ID: <20200414124304.4470-9-eesposit@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4V8mrlSuDSVlkahuOUJ4Ixvzo/y3rjT0a9yuAvHerg=;
 b=afMS7G7pJrStxDVBsjqfIIdyUri5R299a1L4L52AKFaJEM24XoHlMqqG8vRqgeKYUIsWIm
 +TACeeQ9VahsZLmYGayX4EznzV9AXcOJFqh9hISguE1ySvaPbrBOTbtFnoUF7MjIup5qCZ
 P239gwimgRsdvzfOLWpyzPRTKD4P48k=
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

There is no semantic change intended; the code in the simplefs.c functions =
in
fact was derived from debugfs and tracefs code.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/tracefs/inode.c | 86 ++++------------------------------------------
 1 file changed, 7 insertions(+), 79 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a30837a8e1d4..69e2215c797b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -298,57 +298,6 @@ static struct file_system_type trace_fs_type =3D {
 };
 MODULE_ALIAS_FS("tracefs");
=20
-static struct dentry *start_creating(const char *name, struct dentry *pare=
nt)
-{
-=09struct dentry *dentry;
-=09int error;
-
-=09pr_debug("tracefs: creating file '%s'\n",name);
-
-=09error =3D simple_pin_fs(&tracefs, &trace_fs_type);
-=09if (error)
-=09=09return ERR_PTR(error);
-
-=09/* If the parent is not specified, we create it in the root.
-=09 * We need the root dentry to do this, which is in the super
-=09 * block. A pointer to that is in the struct vfsmount that we
-=09 * have around.
-=09 */
-=09if (!parent)
-=09=09parent =3D tracefs.mount->mnt_root;
-
-=09inode_lock(parent->d_inode);
-=09if (unlikely(IS_DEADDIR(parent->d_inode)))
-=09=09dentry =3D ERR_PTR(-ENOENT);
-=09else
-=09=09dentry =3D lookup_one_len(name, parent, strlen(name));
-=09if (!IS_ERR(dentry) && dentry->d_inode) {
-=09=09dput(dentry);
-=09=09dentry =3D ERR_PTR(-EEXIST);
-=09}
-
-=09if (IS_ERR(dentry)) {
-=09=09inode_unlock(parent->d_inode);
-=09=09simple_release_fs(&tracefs);
-=09}
-
-=09return dentry;
-}
-
-static struct dentry *failed_creating(struct dentry *dentry)
-{
-=09inode_unlock(dentry->d_parent->d_inode);
-=09dput(dentry);
-=09simple_release_fs(&tracefs);
-=09return NULL;
-}
-
-static struct dentry *end_creating(struct dentry *dentry)
-{
-=09inode_unlock(dentry->d_parent->d_inode);
-=09return dentry;
-}
-
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
@@ -385,49 +334,28 @@ struct dentry *tracefs_create_file(const char *name, =
umode_t mode,
 =09if (security_locked_down(LOCKDOWN_TRACEFS))
 =09=09return NULL;
=20
-=09if (!(mode & S_IFMT))
-=09=09mode |=3D S_IFREG;
-=09BUG_ON(!S_ISREG(mode));
-=09dentry =3D start_creating(name, parent);
-
+=09dentry =3D simplefs_create_file(&tracefs, &trace_fs_type,
+=09=09=09=09      name, mode, parent, data, &inode);
 =09if (IS_ERR(dentry))
 =09=09return NULL;
=20
-=09inode =3D simple_new_inode(dentry->d_sb);
-=09if (unlikely(!inode))
-=09=09return failed_creating(dentry);
-
-=09inode->i_mode =3D mode;
 =09inode->i_fop =3D fops ? fops : &tracefs_file_operations;
-=09inode->i_private =3D data;
-=09d_instantiate(dentry, inode);
-=09fsnotify_create(dentry->d_parent->d_inode, dentry);
-=09return end_creating(dentry);
+=09return simplefs_finish_dentry(dentry, inode);
 }
=20
 static struct dentry *__create_dir(const char *name, struct dentry *parent=
,
 =09=09=09=09   const struct inode_operations *ops)
 {
-=09struct dentry *dentry =3D start_creating(name, parent);
+=09struct dentry *dentry;
 =09struct inode *inode;
=20
+=09dentry =3D simplefs_create_dir(&tracefs, &trace_fs_type,
+=09=09=09=09     name, 0755, parent, &inode);
 =09if (IS_ERR(dentry))
 =09=09return NULL;
=20
-=09inode =3D simple_new_inode(dentry->d_sb);
-=09if (unlikely(!inode))
-=09=09return failed_creating(dentry);
-
-=09inode->i_mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 =09inode->i_op =3D ops;
-=09inode->i_fop =3D &simple_dir_operations;
-
-=09/* directory inodes start off with i_nlink =3D=3D 2 (for "." entry) */
-=09inc_nlink(inode);
-=09d_instantiate(dentry, inode);
-=09inc_nlink(dentry->d_parent->d_inode);
-=09fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-=09return end_creating(dentry);
+=09return simplefs_finish_dentry(dentry, inode);
 }
=20
 /**
--=20
2.25.2

