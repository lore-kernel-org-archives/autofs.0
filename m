From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.7-56 on RHEL/CentOS: auto.master documentation (or me)
 wrong?
Date: Wed, 17 Jan 2018 12:34:18 +0800
Message-ID: <beff830b-4d04-122a-a2b8-f42fa6833062@themaw.net>
References: <203f8953-f038-a787-8006-8e72f90b7326@drosera.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=KA78s3fXbly7Pmec33gjvOZkEcoi4
        UqcFFZHkVKMaHE=; b=KtNuLIZihf11zFIMXrgzG6O54L1cOujpcIbvkT4VvpiWW
        0mwfSWKauZKusDFkaBZ9AX8BBem3BMRVwplnWhs7WPNI7Dbgxu/o46v2X68Eh+dz
        2yQcAGDIS1TVcNMEQFAiAaI920RHYfuDlwbF+mxYWS7h0JvAz3ox4472sQJpI0tO
        FzhRfhjSLENiSwvqmlC3doFLUXGx81mvxqOcLs0Blpd6UvaatfAhHiSKS32vIHW4
        1LVjcmQocAXYXzqmZwdq4cADjbNLY0LGCHfe5u4BpU2kMUiYY6zcW28jP5ZQ6u7T
        Xk1itiRSjgfT8UW9dWUVoG4983o5kka1SXqhIyV7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KA78s3
        fXbly7Pmec33gjvOZkEcoi4UqcFFZHkVKMaHE=; b=anDuR22zspjBTy1/xlslpg
        K13WYq6daNPRBm1U9KgwHQAE3zWTXlSchHNktFx62/HH1c8HK7Aym2UUzhtsiq1q
        H4KMPbhTAYM33dE6wuJePKnG0Vd3zEmvWqRRn6ZOQularFEAG4tTPiiGL5O8Y9JX
        g9WGy6SujfnE/+EQ07NLnX9g/McT/wNzHrvDN85vPNUjSOafrv+12zcGKPQ1FRwV
        +/YmgC9OTd8KWnAN59py+fSHfslg3LqfcDGN2jFsbepRHBQs+jo/qejd+G0cZJha
        v35tYtxuRR5HSgnJRTaxyhN1/RtCo78XbGf/ByTJfEbMGwNPGh5z9Y79G2gb1HRQ
        ==
In-Reply-To: <203f8953-f038-a787-8006-8e72f90b7326@drosera.ch>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Frank Thommen <list.autofs@drosera.ch>, autofs@vger.kernel.org

On 16/01/18 01:32, Frank Thommen wrote:
> Dear all,
> 
> in the auto.master manpage (CentOS 7.3.1611, autofs-5.0.7-56) it says:
> 
> ---------
> [...]
>        options
>               Any remaining command line arguments without leading dashes (-) are taken as options (-o) to mount.  Arguments with leading dashes are considered options for the maps and are passed to automount (8).
> 
>               The sun format supports the following options:
> 
> [...]
> ---------
> 
> However a line like
> 
>   /home   /etc/auto.home   browse vers=4.0
> 
> or
> 
>   /home   /etc/auto.home   browse,vers=4.0
> 
> 
> results in the following error messages when running autofs with debugging enabled:
> 
> [...]
> Jan 15 17:46:47 tbi-cn010 automount[26585]: syntax error while parsing map.
> Jan 15 17:46:47 tbi-cn010 automount[26585]: syntax error in map near [ bogus option ]
> [...]

The master map parser would reject the . character in the options.
See bug https://bugzilla.redhat.com/show_bug.cgi?id=1486035.

> 
> 
> Instead the option seems to have to be added to the indirect map /etc/auto.home
> 
>   * -vers=4.0 server:/exports/home/&
> 
> 
> Do I misunderstand the documentation or is it wrong?
> 
> Additionally I'm missing the manpage containing the format description of the indirect maps.  AFAIR this used to be part of the "autofs" or "automount" manpage.

I think that has always been in auto.master(5).
I might be wrong in that it changed at some point but I don't think so.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
