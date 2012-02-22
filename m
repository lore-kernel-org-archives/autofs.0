From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 10:16:38 -0800
Message-ID: <CA+55aFzKet5sASgrD==8iZ5m1+-FDpznfuqcNDS5ZyCocwzAbg@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <4F4484F0.9070501@zytor.com>
 <CA+55aFwUvuaGdnpwVQLQLF=DdqROmKqz65v+_DXHbebNhPqkLg@mail.gmail.com> <4F4529D4.6070008@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=VPldgmw4STYdGSYh7FWRk7tA6yJWX4EecPelAvLveOU=;
        b=cAGGh70GFpFD+gy/xdmrBI8wHD70ymYMR4zG+oiUZ8TXu/oQUHkyLOSsBKJY1CAHBZ
         YRitkSdy/G4FhjDVIl7WvliIrXWhZNEYbwpie0Q0dlE0qY0M1E9mhsOGVJhrQRPesLPg
         NcluYUb3r5cAQlXUKZYzt4VZDNMPQEzCIr9Wc=
In-Reply-To: <4F4529D4.6070008@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 22, 2012 at 9:45 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Incidentally, a valid user space workaround for this problem would be to
> just read all the data off the pipe but consider the packet length to be
> NAME_MAX rather than NAME_MAX+1; then simply discard all-zero ints
> received on input since a packet always starts with the autofs version
> number.

Nope, won't work.

Why?

Because that padding word for size is just random data.

In fact, we probably should clear it. I suspect we leak kernel stack
contents to autofs. Not that it matters (system daemon with root
privileges and all that), but it's another case of the whole "packing
data structures" issue.

Of course, right now autofs leaks kernel stack way more than that one
possible alignment word: the whole "name[NAME_MAX+1]" array is leaking
stuff after the name length (and final zero). So the padding is the
least of the leaking worries.

But the point is that because of very similar issues, the user-space
daemon cannot rely on things being zero.

Unless you fix the kernel, and increment the version number. But once
you do that, you're better off just fixing the size anyway.

                           Linus
