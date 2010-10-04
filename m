From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, RFC] autofs3: move to drivers/staging
Date: Mon, 04 Oct 2010 13:34:49 -0700
Message-ID: <4CAA3A69.9040709@zytor.com>
References: <201010042228.10642.arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010042228.10642.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: gregkh@suse.de, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org

On 10/04/2010 01:28 PM, Arnd Bergmann wrote:
> Nobody appears to be interested in fixing autofs3 bugs
> any more and it uses the BKL, which is going away.
> 
> Move this to staging for retirement. Unless someone
> complains until 2.6.38, we can remove it for good.
> 
> The include/linux/auto_fs.h header file is still used
> by autofs4, so it remains in place.

I say we should just delete it.

	-hpa
