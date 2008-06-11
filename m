From: Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [PATCH] autofs4: fix 32-bit userspace vs 64-bit	kernel	communications
Date: Wed, 11 Jun 2008 17:25:07 +0400
Message-ID: <484FD233.20602@openvz.org>
References: <484FA0B8.2000002@openvz.org>	 <1213187579.4994.25.camel@raven.themaw.net>  <484FC94E.1000209@openvz.org> <1213190100.4994.54.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751952AbYFKN2Y@vger.kernel.org>
In-Reply-To: <1213190100.4994.54.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>

> Does the test_thread_flag(TIF_IA32) macro only return true for a 32-bit
> user-space process running within a 64-bit user space environment
> (perhaps I can do away with the check in the autofs daemon, perhaps it
> doesn't quite work correctly)?

Hm... If we fix it in the user level that would also be OK, I
suppose...

> Oh .. so maybe the answer to my question is yes?

It is - we check *only* for the process, that is to receive the 
packet.

> What about other arches offer 32-bit within a 64-bit environment (has
> this been the case on sparc64 at some point)?
> What about the compiler padding on these?

We have no technical ability to check this. First I wanted to
get your opinion about this particular fix for x86 machines.

As far as sparc(64) and other 32-to-64 are concerned - I can
start talking to their users/maintainers to check.

> Don't get me wrong, I'm not against fixing this, in fact I'd like to,
> but I'm concerned it may end up a bit of a can of worms.
