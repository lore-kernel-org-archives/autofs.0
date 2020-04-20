From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH 6/8] simplefs: add file creation functions
Date: Mon, 20 Apr 2020 15:57:48 +0200
Message-ID: <f371bcc0-266a-cb0b-3bde-fed336b8c9b5@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-7-eesposit@redhat.com>
 <20200414125626.GC720679@kroah.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pK26z2Uz8J+xMXGm08XY3fCeYfVumTWEKpq3I9uMJ70=; b=CJNYEC1Q+DhqkW7uwKg7x6/CKS
 sfQiuCcGEb4rfBeaL6PWOWIopZkluklzkDEDMq1c4/mNf7eH6bzDxnmHyFEnbQSbZh6yAMzsaDXlh
 Lir9OSvWwV6R+pvwwctD4JBz+mR58/40b6GVGaO9nS8Z7wuG2lU7LgPm/f3GbqHjLa74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pK26z2Uz8J+xMXGm08XY3fCeYfVumTWEKpq3I9uMJ70=; b=IpNgF2oUJCzIOccyOchOjGfGI8
 YIxNI93OOKwRQ4p4A51ZRj6P02RJCNon3Enm2j9kBSRLnGCBnks+Jo5Tsj1sKvoycTVZOiinUJ+O7
 JNdiHvs0kbyM2ZoV7b1AL85exicb2DCEmEfnXRMQEuAQDFq06RP8Je1kVYCFnVrogRjg=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pK26z2Uz8J+xMXGm08XY3fCeYfVumTWEKpq3I9uMJ70=;
 b=JBeBupR2hI6+yPH2Jr9g+YknQbpgbnCv1v3pgHYKCX5jxVmhwOeJeXfoNscz03zlTY5JBe
 p2Kfp7etIPFA2k2wP3aoJIy1xhhLs7Qc/+KcpvVdx+gJIVV3Od3gbg+HSCrLR8AVcsQ5Zs
 BFebMb+Romn4HGK1c81Jx2O3JxmWMog=
In-Reply-To: <20200414125626.GC720679@kroah.com>
Content-Language: en-US
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/oprofile-list>, 
 <mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>, 
 <mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Michael Ellerman <mpe@e>



On 4/14/20 2:56 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2020 at 02:43:00PM +0200, Emanuele Giuseppe Esposito wrote:
>> A bunch of code is duplicated between debugfs and tracefs, unify it to the
>> simplefs library.
>>
>> The code is very similar, except that dentry and inode creation are unified
>> into a single function (unlike start_creating in debugfs and tracefs, which
>> only takes care of dentries).  This adds an output parameter to the creation
>> functions, but pushes all error recovery into fs/simplefs.c.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   fs/simplefs.c            | 150 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/simplefs.h |  19 +++++
>>   2 files changed, 169 insertions(+)
> 
> What's wrong with libfs, isn't that supposed to be for these types of
> "common" filesystem interactions?
> 
> Why create a whole "new" fs for this?

I assume you meant a new file. These new functions are used only by a 
few filesystems, and I didn't want to include them in vmlinux 
unconditionally, so I introduced simplefs.c and CONFIG_SIMPLEFS instead 
of extending libfs.c. In this way only fs that need this code like 
debugfs and tracefs will load it.

Thank you,

Emanuele
