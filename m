From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Sat, 22 Nov 2003 15:14:45 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311221503030.2992-100000@raven.themaw.net>
References: <3FBDD18D.1030409@wildgate.miee.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBDD18D.1030409@wildgate.miee.ru>
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
To: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Cc: autofs mailing list <autofs@linux.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, 21 Nov 2003, Ruslan U. Zakirov wrote:

> >
> >On the other hand at work we run a cron every night on all our machines to
> >trigger an update of the maps.
> >
> If I return to my task then I have two solutions:
> 1) User space daemon that cache all needed info about workgroup. So it 
> wouldn't be
> much overhead to touch programm map on every request.

Not sure I understand this.
                                                                                           
For maps that are ghosted the map is cached and lookups are done within
the cache. On a failure the external map is consulted and the cache
updated with any new map info.
                                                                                           
That's the current implementation. So I would want fit in with this for 
program maps as well.
                                                        
> 2) Programm map do all things only when it's called without arguments. 
> Sometimes
> network can take much time to finish and I have to use periodicaly 
> update calls(~30min).

Sorry. The point here is not clear to me either.

My understanding of the current request (without timed updates) is that

1) Program map is called without arguments at startup to retrieve entire 
map.

2) A lookup miss causes reread of entire map (program map is called 
without arguments), to update cached map.

So the problem that needs to be solved is the map inconsistency when it 
changes between an entire read and a cache miss.

> 
> So I vote for runtime configuration of interval:
>     value > 0 - time period in seconds(msec,min or other)
>     value = 0 - every time
>     value < 0 - never

Any periodic update would have to be a multiple of the timer signal. This 
means that you would not get the exact update period. Do you think this 
would be a problem?


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
