From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/8] fs: wrap simple_pin_fs/simple_release_fs arguments
 in a struct
Date: Tue, 14 Apr 2020 15:03:50 +0200
Message-ID: <20200414130350.GE720679@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-4-eesposit@redhat.com>
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
 bh=rpQRYUU25dbGoG1SVvlJC2U1EwNiTdA+giTY2sk8hjU=; b=QEaHcoTa0zi1AsF4niBjcfFl2g
 350dAVTBbPkrVHt0ZsZDiBDY98Vr80+RwejILXjT4jUYhqQJkbmtcm4QGDJm+IvHmXfzv6qnbGuVx
 yJbenAHzNuKnhj5xAkYtab5V8ANT42hbWfZ1RhYnyj6DxlwoF8puEE7M1ygV7Z++6NNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rpQRYUU25dbGoG1SVvlJC2U1EwNiTdA+giTY2sk8hjU=; b=VfZU7mvJpeMTzu4Gr2eD04iiFg
 6czTqCqca71iBGp18xU7xlr59PVs8MuMnww8EsdZfbhiytK/wLNfqaoYpXqaMxAciqIVdwsa37rTD
 mOVLyxOK16MCFDKfTU+1Z8joK+w9yJ6iM4nOncBsQb/yAenC7uBWOEL/PHn4ROIhITI0=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586869433;
 bh=EOypBrU9tcg2QQEPNGGQltllXks3y35z6IXUGjl1DG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XLWBhRlVYg1iCtB++EIMGXPAVeF1ZU6z7ff1mOzRtuHPt0RW282VdRwUJrVcq7xeD
 10yO4veG3HRuw+wEo+nv2oXA/aW+uL5LE1lsss39dNDwE7jHcFqC693e0pj+pbc2Iw
 pkZZOnW468SR89YvW+ma9CDlA+A8SG2buRxyANGk=
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-4-eesposit@redhat.com>
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

On Tue, Apr 14, 2020 at 02:42:57PM +0200, Emanuele Giuseppe Esposito wrote:
> @@ -676,9 +674,9 @@ static void __debugfs_file_removed(struct dentry *dentry)
>  
>  static void remove_one(struct dentry *victim)
>  {
> -        if (d_is_reg(victim))
> +    if (d_is_reg(victim))
>  		__debugfs_file_removed(victim);
> -	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> +	simple_release_fs(&debugfs);
>  }
>  
>  /**

Always run checkpatch.pl on your patches so you do not get grumpy
maintainers telling you to run checkpatch.pl on your patches...
