From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH 1/8] apparmor: just use vfs_kern_mount to make .null
Date: Tue, 14 Apr 2020 14:42:55 +0200
Message-ID: <20200414124304.4470-2-eesposit@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/11mAo8TGof9fElMW//bJCzL1+izMSi4fkBrEjCedo=;
 b=OGC9aaPB3eJbJJJodWQ/ggOsRegysFSbO+rmdY1NOQ+mdYzV2XkvKGWDcpB7pDsdKY5v+x
 69J53yz4KyVvm2CDxckdaWjF/RnGGhX00pXZaTadAr6XPIo46YG45NZu8yLvy3r17Vzkg/
 WsaiIoQkfv2wNN8wYsWbms1kYzhgojE=
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

aa_mk_null_file is using simple_pin_fs/simple_release_fs with local
variables as arguments, for what would amount to a simple
vfs_kern_mount/mntput pair if everything was inlined.  Just use
the normal filesystem API since the reference counting is not needed
here.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 security/apparmor/apparmorfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.=
c
index 280741fc0f5f..828bb1eb77ea 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2525,14 +2525,14 @@ struct path aa_null;
=20
 static int aa_mk_null_file(struct dentry *parent)
 {
-=09struct vfsmount *mount =3D NULL;
+=09struct file_system_type *type =3D parent->d_sb->s_type;
+=09struct vfsmount *mount;
 =09struct dentry *dentry;
 =09struct inode *inode;
-=09int count =3D 0;
-=09int error =3D simple_pin_fs(parent->d_sb->s_type, &mount, &count);
=20
-=09if (error)
-=09=09return error;
+=09mount =3D vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
+=09if (IS_ERR(mount))
+=09=09return PTR_ERR(mount);
=20
 =09inode_lock(d_inode(parent));
 =09dentry =3D lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME=
));
@@ -2561,7 +2561,7 @@ static int aa_mk_null_file(struct dentry *parent)
 =09dput(dentry);
 out:
 =09inode_unlock(d_inode(parent));
-=09simple_release_fs(&mount, &count);
+=09mntput(mount);
 =09return error;
 }
=20
--=20
2.25.2

