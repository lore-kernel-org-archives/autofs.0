From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Tue, 06 Jan 2004 13:01:46 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFB223A.8000606@zytor.com>
References: <3FFB12AD.6010000@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFB12AD.6010000@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Mike Waychison wrote:
> 
> The attached paper was written an attempt to design an automount system
> with complete Solaris-style autofs functionality.  This includes
> browsing, direct maps and lazy mounting of multimounts.  The paper can
> also be found online at:
>                                                                               

Sorry to sound like sour grapes, but this is a requirements document,
not a proposed implementation.  Furthermore, as I have expressed before,
I think your claim that expiry should be done in the VFS to be incorrect.

I think you're on the completely wrong track, because you're starting
with the wrong problem.  The implementation needs to start with the VFS
implementation and derive from that.

Finally, throwing out the daemon is a huge step backwards.  Most of the
problems with autofs v3 (and to a lesser extent v4) are due to the
*lack* of state in userspace (the current daemon is mostly stateless);
putting additional state in userspace would be a benefit in my experience.

Pardon me for sounding harsh, but I'm seriously sick of the oft-repeated
idiocy that effectively boils down to "the daemon can die and would lose
its state, so let's put it all in the kernel."  A dead daemon is a
painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
condition.  By cramming it into the kernel, you're in fact making the
system less stable, not more, because the kernel being tainted with
faulty code is a total system malfunction; a crashed userspace daemon is
"merely" a messy cleanup.  In practice, the autofs daemon does not die
unless a careless system administrator kills it.  It is a non-problem.

	-hpa
