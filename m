From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized pipe
Date: Sun, 29 Apr 2012 17:25:35 -0700
Message-ID: <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=3mj5xJ/F+mh6w0PTMsw9e+xyqEE5vLgxKvSOU9l972w=;
        b=HiEitKHrjPrjkmueHCWuQSJ4kkKUXLgjlrAxSd6xv7QSx/XItxrPjQlz0rxvXOP3Lt
         UuRPQIWrpFhUi7mZkXkO8mKuK7doyJt2nj2M/M+E+hq23qXBeCrM6Q+zu2FfurbodXej
         heThqyGIb/F4bZvubqf6vYFhZaoc7ZAYPEJblFN14ctfXph/2/3/DHXvRyER/ACcQmpS
         mZBqbQPfmoB/+UdD6o1WXKgI0yo6oPUmdetqbIo0I+wqsVzzQVvMj035hXWDaQPN4uwL
         UEiAdJDm9QUugRKlj/Jt3C0/7mAL3fPaOhNA9AMVBxJNrQ2seyBoz9hDmIlM95ulPb5P
         lKcQ==
In-Reply-To: <4F9DD994.70202@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, Apr 29, 2012 at 5:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I just looked at am-utils; am-utils *does* use autofs v5, and *will*
> loop back and read more data on a short read.

Can you point to the sources?

If it's "short read" as in "I didn't get as much as I expected", that's fine.

If it is "short read" as in "I don't even try to read 300 bytes, I
read it in 8-byte chunks", we're screwed.

                     Linus
