From: Ian Kent <raven@themaw.net>
Subject: Re: [announce] autofsng 0.3.1
Date: Tue, 23 Nov 2004 13:42:22 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411231337410.1055@wombat.indigo.net.au>
References: <41A29809.9090707@sun.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <41A29809.9090707@sun.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

On Mon, 22 Nov 2004, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello All,
> 
> I'm pleased to announce the release of AutofsNG 0.3.1.
> 
> This automounter is intended to be 100% interoperable with autofs
> implementations on other Unix platforms.  As such, it supports some
> feature that the current Linux automounters do not:
> 
> - - Direct Mounts (*)
> - - /net (--hosts access) (*)
> - - Lazy mounting of hierarchal / multimounts
> - - Lazy unmounting of hierarchal / multimounts
> - - Browsing (*)
> 
> (*) automount 4.1.3 supports these features but with limitations that
> impact interoperability.

Yes. And in 4.x.x ...

Lazy multimounts would (will if ever) be extrordinarily difficult to 
implement.

Direct mount rework is likely to cause 2.4 kernels to choke! But then 
autofsng is 2.6+ specific also.

Ian

