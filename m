From: Ian Kent <raven@themaw.net>
Subject: Re: Executable maps
Date: Tue, 06 Jul 2010 09:19:17 +0800
Message-ID: <1278379157.3070.12.camel@localhost>
References: <AANLkTin8PTdQLShcrAk_cT21pFfwcuatXvMNMQSgYmO3@mail.gmail.com>
	<1276490691.9943.68.camel@localhost>  <4C2E6209.5030506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=+dltU7l3e6/rjU2mKdyIwZ2ByPQ=;
	b=BuY3WPEeHUrtWHSPyJmXdZJxojDrmAsem5ijE+2SchJbMQ9+lQpuWXzpAuf0UHqbIQNagrL3/F+cazHpFYCXyljpGuef1f2CsKxacfcw/12GjaPW70YRjHSCrDTbwVPKzKkpfIef2SivbjI0+NRvMZPGj3ObnxuRgNj7kSr9euo=
In-Reply-To: <4C2E6209.5030506@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

On Fri, 2010-07-02 at 15:02 -0700, H. Peter Anvin wrote:
> On 06/13/2010 09:44 PM, Ian Kent wrote:
> > 
> > Don't think that could work.
> > There's no way for a program map to enumerate the entire map at initial
> > startup and I don't want to add something that allows that because
> > program maps are dynamic and that introduces all sorts of difficulties
> > for the handling of direct mounts. And there is no way to use a program
> > map for a direct mount that has not been mounted (at startup).
> > 
> 
> Sorry for a *way late* reply.
> 
> There isn't a reason why a protocol for a program map to enumerate
> itself couldn't be constructed, probably invoking the program map
> without an argument, and receiving an enumeration on stdout; either
> null- or LF-separated.
> 
> Obviously not all program maps will be capable of being enumerated, but
> that's true for any map set.

I think I more or less nacked that idea a while back but it is the
obvious and sensible way to do it.

Of course there is the bonus that any program map that doesn't check the
passed in key, assuming it's non-null, will likely SEGV, which would
make it all worth while.

Hehe, but seriously automount should be able to cope with crashing
program maps. I'm fairly sure I've tested that on occasion.

So, sounds good, I'll give it a go and we'll see what happens.
Ian
