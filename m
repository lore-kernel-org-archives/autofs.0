From: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Fri, 21 Nov 2003 11:49:17 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBDD18D.1030409@wildgate.miee.ru>
References: <Pine.LNX.4.33.0311211453250.6131-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311211453250.6131-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

Ian Kent wrote:

>On Thu, 20 Nov 2003, H. Peter Anvin wrote:
>
>  
>
>>Ian Kent wrote:
>>    
>>
>>>To fit in with the existing framework I would need to require the entire
>>>map returned for a NULL key.
>>>
>>>      
>>>
>>That's correct.
>>
>>    
>>
>>>>And of course autofs needs to deal with the consequences of the map
>>>>changing underneath it.
>>>>        
>>>>
>>>I normally reread the map and try again on lookup failure. There is the
>>>HUP signal to do a manual map reread.
>>>
>>>      
>>>
>>A better option is probably to update periodically.  You still need to
>>be able to handle query of a mount point that you don't know about
>>(might have appeared anew) or a mount point you thought exist not being
>>found.
>>    
>>
>
>The above works that way without the update.
>
>I'm not sure that a periodic update really gets us much. Since in most
>sites maps change infrequently.
>
Runtime configureable? I think somebody can be interested in 
'timeinterval updates',
some in 'just before request' or 'never'(could be done in map itself).

>
>On the other hand at work we run a cron every night on all our machines to
>trigger an update of the maps.
>
If I return to my task then I have two solutions:
1) User space daemon that cache all needed info about workgroup. So it 
wouldn't be
much overhead to touch programm map on every request.
2) Programm map do all things only when it's called without arguments. 
Sometimes
network can take much time to finish and I have to use periodicaly 
update calls(~30min).

So I vote for runtime configuration of interval:
    value > 0 - time period in seconds(msec,min or other)
    value = 0 - every time
    value < 0 - never

I think it's normal to configure it due userspace daemon startup.

>
>So I'm on the fence here?
>
>  
>
             Best regards. Ruslan.
