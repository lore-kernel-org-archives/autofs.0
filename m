From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 34/35] autofs-5.1.3 - improve description of
 mount_nfs_default_protocol
Date: Mon, 16 Oct 2017 13:51:09 +0800
Message-ID: <5448a054-9bb2-c412-d4b1-8c4f017d640d@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813057523.25695.3001080814749098407.stgit@pluto.themaw.net>
 <20171016053757.GN15217@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=RixDlojAzZsJ2HQB0roCYMu6qeQk4
        CMQ/3xc6iEh8Ps=; b=QR75DzHWvzDb25XD26VOSQJb8PpCFM9wf32aEkT7H5Tyk
        CA/trkHi68ZcsTkUOZpJr4Zps6CP4OWcyGtfSegec5ot2KQnfU2SGM4Ko9E3joRd
        mupM/Tpu5PsMHF2A1bYkZUzVTDtnMRiJmD/OX/T9dH+Org5wbnoC/nROn59h1pYP
        GtKGLIu2DOieKimmeC/Syr0rHMhaxrKsyOIOK+1itFwYLlEyp5BJ5VGxK4k7aYhF
        xFPLyktMCKV5ggxSa6F79AOO/42uvOyQMm2MZV7KlWDO6H1jVw8nVQwJ01EDWeTb
        hTvVCi+koqBrHKuSiNQbGOahYMGTh131Ai3a/N8ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RixDlo
        jAzZsJ2HQB0roCYMu6qeQk4CMQ/3xc6iEh8Ps=; b=AH3A+p5CXncHp/T+v4x3tY
        Hz+r84jC8svvLDNGtyvIOWZzpUMn7E/DRnHxHUpRFkppZX/ZnLMHjdBr4fhc6VsC
        SYcM5V0fXySZaRdq+RaYhxOnDPn0PbF3Y3tdqq3CMaTBOMzEtS6ksukbapSNB0pM
        LXVhYNyOL1JyiYORJqD8fQM8J9IHdWcO3r/sfHbRAy1y6T5fLcTWkwVrqSZw30tC
        HRKN8lyoOAo/ojUUWgvbwwjuv2hK5DfTM8BgzPYknMT8iGx+S5PDSNFDW5LlHO5h
        4C7IMjcm/kh+27MbQQ1MB60SihSxCAgUESB03cFSwfwaRFWX8WDs5rdklkHM5LVA
        ==
In-Reply-To: <20171016053757.GN15217@mayhem.atnf.CSIRO.AU>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs mailing list <autofs@vger.kernel.org>

On 16/10/17 13:37, Vincent McIntyre wrote:
> On Mon, Oct 16, 2017 at 01:09:35PM +0800, Ian Kent wrote:
> 
> nitpicking
> 
>>  # mount_nfs_default_protocol - specify the default protocol used by
>> -# 			       mount.nfs(8). Since we can't identify
>> -# 			       the default automatically we need to
>> -# 			       set it in our configuration.
>> +# 			       mount.nfs(8). Autofs needs to know the
>> +# 			       default NFS protocol that mount.nfs(8)
>> +# 			       will use so it can do special case handling
>> +# 			       for different NFS protocols .Since we can't
> I think you want
>  +# 			       for different NFS protocols. Since we can't

LOL, indeed yes.

It might need a little more work too.

Apparently a casual read still conveys the impression it is meant to
change the default NFS protocol used by mount.nfs(8) which is what
the change is trying to resolve ....


> 
>> +# 			       identify the default automatically we need
>> +# 			       to set it in our configuration.
>>  #
>>  #mount_nfs_default_protocol = 3
>>  mount_nfs_default_protocol = 4
>> diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
>> index a04b56f9..4bbecc64 100644
>> --- a/samples/autofs.conf.default.in
>> +++ b/samples/autofs.conf.default.in
>> @@ -45,9 +45,12 @@ timeout = 300
>>  browse_mode = no
>>  #
>>  # mount_nfs_default_protocol - specify the default protocol used by
>> -# 			       mount.nfs(8). Since we can't identify
>> -# 			       the default automatically we need to
>> -# 			       set it in our configuration.
>> +# 			       mount.nfs(8). Autofs needs to know the
>> +# 			       default NFS protocol that mount.nfs(8)
>> +# 			       will use so it can do special case handling
>> +# 			       for different NFS protocols .Since we can't
> 
> ditto
>  +# 			       for different NFS protocols. Since we can't
> 
>> +# 			       identify the default automatically we need
>> +# 			       to set it in our configuration.
>>  #
>>  #mount_nfs_default_protocol = 3
>>  #
> 
> Vince
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
