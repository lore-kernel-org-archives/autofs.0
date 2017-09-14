From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 1/2] autofs: set compat flag on sbi when daemon uses
 32bit addressation
Date: Thu, 14 Sep 2017 19:29:08 +0800
Message-ID: <a5488db7-e42a-753c-08ba-008579c1ecd6@themaw.net>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
 <20170901112144.2669.1453.stgit@localhost.localdomain>
 <e86c66c6-7430-00e2-518a-cb2b87ab4130@themaw.net>
 <b35f6e37-5138-7ede-4c6c-0aa016645977@virtuozzo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=WoThHwHLVwKN3GWnS8
        zSpRndxDGz3d3A5rHJA/hCPW8=; b=LX1XqScR/S1VYbm+L08jt94/eR1DD1wMJ/
        c6PH4Ss8B1cI2AHHmVriLHI/BfRgN9bYYD+cZwroXfyrE0nndzX5fA2Ln/5omBkC
        GxVU9WCKpdsVS10H9umHosKlOuwtU/LlXUkhOaMpZIx6X/AzGa2Wpt2+ryb4+PY5
        y+ntzGBKqHbDV1jlKle49/iR4ltJRFQc9Zb5zgWP7kirpZ7w7z6logsQNaZzWgZq
        8Nec0gqF3fGBuMtlq8JToIshLU0fDMaC3viLnTPXtQDTr7bCr366CJlyk8doXPPk
        XDUmiN5pKVB+kVbXVN//kbeksAOmxY3o1jMh1BJsU3ScGZO7ZibA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=WoThHwHLVwKN3GWnS8zSpRndxDGz3d3A5rHJA/hCPW8=; b=a2ZIeUG6
        GRXzsD9MAQYFvLs4a9hgOSMBn1OCZBSh3BtfzwjOAmJTWCnD91MvIh58td7ldCWu
        /p53rozmOZ++Z3gVVMbbd47eU9AmsEA2bDrrsYDgvprIuF08uQAaYhuvOoRwjMNk
        588eLnxxKm4iN+gqhsPYX734dN2gKnkAwY/FyZkin+HRc79VrcNeao5MrcF8jHm4
        wQ1MQj6W1gNNlOJRLr6EcBqMwts9qTkxjQhoEvMaY2GbpJ/5G2AGTQBbGCloFECo
        o9jYW79e8sNFxt9kYL7S+yTPXeCH+nX6yTtemVwrnVPoyrRaJ9OBVQviNfwqP9XP
        bqj5MI9mugmGdQ==
In-Reply-To: <b35f6e37-5138-7ede-4c6c-0aa016645977@virtuozzo.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: skinsbursky@virtuozzo.com
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

On 14/09/17 17:24, Stanislav Kinsburskiy wrote:
> 
> 
> 14.09.2017 02:38, Ian Kent пишет:
>> On 01/09/17 19:21, Stanislav Kinsburskiy wrote:
>>> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
>>> ---
>>>  fs/autofs4/autofs_i.h  |    3 +++
>>>  fs/autofs4/dev-ioctl.c |    3 +++
>>>  fs/autofs4/inode.c     |    4 +++-
>>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
>>> index 4737615..3da105f 100644
>>> --- a/fs/autofs4/autofs_i.h
>>> +++ b/fs/autofs4/autofs_i.h
>>> @@ -120,6 +120,9 @@ struct autofs_sb_info {
>>>  	struct list_head active_list;
>>>  	struct list_head expiring_list;
>>>  	struct rcu_head rcu;
>>> +#ifdef CONFIG_COMPAT
>>> +	unsigned is32bit:1;
>>> +#endif
>>>  };
>>>  
>>>  static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
>>> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
>>> index b7c816f..467d6c4 100644
>>> --- a/fs/autofs4/dev-ioctl.c
>>> +++ b/fs/autofs4/dev-ioctl.c
>>> @@ -397,6 +397,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>>>  		sbi->pipefd = pipefd;
>>>  		sbi->pipe = pipe;
>>>  		sbi->catatonic = 0;
>>> +#ifdef CONFIG_COMPAT
>>> +		sbi->is32bit = is_compat_task();
>>> +#endif
>>>  	}
>>>  out:
>>>  	put_pid(new_pid);
>>> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>>> index 09e7d68..21d3c0b 100644
>>> --- a/fs/autofs4/inode.c
>>> +++ b/fs/autofs4/inode.c
>>> @@ -301,7 +301,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>>>  	} else {
>>>  		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
>>>  	}
>>> -
>>> +#ifdef CONFIG_COMPAT
>>> +	sbi->is32bit = is_compat_task();
>>> +#endif
>>>  	if (autofs_type_trigger(sbi->type))
>>>  		__managed_dentry_set_managed(root);
>>>  
>>>
>>
>> Not sure about this.
>>
>> Don't you think it would be better to avoid the in code #ifdefs by doing some
>> checks and defines in the header file and defining what's need to just use
>> is_compat_task().
>>
> 
> Yes, might be...
> 
>> Not sure 2 patches are needed for this either ......
>>
> 
> Well, I found this issue occasionally.

I'm wondering what the symptoms are?

> And, frankly speaking, it's not clear to me, whether this issue is important at all, so I wanted to clarify this first.
> Thanks to O_DIRECT, the only way to catch the issue is to try to read more, than expected, in compat task (that's how I found it).

Right, the O_DIRECT patch from Linus was expected to fix the structure
alignment problem. The stuct field offsets are ok aren't they?

> I don't see any other flaw so far. And if so, that, probably, we shouldn't care about the issue at all.
> What do you think?

If we are seeing hangs, incorrect struct fields or similar something
should be done about it but if all is actually working ok then the
O_DIRECT fix is doing it's job and further changes aren't necessary.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
