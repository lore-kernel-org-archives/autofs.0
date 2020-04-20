From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH 4/8] fs: introduce simple_new_inode
Date: Mon, 20 Apr 2020 15:58:02 +0200
Message-ID: <e87e032e-32cf-a6fc-af8f-3bcece2fcff7@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-5-eesposit@redhat.com>
 <20200414130140.GD720679@kroah.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xUgf1dELTVkqbl5oz8lk6XQ7zC/RuDwFip+M0efFdJc=; b=jph32spHp+B8CL8VE3XFMxkErl
 cSEtAniQ9LnnDXW2or4RFQU1KWOwoC7lAmfPyBX5+fP9lj8EowrF05Ryq4MCHV17h9bCu8/nUrEBJ
 qtChpXuOSU0xXNzIABJUMxw/ChBTYVaoavUI8Z8beZKlbMwApdtK+/sfVgpDd9sCtaS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xUgf1dELTVkqbl5oz8lk6XQ7zC/RuDwFip+M0efFdJc=; b=Efo5517C0agdxk+AQbzf+fLrG2
 ZKtfozXXFFSL7X+dMuJnZf4mSqQzqNewdYQDRQM5Nq61b1txlyhlDGqrqOX6Ima4vD9jjcs1PRIwZ
 /t4vPAtuA4eYPT+ugMGyVOGVQ7OXLaWiG86ZTp5iv9YvE6T9hmyUryxDC28srMkQEZMs=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUgf1dELTVkqbl5oz8lk6XQ7zC/RuDwFip+M0efFdJc=;
 b=bXyaw7FqWAsTBovH9OASnYheQMJHoLqEYSPllAfJvgpnrGG1BqQlE5R2ZOHmZxKlBWr1Rh
 5ZLzRTjCh8X9UukdOBSiewaTEnsuzUFgqFyCxL4gUfjC8FXjLsmQFyJf79XmrMl34oSSaQ
 7euSQ+BjPHRpmRYMbwQ4ZcoVns5yow8=
In-Reply-To: <20200414130140.GD720679@kroah.com>
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



On 4/14/20 3:01 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2020 at 02:42:58PM +0200, Emanuele Giuseppe Esposito wrote:
>> It is a common special case for new_inode to initialize the
>> time to the current time and the inode to get_next_ino().
>> Introduce a core function that does it and use it throughout
>> Linux.
> 
> Shouldn't this just be called new_inode_current_time()?
> 
> How is anyone going to remember what simple_new_inode() does to the
> inode structure?

I noticed that most functions in libfs.c are called "simple_*" when they 
do the right thing for the majority of simple use cases (e.g., 
simple_symlink_inode_operations or simple_dir_operations). I can 
certainly rename the function.

Thank you for all the feedback, I will incorporate it and send a new 
patch series soon.


Emanuele
> 
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -595,6 +595,18 @@ int simple_write_end(struct file *file, struct address_space *mapping,
>>   }
>>   EXPORT_SYMBOL(simple_write_end);
>>   
>> +struct inode *simple_new_inode(struct super_block *sb)
>> +{
>> +	struct inode *inode = new_inode(sb);
>> +	if (inode) {
>> +		inode->i_ino = get_next_ino();
>> +		inode->i_atime = inode->i_mtime =
>> +			inode->i_ctime = current_time(inode);
>> +	}
>> +	return inode;
>> +}
>> +EXPORT_SYMBOL(simple_new_inode);
