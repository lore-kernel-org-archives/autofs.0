From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 5/8] simplefs: add alloc_anon_inode wrapper
Date: Tue, 14 Apr 2020 14:42:59 +0200
Message-ID: <20200414124304.4470-6-eesposit@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9wIrHVinFRSeVONZeGXFdqOI8q2utXHS+EEeF0TTJI=;
 b=BTdtUjAqy1FRBBPspP63M7cIavPpa6piwwPUl4PqEclulNV7OEtzZo3tXvqp8yzOiH+KIe
 sPedXn0uzGKNrMZeNh7bgw1qi3ACSnGLMx8NlmdW2VIyUcbZrdmOAdlRcErWqS9YrAA468
 qgh1fSvsFmRZFSnLk0J1QAOHa3ivA68=
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

Start adding file creation wrappers, the simplest returns an anonymous
inode.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 drivers/gpu/drm/drm_drv.c       | 2 +-
 drivers/misc/cxl/api.c          | 2 +-
 drivers/scsi/cxlflash/ocxl_hw.c | 2 +-
 fs/simplefs.c                   | 6 ++++++
 include/linux/simplefs.h        | 2 ++
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index b4b357725be2..4e4ea1bf312c 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -539,7 +539,7 @@ static struct inode *drm_fs_inode_new(void)
 =09=09return ERR_PTR(r);
 =09}
=20
-=09inode =3D alloc_anon_inode(drm_fs.mount->mnt_sb);
+=09inode =3D simple_alloc_anon_inode(&drm_fs);
 =09if (IS_ERR(inode))
 =09=09simple_release_fs(&drm_fs);
=20
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 6c6566d8bc17..a3d2682eb3a7 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -73,7 +73,7 @@ static struct file *cxl_getfile(const char *name,
 =09=09goto err_module;
 =09}
=20
-=09inode =3D alloc_anon_inode(cxl_fs.mount->mnt_sb);
+=09inode =3D simple_alloc_anon_inode(&cxl_fs);
 =09if (IS_ERR(inode)) {
 =09=09file =3D ERR_CAST(inode);
 =09=09goto err_fs;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_h=
w.c
index 23afde0c6c0e..770fdf186028 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -86,7 +86,7 @@ static struct file *ocxlflash_getfile(struct device *dev,=
 const char *name,
 =09=09goto err2;
 =09}
=20
-=09inode =3D alloc_anon_inode(ocxlflash_fs.mount->mnt_sb);
+=09inode =3D simple_alloc_anon_inode(&ocxlflash_fs);
 =09if (IS_ERR(inode)) {
 =09=09rc =3D PTR_ERR(inode);
 =09=09dev_err(dev, "%s: alloc_anon_inode failed rc=3D%d\n",
diff --git a/fs/simplefs.c b/fs/simplefs.c
index 790d8beb9cc3..c59eb8d996be 100644
--- a/fs/simplefs.c
+++ b/fs/simplefs.c
@@ -36,3 +36,9 @@ void simple_release_fs(struct simple_fs *fs)
 =09mntput(mnt);
 }
 EXPORT_SYMBOL(simple_release_fs);
+
+struct inode *simple_alloc_anon_inode(struct simple_fs *fs)
+{
+=09return alloc_anon_inode(fs->mount->mnt_sb);
+}
+EXPORT_SYMBOL(simple_alloc_anon_inode);
diff --git a/include/linux/simplefs.h b/include/linux/simplefs.h
index 18010414a16f..c62ab526414e 100644
--- a/include/linux/simplefs.h
+++ b/include/linux/simplefs.h
@@ -12,4 +12,6 @@ struct simple_fs {
 extern int simple_pin_fs(struct simple_fs *, struct file_system_type *);
 extern void simple_release_fs(struct simple_fs *);
=20
+extern struct inode *simple_alloc_anon_inode(struct simple_fs *fs);
+
 #endif
--=20
2.25.2

