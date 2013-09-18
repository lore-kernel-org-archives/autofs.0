From: Stef Bon <stefbon@gmail.com>
Subject: Re: How to specify "helper=x" option?
Date: Wed, 18 Sep 2013 07:56:10 +0200
Message-ID: <CANXojcwqLj9qUJGtBCy5=ra7f+hFd3LBzrm7L0FF8hF1ba85fw@mail.gmail.com>
References: <8761tyx5xj.fsf@passepartout.tim-landscheidt.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=b04ecl4yIBHqo5WOeETdwkkeuYwg2cHmhNqKQu1aOZU=;
        b=ihsNMctBx5kUGy919N/UZR93C9isnAXd/DAwSaftfGNdTb1UIddKZaTs3/gz5TeKFD
         Oy7iiYsZztnZRMz8uhvOSXiibiI9VpvV1frK6A/O9r6pVy1xJW1++R6qpteevNv9yffn
         FGnlB8rJWYbVjTGiLFmZtkNOQGc6fimjNkIrhtA7HK/rAT4v6AHcSq+GyIT6eToHAp/8
         wbWwVkz9pLxvrgl6z5XZJtvLxV8VVFamyKQKao9j+OXqNnEEu54jb0mcLcJ02dfLcHBS
         fO9zWl/4lLj8KcyHFonMn6yZqu7y4kempjVy5RUgyeCfKZ6QXblhnbjLSpCafbzhHgXs
         VwIQ==
In-Reply-To: <8761tyx5xj.fsf@passepartout.tim-landscheidt.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

I've had the same problem. I did not use the helper option, but
specified a non existent filesystem:

*   -fstype=md5key    :/&

Now this made my mount.md5key script is called.

But with unmountng autofs ignored my md5key filesystem.

Stef
