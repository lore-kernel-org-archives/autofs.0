From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: fix 32-bit userspace vs
	64-bit	kernel	communications
Date: Wed, 11 Jun 2008 21:40:29 +0800
Message-ID: <1213191629.4994.61.camel@raven.themaw.net>
References: <484FA0B8.2000002@openvz.org>
	 <1213187579.4994.25.camel@raven.themaw.net>  <484FC94E.1000209@openvz.org>
	 <1213190100.4994.54.camel@raven.themaw.net>  <484FD233.20602@openvz.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753574AbYFKNo1@vger.kernel.org>
In-Reply-To: <484FD233.20602@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Emelyanov <xemul@openvz.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>


On Wed, 2008-06-11 at 17:25 +0400, Pavel Emelyanov wrote:
> > Does the test_thread_flag(TIF_IA32) macro only return true for a 32-bit
> > user-space process running within a 64-bit user space environment
> > (perhaps I can do away with the check in the autofs daemon, perhaps it
> > doesn't quite work correctly)?
> 
> Hm... If we fix it in the user level that would also be OK, I
> suppose...
> 
> > Oh .. so maybe the answer to my question is yes?
> 
> It is - we check *only* for the process, that is to receive the 
> packet.

Right, since the send is done in user context.

> 
> > What about other arches offer 32-bit within a 64-bit environment (has
> > this been the case on sparc64 at some point)?
> > What about the compiler padding on these?
> 
> We have no technical ability to check this. First I wanted to
> get your opinion about this particular fix for x86 machines.
> 
> As far as sparc(64) and other 32-to-64 are concerned - I can
> start talking to their users/maintainers to check.

I investigated only x86_64 and sparc64 but that was a quite a while ago
now. My sparc machine doesn't even have a Linux install atm.

If we can find a general and consistent solution I'm happy to remove the
check from the daemon and cope with the bit of pain it might cause.

> 
> > Don't get me wrong, I'm not against fixing this, in fact I'd like to,
> > but I'm concerned it may end up a bit of a can of worms.
