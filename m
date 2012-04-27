From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 15:49:32 -0700
Message-ID: <CA+55aFxoGXgVhPyU6ObOnowpCNVYCyaVeFswLx_vJ3c4KBf3yw@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <20120427234215.079a1565@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=4TKEAmw7ZEQDvFtnQG7lOOerfEu65glcq0Pez8DtA8w=;
        b=FzNi1W88PSV8VZwIj0ElUzgVj8QNqdw0Wa7EwjrG84JG27h9pSrdcJXrrf4xN9W57C
         kanwUjVHYBSW9cXosHXxuRRL97jNo6VethMg6CfptZCIw4gpPjdNu7o2iYDiyEYkMFj8
         R5JT9TqGI5aILAFUbjOBwA2bmWwIuG7qlGu3gL1NedeBPjMgQStMYFSoHm7lUGkRxSKu
         EJWDmCzqb31WjA2BNOP0ex25te3SrL5frfe9NwEIEfCeBefrfqb7WCSJ7L0oWZ3J5/Cf
         +Xa7A3fDAExnWrCeEqzq1HTngmAt/LeifiQTdrlcip5Ftx0yf+ulvg7kNyRe7va82uY+
         X3yA==
In-Reply-To: <20120427234215.079a1565@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 3:42 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Comments? The patch looks fairly simple. The "packetized pipe" might
>> even be useful for other users and maybe we might want to expose it as
>> an actual pipe fcntl, but right now the only thing that sets that flag
>> is autofs.
>
> The obvious way to set the flag would seem to me to also btake O_DIRECT
> on the pipe as meaning this ?

Hmm. That would work, then if you wanted to create a packet pipe, you'd just use

   if (pipe2(fd, O_DIRECT | O_NONBLOCK)) {
     perror("Kernel doesn't support packetized pipes");
     return -1;
  }

which means that if user space wants to use packetized pipes for other
things, it now has a nice way of testing whether the kernel supports
it (because older kernels would return -EINVAL - for once we actually
verify that only the flags we support are set).

And that maybe we wouldn't even need the extra flag in the "struct
pipe" at all - we could just check it in file->f_flags.

Let my try that.

                   Linus
