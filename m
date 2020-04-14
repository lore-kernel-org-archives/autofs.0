From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/8] fs: introduce simple_new_inode
Date: Tue, 14 Apr 2020 15:01:40 +0200
Message-ID: <20200414130140.GD720679@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-5-eesposit@redhat.com>
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
 bh=XXKtbHQiBn9iWIabO2j/9kaf/yzrfj4Idrh7tmjZGIk=; b=WfmBKuHzLOv9B1qCYRHhb0eK4x
 ZBYZ2hBuzJwyB8+BKQZMGc5X1SFFzLnZx8SvcraaAU25NNRwzCLixtg60osHz7IM4kQ6gLTknzFfc
 T/KKDkvsoNa1+jrWT8pyEsXluQVZgcqSOfp1YAWB5Ug/VwImcUgcMaJI6JIwdoxG0VkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XXKtbHQiBn9iWIabO2j/9kaf/yzrfj4Idrh7tmjZGIk=; b=OGQlZMk48IQDwJUxOtPcICdgWw
 mjvgQma3JIg2jtxOJfUEgY3spXJrOxvcZlcbiwmExfIoQdUOvuuP0T/iHqSJsIxe4pYraMatCLsBt
 xoWc6vTkYtAT1/vKFym7/2ckzkcdfz18oO3Be4loMRwylLzb4PKc3tjT/bBf3RiTNwUE=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586869303;
 bh=pWPiuEMg4P2H6WWtKoeEIrJA7EIxTZWcj4PZDt4NV3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pOCxwRSTLKG+fKpoNN6pL7bEaN07jAmFr2DuV0C9RfMmBlnWAv1JOM6YaFZT6nGbN
 ondepi//P7WD886QVYVo/H59B351/kYJKvtSpuSM2jwd5MW3QWne+H2FTR56zMYOCD
 F4NR2z3OGSVjhXk6eqQkeYr86KdJjXN3jC1vRArk=
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-5-eesposit@redhat.com>
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

On Tue, Apr 14, 2020 at 02:42:58PM +0200, Emanuele Giuseppe Esposito wrote:
> It is a common special case for new_inode to initialize the
> time to the current time and the inode to get_next_ino().
> Introduce a core function that does it and use it throughout
> Linux.

Shouldn't this just be called new_inode_current_time()?

How is anyone going to remember what simple_new_inode() does to the
inode structure?

> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -595,6 +595,18 @@ int simple_write_end(struct file *file, struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(simple_write_end);
>  
> +struct inode *simple_new_inode(struct super_block *sb)
> +{
> +	struct inode *inode = new_inode(sb);
> +	if (inode) {
> +		inode->i_ino = get_next_ino();
> +		inode->i_atime = inode->i_mtime =
> +			inode->i_ctime = current_time(inode);
> +	}
> +	return inode;
> +}
> +EXPORT_SYMBOL(simple_new_inode);

No kernel doc explaining that get_next_ino() is called already?

Please document new global functions like this so we have a chance to
know how to use them.

Also, it is almost always easier to introduce a common function, get it
merged, and _THEN_ send out cleanup functions to all of the different
subsystems to convert over to it.  Yes, it takes longer, but it makes it
possible to do this in a way that can be reviewed properly, unlike this
patch series :(

thanks,

greg k-h
