From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs + shared mount namespaces
Date: Thu, 14 Sep 2017 08:51:56 +0800
Message-ID: <3b5cb023-09ad-ccad-dc61-968a1b44dd31@themaw.net>
References: <CAJsjXgryH912APrqk3rzECB=MHKdDg_ROfa6mjTETKKBrW7mmg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=GVN40B75SerXOoThmX
        IFNAWH7EmvmCQCjSMKhbmwMDg=; b=jCpNoJYl75/YC5Rm1m/yojJ67+eU/heV/z
        E+sxEupWOFhyxUoXjPTn/4jbMs9gUhfDTda6FprG14TGoLML5lIglhOHgT3McRLY
        NLdbNJv6t6DnPJTNZ5OgfkvBrL+aW1OzaPCBoHjdJoH0LW5p2V3TRoJWxrSlSOe7
        UI+eSktnHcuFOzt9lCZ0KkymTUmcmlUX2dVkIZhAyMMi9B5+4qWXEY5I/u3h4COF
        WK3TOY5R1HvgWJDgq9TMQpH/NZQZjvgnM+awij+jXHwjyAnYfb6vpZXR3Zl3pXlw
        ZgFT35HI8j4Qs+KWYnegx+/sDz9YydrH9fsEfdw1oRlDcNvVUMXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=GVN40B75SerXOoThmXIFNAWH7EmvmCQCjSMKhbmwMDg=; b=c1ldwmWA
        1saSz+xRqsFev7olVU0Jf5joj2/doqKLo6EL0Lk3LBGyFKJbEw5kIqxw7N4l5iMZ
        6lGP0h7a7DejoSJimWbcQzFzGpxrf0ZrZtlPwj0fCNLeG1HT2h1O33/WbCtOMoMZ
        NWsZF84OTUmxriExLmWKK6uC0lXcjY2xz/Kky4q04z5OuWzoDeHQnvcu/PgRajhF
        3USDXLqWGw7Is2SjbuUP7kvHdbx7eWORR0DIkx0R6QjteHJuz+SWquVGbAkYkuWv
        2z0z0FKpD19rdqSGzEZlSYdUujTVaYeX5Q8jVgW5AiHbsAW0F55xx1hWdYJMxp8/
        virq5fDnYUpY7g==
In-Reply-To: <CAJsjXgryH912APrqk3rzECB=MHKdDg_ROfa6mjTETKKBrW7mmg@mail.gmail.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Badics, Alex" <alex.badics@balabit.com>, autofs@vger.kernel.org

On 12/09/17 21:17, Badics, Alex wrote:
> Hi,
> 
> We've been trying out autofs with both systemd-automount and the
> autofs userspace daemon, and it seems like it incorrectly marks a
> mountpoint as "expired" even though it's still in use in a different
> mount namespace. Am I doing something wrong? Are mount namespaces
> supported by the autofs driver?

There are challenges with namespaces that I'm unable to resolve.

The specific behavior your seeing is one of those problems.

I'm unable to find a way to check propogated mounts.

I tried recently and could only come up with a method that was
order n squared cost with the number of mounts which was, as you
would expect, rejected upstream.

And what kernel version are you using?

> 
> Reproduction:
> /etc/autofs/auto.master:
> /mnt/test   /etc/autofs/auto.test.nfs --timeout 10
> 
> /etc/autofs/auto.test.nfs:
> test  -rw,soft,intr server.domain:/exports/nfs
> 
> On one tab, I start autofs:
> # automount -f -v
> 
> On another, I unshare a namespace, and cd into the test directory:
> # cd /mnt
> # unshare -m --propagation shared
> # cd test/test
> 
> And just wait. The mount correctly happens, but after 10 seconds, the
> autofs daemon gets an expired message and tries to umount hte nfs
> mount, and fails, because it's busy. It retries until I cd out of the
> nfs directory, then it of course succeeds:
> 
> Starting automounter version 5.1.3, master map auto.master
> using kernel protocol version 5.02
> mounted indirect on /mnt/test with timeout 10, freq 3 seconds
> attempting to mount entry /mnt/test/test
> mounted /mnt/test/test
> 1 remaining in /mnt/test
> 1 remaining in /mnt/test
> 1 remaining in /mnt/test
> expiring path /mnt/test/test
>>> umount.nfs4: /mnt/test/test: device is busy
>>> umount.nfs4: /mnt/test/test: device is busy
>>> umount.nfs4: /mnt/test/test: device is busy
> Unable to update the mtab file, /proc/mounts and /etc/mtab will differ
> expired /mnt/test/test
> 1 remaining in /mnt/test
> 1 remaining in /mnt/test
> 1 remaining in /mnt/test
> 1 remaining in /mnt/test
> expiring path /mnt/test/test
> expired /mnt/test/test

What is it your trying to do?
How would you like this to behave?

Keep in mind that a mount namespace is little more than a view of
the set of current mounts so there is limited mount independence
possible.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
