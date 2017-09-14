From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: Re: [RFC PATCH 1/2] autofs: set compat flag on sbi when daemon uses
 32bit addressation
Date: Thu, 14 Sep 2017 13:51:03 +0200
Message-ID: <b878dea4-7d99-f8a6-ec3f-6ccbec74eebe@virtuozzo.com>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
 <20170901112144.2669.1453.stgit@localhost.localdomain>
 <e86c66c6-7430-00e2-518a-cb2b87ab4130@themaw.net>
 <b35f6e37-5138-7ede-4c6c-0aa016645977@virtuozzo.com>
 <a5488db7-e42a-753c-08ba-008579c1ecd6@themaw.net>
 <889ec02e-6146-c180-642b-017f6ca71f8a@virtuozzo.com>
 <323d8907-8fd6-2d8d-35a9-272faa7e7811@themaw.net>
Reply-To: skinsbursky@virtuozzo.com
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yHa9TqrMKblsl63PAQcU5afnk0EEYdBro/Ok0iOcYeo=;
 b=CkixNPEJs8HPCZssXvxcl/1kf0M2Ze6gmjD2edep03yzjPum1sUVhFMHC9BuacwpmxAdJn1/ke1cUiK6SlqSZKnMscuVDD3y0ratOFpGtK0p0rdFUImlfMXzEoCfpH6d4MSP3GeIRlWLAM/5okCE1eF2jj/dcQy+23H/oHZvrtI=
In-Reply-To: <323d8907-8fd6-2d8d-35a9-272faa7e7811@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org



14.09.2017 13:45, Ian Kent пишет:
> On 14/09/17 19:39, Stanislav Kinsburskiy wrote:
>>
>>
>> 14.09.2017 13:29, Ian Kent пишет:
>>> On 14/09/17 17:24, Stanislav Kinsburskiy wrote:
>>>>
>>>>
>>>> 14.09.2017 02:38, Ian Kent пишет:
>>>>> On 01/09/17 19:21, Stanislav Kinsburskiy wrote:
>>>>>> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
>>>>>> ---
>>>>>>  fs/autofs4/autofs_i.h  |    3 +++
>>>>>>  fs/autofs4/dev-ioctl.c |    3 +++
>>>>>>  fs/autofs4/inode.c     |    4 +++-
>>>>>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
>>>>>> index 4737615..3da105f 100644
>>>>>> --- a/fs/autofs4/autofs_i.h
>>>>>> +++ b/fs/autofs4/autofs_i.h
>>>>>> @@ -120,6 +120,9 @@ struct autofs_sb_info {
>>>>>>  	struct list_head active_list;
>>>>>>  	struct list_head expiring_list;
>>>>>>  	struct rcu_head rcu;
>>>>>> +#ifdef CONFIG_COMPAT
>>>>>> +	unsigned is32bit:1;
>>>>>> +#endif
>>>>>>  };
>>>>>>  
>>>>>>  static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
>>>>>> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
>>>>>> index b7c816f..467d6c4 100644
>>>>>> --- a/fs/autofs4/dev-ioctl.c
>>>>>> +++ b/fs/autofs4/dev-ioctl.c
>>>>>> @@ -397,6 +397,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>>>>>>  		sbi->pipefd = pipefd;
>>>>>>  		sbi->pipe = pipe;
>>>>>>  		sbi->catatonic = 0;
>>>>>> +#ifdef CONFIG_COMPAT
>>>>>> +		sbi->is32bit = is_compat_task();
>>>>>> +#endif
>>>>>>  	}
>>>>>>  out:
>>>>>>  	put_pid(new_pid);
>>>>>> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>>>>>> index 09e7d68..21d3c0b 100644
>>>>>> --- a/fs/autofs4/inode.c
>>>>>> +++ b/fs/autofs4/inode.c
>>>>>> @@ -301,7 +301,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>>>>>>  	} else {
>>>>>>  		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
>>>>>>  	}
>>>>>> -
>>>>>> +#ifdef CONFIG_COMPAT
>>>>>> +	sbi->is32bit = is_compat_task();
>>>>>> +#endif
>>>>>>  	if (autofs_type_trigger(sbi->type))
>>>>>>  		__managed_dentry_set_managed(root);
>>>>>>  
>>>>>>
>>>>>
>>>>> Not sure about this.
>>>>>
>>>>> Don't you think it would be better to avoid the in code #ifdefs by doing some
>>>>> checks and defines in the header file and defining what's need to just use
>>>>> is_compat_task().
>>>>>
>>>>
>>>> Yes, might be...
>>>>
>>>>> Not sure 2 patches are needed for this either ......
>>>>>
>>>>
>>>> Well, I found this issue occasionally.
>>>
>>> I'm wondering what the symptoms are?
>>>
>>
>> Size of struct autofs_v5_packet is 300 bytes for x86 and 304 bytes for x86_64.
>> Which means, that 32bit task can read more than size of autofs_v5_packet on 64bit kernel.
> 
> Are you sure?
> 
> Shouldn't that be a short read on the x86 side of a 4 bytes longer
> structure on the x86_64 side.
> 
> I didn't think you could have a 64 bit client on a 32 bit kernel
> so the converse (the read past end of struct) doesn't apply.
> 

Sorry for the confusion, I had to add brackets like this:

> Which means, that 32bit task can read more than size of autofs_v5_packet (on 64bit kernel).

IOW, 32bit task expects to read 300 bytes (size of struct autofs_v5_packet) while there are 304 bytes available on the "wire" from the 64bit kernel.


> Ian
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
