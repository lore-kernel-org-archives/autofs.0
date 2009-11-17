From: devnull@adc.idt.com
Subject: Re: disable direct mounts
Date: Tue, 17 Nov 2009 11:43:11 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0911171031300.6283@bos.adc.idt.com>
References: <Pine.LNX.4.61.0911161206540.6189@bos.adc.idt.com>
	<4B01FA71.5070300@themaw.net>
	<Pine.LNX.4.61.0911170004530.26324@bos.adc.idt.com>
	<4B0247A3.1060702@themaw.net>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B0247A3.1060702@themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

>>>> We would like to continue to disable direct mounts. The other option is
>>>> to use a different "auto.master" w/o the auto.direct, but we would like
>>>> to avoid that.
>>>
>>> Why do you want to disable direct mounts?
>> To solve our /usr/local issue.
>>
>> Our NIS master is a Solaris box. We have an entry in auto.direct for
>> /usr/local that currently points to our Sun Solaris binaries.
>> The auto.direct is included in our auto.master
>>
>> We are considering a move to autofs 5.x as part of our OS upgrade. We
>> could create a separate auto.master.lnx that does not have auto.direct
>> in it, but we prefer not to do that.
>>
>> "Solving the /usr/local/ puzzle" as the NIS and NFS book suggests is
>> something we can do, I am just not sure if we can do that right away.
>>
>> So someway to disable auto.direct would be useful for us.
>
> One thing you could do with v5 is to include a map that has a null map
> entry for /usr/local.
>
> For example, if you are using file maps on each machine you could do
> something like this in auto.master:
>
> /some/mount	/etc/some.map
> .....
> +/etc/auto.master.null
> /-	/etc/auto.map.with.usr.local
> ....
>
> And /etc/auto.master.null would have"
> /usr/local	-null

Our maps are served via NIS. The master map include the direct map and a 
few other non-direct maps. Since we used to be a Solaris shop, the 
auto.direct /usr/local point to the location for Solaris binaries.

This was not an issue with earlier automount version 4.1.3-187 and the way 
it handled (or didn't handle direct maps)

> Or just add the null entry to the master map itself but then you need
> multiple master map instances for each arch.
I am trying to avoid having multiple master map instances for each arch. I 
could just remove the auto.direct for a newly created auto.master.lnx and 
that would solve my problem of having solaris /usr/local on my linux machines.

One issue with using /usr/local -null is that you cannot make /usr/local 
reference any other shared location served via NIS maps (e.g: With v4 of 
autofs and auto.direct is disabled, we made a softlink from /usr/local 
to /home/linuxlocal, where /home/linuxlocal was our repository). This 
solved the /usr/local puzzle for us.

Hence the request to disable direct maps.

Thanks for your time.


> Note that plus map inclusion is allowed only in file maps and is
> typically used to add local client map customisations when using a
> centralized source of map information.
> This obviously introduces possible problems with different versions of
> autofs, and possibly with different distributions. For example there was
> a recent bug in v5 where reading of the master map would stop if the
> plus included map didn't exist. I'm not sure how version 4 will behave
> with this either. However, I would expect other vendor autofs
> implementations to work OK.
