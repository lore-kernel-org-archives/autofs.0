From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
Date: Mon, 21 May 2018 12:17:49 +0800
Message-ID: <d6096c21-1c0f-266f-8541-29f0726fe349@themaw.net>
References: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
 <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=YlyPwUqWoRKxnO6fS9SR5XlruGR1m
        XNACBn8wW2TVUA=; b=RZ5+AxtfINCbYDkvDRGoFfben3EC+NeZd0EQRBu1bvFmd
        RPLJO9qw8yVX+XoBfToK7ZAc117Vkn3jFVc0QXj225cGRwyJ6SALWPN7gxxLwO4z
        wFkgtCyhjBnsDLADAwS2ZMrwOCJhk9lyTk8sVUOtasXwy8zwgwpeGTtFSCpK/16V
        aEiZIcJGrdbd49bWZ6zTdkkrP4qDjjgHsBEUxr8ITG5M1akJEyWRuHv7TLM4CmSt
        H6q//rxghLBhbaXTuKeK3o5vsuiE2MSgAR0nAiX0ErA5q3yTN9yoVkYn41NEv8T2
        L8UowdpQi8j3RysCFDNf2YtUOq/PjmixD+hMAZfAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YlyPwU
        qWoRKxnO6fS9SR5XlruGR1mXNACBn8wW2TVUA=; b=SjdTBPbWdpgNbWghw2Qbz2
        7Ahf5oBxdHb/1xYLCGnF/Kv8Q7nWvDW3jL7zJefw6th7hcSM7L2g19t29zF18UPg
        N3mpNMhXgMsT3CZKnYk4fBvEtNvTFVL/wQIfEUr6QOMKZaojo6LBJM/Po80OA3sZ
        Z3UvXudlVxwVU4YxEiAjWaZpxVltIQmFZV73UWLizm60YHolW40CAKdlUUTrYrXB
        6Pbzcz8RTRkqeacNbFXYmNk3nu2PboRVH8WocAT8KpsbuHsbll+q2TGieePQasvN
        Z0HFODFZ5FtMrd2qqdmROzb8SGOS/KiwpTb+tnYc8kilEmpSg0Ljmw3Tv1v6hjpQ
        ==
In-Reply-To: <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21/05/18 10:08, Randy Dunlap wrote:
> On 05/20/2018 06:04 PM, Ian Kent wrote:
>> Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
>> failure.
>>
>> It isn't possible to unset one if the other is set because it
>> introduces a circular dependency.
>>
>> But adding "depends on AUTOFS_FS = n && AUTOFS_FS != m" will make
>> autofs4 appear under the autofs entry which should call attention
>> to it. It also results in AUTOFS4_FS being removed from .config
>> for any setting of AUTOFS_FS except n.

Arrgh!

I missed that "&& AUTOFS_FS != m" in the description.

Andrew, let me re-post this patch with this fixed and with the
added annotations for Randy below.

>>
>> Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
>> awareness of the change to smooth the transition.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>> ---
>>  fs/autofs4/Kconfig |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
>> index 53bc592a250d..2c2fdf989f90 100644
>> --- a/fs/autofs4/Kconfig
>> +++ b/fs/autofs4/Kconfig
>> @@ -1,6 +1,7 @@
>>  config AUTOFS4_FS
>>  	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
>>  	default n
>> +	depends on AUTOFS_FS = n
>>  	help
>>  	  The automounter is a tool to automatically mount remote file systems
>>  	  on demand. This implementation is partially kernel-based to reduce
>> @@ -30,3 +31,10 @@ config AUTOFS4_FS
>>  	  - any "alias autofs autofs4" will need to be removed.
>>  
>>  	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
>> +
>> +	  NOTE: Since the modules autofs and autofs4 use the same file system
>> +		type name of "autofs" only one can be built. The "depends"
>> +		above will result in AUTOFS4_FS not appearing in .config for
>> +		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
>> +		appear under the AUTOFS_FS entry otherwise which is intended
>> +		to draw attention to the module rename change.
>>
> 
> 

