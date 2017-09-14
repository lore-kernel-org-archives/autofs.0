From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 1/2] autofs: set compat flag on sbi when daemon uses
 32bit addressation
Date: Thu, 14 Sep 2017 19:45:58 +0800
Message-ID: <323d8907-8fd6-2d8d-35a9-272faa7e7811@themaw.net>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
 <20170901112144.2669.1453.stgit@localhost.localdomain>
 <e86c66c6-7430-00e2-518a-cb2b87ab4130@themaw.net>
 <b35f6e37-5138-7ede-4c6c-0aa016645977@virtuozzo.com>
 <a5488db7-e42a-753c-08ba-008579c1ecd6@themaw.net>
 <889ec02e-6146-c180-642b-017f6ca71f8a@virtuozzo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=gvpnL2H6Ipy+A2hGEc
        HHMlxKVxubEpcH8sqk3KVROIE=; b=R+BwQNWTZJ6qyVPVM0/0HXir8nJMTe+pvH
        eiFLtmONyKdsPNDw4csCFfHtnhrYmZU9UCe4Qe0bImnQMJEh44fc3j35vxUhMXUG
        Zn7XeI5V08ac47CC3UQyPucgfilmI8shL4QwqmJtB7uVHVRJmN0/rm9CJ9C7F7Jx
        Nbk6swt3nW+oF7bMUQHDIbjlwJrmERIKiz/2gILFb3PeVdkF+RUjKQbsacoIIIRW
        Xw3/2NVQWaT+Cu/yJi5b/kCeZav2bYbdwK98p7EE6vfC63AWsj8cinoI5wVxFfim
        6Xd3Bhu/aIklN7Lwf5udVO8CxFUdrDW9F3mI79lUzKzJ14MYRhxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=gvpnL2H6Ipy+A2hGEcHHMlxKVxubEpcH8sqk3KVROIE=; b=VJXjh8v6
        BlUseH6buXctOj6kQjiq5WGrDMmpZB5At/oQs6UZFyvzqJxmj3vYEBzMYSphx1AG
        ng70dPZfdX2nG1uCmFTP039H0PFvMMzMPZXmkHJX8JEjvzBgj/iUfd3Pnr4lTj/y
        XDNIhFdTHJDdKC2CZFBwHg6xX8c0chUr+ys96kPygVRCXXwWHvXftiwInaDrhAqO
        367FzTaxbr1L+2PaZFxQY0bzD2P5GbpAAtCV4uIeJW0iDKnNN1VWIIuFDMqJl442
        CjEhzEHVQaWExap7pXgIuVNBT81AWWyk8GyX9ZvMQygeHuTCPoBkG8xl0KI6+62j
        5s/7b4hSyghq3A==
In-Reply-To: <889ec02e-6146-c180-642b-017f6ca71f8a@virtuozzo.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: skinsbursky@virtuozzo.com
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

On 14/09/17 19:39, Stanislav Kinsburskiy wrote:
> 
> 
> 14.09.2017 13:29, Ian Kent пишет:
>> On 14/09/17 17:24, Stanislav Kinsburskiy wrote:
>>>
>>>
>>> 14.09.2017 02:38, Ian Kent пишет:
>>>> On 01/09/17 19:21, Stanislav Kinsburskiy wrote:
>>>>> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
>>>>> ---
>>>>>  fs/autofs4/autofs_i.h  |    3 +++
>>>>>  fs/autofs4/dev-ioctl.c |    3 +++
>>>>>  fs/autofs4/inode.c     |    4 +++-
>>>>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
>>>>> index 4737615..3da105f 100644
>>>>> --- a/fs/autofs4/autofs_i.h
>>>>> +++ b/fs/autofs4/autofs_i.h
>>>>> @@ -120,6 +120,9 @@ struct autofs_sb_info {
>>>>>  	struct list_head active_list;
>>>>>  	struct list_head expiring_list;
>>>>>  	struct rcu_head rcu;
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +	unsigned is32bit:1;
>>>>> +#endif
>>>>>  };
>>>>>  
>>>>>  static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
>>>>> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
>>>>> index b7c816f..467d6c4 100644
>>>>> --- a/fs/autofs4/dev-ioctl.c
>>>>> +++ b/fs/autofs4/dev-ioctl.c
>>>>> @@ -397,6 +397,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>>>>>  		sbi->pipefd = pipefd;
>>>>>  		sbi->pipe = pipe;
>>>>>  		sbi->catatonic = 0;
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +		sbi->is32bit = is_compat_task();
>>>>> +#endif
>>>>>  	}
>>>>>  out:
>>>>>  	put_pid(new_pid);
>>>>> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>>>>> index 09e7d68..21d3c0b 100644
>>>>> --- a/fs/autofs4/inode.c
>>>>> +++ b/fs/autofs4/inode.c
>>>>> @@ -301,7 +301,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>>>>>  	} else {
>>>>>  		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
>>>>>  	}
>>>>> -
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +	sbi->is32bit = is_compat_task();
>>>>> +#endif
>>>>>  	if (autofs_type_trigger(sbi->type))
>>>>>  		__managed_dentry_set_managed(root);
>>>>>  
>>>>>
>>>>
>>>> Not sure about this.
>>>>
>>>> Don't you think it would be better to avoid the in code #ifdefs by doing some
>>>> checks and defines in the header file and defining what's need to just use
>>>> is_compat_task().
>>>>
>>>
>>> Yes, might be...
>>>
>>>> Not sure 2 patches are needed for this either ......
>>>>
>>>
>>> Well, I found this issue occasionally.
>>
>> I'm wondering what the symptoms are?
>>
> 
> Size of struct autofs_v5_packet is 300 bytes for x86 and 304 bytes for x86_64.
> Which means, that 32bit task can read more than size of autofs_v5_packet on 64bit kernel.

Are you sure?

Shouldn't that be a short read on the x86 side of a 4 bytes longer
structure on the x86_64 side.

I didn't think you could have a 64 bit client on a 32 bit kernel
so the converse (the read past end of struct) doesn't apply.

Ian
