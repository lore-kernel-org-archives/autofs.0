From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH 1/8] apparmor: just use vfs_kern_mount to make .null
Date: Mon, 20 Apr 2020 16:00:19 +0200
Message-ID: <b5065645-1f80-27cb-52bd-a7748493967b@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-2-eesposit@redhat.com>
 <20200416064405.GP11244@42.do-not-panic.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap4e89Z5vNdiNiGm/tjhzWgeUaBL0Wv/6U7AnurRbQ0=;
 b=AJUMCbXHRU49iok0VBo/nAwL9QRz8/I0M81qk8pGkN6lA3aLxUc9SQLlXcFfuezbkk9lZr
 jr/3TepM9G90YDZ35/SvGNcRcxpM/VGcy2V5duArPHPu1SeCcflKPIV163X/IRqHUXo+ky
 Y6Lj74NDvbZd+udLR8eyw4znYYV0UOo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap4e89Z5vNdiNiGm/tjhzWgeUaBL0Wv/6U7AnurRbQ0=;
 b=AJUMCbXHRU49iok0VBo/nAwL9QRz8/I0M81qk8pGkN6lA3aLxUc9SQLlXcFfuezbkk9lZr
 jr/3TepM9G90YDZ35/SvGNcRcxpM/VGcy2V5duArPHPu1SeCcflKPIV163X/IRqHUXo+ky
 Y6Lj74NDvbZd+udLR8eyw4znYYV0UOo=
In-Reply-To: <20200416064405.GP11244@42.do-not-panic.com>
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Luis Chamberlain <mcgrof@kernel.org>, Goldwyn Rodrigues <goldwynr@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <anton@enomsg.org>, John



On 4/16/20 8:44 AM, Luis Chamberlain wrote:
> On Tue, Apr 14, 2020 at 02:42:55PM +0200, Emanuele Giuseppe Esposito wrote:
>> aa_mk_null_file is using simple_pin_fs/simple_release_fs with local
>> variables as arguments, for what would amount to a simple
>> vfs_kern_mount/mntput pair if everything was inlined.  Just use
>> the normal filesystem API since the reference counting is not needed
>> here.
> 
> *Why* is refcounting not needed here?

The refcount is a local variable and is always 0 on entry and exit, so 
it is not necessary to have refcounting across function invocations, 
such as what simple_pin_fs and simple_release_fs provide.

Thank you,

Emanuele
> 
>     Luis
> 
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   security/apparmor/apparmorfs.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
>> index 280741fc0f5f..828bb1eb77ea 100644
>> --- a/security/apparmor/apparmorfs.c
>> +++ b/security/apparmor/apparmorfs.c
>> @@ -2525,14 +2525,14 @@ struct path aa_null;
>>   
>>   static int aa_mk_null_file(struct dentry *parent)
>>   {
>> -	struct vfsmount *mount = NULL;
>> +	struct file_system_type *type = parent->d_sb->s_type;
>> +	struct vfsmount *mount;
>>   	struct dentry *dentry;
>>   	struct inode *inode;
>> -	int count = 0;
>> -	int error = simple_pin_fs(parent->d_sb->s_type, &mount, &count);
>>   
>> -	if (error)
>> -		return error;
>> +	mount = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
>> +	if (IS_ERR(mount))
>> +		return PTR_ERR(mount);
>>   
>>   	inode_lock(d_inode(parent));
>>   	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
>> @@ -2561,7 +2561,7 @@ static int aa_mk_null_file(struct dentry *parent)
>>   	dput(dentry);
>>   out:
>>   	inode_unlock(d_inode(parent));
>> -	simple_release_fs(&mount, &count);
>> +	mntput(mount);
>>   	return error;
>>   }
>>   
>> -- 
>> 2.25.2
>>
> 

