From: raven@themaw.net
Subject: Re: Is the "program" format correct ?
Date: Sun, 15 Aug 2004 10:15:53 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408150957290.1776@donald.themaw.net>
References: <1411896967@web.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1411896967@web.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Neuper <ANeuper@web.de>
Cc: autofs@linux.kernel.org

On Sat, 14 Aug 2004, Andreas Neuper wrote:

> Thank you Takashi,
> 
> this confirms my oppinion:  The format for program maps differs!
> Usual and documented format is:
>         key [-options] location

Not really.

> 
> These maps swallow the key and accept only nfs location codes
> where the hostname seems to be overwritten with the key. !?!

It receives the key as a parameter.

Lookups always "lookup a key". The program map returns the map entry for 
the given key only. All the lookup modules work this way.

The confusion here is because you are seeing what the lookup module needs 
to complete its operation not what you expect a map to look like. It 
already knows what key it's looking for and doesn't want or need the key 
to be returned.

> 
> It seems strange to me. just try to use it for the floppy. I get 
> errors on hostname resolution! (even when omitting the key) 

In what way are you using it with your floppy?

> 
> Is there a working release?

Program maps are something that are used by people like yourself. The 
auto.net is an example only.

Ian
