From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Tue, 21 Feb 2012 19:47:38 -0800
Message-ID: <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=JRsBKPQeHO+Xo8xPIOKRFB93Ttf9XbLJAXeAHjomGkg=;
        b=D0Cl3S0xwk4cN1beeJXs/CTrTyoNI/ZXhlNtBqX7TEkqo8iHP6vmeJy5j+mXBV+BO9
         +jUixCuhUw9MUVzuZYcwHLmQ+p50vibtQ97H0fD/nN5aN93h6SODBHggZ+gKBm0zmY1R
         eG+H1iHyQfH6932jhJBgsyWDNG2fvY4CJY0tk=
In-Reply-To: <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, autofs@linux.kernel.org, thomas@m3y3r.de, viro@zeniv.linux.org.uk

On Tue, Feb 21, 2012 at 7:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I'm sure that the autofs daemon does something simple that we can
> depend on in practice.

I didn't find the most recent source code, but the first thing that
automount.c does after calling "mount" (which is a for+exec, so we
cannot take the mounting is_compat_task() into account is to open the
new root for the ioctlfd, and then it does a stat.

And then it does a AUTOFS_IOC_PROTOVER ioctl to see what the protocol
version is.

So we could just decide that

 (a) we add a mount option for the packet size (or just "v6" - which
would be "v5 with a fixed packet size")

 (b) in the absence of an explicit mount option, we look at
is_compat_task() for the first AUTOFS_IOC_PROTOVER ioctl we get.

That looks fairly straightforward and safe. Hmm?

Where are the automount sources supposed to be, anyway? kernel.org has
a v5 directory, but it's empty.

                Linus
