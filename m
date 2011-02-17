From: Ian Kent <raven@themaw.net>
Subject: Re: Wrong network
Date: Thu, 17 Feb 2011 09:58:08 +0800
Message-ID: <1297907888.2893.21.camel@perseus>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
	<1297649183.2822.6.camel@perseus>
	<alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
	<1297739162.13007.7.camel@perseus>
	<alpine.LRH.0.9999.1102150702520.15610@helios.vgersoft.com>
	<1297772151.13007.21.camel@perseus>
	<alpine.LRH.0.9999.1102150729250.16053@helios.vgersoft.com>
	<1297774988.13007.43.camel@perseus>
	<alpine.LRH.0.9999.1102161657250.24619@helios.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=sbtz0cxjzJizVh2pDQwtBuedBV4=;
	b=HFpmhc5iyb+XVZ4jusK/4A/T66/v7uEzeFU2WSifGW/zJ/qTQB6I5guSLeR1VMWUcUa2yim6Jz4MDAWqrDLRjvIWOS+1kPvDWtPkwl/M0PiWRqdwQ84Hh47ZanOVHKmmEtr0QZV3Qo9SkAWBfrVNndZSX2IQ9uvRxvjequGY9vA=
In-Reply-To: <alpine.LRH.0.9999.1102161657250.24619@helios.vgersoft.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Wed, 2011-02-16 at 17:00 -0500, Steve Thompson wrote:
> On Tue, 15 Feb 2011, Ian Kent wrote:
> 
> > As far as the hang you have seen, I don't know why that's happening, the
> > patches were added between el5_5.4 and el5_5.6 have been around for
> > quite a while, upstream and in Fedora and tested by more than one
> > customer, so I didn't expect to hear of a problem.
> 
> While thinking about this I noticed that the automount hangs all occurred 
> on systems that had SElinux set to enforcing mode; there were no hangs on 
> systems with SElinux either disabled or in permissive mode. So for now I 
> have disabled SElinux on most of the systems on which a hang was observed. 
> So far, so good: no more hangs. But it's only been a couple of days, so I 
> will keep an eye on it.

Right, but to help me a gdb backtrace (the "thr a a bt") of a hung
automount process would be useful.

Also, an avc log from a system with selinux in permissive mode is needed
to find out what is happening. I don't think the changes to the package
caused this breakage and QA testing is always done with selinux in
enforcing mode. So maybe there has been an selinux policy change too.

Ian
