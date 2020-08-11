From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] fs: autofs: delete repeated words in comments
Date: Tue, 11 Aug 2020 07:42:39 -0700
Message-ID: <811e011e-2f45-87c3-d92d-729680da5917@infradead.org>
References: <20200811021817.24982-1-rdunlap@infradead.org>
 <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qDSQHCDBU4D3YRSldaGEKRiZu5f5C5HcKUrvXP1BRoo=; b=BIjSpO0jPg+gb45bDcxNRZ5Cvw
        6TGXh918jACirRi/3Eo6jf/a9OrSgID5WPc9DYawF3ydNVOyu4YgdTblKd8HcyILobnac/x96bxeJ
        tTAT+8GYuesYENvzgLd8tipOmbaw4V5NTuHn3EpMpFz+qSydXoGQ/PWDcPBLX8zmU5RR8kt3Q/ZhZ
        uiuVgAi1f+STKDoAzmA1Xq7s/+qwntQftwuVrZrzTNawhyUW/V5/Z3Xc8yWkCnNpgwTOR46Y7/NQ9
        tiR6XqCrcF6XWtN2yJG3iZAVG+moqBhIwTc1eEnSXVAonvU908HuZN/uxx/mvlVZMwPBMdeLQbcBH
        oMMzoFeQ==;
In-Reply-To: <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org
Cc: autofs@vger.kernel.org

On 8/11/20 1:36 AM, Ian Kent wrote:
> On Mon, 2020-08-10 at 19:18 -0700, Randy Dunlap wrote:
>> Drop duplicated words {the, at} in comments.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Ian Kent <raven@themaw.net>
>> Cc: autofs@vger.kernel.org
> 
> Acked-by: Ian Kent <raven@themaw.net>

Hi Ian,

Since you are the listed maintainer of this file, does this mean
that you will be merging it?

thanks.

> 
>> ---
>>  fs/autofs/dev-ioctl.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
>> +++ linux-next-20200807/fs/autofs/dev-ioctl.c
>> @@ -20,7 +20,7 @@
>>   * another mount. This situation arises when starting automount(8)
>>   * or other user space daemon which uses direct mounts or offset
>>   * mounts (used for autofs lazy mount/umount of nested mount trees),
>> - * which have been left busy at at service shutdown.
>> + * which have been left busy at service shutdown.
>>   */
>>  
>>  typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
>> @@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
>>   * located path is the root of a mount we return 1 along with
>>   * the super magic of the mount or 0 otherwise.
>>   *
>> - * In both cases the the device number (as returned by
>> + * In both cases the device number (as returned by
>>   * new_encode_dev()) is also returned.
>>   */
>>  static int autofs_dev_ioctl_ismountpoint(struct file *fp,
> 

-- 
~Randy

