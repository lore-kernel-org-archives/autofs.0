From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized pipe
Date: Sun, 29 Apr 2012 17:43:29 -0700
Message-ID: <CA+55aFzDhkVzaUYQwKbkUqoRNb223+w0-k=pOxTZHja75JOMvQ@mail.gmail.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com>
 <4F9DDCB6.1070908@zytor.com> <CA+55aFwGZm4+rdJ+xArhsVJ8P5gH3xxCfuoHibotr0Sik484=w@mail.gmail.com>
 <4F9DDE47.5060008@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=p806KuJG+hEoW5Yd6H0JV1IbVOUjz3/ZMuYLzzutvFc=;
        b=HgR0ZLIx76DZdyLqakruyiHLJL9gzdyjv5FSqeFSHVKoz+uLjb0yKzRBr5QBffpHeH
         zoqb0z2m2sLKAdqRw5oknR40y58Q2sAEiSY48MNSU7bMJlN+gCQ836V3/JNlKDjECLG7
         qUwoYUWmH6Udwg7Z4f8P1X1IheLYmTSbm+aanMeYzo1vWzoeZvojd/m/UlNmQ0RUj+aB
         f2W16RwLlIRyhyeqZzbQ9o8DmCRwM/0qNorTlj9ewyQcNpHc0UYq/iDcX9U+HdBAh02X
         wNt6AXOKreVR6xdf0P8BpGbETpr5R73ChdpHwOZmdjnsfa08ubagqiqIggWyqjzs21Pt
         GzBw==
In-Reply-To: <4F9DDE47.5060008@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, Apr 29, 2012 at 5:35 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Which is funny/sad, because that's actually the intended way the
> interface is meant to work.

Well, the autofs packet model is actually horribly badly misdesigned
even for that: the header doesn't contain the size of the packet. It
contains the packet *type*, and from that you can then determine the
size (of course, every other program would determine it *wrongly* for
this whole x86-64 alignment reason), but that is actually a horrible
model because it assumes you know all the packet types.

(There's a "len" field in the v5 packet, but that's not the packet
length, that's the length of the name component)

And the reason nobody does that is that in practice there is only ever
one single type of packet that is possible anyway, so there's no point
in even reading the header to find the type.

So a much nicer model is one where the actual *size* of the packet is
in the header. That would have allowed for not having that fixed
maximum size of a name etc, and would have avoided the whole problem
to begin with.

Of course, the nicest model of all is to just use a packetized
interface to begin with, so that none of these issues exist. Which is
what we're now effectively moving to, unless we can find some horrible
program that makes that impossible due to it playing games and knowing
it's a "stream".

Looking at am-utils, I think we're ok so far. But maybe you know of
yet another crazy user of the autofs interfaces.

                      Linus
