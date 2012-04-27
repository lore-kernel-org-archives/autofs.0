From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 15:42:55 -0700
Message-ID: <CA+55aFz-1n=REkh9SzA1aEz5J_uGc=B_nKj+cP8J=PR6YSZD1w@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <4F9B050C.3000309@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=X9SUGwTugGqqtmMiVSB30O+qHMfNOXTI0w6V3i/P+F8=;
        b=q/2Gjw/Y1HcPkwAcu8Rp3Bhb6kjwU6qS3HTw8jVpCBB9dk4XUsnjvD8rTG2pWeJPU8
         D72f3+O+3WwWoPIRuYfdz/m+Lgz+jHsJjTUGPb31l7SEiQyFjwaYztN1Mz8/6dOG9kjI
         nw7WzMkh5MyC7CTrfXjrRvoAiqb1oj5AbWd6x0h51WYiz1EAOOALM2zp9Pv+CFJg8f8b
         n1CEZfbF5aWfRPtbh+ZuufV1OmJqFr9fNMiwjMKgtLrHqVzyRUnrY3tM0G2lv+T/0ogc
         re+UKy2n6ihBJ0OxQMCeEF0SEUzhFTCErRdX2N/1Vv0xxTAbzNcIIMbL3abtW3vm8qO8
         r2aw==
In-Reply-To: <4F9B050C.3000309@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 1:43 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Why not just use the already existing SOCK_SEQPACKET sockets?

Have you looked at the interface?

The file descriptor is created in user space, and is defined to be a
pipe. So both automount and systemd create a pipe, and then pass that
pipe fd to the mount system call.

So it is not autofs that creates the file descriptor for the user.
It's the other way around: the user creates (using "pipe()") the file
descriptor, and passes it to autofs.

                        Linus
