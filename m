From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 26/35] autofs-5.1.3 - document ghost option in auto.master
 man page
Date: Mon, 16 Oct 2017 14:07:24 +0800
Message-ID: <7e8af081-4a72-f4dc-a3b4-adb23909bddc@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813052207.25695.16615651390055095096.stgit@pluto.themaw.net>
 <20171016060014.GP15217@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=rha+iBm/7cBBSbvUfyhty0/cInVOO
        kRpoxnkbZwMCqs=; b=K3m6UuL2qr1hQqi5Q8sdP0/igz+eG+nil95I7PXQJuKqD
        R7nCbWOlM3THMaL7LVEAPf38tcUQ1NC2jVBzFc2sGGvGHYrW0kTC/DM6ElV+gzkl
        xoGdv4gN9yl1utpgiTgIWgFi1FVMuMQ2uHk+G2UpDuohJGNnF/RRKTq8LL94Tx39
        WQQaSnGcC9n+BfxDlvBFC3ASiIgIVmNi062lE/LNLB0agaFVvOqIkheqKYZyToEt
        cGvr/hJjq+6IwTvCSyd37Bo5S8cwltaBJXXtJF17xJoaZ0TCzK5mq0f+ww0J+G7f
        E85I2UQ3De9FyVqTPc8pZNEhODwVDibTV5nfrBCsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rha+iB
        m/7cBBSbvUfyhty0/cInVOOkRpoxnkbZwMCqs=; b=KYYG5u3PgekDIs6pggBOrx
        ABjCankc//rFbeAfnr2Z5HoOy3y3lDvEULpWEzbv1RpPOeG4UqqbdZABIduAJ9Ok
        KYkVFiMqTMmsjU3rgMh/jb2Afrvr/kfm/orHFvQfhlNKO+3Rl0NDMa5MJPz9Z69d
        WhYtL6+ilDgLWI1+p78byuKZIafSVm6osjpTLA+3358Iel//t1R5P8q/ca4s7Rnr
        iNrJBL/8M7uCA8Dz+t4iiNKPbhIFhFbfDzeoapowgVSEC2+NwVjvyQzwx94X6/jb
        xX+Dj3w2q21Bx51Rks7FofZ7oboYmOUiV6InNB6LOitDH5HAXVQFLSuTKgQW9Xtg
        ==
In-Reply-To: <20171016060014.GP15217@mayhem.atnf.CSIRO.AU>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs mailing list <autofs@vger.kernel.org>

On 16/10/17 14:00, Vincent McIntyre wrote:
> On Mon, Oct 16, 2017 at 01:08:42PM +0800, Ian Kent wrote:
>> The --ghost pseudo option has been depricated for quite a while now
>> in favour of the browse option as descibed in auto.master(5).
>>
>> However it isn't noted in the description of the browse option that
>> the --ghost option is the same as the browse option.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>  CHANGELOG            |    1 +
>>  man/auto.master.5.in |    3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/CHANGELOG b/CHANGELOG
>> index 6a18fd15..7457e620 100644
>> --- a/CHANGELOG
>> +++ b/CHANGELOG
>> @@ -24,6 +24,7 @@ xx/xx/2017 autofs-5.1.4
>>  - fix autofs_use_lofs description.
>>  - fix amd parser error buffer size.
>>  - make spawn_bind_mount() use mount_wait as well.
>> +- document ghost option in auto.master man page.
>>  
>>  24/05/2017 autofs-5.1.3
>>  =======================
>> diff --git a/man/auto.master.5.in b/man/auto.master.5.in
>> index c87fb7f4..4475186a 100644
>> --- a/man/auto.master.5.in
>> +++ b/man/auto.master.5.in
>> @@ -168,7 +168,8 @@ can cause performance problem if the indirect map is large so it should
>>  be used with caution. The internal program default is to enable browse
>>  mode for indirect mounts but the default installed configuration overrides
>>  this by setting BROWSE_MODE to "no" because of the potential performance
>> -problem.
>> +problem. This option does the same as the depricated --ghost option, the
> 
> nit:
> s/depricated/deprecated/g

And again, yes.

> 
>> +browse option is preferred because it is used by other autofs implementations.
>>  .TP
>>  .I "nobind"
>>  This is an autofs specific option that is a pseudo mount option and
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>>
> 
> Vince
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
