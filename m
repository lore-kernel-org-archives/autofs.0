From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: Re: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
Date: Mon, 4 Jul 2016 13:04:54 +0900
Message-ID: <CAHndrB=8zS7zdr4X6aTby4TsqKc5waGjc3Lbrva-puZZv6q9pw@mail.gmail.com>
References: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
 <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com> <1467599063.3317.10.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bXJXFt+iMFetm/IfdrVVs7Ma+uK7WADMquqX9wOYf7A=;
        b=cr9HtIzVo8ZPeSQfe8yuht/+kwP/3r2xvsmsLoMORbeG1L2kMIJa6yJWWbhH2OcK4p
         Eqmi9KnpU3yXJ6ERft3gdprwoLvHQelwX2Z0A+q3obmS9HPlmtuK69usgxpDxAh4RXTx
         GqPc3eIVIjxYNo+MPDiaP+CtPbUESWWzc34yN04ail/VxsSEjHmkOVYQ7TDvckjYnfE+
         R3VTV24tzS1AFQ3TK8yyGPyTyV//F+u994CGB6BhM06y3pbvh8uvoaxGO5kCMpRTHD3c
         SSXdA62j/Qs/ihf3ZgBkXLoqClTfl0pnG6AM8m7HqdzV8QvjATxguWD1OH90N7T6Of0t
         +qqA==
In-Reply-To: <1467599063.3317.10.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

Thanks for your review.
I've submitted the v2 patch which only changed BUG_ON to WARN_ON.

I didn't use a return value of EINVAL as this function returns a pointer.
(and I didn't want to return EINVAL casted to a pointer)

2016-07-04 11:24 GMT+09:00 Ian Kent <raven@themaw.net>:
> On Sun, 2016-07-03 at 18:51 -0400, Jeff Mahoney wrote:
>> On 7/3/16 6:29 AM, Tomohiro Kusumi wrote:
>> > It's invalid if the given mode is neither dir nor link,
>> > so don't let it fallthrough on else case.
>>
>> Is this case really worth crashing the entire system?
>>
>> Wouldn't a WARN_ON + return -EINVAL be sufficient?  At the very least it
>> means that a developer doesn't need to reboot to reload the module if
>> they hit this.
>
> That error return should be sufficient to cover this case and the WARN_ON() is
> useful too.
>
> And while there is some justification for the BUG_ON() earlier I also think an E
> INVAL return would be more sensible there too.
>
> BUG()ing on errors that should be handled is really bad IMHO.
>
>>
>> -Jeff
>>
>> > Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
>> > ---
>> >  fs/autofs4/inode.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
>> > index ad0ee93..7f35c82 100644
>> > --- a/fs/autofs4/inode.c
>> > +++ b/fs/autofs4/inode.c
>> > @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void
>> > *data, int silent)
>> >     if (autofs_type_trigger(sbi->type))
>> >             __managed_dentry_set_managed(root);
>> >
>> > +   BUG_ON(!root_inode->i_fop || !root_inode->i_op);
>> >     root_inode->i_fop = &autofs4_root_operations;
>> >     root_inode->i_op = &autofs4_dir_inode_operations;
>> >
>> > @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb,
>> > umode_t mode)
>> >             inode->i_fop = &autofs4_dir_operations;
>> >     } else if (S_ISLNK(mode)) {
>> >             inode->i_op = &autofs4_symlink_inode_operations;
>> > -   }
>> > +   } else
>> > +           BUG_ON(1);
>> >
>> >     return inode;
>> >  }
>> >
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
