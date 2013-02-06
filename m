From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] unbreak automounter support on 64-bit kernel with
 32-bit userspace (v2)
Date: Wed, 6 Feb 2013 17:21:20 +0000
Message-ID: <20130206172120.GJ26454@arm.com>
References: <510AE21D.2090002@zytor.com>
 <20130204193952.GA5785@p100.box>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130204193952.GA5785@p100.box>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Ian Kent <raven@themaw.net>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, Feb 04, 2013 at 07:39:52PM +0000, Helge Deller wrote:
> automount-support is broken on the parisc architecture, because the existing
> #if list does not include a check for defined(__hppa__). The HPPA (parisc)
> architecture is similiar to other 64bit Linux targets where we have to define
> autofs_wqt_t (which is passed back and forth to user space) as int type which
> has a size of 32bit across 32 and 64bit kernels.
> 
> During the discussion on the mailing list, H. Peter Anvin suggested to invert
> the #if list since only specific platforms (specifically those who do not have
> a 32bit userspace, like IA64 and Alpha) should have autofs_wqt_t as unsigned
> long type.
> 
> This suggestion is probably the best way to go, since Arm64 (and maybe others?)
> seems to have a non-working automounter. So in the long run even for other new
> upcoming architectures this inverted check seem to be the best solution, since
> it will not require them to change this #if again (unless they are 64bit only).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> CC: James Bottomley <James.Bottomley@HansenPartnership.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rolf Eike Beer <eike-kernel@sf-tec.de>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Ian Kent <raven@themaw.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
