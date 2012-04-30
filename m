From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized
 pipe
Date: Sun, 29 Apr 2012 23:48:28 -0700
Message-ID: <4F9E35BC.5000200@zytor.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com> <4F9E30BF.4030704@msgid.tls.msk.ru> <4F9E3474.2050405@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9E3474.2050405@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On 04/29/2012 11:43 PM, Michael Tokarev wrote:
> 
> I think this is a false alarm.  I checked autofs v3 and v4
> userspace code (found on  http://www.kernel.org/pub/linux/daemons/autofs )
> and they both read whole packet at once, not piece-wise.
> 

Yup, the original braindamage is all mine.

	-hpa
