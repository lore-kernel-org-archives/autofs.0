From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized
 pipe
Date: Mon, 30 Apr 2012 13:03:01 -0700
Message-ID: <4F9EEFF5.4000703@zytor.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com> <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com> <4F9DDD3E.6010801@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9DDD3E.6010801@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On 04/29/2012 05:30 PM, H. Peter Anvin wrote:
> Incidentally, I think there is a good reason to add a v6 packet type
> regardless, for efficiency: with packetized pipes there really is no
> point in sending a packet which is mostly padding for no good reason.

Thinking about it some more: for v6, I wouldn't use a packetized pipe at
all (due to the unnecessary extra buffer consumption.)  Instead just put
the message size in the header and read a large chunk, which may end up
being more than one packet and may end up with a partial packet at the
end.  *This is okay*, because there is only one reader, and any
additional data needed will be gotten the next time around the loop.

	-hpa
