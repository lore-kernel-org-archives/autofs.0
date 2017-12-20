From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Wed, 20 Dec 2017 14:50:59 +0800
Message-ID: <5f98a504-90f1-0dd5-f536-38b24de2912e@themaw.net>
References: <1465960537.3164.1.camel@themaw.net>
 <876092krew.fsf@notabene.neil.brown.name>
 <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net>
 <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=MIF4AI+Lc5M9bqF8OlE5jfUgNrUOL
        jT4BP1fTlLFH5g=; b=hvnsxKwA6dH7zXw0YF6DCbpW2LYVCjNVmmL9AWVle+2OP
        TH0wI1dvdub0V7jKV0hpBVJTeJYsHZXdgLAc5Xl2om5Mcx+NJjyV8tdmufdbMpZ3
        ZxnvkCsXaIUYmRO2s6m9a9OGTjotzU0Yi1UPeaXRYcq5dphXEuDNQX8uZxymEL+5
        pTXAGrLZszhLveAVrBgCBdPpMQSfZe48k5HnhlwrslvcyBNkQXXywrL0ffk9jFJZ
        99rfmkzsbQ9uzw3TleAz2USbgK6k9qioJkEqJ42/qVgAiM2/Bwdqox9OFIP7Ba1W
        LyScHF1XKWi8u1/xbVrNxc1I8ljA0AxpiPj5QmCOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MIF4AI
        +Lc5M9bqF8OlE5jfUgNrUOLjT4BP1fTlLFH5g=; b=Kbx4XfhIiNEHdskRGSHzFk
        4eDoyrW5X2KMOO34FD5l0dBAqcHjQq0u7pzyvz4G7d0bEWlPrPf3T90YaO1ZbGx3
        ZHfNG7KyHR+1qhHvfQUemNcxrMwB5hOmuOjNJPXE/raOlBSDlqMtCorWhXtrXGPO
        Z1iIPtarhxNo0/aAn1IpnS+VbpypSg0zwN20IRQc2uCht1Kgr7oqMVSxDtnCo2WO
        ptlMcsmPZSzqbuqASsQxs2OkEuuGq6tfwkabNXeRPv2IvCPiXx1Zb+CawjPvhBAz
        7CaDwzsLOCmVwpbAhQlPJ1tDArrxrlLfJuEQltvEeaFhv+T4kRdJkYdcrg+0cAVA
        ==
In-Reply-To: <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/12/17 14:10, Ian Kent wrote:
> On 20/12/17 13:52, Ian Kent wrote:
>> On 20/12/17 11:29, NeilBrown wrote:
>>>
>>> Hi Ian,
>>>  I've been looking at:
>>>
>>>> - add configuration option to use fqdn in mounts.
>>>
>>> (commit 9aeef772604) because using this new option causes a regression.
>>> If you are using the "replicated server" functionality, then
>>>   use_hostname_for_mounts = yes
>>> completely disables it.
>>
>> Yes, that's not quite right.
>>
>> It disables the probe and proximity check for each distinct host
>> name used.
>>
>> Each of the entries in the list of hosts should still be
>> attempted and given that NFS ping is also now used in the NFS
>> mount module what's lost is the preferred ordering of the hosts
>> list.
>>
>>>
>>> This is caused by:
>>>
>>> diff --git a/modules/replicated.c b/modules/replicated.c
>>> index 32860d5fe245..8437f5f3d5b2 100644
>>> --- a/modules/replicated.c
>>> +++ b/modules/replicated.c
>>> @@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host **list,
>>>         if (!*list)
>>>                 return 0;
>>>  
>>> +       /* If we're using the host name then there's no point probing
>>> +        * avialability and respose time.
>>> +        */
>>> +       if (defaults_use_hostname_for_mounts())
>>> +               return 1;
>>> +
>>>         /* Use closest hosts to choose NFS version */
>>>
>>> My question is: why what this particular change made.
>>
>> It was a while ago but there were complains about using the IP
>> address for mounts. It was requested to provide a way to prevent
>> that and force the use of the host name in mounts.
>>
>>> Why can't prune_host_list() be allowed to do it's thing
>>> when use_hostname_for_mounts is set.
>>
>> We could if each host name resolved to a single IP address.
>>
>> I'd need to check that use_hostname_for_mounts doesn't get
>> in the road but the host struct should have ->rr set to true
>> if it has multiple addresses so changing it to work the way
>> your recommending shouldn't be hard. I think there's a couple
>> of places that would need to be checked.
>>
>> If the host does resolve to multiple addresses the situation
>> is different. There's no way to stop the actual mount from
>> trying an IP address that's not responding and proximity
>> doesn't make sense either again because every time a lookup
>> is done on the host name (eg. at mount time) the next address
>> in its list will be returned which can and usually is different
>> from what would have been checked.
>>
>>> I understand that it would be pointless choosing between
>>> the different interfaces of a multi-homed host, but there is still value
>>> in choosing between multiple distinct hosts.
>>>
>>> What, if anything, might go wrong if I simply reverse this chunk of the
>>> patch?
>>
>> You'll get IP addresses in the logs in certain cases but that
>> should be all.
>>
>> It would probably be better to ensure that the checks are done
>> if the host name resolves to a single IP address.
> 
> I think that should be "if the host names in the list each resolve
> to a single IP address", otherwise the round robin behavior would
> probably still get in the road.

I think maybe this is sufficient ....

autofs-5.1.4 - use proximity check if all host names are simple

From: Ian Kent <raven@themaw.net>

Currently if the configuration option use_hostname_for_mounts is
set then the proximity calcualtion is not done for the list of
hosts.

But if each host name in the host list resolves to a single IP
address then performing the proximity check still makes sense.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 modules/replicated.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/modules/replicated.c b/modules/replicated.c
index 3ac4c70f..e5c2276d 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -711,6 +711,24 @@ done:
 	return 0;
 }
 
+static unsigned int is_hosts_list_simple(struct host *list)
+{
+	struct host *this = list;
+	unsigned int ret = 1;
+
+	while (this) {
+		struct host *next = this->next;
+
+		if (this->rr) {
+			ret = 0;
+			break;
+		}
+		this = next;
+	}
+
+	return ret;
+}
+
 int prune_host_list(unsigned logopt, struct host **list,
 		    unsigned int vers, int port)
 {
@@ -726,12 +744,6 @@ int prune_host_list(unsigned logopt, struct host **list,
 	if (!*list)
 		return 0;
 
-	/* If we're using the host name then there's no point probing
-	 * avialability and respose time.
-	 */
-	if (defaults_use_hostname_for_mounts())
-		return 1;
-
 	/* Use closest hosts to choose NFS version */
 
 	first = *list;
@@ -767,6 +779,14 @@ int prune_host_list(unsigned logopt, struct host **list,
 			return 1;
 	}
 
+	/* If we're using the host name then there's no point probing
+	 * avialability and respose time unless all host names in the
+	 * list each resolve to a single address.
+	 */
+	if (defaults_use_hostname_for_mounts() &&
+	    !is_hosts_list_simple(this))
+		return 1;
+
 	proximity = this->proximity;
 	while (this) {
 		struct host *next = this->next;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
