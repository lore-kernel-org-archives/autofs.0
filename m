From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Tue, 21 Feb 2012 19:33:26 -0800
Message-ID: <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DDhGC6smAWYBF+YlOh1yJmU+Fr7nMb8RijTJ3O30ApA=;
        b=PaNl/9tk8CY72ZuPZ7mTRROVcqZswBArXwzRoH8ApGkCjvHHBPoauz83+/yoJSYX6e
         S1HLT9mQ2ihX7BLfOw7vPryIDLTlVvKgMvN+i7OIgDXbv8uQscNSE8AG6y3Kuq4T32sO
         EXeVr1K+vxr+MGvhZpwmfFuI3aqSfIaaYEhR8=
In-Reply-To: <20120221.221609.218135609185671883.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, autofs@linux.kernel.org, thomas@m3y3r.de, viro@zeniv.linux.org.uk

On Tue, Feb 21, 2012 at 7:16 PM, David Miller <davem@davemloft.net> wro=
te:
>
> It's just a real fd, and there is no way to tell the compat'ness for
> that. =A0The mount operation literally passes in an integer attribute=
 as
> the pipefd mount option, and that's what it seems to use to send thes=
e
> events.

Sure.

But I'm sure that the autofs daemon does something simple that we can
depend on in practice. It's fine if we default to the current "native
size" but then just have some heuristic that notices "oh, but we seem
to be running a compat daemon". After all, this is very much a special
case, I don't think we need to worry about people doing crazy things
in *general*, the only thing we need to worry about is a legacy x86-32
install that has been updated with a 64-bit kernel.

Where is that autofs daemon source code so that I can see what it does?

> The only way to fix this cess pool completely is to override the
> read() fop on that pipe, and translate the event stream in-situ.
>
> What we could do is just manage the autofs messages as a linked list
> of events, f.e. the packets in native format, then in the overridden
> read() handler we either pass it along as is (for non-compat tasks) o=
r
> translate to compat format and copy that to userspace instead.

Sure. But I just don't think we need to fix the general case.

                  Linus
