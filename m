From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] avoid calling mount during configure
Date: Sun, 21 Apr 2013 13:53:38 +0400
Message-ID: <5173B722.1030807@msgid.tls.msk.ru>
References: <5173AD94.9080301@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <5173AD94.9080301@gmx.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin von Gagern <Martin.vGagern@gmx.net>
Cc: autofs@vger.kernel.org

21.04.2013 13:12, Martin von Gagern wrote:
> Hi!
> 
> The configure script unconditionally calls "mount -s" in an attempt to
> figure out whether the command supports that option or not. This can

The support for old mount command, together with pre-2.2-something kernel,
should be just dropped from automount, together with all these configure
checks, instead of inventing even more workarounds.  In my opinion anyway.

/mjt
