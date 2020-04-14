From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/8] fs: extract simple_pin/release_fs to separate files
Date: Tue, 14 Apr 2020 14:54:18 +0200
Message-ID: <20200414125418.GA720679@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-3-eesposit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ho1WYZcuYJxaOveuqzjzhhN7Qc3fQZuer0IuVwVVPcQ=; b=igB0sh+Se1e/Ni1gH4in+JXOx3
 E/ks6gkL8LV0V0yQW86THK3EyCDsXPfZu+uBCaV5DnDAAuJmgYREAQXwfYoiYeCS52WYWRtkacDA6
 iCdQlh030IuHL4tiuZKkrFw2sA5QQyQevOiJJh/fhAayDS0UVpRC9TnK+Fo2RegXs9vM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ho1WYZcuYJxaOveuqzjzhhN7Qc3fQZuer0IuVwVVPcQ=; b=hOu/pmDycZg4/GZ4CcuLDMhj1+
 Z1GqkZQFAphR96FE0ODDzmL7gQm5AhIf8j3hp+pAq+XYqTyKZvYll+9CoWnVdbe6i22w1ZWE4dVq+
 Ym2SlSKfChrtA1pmL4oIRz5kaEsp0/5MkvaQOSLUpJPApR/UVYSFHLYbgsmPnDTY4CWA=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586868861;
 bh=w6XXP195+Jxp1MIJYohG3U+bL2LY4rMomokRATUVj6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KUUWawnRhZWVZA4Mx1xQ7dOhftFNPIxzf1waPD79QN2nHLTwGwIA6cevta1EjCSOo
 //wKDlEIhBkx41x9paKY8+IyKktSaZFdJL/+3KUH2daqkCRS3WinhuXoTw3ctowKfO
 34eA1F0TTUmwr4Vr1nPyvba5Bm60H1KoF4fIh+7c=
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-3-eesposit@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/oprofile-list>, 
 <mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>, 
 <mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Michael Ellerman <mpe@e>

On Tue, Apr 14, 2020 at 02:42:56PM +0200, Emanuele Giuseppe Esposito wrote:
> We will augment this family of functions with inode management.  To avoid
> littering include/linux/fs.h and fs/libfs.c, move them to a separate header,
> with a Kconfig symbol to enable them.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

You have a lot of people on cc:, this is going to be hard for everyone
to review...


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

Why did you loose the indentation here and add trailing whitespace?

> +config DEBUG_FS
> +	bool "Debug Filesystem"
> +	select SIMPLEFS
>  

We already have a DEBUG_FS config option in this file, why another one?
And what happened to the help text?

I think you need to rework your patch series to do smaller things on
each step, which would make it reviewable much easier, and prevent
mistakes like this one.

thanks,

greg k-h
