From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
Date: Mon, 02 Jul 2018 09:10:27 +0800
Message-ID: <1530493827.2749.8.camel@themaw.net>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8YZam6lJmaF6kOuDSp1z1cynco9eK
        pZcmoE12zJ3WDE=; b=d4+mMHRurFPaBBLc+VgmmcrO9bq6iFmukPDJVKNBg3Pcz
        1V4W4liYVviT/0AZayMoZ5xbccC6jpMz0stRdQmVSmCUVtYAU8R0qMtjcwLi7gAf
        B85QZzcbr1QCL6IMZa8wXEc0+vF8goR8gm5q/I0kpjBgySIvhp59yBvGV7bQxiXx
        jDGnaLBpZYtQsROdSih5eYgNL/NRSAxMJttqxeQpZPt7kJP0eQ/jnW2RlFsfhSFJ
        1c55krPbAYvYoNAAf1GqKVv7rbWYqd9O38TStBhynKtH9tffv6NYYnwybtTrZ0FZ
        EIYVxMjt97vnkNieZCmaM7W0eWVMRLiRYLI2ESXEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8YZam6
        lJmaF6kOuDSp1z1cynco9eKpZcmoE12zJ3WDE=; b=T8YJC6NR39jC21CIXJn1zt
        go8vCP1jC7wd2ZNLfEZVHpnb3tNOGMFnlYhb/Twz8m+PPpARPU4gZJitWK0EwVLf
        76TqWoHq6hV3WHZ7rlkaEHq2df0iZUrKDAZu4v7/sjurfcDEBoyFuMRRuCYoBecB
        O88ulhX98CUTR0H0A0fiZcL2eFW6gDLeNJ7KNCUTGs9B5R0jaCxyVM/RoxA2qOwJ
        f6vJT/kh6VNoqW/fc8ZkeuIh0qfNLFo1mEolNKZAbKb2tXOA2+im4q2ZFnUR+4hu
        FyIgXyUTBW4IXDXUkg3MWYeDzzNx3Jl2iPQ/StoioAKik9qZXsuXPWflPplSQ29g
        ==
In-Reply-To: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tomas <tomasbortoli@gmail.com>, autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> Hi,
> 
> I've looked into this issue found by Syzbot and I made a patch:
> 
> https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425b1163

Umm ... oops!

Thanks for looking into this Tomas.

> 
> 
> The autofs subsystem does not check that the "path" parameter is present
> within the "param" struct passed by the userspace in case the
> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
> path is always provided (though a path is not always present, as per how
> the struct is defined:
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_dev-ioct
> l.h#L89).
> Skipping the check provokes an oob read in "strlen", called by
> "getname_kernel", in turn called by the autofs to assess the length of
> the non-existing path.
> 
> To solve it, modify the "validate_dev_ioctl" function to check also that
> a path has been provided if the command is AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> 
> 
> --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200
> +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
>              goto out;
>          }
>      }
> +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> +        return -EINVAL;

My preference is to put the comment inside the else but ...

There's another question, should the check be done in
autofs_dev_ioctl_openmount() in the same way it's checked in other
ioctls that need a path, such as in autofs_dev_ioctl_requester()
and autofs_dev_ioctl_ismountpoint()?

For consistency I'd say it should.

>  
>      err = 0;
>  out:
> 
> 
> Tested and solves the issue on Linus' main git tree.
> 
> 

Ian
