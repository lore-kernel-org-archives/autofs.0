From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 13:43:56 -0700
Message-ID: <4F9B050C.3000309@zytor.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net> <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com> <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On 04/27/2012 12:56 PM, Linus Torvalds wrote:
> 
> What it does is add a new "packetized" flag to pipes, which does two
> simple things:
>  - do not merge write data in pipe buffers when writing
>  - when reading, consider a pipe buffer to be "spent" when any of the
> data has been read
> 

Why not just use the already existing SOCK_SEQPACKET sockets?

	-hpa
