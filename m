From: tomas <tomasbortoli@gmail.com>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in getname_kernel
Date: Mon, 2 Jul 2018 13:55:47 +0200
Message-ID: <b9188b32-d50a-4498-a05b-5f0e589bf985@gmail.com>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
 <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
 <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
 <1530526820.9527.4.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RxrMUVGDhR3GC/B2L1wpEqprgsmh4736CIMcI8Fd+JY=;
        b=suQygYhmdUbAbSLIKmnvlMSGhIJlzcE7JZtjccKnu1XZlPDJXWK6mJCDOV8xsLBG4C
         C0OxCNww1FmbynVzv04QwXBPnYWs+jfdyt8lA+Fg3hyshwuFOJnhkV/kdCwaT9BVdOee
         3vtTgB/0fXUe2WPoCX3Dz7Z2woXOv73kSH+YuoJnImnX7KCwGwjDdXtD2sPRyhmU1V5+
         csMN6GDiOSXP3VocqK/JUU+lXxMc/0fG9Zw0wkVJ41MNCYWbXOtLrTuybMFs4NPYM2A4
         qNpLKFn1IGZ/sf87O4lqRSck61WOkVV3qWxzpUYLY5D9L+0qeWwb6DOQtZIb7Hiw76rd
         AUtQ==
In-Reply-To: <1530526820.9527.4.camel@themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, autofs@vger.kernel.org

Yes, thanks. Please use my full name, Tomas Bortoli.

Cheers


On 07/02/2018 12:20 PM, Ian Kent wrote:
> On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
>> Hi Ian,
>>
>> you are welcome!
>>
>> yes your patch is much better. You should just put the "_IOC_NR" macro
>> around "cmd" in the lines added to "validate_dev_ioctl" to make it work.
> LOL, yes, that was a dumb mistake.
>
> I'll send it to Andrew Morton, after some fairly simple sanity testing,
> with both our Signed-off-by added.
>
>> Tomas
>>
>>
>> On 07/02/2018 03:42 AM, Ian Kent wrote:
>>> On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
>>>> On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
>>>>> Hi,
>>>>>
>>>>> I've looked into this issue found by Syzbot and I made a patch:
>>>>>
>>>>> https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425
>>>>> b116
>>>>> 3
>>>> Umm ... oops!
>>>>
>>>> Thanks for looking into this Tomas.
>>>>
>>>>> The autofs subsystem does not check that the "path" parameter is present
>>>>> within the "param" struct passed by the userspace in case the
>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
>>>>> path is always provided (though a path is not always present, as per how
>>>>> the struct is defined:
>>>>> https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_de
>>>>> v-io
>>>>> ct
>>>>> l.h#L89).
>>>>> Skipping the check provokes an oob read in "strlen", called by
>>>>> "getname_kernel", in turn called by the autofs to assess the length of
>>>>> the non-existing path.
>>>>>
>>>>> To solve it, modify the "validate_dev_ioctl" function to check also that
>>>>> a path has been provided if the command is
>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
>>>>>
>>>>>
>>>>> --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200around
>>>>> +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
>>>>> @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
>>>>>              goto out;
>>>>>          }
>>>>>      }
>>>>> +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
>>>>> +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
>>>>> +        return -EINVAL;
>>>> My preference is to put the comment inside the else but ...
>>>>
>>>> There's another question, should the check be done in
>>>> autofs_dev_ioctl_openmount() in the same way it's checked in other
>>>> ioctls that need a path, such as in autofs_dev_ioctl_requester()
>>>> and autofs_dev_ioctl_ismountpoint()?
>>>>
>>>> For consistency I'd say it should.
>>>>
>>>>>  
>>>>>      err = 0;You should just put the "_IOC_NR" directive around "cmd" in
>>>>> the lines added to "validate_dev_ioctl" to make it work.
>>>>>  out:
>>>>>
>>>>>
>>>>> Tested and solves the issue on Linus' main git tree.
>>>>>
>>>>>
>>> Or perhaps this (not even compile tested) patch would be better?
>>>
>>> autofs - fix slab out of bounds read in getname_kernel()
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> The autofs subsystem does not check that the "path" parameter is
>>> present for all cases where it is required when it is passed in
>>> via the "param" struct.
>>>
>>> In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
>>> ioctl command.
>>>
>>> To solve it, modify validate_dev_ioctl() function to check that a
>>> path has been provided for ioctl commands that require it.
>>> ---
>>>  fs/autofs/dev-ioctl.c |   15 +++++++--------
>>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
>>> index ea4ca1445ab7..61c63715c3fb 100644
>>> --- a/fs/autofs/dev-ioctl.c
>>> +++ b/fs/autofs/dev-ioctl.c
>>> @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
>>> autofs_dev_ioctl *param)
>>>  				cmd);
>>>  			goto out;
>>>  		}
>>> +	} else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
>>> +		   cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
>>> +		   cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
>>> +		err = -EINVAL;
>>> +		goto out;
>>>  	}
>>>  
>>>  	err = 0;
>>> @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
>>>  	dev_t devid;
>>>  	int err = -ENOENT;
>>>  
>>> -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>> -		err = -EINVAL;
>>> -		goto out;
>>> -	}
>>> +	/* param->path has already been checked */
>>>  
>>>  	devid = sbi->sb->s_dev;
>>>  
>>> @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file
>>> *fp,
>>>  	unsigned int devid, magic;
>>>  	int err = -ENOENT;
>>>  
>>> -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>> -		err = -EINVAL;
>>> -		goto out;
>>> -	}
>>> +	/* param->path has already been checked */
>>>  
>>>  	name = param->path;
>>>  	type = param->ismountpoint.in.type;
>>

