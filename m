From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] simplefs: add file creation functions
Date: Tue, 14 Apr 2020 14:56:26 +0200
Message-ID: <20200414125626.GC720679@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-7-eesposit@redhat.com>
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
 bh=8gTb0+znpka58d+yYhW++jo0dSogE2Z5gnSmn2DAgd0=; b=SrXKOW3WiNLS4FEMoCguJ4lkJM
 tcDoM8ool3Az67y5Sd6RkpP6O4fSPPoPA7bhTI7BNml6pY7I3gitiY7AclQyvQHxu5WziM1oxtj6T
 YxtcUw4LZ/0Ypks2TZXdqiWi4YeVOPcxrwJs64cVwWh4nkYIukxzjPCykG1KnEzq60Q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8gTb0+znpka58d+yYhW++jo0dSogE2Z5gnSmn2DAgd0=; b=IR/uxmtSX1zsNmTkCGXLKo1dz/
 KqCNB44l2XS/anGA6ptOrUXTcGnreP3bfRJmbbYrOpdrCSbS5uXxAcLBeMq8rnTCJvH3G8dxD1zWY
 iFRn2gugENMQ57wnTHOedFWk3EWKXtOti6BhoiEjsfBiBlI7C8Ac7ZrlOCb3a6UDEmQM=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586868988;
 bh=cUsRBw4xRJcezB/ZRtjYiCyoUTShgzDF9QmHT/uunvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O+0/+J3q6IpztwhxEGT0OVnfIh3pCJ6dMzQN4HIku+0vphymoWpQOOM8ckygO7bvj
 tEo5/7yl4Jc4KVFc6uDRp76itFJ6WWgv+Y89NA119rqZSOnLZidaj8mNe2CoW6MsD9
 WuhJF5efIRKL5VDTIVeF02sAYzd85r8Rx8V2Id0A=
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-7-eesposit@redhat.com>
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

On Tue, Apr 14, 2020 at 02:43:00PM +0200, Emanuele Giuseppe Esposito wrote:
> A bunch of code is duplicated between debugfs and tracefs, unify it to the
> simplefs library.
> 
> The code is very similar, except that dentry and inode creation are unified
> into a single function (unlike start_creating in debugfs and tracefs, which
> only takes care of dentries).  This adds an output parameter to the creation
> functions, but pushes all error recovery into fs/simplefs.c.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  fs/simplefs.c            | 150 +++++++++++++++++++++++++++++++++++++++
>  include/linux/simplefs.h |  19 +++++
>  2 files changed, 169 insertions(+)

What's wrong with libfs, isn't that supposed to be for these types of
"common" filesystem interactions?

Why create a whole "new" fs for this?

thanks,

greg k-h
