From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 11:42:58 -0700
Message-ID: <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
References: <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com>
 <4F9A6ABA.6050503@msgid.tls.msk.ru> <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com>
 <20120427.143402.1028957981042061092.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cECOehfmvcKZKmgtZT+xkkodJVgQRX+GVfL2BQFHoOI=;
        b=kKQo+SHKdN+NdY5JIi9V9SmvVDlPCZiiLLf5oaSLJf0f2odWzQg/tnNxSk+yiK8y8Q
         9bjJWREQHj5Vyju19P0kEav5GGSyP5r3omA0vRzjMSttpZdEm8eTl00fv/0QE2B/wEfz
         FaZW1Imw+AHPXZFjr8aDQMzABzWRuAN0Qvlr/rOSIoIMYCN7kHrAGyboQIzm7PHgFmK1
         5zPR3KnqDYM7IRHDiEJ9NU8SNxrVBdy7+KyPEq8541CukXqHupzdNMG1Z0eE66lh5zVD
         OU6xaMjvx1vpdqf3kM3DE3GyMR+nQutw4VHUkhiKskRlYA/TD8ceLDm0qI4/iPFHDJ7a
         5NCg==
In-Reply-To: <20120427.143402.1028957981042061092.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Miller <davem@davemloft.net>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 11:34 AM, David Miller <davem@davemloft.net> wr=
ote:
>
> If systemd wants to use version 5 of this thing, it has to have the
> same workaround code automountd has. =A0It is systemd (and now the
> kernel) which is broken.

There's no question that systemd is broken.

But those broken binaries are out in the wild. End of story.

> We should have never touched version 5 of the data-structure. =A0Havi=
ng
> 5 years of workaround precedence in userspace proves this.

Umm. The thing is, those broken binaries *work* on 32-bit.  They were
*tested* on 32-bit. They were *shipped* on 32-bit.

And we really do want to make it just work for people to build 64-bit
kernels. It is simply not acceptably to say "hey, you have 32-bit user
land, so use a 32-bit kernel". It's not a different ABI, never has
been.

It's entirely pointless to talk about some next version. THAT FIXES
NOTHING. What's so hard to understand? This is an existing problem,
and making a v6 DOES NOT FIX ANYTHING AT ALL.

And people who bring it up as a "fix" are entirely missing the point.

Seriously.

                      Linus
