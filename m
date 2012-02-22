From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 08:10:42 -0800
Message-ID: <CA+55aFwUvuaGdnpwVQLQLF=DdqROmKqz65v+_DXHbebNhPqkLg@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <4F4484F0.9070501@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4kJDjiBrDPJzoC4MHD2XxBBoA5gyKlMeeZwUzunJu3g=;
        b=EdgqP5OBpNpRCBdosUIt1EuKDr0a/UEWEosp1h/+SaX3CE9r8MsTkIBVG/Q55G7nCV
         Uf/k7vrifkMjxnwlm055OVnhOSWSvgDzCfqltWQW7y4h/KJcZ3TtrqK2WHQMq961vofJ
         /9qgiyzziO5/goCOn263w/ndfUQrwV0fhECkA=
In-Reply-To: <4F4484F0.9070501@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Tue, Feb 21, 2012 at 10:02 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Note that it's really rather unfortunate that this transmits the enti=
re
> packet no matter what, which also means that the "len" field is actua=
lly
> completely and totally pointless.

Yes.

> I have mentioned in the past that I consider it a design mistake on m=
y
> part to have used a pipe in the first place: it was "so easy", but
> required an extra read for no good reason, or padding to fixed size
> resulting in this problem. =A0The right thing really should have been=
 to
> use a Unix datagram socket; these days using SOCK_SEQPACKET - that wa=
y
> the kernel would give you the right semantics by design.

Well, the kernel gives the right semantics for pipes too - writes are
guaranteed to be "atomic", so even in the presence of multiple writers
you can trivially do packetized data.

You just have to (a) add the length to the packet and (b) do the
length+packet write as a single write (which is limited to PIPE_SIZE -
4kB - for the atomicity guarantee).

If you don't have multiple concurrent writers without locking, the (b)
part falls away entirely, of course.

Yes, for the reader side you need to be able to handle the fact that
you can get more than one packet in one read() call, but sorting that
out isn't hard either.

But yeah, writing fixed-size data and then having a reader that reads
fixed-size data is just not a very good approach. It's doubly bad when
the "fixed size" isn't an explicit size that is documented in the
protocol, but depends on data structures.

                               Linus
