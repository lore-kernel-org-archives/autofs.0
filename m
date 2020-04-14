From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/8] simplefs: add alloc_anon_inode wrapper
Date: Tue, 14 Apr 2020 14:55:03 +0200
Message-ID: <20200414125503.GB720679@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-6-eesposit@redhat.com>
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
 bh=luGG2k3AyY3iLFwXaePWnUB1vWs9kw0xeCFweEDu4fc=; b=axjAErzCs7+nUL2pnW9IJcygq1
 KOxnNaudxblI+n1n9FA9Jv2E7bTPZ6+ILZFvlJU+7QQueGV5QEbElmUv4Ahhp0L/q52DFXciUaRI5
 suQsa1gYG6ECFnxHcUlT2rT98paaVxV1W4UsWrAkVqKYLYB2I3U0Kd4HFZXNphGtvo0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=luGG2k3AyY3iLFwXaePWnUB1vWs9kw0xeCFweEDu4fc=; b=hVpmY8kzP4vt6duMCedazT/4+O
 +6OqRccPfQvhZSwfTFPtmmN/JFktgc/FmymiNxSD9BvxpJrnn6HiQsdFkvVW8cE4cZKPyLsJd+jOx
 ELadMH+GVsnkEujOgtuyJKWxsQVWdeZqOi/FbtScPfpIiH2xqMswPyUqbZDzfcdi781k=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586868906;
 bh=3mtVbazOODlWmZkI2pC3OZrxU4xuKxy4xYMqOMi+DOo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=owjpvTR/99cTOPzzwnkDnpkDpyHwqR3u/28s6xClkS7BDEyhyW63auTVtn9fbzvgw
 gSPxDTRm63N6w859trpZorcERRfHwuo0gOq3qU8enok4JrslGok4+0RyU/6hKXTvQp
 N1FGoKtqAWcRwtbvdskl4jZY6mpYC1zWhMkP0m6o=
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-6-eesposit@redhat.com>
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

On Tue, Apr 14, 2020 at 02:42:59PM +0200, Emanuele Giuseppe Esposito wrote:
> Start adding file creation wrappers, the simplest returns an anonymous
> inode.

This changelog text does not make much sense on its own.  Please say why
you are doing something, not just what you are doing.

thanks,

greg k-h
