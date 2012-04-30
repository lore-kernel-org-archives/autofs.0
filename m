From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized pipe
Date: Sun, 29 Apr 2012 17:33:48 -0700
Message-ID: <CA+55aFwGZm4+rdJ+xArhsVJ8P5gH3xxCfuoHibotr0Sik484=w@mail.gmail.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com> <4F9DDCB6.1070908@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZCj2ek4vBtjtpFmR+NWyhcYqZ2eVxeDpvu3rXu6+89c=;
        b=iBzRL6Yn6HErByl7ug5A2mf713dpZJ1e/qNFlsfLZmia8x9LAXPnJTooKUq/b+/Etc
         BFwZtSNx0BhDh6vGvnpL9dzC/topCkcgEUUkh5Qu4dfwQq6nYEfvX54f+YjcgPic0EpL
         S7WCESjHtJr877pvrr81121HAz62O7ZETMUlsclWqqKP0Opg0c2DeZKseM0YTm9AAyck
         KLNRWw5dux2BRpEvS5fJrthbtPWa3bbz9htt88H99tkRs5Ng3/BDZj1pcMHs7n72QcL+
         3McprhBlKS6K3SQGkOQk6IcQoQBiZQ+7CHzgH1V3OQDaIQktbyiODL0YRxNco1Lfx8mz
         Dqxw==
In-Reply-To: <4F9DDCB6.1070908@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, Apr 29, 2012 at 5:28 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> =A0do {
> =A0 =A0i =3D read(fd, buf, bytes);
>
> =A0 =A0if (i <=3D 0)
> =A0 =A0 =A0break;
>
> =A0 =A0buf =3D (char *)buf + i;
> =A0 =A0bytes -=3D i;
> =A0} while (bytes);
>
> =A0return bytes;

Ok, that should be fine. It will always get the full packet in one
read, so the short read case will never actually happen.

In fact, automount has this exact same pattern, except it calls the
function "fullread()".

The problem is only if it starts out by reading just the header of the
packet, and then reads the rest of the packet as a second read. *THAT*
won't work with the packetized pipe approach, because reading the
header of the packet will then discard the rest of it, and the second
read would try to read the *next* packet (which under many normal
loads won't even exist, of course).

                       Linus
