From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 16/35] autofs-5.1.3 - add some more debug logging to
 get_nfs_info()
Date: Mon, 16 Oct 2017 13:52:47 +0800
Message-ID: <4e483dea-d9bd-c419-8cdd-5ebcff573e32@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813045784.25695.14126222440890016371.stgit@pluto.themaw.net>
 <20171016054645.GO15217@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=w/Su7TkYyzUQxR20Md5iDTIFGpW6F
        6cPDYTseKRAQ4A=; b=SrrGqZ/p0MTUllgjaWJ4OLFOQMxaRZOPJczXzWEDvv66h
        zAvcbTQ5tULX5hRUTmRH3ZvCl2LtVkyVrBBfwp0PGWxMW+6s9pqHvCs6h6nUg73q
        hmRIp9JmkTCOIdnyCR1m7k73uMXRNWLfs3JT5b3D9xDkSsm8mi3IC3GCqRJA/IFs
        zSU9j0Xd8mh0O7I+NWrrvxWddYc+VS/RhK3GudNdzQttDbAByPWuu5MZtDYdFqIC
        zdZml3558pcdo1eIJ2/25Wdqf80tfCTsYPHCrdOHszhwRFN9ppQppQrEsYAxTPti
        cdnZeDAG33n/Z9kfQm8wGGnDzdoq6arORu7S12H9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=w/Su7T
        kYyzUQxR20Md5iDTIFGpW6F6cPDYTseKRAQ4A=; b=a4SmZupu9T4Jhsan3k81AL
        /kGqDrZrluO9xcObdlkcxKYSpchUiTeKC64KvBX9uxc3Ew02sZSVo5fY2a8ED5T0
        eU8WP/XSSQbw/Bc0BDeMRBu24AgF/JAu5mdT+wSOGYun1f6mcthc5x2sWc60dWFR
        KAGPC66cHOaxeQgy2nkCVKheUIYym7ifAD4Dkxs/J4LmZdGMrFVwXA6I5LFq/JVF
        6kQ2MBjLhVVdoMbUt+1ZvE1rGbiLwSccN6F+/RQGHrisXPiwFG4GKrfhApJHnjnL
        D0Q2z2Av8Jm264NBgcqQhLVV6Z9DdWUoUdh98Ruz/cIfvSwuvM4jMOHI8bA4Ss8g
        ==
In-Reply-To: <20171016054645.GO15217@mayhem.atnf.CSIRO.AU>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs mailing list <autofs@vger.kernel.org>

On 16/10/17 13:46, Vincent McIntyre wrote:
> On Mon, Oct 16, 2017 at 01:07:37PM +0800, Ian Kent wrote:
>> Add some additional debug logging to get_nfs_info() for failure cases.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>  CHANGELOG            |    1 +
>>  modules/replicated.c |   36 +++++++++++++++++++++++++++++++-----
>>  2 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/CHANGELOG b/CHANGELOG
>> index c6423ce8..a21da121 100644
>> --- a/CHANGELOG
>> +++ b/CHANGELOG
>> @@ -14,6 +14,7 @@ xx/xx/2017 autofs-5.1.4
>>  - set systemd KillMode to process.
>>  - fix mount.nfs blocks on first mount.
>>  - fix some man page problems.
>> +- add some more debug logging to get_nfs_info().
>>  
>>  24/05/2017 autofs-5.1.3
>>  =======================
>> diff --git a/modules/replicated.c b/modules/replicated.c
>> index c5c4f392..c44ed466 100644
>> --- a/modules/replicated.c
>> +++ b/modules/replicated.c
>> @@ -266,20 +266,29 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
>>  				host->name, host->addr, host->addr_len,
>>  				proto, RPC_CLOSE_DEFAULT);
>>  		if (status == -EHOSTUNREACH) {
>> +			debug(logopt,
>> +			      "host not reachable getting portmap client");
>>  			supported = status;
>>  			goto done_ver;
>> -		} else if (status)
>> +		} else if (status) {
>> +			debug(logopt, "error 0x%d getting portmap client");
>>  			goto done_ver;
>> +		}
>>  		parms.pm_vers = NFS4_VERSION;
>>  		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
>>  		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
>> +			debug(logopt,
>> +			      "host not reachable or timedout getting service port");
> 
> nit:
> "timed out" instead of "timedout" ? The latter isn't English, methinks.

Yep, agree with all these, thanks.

> 
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status < 0) {
>>  			if (version & NFS_VERS_MASK)
>>  				goto v3_ver; /* MOUNT_NFS_DEFAULT_PROTOCOL=4 */
>> -			else
>> +			else {
>> +				debug(logopt,
>> +				      "error 0x%d getting service port");
>>  				goto done_ver;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -288,6 +297,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
>>  	else
>>  		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS4_VERSION);
>>  	if (status == -EHOSTUNREACH) {
>> +		debug(logopt, "host not reachable getting RPC client");
>>  		supported = status;
>>  		goto done_ver;
>>  	} else if (!status) {
>> @@ -295,6 +305,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
>>  		status = rpc_ping_proto(rpc_info);
>>  		clock_gettime(CLOCK_MONOTONIC, &end);
>>  		if (status == -ETIMEDOUT) {
>> +			debug(logopt, "host NFS ping timed out");
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status > 0) {
>> @@ -326,16 +337,23 @@ v3_ver:
>>  				host->name, host->addr, host->addr_len,
>>  				proto, RPC_CLOSE_DEFAULT);
>>  		if (status == -EHOSTUNREACH) {
>> +			debug(logopt,
>> +			      "host not reachable getting portmap client");
>>  			supported = status;
>>  			goto done_ver;
>> -		} else if (status)
>> +		} else if (status) {
>> +			debug(logopt,
>> +			      "error 0x%d getting getting portmap client");
>>  			goto done_ver;
>> +		}
>>  	}
>>  
>>  	if (!port) {
>>  		parms.pm_vers = NFS3_VERSION;
>>  		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
>>  		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
>> +			debug(logopt,
>> +			      "host not reachable or timedout getting service port");
> 
> ditto:
> "timed out" instead of "timedout" ?
> 
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status < 0)
>> @@ -347,6 +365,7 @@ v3_ver:
>>  	else
>>  		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS3_VERSION);
>>  	if (status == -EHOSTUNREACH) {
>> +		debug(logopt, "host not reachable getting RPC client");
>>  		supported = status;
>>  		goto done_ver;
>>  	} else if (!status) {
>> @@ -354,6 +373,7 @@ v3_ver:
>>  		status = rpc_ping_proto(rpc_info);
>>  		clock_gettime(CLOCK_MONOTONIC, &end);
>>  		if (status == -ETIMEDOUT) {
>> +			debug(logopt, "host NFS ping timed out");
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status > 0) {
>> @@ -382,6 +402,8 @@ v2_ver:
>>  				host->name, host->addr, host->addr_len,
>>  				proto, RPC_CLOSE_DEFAULT);
>>  		if (status == -EHOSTUNREACH) {
>> +			debug(logopt,
>> +			      "host not reachable getting portmap client");
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status)
>> @@ -392,6 +414,8 @@ v2_ver:
>>  		parms.pm_vers = NFS2_VERSION;
>>  		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
>>  		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
>> +			debug(logopt,
>> +			      "host not reachable or timedout getting service port");
> 
> ditto:
> "timed out" instead of "timedout" ?
> 
>>  			supported = status;
>>  			goto done_ver;
>>  		} else if (status < 0)
>> @@ -403,15 +427,17 @@ v2_ver:
>>  	else
>>  		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS2_VERSION);
>>  	if (status == -EHOSTUNREACH) {
>> +		debug(logopt, "host not reachable getting RPC client");
>>  		supported = status;
>>  		goto done_ver;
>>  	} else if (!status) {
>>  		clock_gettime(CLOCK_MONOTONIC, &start);
>>  		status = rpc_ping_proto(rpc_info);
>>  		clock_gettime(CLOCK_MONOTONIC, &end);
>> -		if (status == -ETIMEDOUT)
>> +		if (status == -ETIMEDOUT) {
>> +			debug(logopt, "host NFS ping timed out");
>>  			supported = status;
>> -		else if (status > 0) {
>> +		} else if (status > 0) {
>>  			double reply;
>>  			if (random_selection) {
>>  				/* Random value between 0 and 1 */
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>>
> 
> Vince
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
