From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Fri, 07 May 2004 11:45:44 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409BD958.2080202@sedona.intel.com>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
	<Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
	<Pine.LNX.4.53.0405062024330.6910@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0405062024330.6910@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Jim Carter wrote:

>On Fri, 7 May 2004, Ian Kent wrote:
>  
>
>>This changed in 4.1.0 because, to do browsable directoties the entire map
>>must be known in advance...
>>
>>So guys, the options here are:
>>
>>1) leave as is and use HUP signal to refresh maps.
>>
I don't think this solution can work.  It puts to much burden on the 
clients.  It would be impossible to get consistency across a large 
number of clients.

>>2) reintroduce the "discover at mount time" behaviour (possibly
>>   with a periodic resync).
>>
Does this mean verify the map entry once again at the time of mount?  If 
so, that seems like it might work.

>>3) add a periodic map refresh whose frequency is perhaps configurable.
>>    
>>
I think a periodic map refresh +  verify the map entry at mount time 
could resolve the issue.

map refreshes could be done on a random schedule within a time.  That 
would keep the load down on the map servers.

The random map refresh could keep the ghosting data fairly valid while 
mounts would be 100% consistent.

>Another idea: if the map row is in the cache AND the mount succeeds,
>fine, leave it in the cache.  If either one fails, the problem
>might be with the map -- we've cached a row that was removed (and so was
>its server), or we've failed to cache a newly added row.  So flush the
>cache (for that map) and enumerate the map again.  But if a second mount
>attempt fails, believe in the failure.  I think it likely that you can
>get away with reading (or trying and failing to read) just that one row,
>with random access data sources.
>  
>
What happens if you change the mount point but the old remains?  autofs 
wouldn't notice the change in your scenario and we would get the wrong 
behaviour.

It seems like we need to verify the cached entry at every mount.

>The only fly in the ointment is, if the mount options change, you won't
>know.  I'd say, include a time to live (with a configurable timeout), so
>if a row is needed that hasn't been read authoritatively in (let's say) one
>hour, you should re-read just that one row, for random-access data sources
>
I just don't think that works well enough.  If a map changes, autofs 
needs to notice.  Waiting an hour or even 5 minutes isn't the right 
solution. 

>The current HUP behavior needs to be retained if the sysop wants to update
>an entire map immediately, but as one of the writers said, HUP is not very
>scalable.  I have an automated script for doing this kind of thing, but if
>there were 1000 machines it would still be a burden.
>  
>
Think of even larger deployments.  HUP'ing isnt a just a burden, it is 
impractical.

Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
