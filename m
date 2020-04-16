From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/8] fs: extract simple_pin/release_fs to separate files
Date: Thu, 16 Apr 2020 06:52:47 +0000
Message-ID: <20200416065247.GR11244@42.do-not-panic.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-3-eesposit@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-3-eesposit@redhat.com>
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
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <>

On Tue, Apr 14, 2020 at 02:42:56PM +0200, Emanuele Giuseppe Esposito wrote:
> We will augment this family of functions with inode management.  To avoid
> littering include/linux/fs.h and fs/libfs.c, move them to a separate header,
> with a Kconfig symbol to enable them.

If there are no functional changes, indicating that on the commit log
will make the review much easier.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d1398cef3b18..fc38a6f0fc11 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -288,12 +288,16 @@ config STRIP_ASM_SYMS
>  
>  config READABLE_ASM
>  	bool "Generate readable assembler code"
> -	depends on DEBUG_KERNEL
> -	help
> -	  Disable some compiler optimizations that tend to generate human unreadable
> -	  assembler output. This may make the kernel slightly slower, but it helps
> -	  to keep kernel developers who have to stare a lot at assembler listings
> -	  sane.
> +    depends on DEBUG_KERNEL
> +    help
> +      Disable some compiler optimizations that tend to generate human unreadable
> +      assembler output. This may make the kernel slightly slower, but it helps
> +      to keep kernel developers who have to stare a lot at assembler listings
> +      sane.
> +	  

This minor change above should just be a separate patch. Its just noise
otherwise.

> +config DEBUG_FS
> +	bool "Debug Filesystem"
> +	select SIMPLEFS

I'm at a loss reviewing this,  my lib/Kconfig.debug already has a config
DEBUG_FS.  But above I see it is being added for the very first time.
I'm sure there is some odd conditional which is obscuring this, can
this be explained in the commit log?

  Luis
