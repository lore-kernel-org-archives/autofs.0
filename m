From: Michael Clark <michael@metaparadigm.com>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 07:42:30 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3FFDEAE6.4030503@metaparadigm.com>
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net> <3FFD9498.6030905@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FFD9498.6030905@zytor.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, Mike Waychison <Michael.Waychison@Sun.COM>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On 01/09/04 01:34, H. Peter Anvin wrote:
> In many ways this returns to the simplicity of the autofs v3 design 
> where the atomicity constraints where guaranteed by the VFS itself, *as 
> long as* mount traps can be atomically destroyed with umounting the 
> underlying filesystem.

Do we need to revive Tigran's forced unmount patch 'badfs' ala FreeBSD's
deadfs? Although it doesn't guarantee atomic unmount, it could help
a lot with the tendancy to get stuck autofs mounts.

   http://tinyurl.com/2hto8

I've been long waiting for this functionality in mainline.

I wonder if binding badfs over the mountpoint at the beginning of the
potentially lengthy unmount process would improve the atomicity
to userspace. ie although the unmount would proceed in the background,
badfs would have been mounted at that point at the start of the process
- mounts are atomic no?

~mc
