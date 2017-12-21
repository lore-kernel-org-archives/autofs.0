From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Thu, 21 Dec 2017 19:36:50 +0800
Message-ID: <6c21c2c6-633b-fc79-74b0-39459f184595@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
 <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
 <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
 <87po78khtj.fsf@notabene.neil.brown.name>
 <2e032b27-6776-9177-ae15-42f016a2979c@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Y3WLbG/g2azVnoWfpkLxdsmMzmaLI
        pJ/Tu+KNcgOn6g=; b=O8y/JneCj+aJQttWQHrEActAAKofZG+Ps1XNpXziFuG3+
        WChoO0xm7TjETw1zw//ZwbiEGzWmbqIR+E2/M8l0VLNpnzWEqGDVnOS3pWq4d+QA
        VGqiEAz6MUcofxXeRZphdAMb/YtdbSuf3gpkQxjl4+x+gU0DIvqDbfgM7md17cut
        cvbdV+dBVTELe5VLQIPNH0lZPKVtCfWDczQrlyenF1J/3MFrr4oOQhxYB01oLLHw
        jxvBEe6kVYXM+H+vnR+swKUPgJDgQ83Nf2I2wmv7BG5dHddZtwaehHfUhdGtyMyv
        JHUwjvuRHYCvAtH2XMl4+3BYWfHM51s4iX36b8TxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y3WLbG
        /g2azVnoWfpkLxdsmMzmaLIpJ/Tu+KNcgOn6g=; b=nsJx9TJEhutM7mFZSmNv9P
        r40M4/clQeCx7akYsJNjhOtWUJ1zvuYsbEHN4AlYSSlaq6G94CfAvwu4PvELIimR
        ejHvEt0ayI9cJkeVzAQ4/w3lcL8zoPPdhnlKdE1ef5VT2JojumMqoNK47KWrqd0Z
        Qw6DwGkpWPBl652fnb0Micl4egr6qLZ15z2USFXDViyKS22KbMzymPZAM8t/B1Us
        07g0MgGmtCJc4bDeLwczB7hxvYr8RzWyuDC+Iq+XrKKz9pvcmUUOhh0LRK3qSKUo
        VsIaQgShYYGZPvZ49IYSxY2AclRIgJ2/9Ehaob1XWhtpit/A/lbQY7y5kP3ABQKg
        ==
In-Reply-To: <2e032b27-6776-9177-ae15-42f016a2979c@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/12/17 19:06, Ian Kent wrote:
> On 21/12/17 09:09, NeilBrown wrote:
>> On Wed, Dec 20 2017, Ian Kent wrote:
>>
>>> On 20/12/17 13:52, Ian Kent wrote:
>>>> On 20/12/17 11:29, NeilBrown wrote:
>>>>>
>>>>> Hi Ian,
>>>>>  I've been looking at:
>>>>>
>>>>>> - add configuration option to use fqdn in mounts.
>>>>>
>>>>> (commit 9aeef772604) because using this new option causes a regression.
>>>>> If you are using the "replicated server" functionality, then
>>>>>   use_hostname_for_mounts = yes
>>>>> completely disables it.
>>>>
>>>> Yes, that's not quite right.
>>>>
>>>> It disables the probe and proximity check for each distinct host
>>>> name used.
>>>>
>>>> Each of the entries in the list of hosts should still be
>>>> attempted and given that NFS ping is also now used in the NFS
>>>> mount module what's lost is the preferred ordering of the hosts
>>>> list.
>>>>
>>>>>
>>>>> This is caused by:
>>>>>
>>>>> diff --git a/modules/replicated.c b/modules/replicated.c
>>>>> index 32860d5fe245..8437f5f3d5b2 100644
>>>>> --- a/modules/replicated.c
>>>>> +++ b/modules/replicated.c
>>>>> @@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host **list,
>>>>>         if (!*list)
>>>>>                 return 0;
>>>>>  
>>>>> +       /* If we're using the host name then there's no point probing
>>>>> +        * avialability and respose time.
>>>>> +        */
>>>>> +       if (defaults_use_hostname_for_mounts())
>>>>> +               return 1;
>>>>> +
>>>>>         /* Use closest hosts to choose NFS version */
>>>>>
>>>>> My question is: why what this particular change made.
>>>>
>>>> It was a while ago but there were complains about using the IP
>>>> address for mounts. It was requested to provide a way to prevent
>>>> that and force the use of the host name in mounts.
>>>>
>>>>> Why can't prune_host_list() be allowed to do it's thing
>>>>> when use_hostname_for_mounts is set.
>>>>
>>>> We could if each host name resolved to a single IP address.
>>>>
>>>> I'd need to check that use_hostname_for_mounts doesn't get
>>>> in the road but the host struct should have ->rr set to true
>>>> if it has multiple addresses so changing it to work the way
>>>> your recommending shouldn't be hard. I think there's a couple
>>>> of places that would need to be checked.
>>>>
>>>> If the host does resolve to multiple addresses the situation
>>>> is different. There's no way to stop the actual mount from
>>>> trying an IP address that's not responding and proximity
>>>> doesn't make sense either again because every time a lookup
>>>> is done on the host name (eg. at mount time) the next address
>>>> in its list will be returned which can and usually is different
>>>> from what would have been checked.
>>>>
>>>>> I understand that it would be pointless choosing between
>>>>> the different interfaces of a multi-homed host, but there is still value
>>>>> in choosing between multiple distinct hosts.
>>>>>
>>>>> What, if anything, might go wrong if I simply reverse this chunk of the
>>>>> patch?
>>>>
>>>> You'll get IP addresses in the logs in certain cases but that
>>>> should be all.
>>>>
>>>> It would probably be better to ensure that the checks are done
>>>> if the host name resolves to a single IP address.
>>>
>>> I think that should be "if the host names in the list each resolve
>>> to a single IP address", otherwise the round robin behavior would
>>> probably still get in the road.
>>
>> I cannot see why the round-robin behavior would get in the road.
>> It might be pointless to probe each IP address on a multi-homed host if
>> we are just going to mount by host name, but I don't see how it hurts.
> 
> I was wondering whether I had considered the configuration option
> when setting ->rr of the host struct. I haven't so it should be set
> if the name resolves to multiple addresses.
> 
>>
>> So this is what I'm thinking.  Some simple testing suggests that
>> it does the right things.
>>
>> If a host has addresses with different proximity they will still be
>> probed separately, but this won't affect the final choice.
> 
> Well no but ...
> 
> The prune_host_list() function is meant to put the list of hosts
> in proximity order with hosts ordered by response time within proximity.
> 
> It's also meant to remove hosts that don't respond from the list so that
> mount attempts are not made to them (hence the need to use address).
> 
> When use_hostname_for_mounts is set there will be multiple host structures
> with the same host name and each would be probed by name so all would be
> considered.
> 
> But the probe is not tied to IP address so each probe failure would remove
> one of the structures from the list resulting in a reduced list of hosts
> to try to mount.
> 
> So it's then quite possible a mount attempt will be made to a host that
> isn't responding with an associated long delay, around 3 minutes IIRC.
> That's not good for the interactive nature of autofs.
> 
> It's also possible that a number of the hosts in the list are not
> responding causing a portion of them to be removed making the list
> smaller and the likelihood that the mount will fail when one of the
> hosts actually would succeed but isn't tried because of the reduced
> list size. Worse, is the long delay for each host that's not responding.
> 
> What I was trying to get at in my previous reply is that when
> use_hostname_for_mounts is set and the hosts haven't been probed then
> an nfs_ping should be done before attempting the mount to avoid the long
> delay.
> 
> Before calling the prune function all the potential hosts are present on
> the list so I think pruning the list isn't going to be of any benefit and
> will cause problems of the type I described.
> 
> You have certainly identified a problem and I'd like to fix it but what is
> the problem your seeing and trying to resolve?

Oh wait, sorry, I didn't read far enough.

You concern is hosts with weighting ..... I'll need to look at that
and the patch you've offered, ;)

> 
> Maybe we are approaching this the wrong way.
> 
>>
>> Thanks,
>> NeilBrown
>>
>> --------8<---------------
>> Subject: use_hostname_for_mounts shouldn't prevent selection among replica
>>
>> If several replicas have been specified for a mount point, and
>> use_hostname_for_mount is set to "yes", the selection between
>> these replicas is currently disabled and the last in the list is always
>> chosen.
>>
>> There is little point selecting between different interfaces on the one
>> host in this case, but it is still worth selecting between different
>> hosts, particularly if different weights have been specified.

I don't understand your thinking wrt. interfaces.

I don't think the possibility a target machine offers the file system on
different interfaces can be considered as the only possibility in this
scenario.

The replicated server machines might offer the same file system
on multiple interfaces but they could easily be distinct hosts possibly
even in different geographic locations.

>>
>> This patch restores the "prune_host_list()" functionality when
>> use_hostname_for_mount is set, and modifies it slightly so that once
>> an IP address with a given proximity has been successfully probed,
>> other IP address for the same host(weight):/path and proximity are ignored.
>>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>>
>> diff --git a/modules/replicated.c b/modules/replicated.c
>> index 3ac4c70f4062..16cf873513ff 100644
>> --- a/modules/replicated.c
>> +++ b/modules/replicated.c
>> @@ -714,7 +714,7 @@ done:
>>  int prune_host_list(unsigned logopt, struct host **list,
>>  		    unsigned int vers, int port)
>>  {
>> -	struct host *this, *last, *first;
>> +	struct host *this, *last, *first, *prev;
>>  	struct host *new = NULL;
>>  	unsigned int proximity, selected_version = 0;
>>  	unsigned int v2_tcp_count, v3_tcp_count, v4_tcp_count;
>> @@ -726,12 +726,6 @@ int prune_host_list(unsigned logopt, struct host **list,
>>  	if (!*list)
>>  		return 0;
>>  
>> -	/* If we're using the host name then there's no point probing
>> -	 * avialability and respose time.
>> -	 */
>> -	if (defaults_use_hostname_for_mounts())
>> -		return 1;
>> -
>>  	/* Use closest hosts to choose NFS version */
>>  
>>  	first = *list;
>> @@ -877,11 +871,18 @@ int prune_host_list(unsigned logopt, struct host **list,
>>  
>>  	first = last;
>>  	this = first;
>> +	prev = NULL;
>>  	while (this) {
>>  		struct host *next = this->next;
>>  		if (!this->name) {
>>  			remove_host(list, this);
>>  			add_host(&new, this);
>> +		} else if (defaults_use_hostname_for_mounts() && prev &&
>> +			   prev->proximity == this->proximity &&
>> +			   strcmp(prev->name, this->name) == 0 &&
>> +			   strcmp(prev->path, this->path) == 0 &&
>> +			   prev->weight == this->weight) {
>> +			/* No need to probe same host(weight):/path again */

Yeah but when the mount is actually tried you'll most likely get a different
IP address which could easily be a different host entirely.

Just how file systems are replicated is (I believe) undefined so we have no
way of knowing if the host IP used will belong to the same host as the one
tried above.

Certainly, correct me if I'm wrong, ;)

>>  		} else {
>>  			status = get_supported_ver_and_cost(logopt, this,
>>  						selected_version, port);
>> @@ -889,6 +890,7 @@ int prune_host_list(unsigned logopt, struct host **list,
>>  				this->version = selected_version;
>>  				remove_host(list, this);
>>  				add_host(&new, this);
>> +				prev = this;
>>  			}
>>  		}
>>  		this = next;
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
