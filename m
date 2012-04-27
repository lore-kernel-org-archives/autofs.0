From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 15:56:32 -0700
Message-ID: <4F9B2420.5030806@zytor.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net> <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com> <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com> <4F9B050C.3000309@zytor.com> <CA+55aFz-1n=REkh9SzA1aEz5J_uGc=B_nKj+cP8J=PR6YSZD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz-1n=REkh9SzA1aEz5J_uGc=B_nKj+cP8J=PR6YSZD1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On 04/27/2012 03:42 PM, Linus Torvalds wrote:
> 
> Have you looked at the interface?
> 

Yes.  I designed and implemented the v1-3 versions of the interface.
v4-5 has kept the pipe, but at least v5 dropped the reading of the
header with the included length as a separate operation.

> The file descriptor is created in user space, and is defined to be a
> pipe. So both automount and systemd create a pipe, and then pass that
> pipe fd to the mount system call.
> 
> So it is not autofs that creates the file descriptor for the user.
> It's the other way around: the user creates (using "pipe()") the file
> descriptor, and passes it to autofs.

I would have used SOCK_SEQPACKET if it had existed today, and so if
there is going to be a change in the interface I would use it.

I guess, though, what you're saying is to change the semantic of the
existing pipe to return short reads on the receive end.  That won't work
since the daemon code is written to loop back and read more if it
doesn't fill the buffer, so it "swallows the comma."  Hence it's a new
interface no matter how you slice it.

	-hpa

