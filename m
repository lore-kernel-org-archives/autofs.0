Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE03290D1
	for <autofs@vger.kernel.org>; Wed,  7 Oct 2026 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416581; cv=none; b=KHx2c40sQSrv44kJULeBXVddN7dRyPPprXqoE8/h9H7Jc+KJ+IDtzYvJBIU8cIwmDLG/PXK6sBfrkZhUhqIBAzKwHxFwAzRX8ABe4ek46OmCcVKuBPCUo12hIwKO7DXCx2kaJnTcmqSAVQKGhj23yja4JD22Q5zOtkjjxAaMEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416581; c=relaxed/simple;
	bh=Cindm6x8XGUHnO4VgwhMCwDDPBKWGT3wuLcAFxwPj/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXvTHq4b2e9XIWWsSvIfVVsgGhkqgsqBQh+JOZeOgowLluh7I1fQfQ/Zr8vLXyHHJSp1fPc/9jolrxu0ItPzz3djucwcP6WXm1ibJBNqKtdpCclbo97qdVE2DmzonhqHnpJrK07FkH8iVpTIFZy9fT5gvToYAJuMHCLp+mjK/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=SW5s7jmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qb94iwNq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="SW5s7jmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qb94iwNq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DECA67A00CF
	for <autofs@vger.kernel.org>; Wed,  7 Oct 2026 19:42:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 07 Oct 2026 19:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791416576;
	 x=1791502976; bh=m4TMw7vUyGM7/ReqmujwCCW66gpxzFZouTpziTv6ZdE=; b=
	SW5s7jmQU9WecvjpF3uCvBZAnwWF/yzFlfgZlLFuPtp3Rq7TnPwKCVzqSUgFa0tR
	6FknmgxnPi6nsiaeRi23phklteHqnzrWbkItel2zP6QkM63g8MpzHaSVZkawoq7g
	EHLiUR7MT9a2kEuBqFBVcreZMFKOfxOm5E3OeU91S0/t9yj95Hh9+E8kHUZUKGSM
	xsDx8P/NT9kC8Zs/Tuaa0qfKdGdVwMoQXQhUtlxmLcVateNdT4JSvzK4xN33PZUZ
	ZvCH7e+jLsJtyMtYtC+jirdzopQp7rjaEnNLLwyT7C5t62yScr1ocWPU4wS8RXVv
	OSU+TNmwD6HavJjr97XRcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791416576; x=
	1791502976; bh=m4TMw7vUyGM7/ReqmujwCCW66gpxzFZouTpziTv6ZdE=; b=q
	b94iwNq+wJHN1WfAsDPhhdHe/uQGxyCqnuV8UXvkvUHohKoFiOp/7D9b/OXyvVlr
	Sk7t/uHWkSV+4CqARHrowFeq7tnUy5K7sconyrUeNHB5P09WZ/dJi3XYXLZxpqof
	FAGcbw85Nja+JWpOx7HW0iFyFNTm/mlK12bNQaiXKUgvpDCwXpF171mxuC6LJR5S
	ZV7qI1x4zoKmZovUqRzS/TviadIHERZlP0hOceuvisF3pbenw4YBSKFqL3+wKZUY
	IEm99nLFei/QOhHN/H6MQo1PQNVGz003nM0fBwEebBNFwGWHQKQp/AOzMP+AGdDC
	Fr5or0TBnP338cmgVZ7hA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791416576; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGF1dG9mc0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MElfM59h+LyjItMOQklZfd6OUmv+lLNZcKwXuHcm03n8aTg
	4HMXsOIbN0BlxkG1jEaMRgICDyg4ui3eEPFVS4leshW9tikRIkzOxmfR3cNdLaiH
	J5tjX94NlqsOrao41WXufaaKObb1RJSNqAsJ4OWkTxtOW8SKPQthAecHnQTMW1H+
	HqNZh7BAYiKtAvPwbpqATVrWbuyK/8s/nu0IeOsZy27e9UhsrAuoq4m8niPvsRMM
	2O8zWtGMm2MxRx7FCbSARddchl+cJ5WHNzWfmRU6OuvRCZ+dVJKk2i28w6ZhAY/J
	QicPCohGe0O6eXuccOyblg/mLAyiUZlbR5BkRrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=15;
	hn=autocrypt,cc,content-language,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7K60q61VgyVEYqXJTaZMl52v4Ld1L39qtwoAKqEa2wU=:Cindm6x8XGUHnO4VgwhMCwDDPBKWGT3wuLcAFxwPj/Y=;
X-ME-Sender: <xms:ANnGamAiuKIWhhGxktJK2NTvS8OyuDVW3v29BofhKE5r9MPzQokU_Q>
    <xme:ANnGauXw6IANDfU2hzuDeKf5Q0hAm9s-Zp0oYGzWs6XOA6sXYIq5WTiSysbR75ll9
    lHOF1SBNUcDOCfu5VB6ywxmJ6Z4hdPng_Rhw2ttBo5Rkp0F>
X-ME-Received: <xmr:ANnGakCF-YHRz7L-jvNo2a_nZKOdncRnG6LrQxW7CdfrPgSy_XZI-WXJ8O1jPBb7_Uhac1eIVnj0Of2oYpQ8o21JCmEAnpHO-k-7NhrBrs8jJYpvICw7NYb_>
X-ME-Proxy-Cause: dmFkZTGT7Z5OOOJqx7S8bS5u/wH9IxrVtggxfqHlSH1p+wH6vOUdipEd1JBJ59TmB1M91h
    5AsWSvK98KfKA9pqTlre35JKppmTn8OI3YWLRs2dn3fyoL4NWVU9xEyDFnayQ1l7fMrtbg
    AbDFGdBiC9oYzmWK8bASkvmkLCi8M6zDdIQPPPfnQTcvsAnw2r7V4ymX0itlm+tEI29Sel
    wfb2kA5AWkh1zIoypCCn9AhaTjxogfIfhKU5pRmoWo2J739frc9nd2EU2FK5ZgvPElxULM
    ouQ7AymdRHL6fIgiVMs89vgH0MdoLuwtLvxN2+ldTjA5N0xYdWShL5MJGVzeiwKZvz0JpD
    qI1k9Oy87YrprFQrh6bbXvWoi/YkDoy1URj0iZeXYPrSDQjZO6XqMf+sFoz17tY5Qi4sny
    BfxZy95wy1V3f4jZLkeGzIZEhbRS7p5rUR6OPLsCe2mGjgktX+ObhWuqZvg7Jv149YNqR0
    oBMm8N4VSU/5Myh16OiJgQfGWdgdkutzVllPew9vYy5Vo691I2+jFvK2oGf0TT/L23bNAj
    zfsTnfIwFw26OP+CcB4pjZT5jq0R1H3OzhaIrO5PC2yp2I6p1iabpZtuEx6wuf7r8AzHpx
    o/UvB1wuqLwH3lGF3a7S2JAdTJlFfNfxXPbNUAKjmKIzFiIluGiVDT14/MEQ
X-ME-Proxy: <xmx:ANnGah-KiyqZ3qzYU2pD6A99ooUSHjj6GaKAKeQP8sBmmS5rpMje1w>
    <xmx:ANnGarG8ADqhnln434WunekKRh9_XfMuz6fBPINzUMDt34zoKPWAEA>
    <xmx:ANnGavNDMOjL4_rtyd3IuNnQB0xJDUmpVy85C-zeKi0UC1H2k9Ou3g>
    <xmx:ANnGalfTrzpRXdbzE01APn3k7impBqO7RvskLjCO5zzhyuxWLgAwrg>
    <xmx:ANnGarRypZA6-rX0h72XQe3Vlmq02zs1dTI0JwIEZkJTPQDcmq1xLAyZ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 19:42:54 -0400 (EDT)
Message-ID: <83e9eb08-ef9b-4eb8-bc5c-e9dc9636e204@themaw.net>
Date: Thu, 8 Oct 2026 07:42:50 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs: ignore notification errors from a replaced pipe
To: tjdqudcks0424@naver.com
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20261007173542.593624-1-tjdqudcks0424@naver.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20261007173542.593624-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 01:35, tjdqudcks0424@naver.com wrote:
> From: Sung Byeongchan <tjdqudcks0424@naver.com>
>
> autofs_notify_daemon() takes a reference to the current notification
> pipe under wq_mutex, then drops the mutex before writing the request. The
> write can block while the daemon enters catatonic mode and installs a
> replacement pipe.
>
> If the old pipe's reader is then closed, the delayed write returns -EPIPE
> and the generic error path enters catatonic mode again. That transition
> acts on the current superblock state, closes the replacement pipe, and
> releases the new daemon generation's wait queues.
>
> Only enter catatonic mode when the pipe which failed is still the current
> pipe. Factor the already-locked transition so the identity check and state
> change are atomic with respect to another replacement.
>
> This was reproduced on v7.3-rc5-337-gff47652a4b66c in a local QEMU guest.
> An unprivileged UID 65534 lookup filled the old packet pipe before a
> normal CATATONIC/SETPIPEFD restart. On the unmodified kernel, the new pipe
> received HUP and both a pending victim lookup and a later lookup failed
> with ENOENT in two out of two fresh-mount runs.
>
> With this change, the new pipe remained active, received an intact
> 304-byte request, and both victim lookups completed in two out of two
> runs. Normal lookup and restart-without-a-blocked-writer controls passed.
> No KASAN, oops, refcount, or lock diagnostic was observed. A source
> reproducer and complete local logs are available privately on request.
>
> The demonstrated impact is limited to denial of a shared autofs service
> during a legitimate daemon restart. No memory corruption, information leak,
> privilege escalation, or code execution primitive was observed.

The description looks sound and a after a quick look over the patch it

looks fine. So I'll add my acked-by and also look more closely at the

change later, mostly, because of the problem I mention below.


This sounds like a problem I have been struggling with for ages and had

stopped working on it because I ended up starting an quite ugly refactor.

Looking at this I think that was misguided.


Acked-by: Ian Kent <raven@themaw.net>


Thanks for this Sung, much appreciated.

Christian, it would be great if you could pick this up as you usually

do, ;)


Thanks

Ian

>
> Fixes: 8d7b48e0bc5fa ("autofs4: add miscellaneous device for ioctls")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
> ---
>   fs/autofs/waitq.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> index d46241342dfc9..fd78d96e105d 100644
> --- a/fs/autofs/waitq.c
> +++ b/fs/autofs/waitq.c
> @@ -12,15 +12,13 @@
>    */
>   static autofs_wqt_t autofs_next_wait_queue = 1;
>   
> -void autofs_catatonic_mode(struct autofs_sb_info *sbi)
> +static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
>   {
>   	struct autofs_wait_queue *wq, *nwq;
>   
> -	mutex_lock(&sbi->wq_mutex);
> -	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
> -		mutex_unlock(&sbi->wq_mutex);
> +	lockdep_assert_held(&sbi->wq_mutex);
> +	if (sbi->flags & AUTOFS_SBI_CATATONIC)
>   		return;
> -	}
>   
>   	pr_debug("entering catatonic mode\n");
>   
> @@ -40,6 +38,21 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
>   	fput(sbi->pipe);	/* Close the pipe */
>   	sbi->pipe = NULL;
>   	sbi->pipefd = -1;
> +}
> +
> +void autofs_catatonic_mode(struct autofs_sb_info *sbi)
> +{
> +	mutex_lock(&sbi->wq_mutex);
> +	autofs_catatonic_mode_locked(sbi);
> +	mutex_unlock(&sbi->wq_mutex);
> +}
> +
> +static void autofs_catatonic_mode_for_pipe(struct autofs_sb_info *sbi,
> +					   struct file *pipe)
> +{
> +	mutex_lock(&sbi->wq_mutex);
> +	if (sbi->pipe == pipe)
> +		autofs_catatonic_mode_locked(sbi);
>   	mutex_unlock(&sbi->wq_mutex);
>   }
>   
> @@ -170,7 +183,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
>   		autofs_wait_release(sbi, wq->wait_queue_token, ret);
>   		break;
>   	default:
> -		autofs_catatonic_mode(sbi);
> +		autofs_catatonic_mode_for_pipe(sbi, pipe);
>   		break;
>   	}
>   	fput(pipe);
