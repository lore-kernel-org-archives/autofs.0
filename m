From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized
 pipe
Date: Mon, 30 Apr 2012 13:14:15 -0700
Message-ID: <4F9EF297.50505@zytor.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com> <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com> <4F9DDD3E.6010801@zytor.com> <4F9EEFF5.4000703@zytor.com> <CA+55aFxXMXmdeHAu3xOBSJEsJ97P_-6qn595FM6s7WXeK0DkjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxXMXmdeHAu3xOBSJEsJ97P_-6qn595FM6s7WXeK0DkjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

> 
> The thing I *really* hate about the current autofs situation is how it
> really does everything you can possibly do wrong. Not at all the
> "let's just read as much as we can, and look at the return value to
> determine number of bytes/packets", but literally "I know a-priori how
> big the packet is, and I will read exactly that many bytes". That
> coupled with the psueod-fixed-size packets just made it a very very
> fragile thing.
> 

Yes, and that was my fault, originally... back when there was one packet
size and long before compat was a concern.

	-hpa
