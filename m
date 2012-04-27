From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 16:07:21 -0700
Message-ID: <CA+55aFyCpiU5_nG-3Nra5q9x0-71amAQVetZTxxP6waR1ueYNQ@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <4F9B050C.3000309@zytor.com> <CA+55aFz-1n=REkh9SzA1aEz5J_uGc=B_nKj+cP8J=PR6YSZD1w@mail.gmail.com>
 <4F9B2420.5030806@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=csavlwcZIMjB6CJaADppGDREa86C1DuKuy1J+2+sJDY=;
        b=s3YL1ENsu31IDLeMJ3IoIDkQKC5TTbpY4E/6TavkbLk20Wvncz0Sor0TIe8BylpDnc
         b0D0Yf0WPdxuNEdrBd3K/3q0OOrIIkWe4fpQ7E827s/Bc8YBfhAxfQYTTBKdoH3Xkk8E
         SKmxSgWkRBwe3g1tFcXDNd99hi3jHbz3BYUUxQVBs8OzsKgavvd2gLDUg/1iMxLy7Yu6
         376EQ3R1qx7diPSEM5sPvD/iRAhTIRsXnljrfFax51p2zTZ/RdK61AAlV6QtIUVOvC/D
         yWI/hfFMKgMx7gtgI1wpXNzYmkfjCIC2PKGT89oaTHe/TO2iyEGzdcIs1BS3F49046Pn
         5i3w==
In-Reply-To: <4F9B2420.5030806@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 3:56 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I guess, though, what you're saying is to change the semantic of the
> existing pipe to return short reads on the receive end.

The important change is actually to make the read return the size requested.

So broken user space does a read() with the wrong size - and then
checks that it gets *exactly* that many bytes. Not more, not less.

The way to handle that is to
 - make sure the kernel always writes the maximally padded data
 - make the packetization simply drop any data that was in the packet
that the reader didn't ask for.

This is very much a semantic change, in that any client that tries to
read the packet with multiple reads (one 4-byte read to see the size,
followed by one "right-sized" read of the data) would be totally
screwed. The first read would indeed read the size, but it also -
because of the packetized interface - would simply drop the data, and
the next read would read the first bytes of the next packet.

But that's not what the autofs users actually do anyway. They just
read the whole packet.  So we can make *them* work. And the new
interface will be fairly robust (in fact, you could pass it some big
buffer and just know you always get exactly one packet, and never have
that whole stupid "sizeof()" at all).

                           Linus
