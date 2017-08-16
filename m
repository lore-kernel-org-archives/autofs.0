From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Wed, 16 Aug 2017 13:46:28 +0800
Message-ID: <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=N7faO/mOO963kQdfYx
        ER4MPjJHfosOqvO67+kP7gRdA=; b=G4YgRl3uKcNUPPqffHdkkDul+bvUqlDp8z
        +V3KvAcK9zt1XVK/hKtCqb4FxPy2KDkLkrzYSGZiPs5S6SsfzPaXjp7mEBU0KMDk
        yIsgmsv5GhMOLPm4eZHf6+qCmuAdEiNrmgaG064JjH/1oh9nlkapgI4o7NlJwzXg
        hex2WGf355rqugntTaHAv4l/fovqA/+EzXyNf3XGBmg4N/1lBRjjcUb7qTp9imQB
        reZXFiI3D0KM4PETr3fItqDL8qjDnMkYjCmQwB7VV41KdyYVs2x7MRMPCnmdgzDD
        zN/UN3tPZ4BwHiyUMSKD9NiiAAocVMOYCP8iZiDE2wZrj2WogHvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=N7faO/mOO963kQdfYxER4MPjJHfosOqvO67+kP7gRdA=; b=Ovb+UHR/
        wyVL6MpJw6jqNqsua8s9t5a7HD71evZ7fGvdBpD8njbttFuESqZz96PCZWaid3YK
        TNJIJdv+X7gVjts+FLv4oAwBJTcsWEwR8MHFPHfeZzKYXn0/c8VvQPjpYUHnID9p
        yMeIVi/Eg9FUhPInun6cJOoJ46AcJiguIMvlqWOzbHvABXhyuyzf1mt70bHPLgAZ
        rEExgE+9nObDpz4e4a/qSh3gvNDAP7/B26b0Nwa2DUCnbGGs8A37F9GsvxTLethO
        IfN3nF3yR3HUYTEFDjd4Bsv9Pqyiny4McQyu2Qhiilyg6UjsvwCTDkNzbo3vOL8o
        j3Ihtrhl/HXZJA==
In-Reply-To: <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oscar Salvador <osalvador@suse.com>, autofs@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>

On 16/08/17 13:02, Ian Kent wrote:
> On 11/08/17 05:15, Oscar Salvador wrote:
>> Right now we are just checking and parsing the ldap's configuration
>> in lookup_init() function, and if everything goes well we return a zero
>> value indicating that everything worked fine.
>>
>> This has a problem, because in the case we set ldap method in
>> /etc/nsswitch.conf, configuration parsing goes fine but ldap is not working,
>> we will return a zero value in lookup_init() function, so autofs will move on,
>> but then we will return NSS_STATUS_UNAVAIL in lookup_read_master() function
>> once do_reconnect() fails, and because of this autofs will not be able to
>> reread the maps.
> 
> Umm ... I can't see a check in the current upstream NIS code?

I also don't understand the problem in the upstream code your trying to
resolve. Can you try and describe it again please?

> 
>>
>> NIS already handles this by testing for server connectivity during initialization.
>> This patch does the same thing for LDAP.
>>
>> Signed-off-by: Oscar Salvador <osalvador@suse.com>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  modules/lookup_ldap.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
>> index 98701e5..29a67a5 100644
>> --- a/modules/lookup_ldap.c
>> +++ b/modules/lookup_ldap.c
>> @@ -1681,6 +1681,7 @@ static int do_init(const char *mapfmt,
>>  		   int argc, const char *const *argv,
>>  		   struct lookup_context *ctxt, unsigned int reinit)
>>  {
>> +	struct ldap_conn conn;
>>  	unsigned int is_amd_format;
>>  	int ret;
>>  
>> @@ -1810,6 +1811,12 @@ static int do_init(const char *mapfmt,
>>  		}
>>  	}
>>  
>> +	memset(&conn, 0, sizeof(struct ldap_conn));
>> +	ret = do_reconnect (LOGOPT_ANY, &conn, ctxt);
>> +	if (ret != NSS_STATUS_SUCCESS)
>> +		return 1;
>> +
>> +	unbind_ldap_connection(LOGOPT_ANY, &conn, ctxt);
>>  	return ret;
>>  }
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
