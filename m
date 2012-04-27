From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 15:40:32 -0700
Message-ID: <CA+55aFw=T-+fsLi7RWxPz2FWAUzk4fxH28GWGLhwo3+L5JWsrw@mail.gmail.com>
References: <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <20120427.162925.2185774349490743693.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pWXIApqMfiwykH1FHLCdSFVrJcozIhvJzzH2zXYwPzQ=;
        b=aJuRlzm5jshBuu/taZxPelhB5ec7hACqrlURKdsSE3jwDVZVsWj6gZqUWptIcH/Bgp
         YF6ZK160VAfiHLT1Zab96lM1aHKT1t1vn5jjXME6iDMlWf9xZeB82V4Gkxh6qrenHzeo
         rxcTjgsnOAewsSiUynPSpZw1LyatpB13sjMZpBcUXs53aJTlxKmwmiNStQDX5KJBSHzu
         ghEBoepnimtlrE4T+XYh9Ntbk3pgRdiV6EW4SPr3NTTUX4KLfF9TY/05ZqzDNisAfd33
         onfz+ObYCkiuHhXW7Hlwx/BgG7mHl+pIcU2oLwImauIFFRdNbNGECUu1tSIixdRml/Jv
         i8VA==
In-Reply-To: <20120427.162925.2185774349490743693.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Miller <davem@davemloft.net>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 1:29 PM, David Miller <davem@davemloft.net> wro=
te:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 27 Apr 2012 12:56:20 -0700
>
>> =A0- when reading, consider a pipe buffer to be "spent" when any of =
the
>> data has been read
>
> So basically any sized read empties the entire pipe, right?
>
> As long as we never generate multiple messages at the same
> time, I guess this would work.

It would work regardless.

Read the notes (or the small patch) again. Reading a part of a pipe
buffer clears *that* buffer. And since the packetized mode also
disables merging of writes into buffers, that means that multiple
writes result in multiple buffers. By default, pipes have 16 buffers
(you can set the number if you really want to), so you can do multiple
writes of multiple packets, and then as you read them, you'll see each
write individually.

So let's say that you have a writer that does the following writes: 8
bytes, 100 bytes, 32 bytes.  If you have a reader that reads a
fixed-size buffer (let's pick 64 bytes just to make an example), the
reader will then see those exact three writes, except it will only get
the 64 first bytes of the 100-byte write (and the remaining 36 bytes
will be lost forever).

So it really is packetized.

Of course, if you try to write more than PAGE_SIZE in one single
write, the pipe code will split that up into multiple buffers, so then
a reader would see that as multiple "packets". But hey, that's how
pipes work - they have a size limit on write atomicity guarantees,
regardless of the packetized mode. And obviously right now we only
expose the packetized mode for the autofs pipe, which only does writes
of that one fixed size (~300 bytes).

                     Linus
