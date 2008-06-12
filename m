From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: fix 32-bit userspace vs 64-bit
	kernel	communications
Date: Thu, 12 Jun 2008 10:52:28 +0800
Message-ID: <1213239148.4994.70.camel@raven.themaw.net>
References: <484FA0B8.2000002@openvz.org>
	 <1213187579.4994.25.camel@raven.themaw.net> <484FC94E.1000209@openvz.org>
	 <1213190100.4994.54.camel@raven.themaw.net>
	 <18511.57661.944934.513223@harpo.it.uu.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755889AbYFLC4h@vger.kernel.org>
In-Reply-To: <18511.57661.944934.513223@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Pavel Emelyanov <xemul@openvz.org>, autofs mailing list <autofs@linux.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>


On Wed, 2008-06-11 at 16:29 +0200, Mikael Pettersson wrote:
> Ian Kent writes:
>  > What about other arches offer 32-bit within a 64-bit environment (has
>  > this been the case on sparc64 at some point)?
>  > What about the compiler padding on these?
> 
> Both ppc64 and sparc64 commonly have 32-bit userspaces.
> But 64-bit and mixed 32/64-bit userspaces are of course possible.

I believe that both these archs have the same alignment characteristics
a x86_64. Can anyone confirm that?

Ian

