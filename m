From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: fix 32-bit userspace vs 64-bit
	kernel	communications
Date: Wed, 11 Jun 2008 21:08:33 +0800
Message-ID: <1213189713.4994.47.camel@raven.themaw.net>
References: <484FA0B8.2000002@openvz.org>
	 <1213187579.4994.25.camel@raven.themaw.net>  <484FC94E.1000209@openvz.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755390AbYFKNM2@vger.kernel.org>
In-Reply-To: <484FC94E.1000209@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Emelyanov <xemul@openvz.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>


On Wed, 2008-06-11 at 16:47 +0400, Pavel Emelyanov wrote:
> Ian Kent wrote:
> > On Wed, 2008-06-11 at 13:54 +0400, Pavel Emelyanov wrote:
> >> From: Konstantin Khlebnikov <khlebnikov@openvz.org>
> >>
> >> The struct autofs_v5_packet has only one difference between
> >> 32-bit and 64-bit versions - on 64-bit gcc aligns its size and
> >> it is 4 bytes larger that it is on 32-bit kernel. This confuses
> >> 32-bit user-space daemon, when talking to 64-bit kernel.
> > 
> > No, I don't think that's quite right.
> > 
> > As far as I know this issue arises when a user space program, compiled
> > as a 32-bit application is executed within 64-bit user space.
> 
> What program do mean here? The problem arises right on the kernel-daemon
> boundary - the latter refuses to accept the message with larger length.
> No other software required.

Any program that is compiled to use the autofs4 module with the version
5 communication protocol. As far as I know only autofs version 5 uses
this at the moment.

This isn't a problem for a 32-bit daemon running within a 32-bit user
space environment or a 64-bit daemon running within a 64-bit user space
environment.

> 
> >> This is very critical for containerized setups, when containers
> >> with <different>-bit tolls are used.
> > 
> > Have you tested different situations with this change?
> > Will this affect the existing check and adjustment the version 5
> > automount daemon does now?
> 
> 64-bit daemons *still* work OK and 32-bit *start* to after this fix :)

My point is that I think this change may adversely affect existing
compiled user space applications and I want know if I'm right.

I acknowledge that the struct padding is a problem and I am aware of it
but it is potentially a big problem to just change the kernel structure
size.

Does the test_thread_flag(TIF_IA32) macro only return true for a 32-bit
user-space process running within a 64-bit user space environment
(perhaps I can do away with the check in the autofs daemon, perhaps it
doesn't quite work correctly)?

> 
> >> Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> >> Acked-by: Pavel Emelyanov <xemul@openvz.org>
> >>
> >> ---
> >>
> >> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> >> index 1e4a539..9855b6e 100644
> >> --- a/fs/autofs4/waitq.c
> >> +++ b/fs/autofs4/waitq.c
> >> @@ -132,6 +132,14 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
> >>  		struct autofs_v5_packet *packet = &pkt.v5_pkt.v5_packet;
> >>  
> >>  		pktsz = sizeof(*packet);
> >> +#if defined(CONFIG_X86_64) && defined(CONFIG_IA32_EMULATION)
> >> +		/*
> >> +		 * On x86_64 autofs_v5_packet struct is padded with 4 bytes
> >> +		 * which breaks 32-bit autofs daemon.
> >> +		 */
> >> +		if (test_thread_flag(TIF_IA32))
> >> +			pktsz -= 4;
> >> +#endif
> >>  
> >>  		packet->wait_queue_token = wq->wait_queue_token;
> >>  		packet->len = wq->len;
> >>
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
