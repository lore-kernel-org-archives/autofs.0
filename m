From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] autofs4: fix 32-bit userspace vs 64-bit
	kernel	communications
Date: Wed, 11 Jun 2008 16:29:17 +0200
Message-ID: <18511.57661.944934.513223@harpo.it.uu.se>
References: <484FA0B8.2000002@openvz.org>
	<1213187579.4994.25.camel@raven.themaw.net>
	<484FC94E.1000209@openvz.org>
	<1213190100.4994.54.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759383AbYFKOwV@vger.kernel.org>
In-Reply-To: <1213190100.4994.54.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Pavel Emelyanov <xemul@openvz.org>, autofs mailing list <autofs@linux.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>

Ian Kent writes:
 > What about other arches offer 32-bit within a 64-bit environment (has
 > this been the case on sparc64 at some point)?
 > What about the compiler padding on these?

Both ppc64 and sparc64 commonly have 32-bit userspaces.
But 64-bit and mixed 32/64-bit userspaces are of course possible.
