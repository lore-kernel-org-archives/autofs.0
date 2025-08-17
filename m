Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38C1F4C98;
	Sun, 17 Aug 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455699; cv=none; b=RHDRDpCElVNpKd9fxpQwJhWcVCzLHBMknFqaIUltTT5IsWwnIRspTe+v4QaXl2ZhMK3PUnck9HtAIzybX+q8o3tUh4M5xDg7AFS2lYUDzMMUv6SGdv+C6VlGU3wkx1OJ10UDcTuohnN00h5wWohxgy+tOQF62jzW/6F7wATfrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455699; c=relaxed/simple;
	bh=DTnbaTdos2se8naC0CupyhhLgsthUHFqG3p7FNFbcA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlGYOwow2xR4hi6bnSNjJBYQqK7OnCT/DqQa5idQcp+a3QxJM+DnJFFSv7gtnfoUp9oiWzBU9g6K4xIsPH3pgUkmaPthXCHYPoOYnX8F064jRrLXdZ8fkbUNWFCS2OKnlEmzbyJz1a3zJbwTEHR06wdSn7s0fECRoDiLOh5DhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.54.22] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC26E61E647BB;
	Sun, 17 Aug 2025 20:34:39 +0200 (CEST)
Message-ID: <c1ccb74a-d715-41a7-862b-3038323d8091@molgen.mpg.de>
Date: Sun, 17 Aug 2025 20:34:35 +0200
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
To: Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, autofs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250817163609.GV222315@ZenIV>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250817163609.GV222315@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Al,


Am 17.08.25 um 18:36 schrieb Al Viro:
> 	That function should never be (and never is) called with irqs
> disabled - we have an explicit mutex_lock() in there, if nothing else.
> Which makes spin_lock_irqsave() use in there pointless - we do need to
> disable irqs for ->siglock, but that should be spin_lock_irq().
> 
> 	The history is interesting - it goes all way back to 2.1.68pre1,
> and that obviously was a tree-wide work.  Might be interesting to look
> for other places with just-in-case spin_lock_irqsave()...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> index 33dd4660d82f..4dc226e86360 100644
> --- a/fs/autofs/waitq.c
> +++ b/fs/autofs/waitq.c
> @@ -46,7 +46,7 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
>   static int autofs_write(struct autofs_sb_info *sbi,
>   			struct file *file, const void *addr, int bytes)
>   {
> -	unsigned long sigpipe, flags;
> +	unsigned long sigpipe;
>   	const char *data = (const char *)addr;
>   	ssize_t wr = 0;
>   
> @@ -66,10 +66,10 @@ static int autofs_write(struct autofs_sb_info *sbi,
>   	 * SIGPIPE unless it was already supposed to get one
>   	 */
>   	if (wr == -EPIPE && !sigpipe) {
> -		spin_lock_irqsave(&current->sighand->siglock, flags);
> +		spin_lock_irq(&current->sighand->siglock);
>   		sigdelset(&current->pending.signal, SIGPIPE);
>   		recalc_sigpending();
> -		spin_unlock_irqrestore(&current->sighand->siglock, flags);
> +		spin_unlock_irq(&current->sighand->siglock);
>   	}
>   
>   	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
> 

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
