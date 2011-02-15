From: Ian Kent <raven@themaw.net>
Subject: Re: Wrong network
Date: Tue, 15 Feb 2011 21:03:08 +0800
Message-ID: <1297774988.13007.43.camel@perseus>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
	<1297649183.2822.6.camel@perseus>
	<alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
	<1297739162.13007.7.camel@perseus>
	<alpine.LRH.0.9999.1102150702520.15610@helios.vgersoft.com>
	<1297772151.13007.21.camel@perseus>
	<alpine.LRH.0.9999.1102150729250.16053@helios.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=l6KlRqUAv30qrPOrRErdAY6l4co=;
	b=gIrkTXdcFy8KVTkzOKT/X91eq66iIjtcRrtdXLdCsnD+Iy+e5ZhxuZhHBkjE4hwo303esKGVG9ba2z+Nbw86kP33gsoY7LylaHxUAnIuZ7Vys+YI/SaJREh50hS+ZKJDNtOZ2TtvNkycfKEERmbebiVvvTVJESeoCcPMCboQe5U=
In-Reply-To: <alpine.LRH.0.9999.1102150729250.16053@helios.vgersoft.com>
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

On Tue, 2011-02-15 at 07:40 -0500, Steve Thompson wrote:
> On Tue, 15 Feb 2011, Ian Kent wrote:
> 
> > Fair call, but it comes over as though you don't want to contribute at
> > all, which isn't good.
> 
> That's not the impression I meant to give at all. I _am_ building some new 
> test machines (about ten of them), and I _will_ do some testing. My test 
> machines will all be 32-bit, though, as there is no spare 64-bit hardware. 
> I just can't go testing on a production network; what with this and the 
> hang problem I described in a separate post, I'm close enough to being 
> lynched as it is. I have written my own applications of a similar level of 
> complexity to autofs, and I certainly appreciate that it's not easy, and I 
> definitely appreciate the job that you're doing.

We're good then.

I appreciate you are in a difficult spot, but spare a thought for the
pressures I may have that tent to make me a bit short from time to
time, ;)

As far as the hang you have seen, I don't know why that's happening, the
patches were added between el5_5.4 and el5_5.6 have been around for
quite a while, upstream and in Fedora and tested by more than one
customer, so I didn't expect to hear of a problem. Like I said, send me
a gdb backtrace so that I can see where it's happening.

Just to confirm, this is autofs-5.0.1-0.rc2.143.el5_5.6, and what kernel
revision, I guess the same as RHEL-5.5, which should be fine.

I can post the previous RedHat package to people.redhat.com so you can
revert back while we work on this, if that will kelp.

Ian
