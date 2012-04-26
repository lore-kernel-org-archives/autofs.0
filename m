From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Thu, 26 Apr 2012 17:44:48 +0400
Message-ID: <4F995150.4070003@msgid.tls.msk.ru>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

On 26.04.2012 17:34, Michael Tokarev wrote:
> This patch introduces a new autofs interface version, v6, which
> is exactly the same as v5 but uses better defined packet structure
> which does not change between architectures or platform bitness.
> Old interface is supported still.

I forgot to mention: this should go on top of revert of the
previous attempt to fix it, ie, after reverting commit
a32744d4abae24572eff7269bc17895c41bd0085.

The change does not break old API on which the workaround
in the automount daemon relies since new sizeof(packet)
will be dividable by 8 and hence the old workaround code
in automount (compiled with new header) will not trigger.

Thanks,

/mjt
