From: raven@themaw.net
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 23:24:42 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504202319550.9260@donald.themaw.net>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net> 
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.58.0504200903300.7460@wombat.indigo.net.au>
	<1113959940.5879.5.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113959940.5879.5.camel@tleilax.poochiereds.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jeff Layton wrote:

> On Wed, 2005-04-20 at 09:12 +0800, Ian Kent wrote:
>> I'm not saying the original code works.
>>
>> I don't think it will work.
>> Can you test this or should I setup an environment to test it?
>
> Hmmm, I don't have a multi-homed host to test this on, but it looks to
> me like it should do the right thing. I'll see if I can find one that I
> can test on, but if you have a multi-homed host handy it would save me
> some trouble.

I've tested this and it certainly seems to work.

But another thing came to mind.

We've had complaints about ports and protocols being blocked for the 
rpc_ping function.

Any thoughts on how to work around that?
The other thing that plagues us is that when we open TCP sockets they hang 
around which causes port exaustion.
Thoughts on that as well?

Ian
