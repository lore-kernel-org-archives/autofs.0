From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sun, 03 Apr 2005 06:11:55 -0400
Message-ID: <424FC16B.4030006@poochiereds.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

raven@themaw.net wrote:

>
> Thanks for that.
>
> As you probably realise adding this to the current beta is not a good 
> idea as this needs to stabilise to go to release. Making a significant 
> change like this at this time is a bad idea. So it's 4.1.5. At least 
> your not alone, I have a couple of other patches.
>
> I'll have a look.
>
> One think I noticed is that there are places where there's a 4 
> character indent. While that's present in other places in the code I 
> prefer a straight 8 char tab for all indents. Long lines are really 
> bad as well and we should try our best to keep them short. I try to 
> keep lines to 80 chars (but often don't succeed).
>
> The usual thinking is that if the code needs to be indented to far it 
> needs to be restructured.
>
> Anyway they're my goals.

Sounds good. I didn't expect this to go into 4.1.4 -- it's too big a 
change for that, but if you could consider it for 4.1.5 that would be great.

I'll try to clean up the indenting and see if I shorten some of the 
lines (maybe I'll take a stab at running it through "indent" first). 
Most of the long lines are due to debug statements in the code, so some 
of those can probably be removed once the code stabilizes a bit.

Thanks,
Jeff
