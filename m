From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: Re: [PATCH v2] autofs: Add WARN_ON(1) for non dir/link inode case
Date: Thu, 7 Jul 2016 15:46:43 +0900
Message-ID: <CAHndrB=R8OCikM+WZD_LizLWSbBOZc8izbcTJyWP_WCNYgAfww@mail.gmail.com>
References: <1467603603-1530-1-git-send-email-kusumi.tomohiro@gmail.com> <1467871749.3206.25.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TwmIhr3QGKZELQj3tc5Ns5sVrbnHfjVs3WSp0dbQBrs=;
        b=jd5hboEMhItxgJ5GrY9p/YA87enC4ktq3r1yX2e5Mu6okFCINqxYTIsrVQe4yC5FaD
         8sthhassOUTL6FhTux5qYB9HakRlijAJeL8r5LNjBd9Ja9LsIA8SQdxDnOJFnFcD6L+t
         00K8fvlzmsJ0dAn05FnHkDnL6LqQ5roVF1hk6GtvqGwil9nT0HxVZ5WUVInJs0ofodhR
         bb8gEPhHAyNnHVTeowaZVsCmt3kiAAwwcJsrGkiOUDiuwIlP23O9nBwW08Vrdwo6XVrr
         m7qhP2mJ7pI37j87rx5I8Y/wgKDtLNE5HO0HclPlQ4YninRf8oD8qjK5XAqJTAM4QRT1
         w7cw==
In-Reply-To: <1467871749.3206.25.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

Sure, thank you for applying.

2016-07-07 15:09 GMT+09:00 Ian Kent <raven@themaw.net>:
> On Mon, 2016-07-04 at 12:40 +0900, Tomohiro Kusumi wrote:
>> It's invalid if the given mode is neither dir nor link,
>> so warn on else case.
>
> I've added this too.
>
> But ....
>
>>
>> (v2 changed BUG_ON to WARN_ON)
>>
>> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
>> ---
>>  fs/autofs4/inode.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>> index ad0ee93..89174ec 100644
>> --- a/fs/autofs4/inode.c
>> +++ b/fs/autofs4/inode.c
>> @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void *data,
>> int silent)
>>       if (autofs_type_trigger(sbi->type))
>>               __managed_dentry_set_managed(root);
>>
>> +     WARN_ON(!root_inode->i_fop || !root_inode->i_op);
>
> I'm dropping this.
>
> We know for a fact that this is a directory inode because above it was created
> with autofs4_get_inode(s, S_IFDIR | 0755) and here the operations are changed to
> those specific to the root inode.
>
>>       root_inode->i_fop = &autofs4_root_operations;
>>       root_inode->i_op = &autofs4_dir_inode_operations;
>>
>> @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb,
>> umode_t mode)
>>               inode->i_fop = &autofs4_dir_operations;
>>       } else if (S_ISLNK(mode)) {
>>               inode->i_op = &autofs4_symlink_inode_operations;
>> -     }
>> +     } else
>> +             WARN_ON(1);
>>
>>       return inode;
>>  }
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
