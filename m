From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] simplefs: add file creation functions
Date: Mon, 20 Apr 2020 16:28:42 +0200
Message-ID: <20200420142842.GA4125486@kroah.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-7-eesposit@redhat.com>
 <20200414125626.GC720679@kroah.com>
 <f371bcc0-266a-cb0b-3bde-fed336b8c9b5@redhat.com>
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
 bh=rs1eeAHnl32h4UvhUZO+xC6LLoMEI3G8MsMW429MPSg=; b=ihrXBZlMiB9EUamyvRihTFj2zJ
 Jt5osR6SWoWRQA+LoLGuER1lBstWbvuIhqR1O7BhcdL7QObr/N8ncmUdD+fE/6CB82dXmhHRHyByB
 2AA4bXYNEqjfrwoNT8CDF3pDtEW0rFTxzhSIujNOrPZSulCG8PrqVDlng8twqH8QF+bA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rs1eeAHnl32h4UvhUZO+xC6LLoMEI3G8MsMW429MPSg=; b=FgkR9+r74tB8zKmzQBdLME2vVL
 BzV877ovSZZZV57acIiVUVr7ERDh2c6YsILnPYDHxLPw/s3mRZFr7/z4DkUzgds5y4RbJc5C4j+eK
 vAFTZV9+OWj4wadCAzDH7/PPSXLCLMqJI6mPNiAoLe7dHeYS5Aj2MkxPtMHpMtwXheH8=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587392924;
 bh=Xfhmbt3oILrMnmMSAOk0kNM8XdFhuXm9MUCUSzShG8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LnzLHOGL3SfYzz4pLofCJ1ROQjqVMmfWQwIeMijgCZdRKOiLZgnrpkFWugSMer61U
 SUy1vwyCeMyLufrPfYFn9wMKcSES/m+B4D/DjqcEiwhebOFIg8iwdCJThhBrgF45My
 mDtP1iFIfm+kWnwF33LB3q5mplaFnA9YYIC790Wo=
Content-Disposition: inline
In-Reply-To: <f371bcc0-266a-cb0b-3bde-fed336b8c9b5@redhat.com>
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

On Mon, Apr 20, 2020 at 03:57:48PM +0200, Emanuele Giuseppe Esposito wrote:
> 
> 
> On 4/14/20 2:56 PM, Greg Kroah-Hartman wrote:
> > On Tue, Apr 14, 2020 at 02:43:00PM +0200, Emanuele Giuseppe Esposito wrote:
> > > A bunch of code is duplicated between debugfs and tracefs, unify it to the
> > > simplefs library.
> > > 
> > > The code is very similar, except that dentry and inode creation are unified
> > > into a single function (unlike start_creating in debugfs and tracefs, which
> > > only takes care of dentries).  This adds an output parameter to the creation
> > > functions, but pushes all error recovery into fs/simplefs.c.
> > > 
> > > Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> > > ---
> > >   fs/simplefs.c            | 150 +++++++++++++++++++++++++++++++++++++++
> > >   include/linux/simplefs.h |  19 +++++
> > >   2 files changed, 169 insertions(+)
> > 
> > What's wrong with libfs, isn't that supposed to be for these types of
> > "common" filesystem interactions?
> > 
> > Why create a whole "new" fs for this?
> 
> I assume you meant a new file. These new functions are used only by a few
> filesystems, and I didn't want to include them in vmlinux unconditionally,
> so I introduced simplefs.c and CONFIG_SIMPLEFS instead of extending libfs.c.
> In this way only fs that need this code like debugfs and tracefs will load
> it.

Nothing "loads it", why not just make these libfs functions instead?  As
the difference between the two is not obvious at all, please don't make
things confusing.

thanks,

greg k-h
