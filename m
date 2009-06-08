From: Stef Bon <stef@bononline.nl>
Subject: Re: ldap and reloading
Date: Mon, 08 Jun 2009 11:09:10 +0200
Message-ID: <4A2CD536.8070907@bononline.nl>
References: <4A2B7C7B.7060909@bononline.nl> <4A2C70C2.6060505@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2C70C2.6060505@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> Stef Bon wrote:
>   
>> Hello,
>>
>> when using static file maps, or even executable maps, when the map 
>> changes, you'll have to reload the daemon to make these changes effective.
>>
>> How does this work when all the data is in ldap? Does the automounter 
>> still creates a sort of snapshot of the map in memory, and to reread the 
>> data provided by ldap, a reload is neccesary? ldap is well know for that 
>> this is not needed. For example with postfix, it can use static maps, 
>> and when something changes, it has te be restarted. But when the lookup 
>> data (for local users for example) is in ldap, this is not neccesary.
>>     
>
> That's not quite right.
>
> If you use the "browse" option then the entire map must be read in at
> start. If not then autofs remembers entries that it has seen and
> attempts to check their currency at lookup.
>
> Each lookup should check if the entry is still up to date and attempts
> to work out if the map has changed (although it's not quite as simple as
> that). If we think the map has changed a re-load should be triggered
> internally. Following the (or any) re-load there is a cleanup which is
> probably why it looks like map changes aren't seen. Any changes in
> multi-mount entries cannot be seen until after they have expired away,
> because of the need to maintain the context of the entry over the
> duration of the mount.
>
> Direct maps don't quite do this properly, partly because of the way they
> work and partly because of an issue I haven't addressed yet.
>
> Clearly, with program maps, we need to rely on the re-load to a large
> extent but a best effort is made to work out if the entry is stale,
> however, we just don't have anything really to use to establish this, so
>  a re-load is needed to clean them up.
>   

Ok Ian,

maybe you're right. You probably are, I cannot discuss this with you, 
you're the expert.

You say that it may look like map changes aren't seen. How, as developer 
of a construction making use of autofs,
can I see/check it's reloaded. Are there any indications, or triggers 
which always lead to this internal reloading?
BTW I also use reloading when a map/mountpoint is added or removed, so 
not only when a map changes.

I know multimount entries are difficult, and are handled as one.

But how about ldap? I assume you're talking about how maps are handled 
here in general, but is this different/the same with ldap??

Stef Bon
