From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/8] apparmor: just use vfs_kern_mount to make .null
Date: Thu, 16 Apr 2020 06:44:05 +0000
Message-ID: <20200416064405.GP11244@42.do-not-panic.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-2-eesposit@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-2-eesposit@redhat.com>
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
Content-Transfer-Encoding: 7bit
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, Goldwyn Rodrigues <goldwynr@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <>

On Tue, Apr 14, 2020 at 02:42:55PM +0200, Emanuele Giuseppe Esposito wrote:
> aa_mk_null_file is using simple_pin_fs/simple_release_fs with local
> variables as arguments, for what would amount to a simple
> vfs_kern_mount/mntput pair if everything was inlined.  Just use
> the normal filesystem API since the reference counting is not needed
> here.

*Why* is refcounting not needed here?

   Luis

> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  security/apparmor/apparmorfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 280741fc0f5f..828bb1eb77ea 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2525,14 +2525,14 @@ struct path aa_null;
>  
>  static int aa_mk_null_file(struct dentry *parent)
>  {
> -	struct vfsmount *mount = NULL;
> +	struct file_system_type *type = parent->d_sb->s_type;
> +	struct vfsmount *mount;
>  	struct dentry *dentry;
>  	struct inode *inode;
> -	int count = 0;
> -	int error = simple_pin_fs(parent->d_sb->s_type, &mount, &count);
>  
> -	if (error)
> -		return error;
> +	mount = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
> +	if (IS_ERR(mount))
> +		return PTR_ERR(mount);
>  
>  	inode_lock(d_inode(parent));
>  	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
> @@ -2561,7 +2561,7 @@ static int aa_mk_null_file(struct dentry *parent)
>  	dput(dentry);
>  out:
>  	inode_unlock(d_inode(parent));
> -	simple_release_fs(&mount, &count);
> +	mntput(mount);
>  	return error;
>  }
>  
> -- 
> 2.25.2
> 
