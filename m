From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Wed, 01 Aug 2007 15:36:39 -0400
Message-ID: <x49643z6o8o.fsf@segfault.boston.redhat.com>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185606915.8326.22.camel@raven.themaw.net>
	<1185607363.8326.25.camel@raven.themaw.net>
	<1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185807243.3210.26.camel@raven.themaw.net>
	<x49lkcv6pcx.fsf@segfault.boston.redhat.com>
	<46B0DF06.30406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B0DF06.30406@redhat.com> (Peter Staubach's message of "Wed,
	01 Aug 2007 15:29:10 -0400")
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Peter Staubach <staubach@redhat.com> writes:

> Jeff Moyer wrote:
>> Ian Kent <raven@themaw.net> writes:
>>
>>
>>> On Mon, 2007-07-30 at 15:36 +0200, Lukas Kolbe wrote:
>>>
>>>> Hi Ian, thanks for your support!
>>>>
>>>>>> Presumably the exports are distinct, in which case using a list of
>>>>>> server should allow autofs to try each one?
>>>>>>
>>>> Yep, they are - differnet homes come from different servers.
>>>>>> What about trying something like:
>>>>>>
>>>>> On second thoughts this may get only the nfs4 or only the nfs3 servers
>>>>> as well.
>>>>>
>>>> Automount now mounts fine from all servers, but still nfs3
>>>> only. /proc/mounts shows me:
>>>>
>>>> figaro:/users/xxx /homes/xxx nfs rw,nosuid,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=figaro 0 0
>>>> bongossi:/export/yyy /homes/yyy nfs rw,nosuid,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=bongossi 0 0
>>>>
>>>> where figaro only exports nfs v3, bongossi exports both v4 and v3 and we
>>>> really would like to use v4.
>>>>
>>> Actually, a multi map entry in the master map would probably work.
>>> Initially I missed this out of version 5 (by accident) so you'll need
>>> the patch on kernel.org that adds it. In fact I'd recommend applying all
>>> the 5.0.2 patches.
>>>
>>> So forget the last suggestion and patch and apply all the 5.0.2 patches
>>> on kernel.org and try a line in the master map like:
>>>
>>> /homes  multi yp auto_homes -fstype=nfs4,nosuid,grpid,nobrowse,proto=tcp,port=2049 -- \
>>> 		yp auto_homes -fstype=nfs,nosuid,grpid,nobrowse,proto=tcp,port=2049
>>>
>>> and see if that gets what you need. The nfs4 one needs to be first
>>> because the v4 servers provide both v4 and v3.
>>>
>>
>> That won't work as the cache code will not even add the second set of
>> entries for the keys:
>>
>> cache_update:
>> 	} else {
>> 		/* Already seen one of these */
>> 		if (me->age == age)
>> 			return CHE_OK;
>
> All these excellent suggestions and analysis notwithstanding,
> wouldn't it be easier to build a version of the NFS mount
> command which defaulted to NFSv4?

Precisely.  I wasn't sure if that was an option, though.  We were slow
to move to nfsv3 as the default, as I recall.

-Jeff
