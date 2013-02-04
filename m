From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] unbreak automounter support on 64-bit kernel with 32-bit
 userspace (v2)
Date: Mon, 04 Feb 2013 13:35:38 -0800
Message-ID: <511029AA.1060007@zytor.com>
References: <20130204193952.GA5785@p100.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20130204193952.GA5785@p100.box>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, Catalin Marinas <catalin.marinas@arm.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 02/04/2013 11:39 AM, Helge Deller wrote:
> 
> This suggestion is probably the best way to go, since Arm64 (and maybe others?)
> seems to have a non-working automounter. So in the long run even for other new
> upcoming architectures this inverted check seem to be the best solution, since
> it will not require them to change this #if again (unless they are 64bit only).
> 

... and even then they will generally work just fine.

	-hpa

