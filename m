From: raven@themaw.net
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Wed, 14 Jan 2004 23:58:42 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
 <4004409C.6040900@sun.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <4004409C.6040900@sun.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 13 Jan 2004, Mike Waychison wrote:

> >
> My proposal uses filesystems for all automount mechanism *except* 
> expiry. I see expiry as a VFS service, and strongly believe that this is 
> where it belongs.
> 

I'm certainly thinking alot about this and have made quite a bit of 
progress thanks to the patiience of all.

Now it think it may be time to ponder the expire mechanism.

I was thinking it might be good for me to write up a specification based 
on the discussion so far to make sure that we all have the same 
understanding of what has been discussed. Perhaps this could allow for a 
specification to follow.

Good idea or not?

Ian
