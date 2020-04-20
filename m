From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] simplefs: add file creation functions
Date: Mon, 20 Apr 2020 16:33:04 +0200
Message-ID: <7d7a9ccc-022d-f60d-d28a-f063ab9494bc@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-7-eesposit@redhat.com>
 <20200414125626.GC720679@kroah.com>
 <f371bcc0-266a-cb0b-3bde-fed336b8c9b5@redhat.com>
 <20200420142842.GA4125486@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/BICmOxm1sDjBE0Fw16pReYLCBtQ7NAWk0hypsbt5YE=; b=gR3d2hOOQXV6HcVd17Ie4NFEo2
 eKV6u31tI41tuh+7TcV/dxmIX91lplxiYjS0YdiCwl5778ZoqXsH6pP9GR2fy/WslqopvZhGPLD2Q
 myJfi8SmF/AryTwZ/xU/AKOR2F0c8D18Jimowe2wJKPzMmtfH2NcQJ72r/Vefs4TaTzs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/BICmOxm1sDjBE0Fw16pReYLCBtQ7NAWk0hypsbt5YE=; b=IJ2mSm0mDyw5EEPFIzdhKzQlvB
 3SMfQd9ewCI++Kr85Cl1DZ/FQ9VAEgJMqZKaKiszamB152rbo70f9N0jRiRi+fKqXsiFrDhy9m+tW
 aMAIjCF14bpMY4EJA7lXSykFtKiZSKv//3mOAYiS3ruZsy8DUH4mYq4NNVU66rJiiA3k=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587393193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BICmOxm1sDjBE0Fw16pReYLCBtQ7NAWk0hypsbt5YE=;
 b=bmnKa3ezmg3iI1DZKglhGQwcaUqqoKFPkyirnCM0wiPWofvL2/8XTfnhKKSjE+mQosu2Rt
 Xpc1rFgIYoVZKrD/z6J08LP+pZfYLCkUvCRqRkwlA/B1ZP4k+/bH8kpjoHcgGs+ms7/C7y
 70S5aLHgxpF9yoEc7Fy/WSHeit0ncEg=
In-Reply-To: <20200420142842.GA4125486@kroah.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Michael Ellerman <mpe@e>

On 20/04/20 16:28, Greg Kroah-Hartman wrote:
>> I assume you meant a new file. These new functions are used only by a few
>> filesystems, and I didn't want to include them in vmlinux unconditionally,
>> so I introduced simplefs.c and CONFIG_SIMPLEFS instead of extending libfs.c.
>> In this way only fs that need this code like debugfs and tracefs will load
>> it.
> Nothing "loads it", why not just make these libfs functions instead?  As
> the difference between the two is not obvious at all, please don't make
> things confusing.

I think Emanuele meant "will link it" not "will load it".

Emanuele, you can just move everything to libfs.c and get rid of
CONFIG_SIMPLEFS too.  "Do less" is not an offer you want to turn down!

Thanks,

Paolo
