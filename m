From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 15:16:51 -0400 (EDT)
Message-ID: <20120427.151651.2274764174217164454.davem@davemloft.net>
References: <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
	<CA+55aFyLk-uPMVaic19YOWdvdj2pv4R+E3s7UQ6voAy6UkO_Sg@mail.gmail.com>
	<20120427.151433.1007849975903946491.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120427.151433.1007849975903946491.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: torvalds@linux-foundation.org
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 15:14:33 -0400 (EDT)

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 27 Apr 2012 11:55:12 -0700
> 
>> On Fri, Apr 27, 2012 at 11:42 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> There's no question that systemd is broken.
>> 
>> Actually, I'll take that back.
>> 
>> Yes, systemd has breakage. But it's actually automount that is the
>> truly broken piece of sh*t.
>> 
>> I think that 'automount' is even more broken. The fact that the
>> automount maintainers knew about this, and added TOTALLY BROKEN code
>> to their automount source tree, over five years ago, because the
>> authors clearly did not understand what the f*ck they were doing,
>> that's the real problem.
> 
> I respectfully disagree.

BTW, I want to clarify that my position is that userland might have
been the best place to handle this rather than the kernel.

I fully recognize that the automountd test is busted on ppc, sparc,
et al. 
