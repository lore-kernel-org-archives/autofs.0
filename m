Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC22BCF5
	for <autofs@vger.kernel.org>; Wed, 24 Sep 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702970; cv=none; b=BcQMutDCGriJzxha8HmoJETnS43QlH6o0QQv8aXXR3yhbhVGcuzxjzQcmLItV7kISP2f9ob9H295i5HKYjc0d22LyXkoJoIBleqCXX3m6NzPT+CtUHmwaLaSqKRByRVv9illJcdrvV08tAp87SyYTjV++iDKQ+OI+sxJTXYxeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702970; c=relaxed/simple;
	bh=tae1uv93PdXXPXx4CQeR/AHgYrNPj//sqVc/AI49pVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZY1DqZuApD7sUmb2H6AAHSwaL2ufjQkVE3UCfRw0gmI6af+/sEYA/d7y6nCnGHuB9vb/tuz8MF+DYEZeAbWDj05spL7eSnIzj56lW0JzV//RHwTNOKyYN95DI5dna+mBMehqfgsWi0AnXyK4TkLFU017B6hNlcGUEC5L2lS5KDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ZAOaRTPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M77t9xXU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ZAOaRTPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M77t9xXU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D53BEC00D7;
	Wed, 24 Sep 2025 04:36:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 04:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758702966;
	 x=1758789366; bh=TjjIkO8RpnaZKq+AbRO2UgAmNa0CF/MYwE3+byatbsA=; b=
	ZAOaRTPqWQWdTOBbp+RyrLeQqV7Xosi25MoO3OBUKso8QYNPglg8W70U5W3sHk48
	oMvQqEStU/bx/owf6XbjWOr/PV4Q5nkT7J68ubp9t7irRYs8ZeuMGCujSAF5vntr
	oceYiK1XKp+ew3ImAA6xWOb2JuscWOVp+fPikG+0vEC5mFQzAUW120kjyCbtKiTy
	kYwdjR+S/vpq3VJeCxl058W/QMzfoyE4rqb/nNLLDDTFgqLjU/aYrHor7D9MWMjz
	a3ZTcVF52bUFwzvKzztylv1j0yrjw+FrpuCZwohbqIhO2uDVQSe+kKJ2wz+/fVF3
	lB0/Tgo/K4spzlwZDvCH2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758702966; x=1758789366; bh=T
	jjIkO8RpnaZKq+AbRO2UgAmNa0CF/MYwE3+byatbsA=; b=M77t9xXUzCHtS31Ta
	RT3oOFyBafhj+ENWX9XHiBEY9dHufpcaMYU2EpnwtdabN5KnAis+LlBkrUCg0rpu
	rc4H5G6uGIuXFirgVG4NOBYzEZ2FsCLWkgJwoyqCZw+61cY6bYfyeZjbRz2Fhm5a
	FnTtuidZexVxS0fNYqvT4HVaVR57uemrJFdcZ2Tj0JqOCWQkruXR3P3d8GC7mjB1
	7rX1yS0f5HAcMu0aNkmwhpXmaN7IO2dunevQNICJZWOwGNkinz0ownzVngTiMZf+
	2I4kjt63Rkls0iDHBCWWx0lRzOv+Cr9MDfwxYQZLoVjerwQRDnonPp+EWHMkD7kb
	VJpGg==
X-ME-Sender: <xms:da3TaHPN5GZ4EvMdAVubtRro7lQQwx9Rjga3rXCXfqST96wNEU0i0w>
    <xme:da3TaH9rmFjH92GH5oa0lVS6xKOIS7Bid7lHYEFnqUK4f73Ihm_kObK4SDjObbJF4
    0NVhPpCPycqUmyvMhd5E1PdFBBmS_egP1Q4ID8CMQP0sh3w>
X-ME-Received: <xmr:da3TaD7V1hjezutTPMp5gsFPjaS4Urp4sENeLR08deIz2eH-6WZvuXp1FPYDpJvYXHxAAcE2zc_DLgTXKIyw5l4U0Zy73WT3IkRmovAtipoBLkSjvI8KukY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfmvghn
    thcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepjeeuue
    etffeugeejheekteeiudefhedvheetjedtjeetleelheekgfeffeeutdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvg
    hmrgifrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopeguughishhssehsuhhsvgdruggvpdhrtghpthhtoheprghuthhofhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:da3TaG3IEBjfmok-bl2LWebnlxQsanVr6fyG4qklVXfuPf0ixgSH1Q>
    <xmx:da3TaCDCeYcjETgoA7fXDKVgxhnrFFbA7fFLa8C_-VYLXpQ0AtlOIw>
    <xmx:da3TaA1TWGaZbE0K1p0auXpiCG4Viv3sI36g5rt9JB5IkKj-JSO0iQ>
    <xmx:da3TaEu9yZ93ugaMki8xYUOqwcc_EiFJpMaTzYZURf1t6omxVcum4w>
    <xmx:dq3TaCmRJFHRQWkt2B22Vu59wr81XXIkhWfBy58vXysT_EqxZ8MmifJW>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 04:36:04 -0400 (EDT)
Message-ID: <5a0d52c2-2a45-4b8d-a621-31c4fe63ff57@themaw.net>
Date: Wed, 24 Sep 2025 16:36:01 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: autofs-5.1.9 - flag removed entries as stale
To: David Disseldorp <ddiss@suse.de>, autofs@vger.kernel.org
References: <20250801152210.15501-2-ddiss@suse.de>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250801152210.15501-2-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 23:22, David Disseldorp wrote:
> This effectively reverts commit 21ce28d ("autofs-5.1.4 - mark removed
> cache entry negative"), which causes the kernel to stall in autofs_wait
> for the following workload:
>
>    cat > /etc/auto.direct <<EOF
>    echo "/nfs/share  $mount_args ${NFS_SERVER}:/${NFS_SHARE}"
>    EOF
>
>    setsid --fork automount --debug --foreground &> /automount.log
>    sleep 1
>
>    touch /test.run
>    setsid --fork /bin/bash -c \
>      "while [[ -f /test.run ]]; do df -ia >> /test.log; sleep 1; done"
>    echo "df loop logging to /test.log"
>
>    sleep 2
>    echo "changing and reloading auto.direct"
>    echo > /etc/auto.direct
>    killall -HUP automount
>
>    sleep 2
>    echo "unmounting..."
>    umount /nfs/share || echo "umount failed"
>
> The current behaviour sees us hit:
>    handle_packet_missing_direct:1352: can't find map entry for ()
> ...which doesn't respond to the kernel, triggering the stall.
>
> This approach adds a new MOUNT_FLAG_STALE flag to track removed map
> entries. While keeping enough state around to respond for the
> handle_packet_missing_direct case.
>
> RFC:
> - needs further testing (e.g. indirect maps)
> - I'm not familiar with the codebase so this may be the wrong approach
> - we may need a background job to purge MOUNT_FLAG_STALE entries?

In the light of the work that I did reviewing the map entry cache pruning

this patch seems not quite right but it is a good approach and I do like

it. I'll see if I can work it into what I've done to the cache pruning

without breaking it.


Ian

>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   daemon/direct.c     |  8 ++++++--
>   daemon/indirect.c   |  8 ++++++--
>   daemon/lookup.c     | 11 ++++-------
>   include/automount.h |  3 +++
>   4 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/daemon/direct.c b/daemon/direct.c
> index 42baac8..5e78c40 100644
> --- a/daemon/direct.c
> +++ b/daemon/direct.c
> @@ -1389,8 +1389,12 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
>   		return 0;
>   	}
>   
> -	/* Check if we recorded a mount fail for this key */
> -	if (me->status >= monotonic_time(NULL)) {
> +	/*
> +	 * Check if we recorded a mount fail for this key, or the entry has
> +	 * been removed.
> +	 */
> +	if (me->status >= monotonic_time(NULL) ||
> +	    me->flags & MOUNT_FLAG_STALE) {
>   		ops->send_fail(ap->logopt,
>   			       ioctlfd, pkt->wait_queue_token, -ENOENT);
>   		ops->close(ap->logopt, ioctlfd);
> diff --git a/daemon/indirect.c b/daemon/indirect.c
> index 7d4aad7..934bb74 100644
> --- a/daemon/indirect.c
> +++ b/daemon/indirect.c
> @@ -798,8 +798,12 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
>   
>   	me = lookup_source_mapent(ap, pkt->name, LKP_DISTINCT);
>   	if (me) {
> -		/* Check if we recorded a mount fail for this key */
> -		if (me->status >= monotonic_time(NULL)) {
> +		/*
> +		 * Check if we recorded a mount fail for this key, or the entry
> +		 * has been removed.
> +		 */
> +		if (me->status >= monotonic_time(NULL) ||
> +		    me->flags & MOUNT_FLAG_STALE) {
>   			ops->send_fail(ap->logopt, ap->ioctlfd,
>   				       pkt->wait_queue_token, -ENOENT);
>   			cache_unlock(me->mc);
> diff --git a/daemon/lookup.c b/daemon/lookup.c
> index dc77948..ad0b460 100644
> --- a/daemon/lookup.c
> +++ b/daemon/lookup.c
> @@ -1416,15 +1416,12 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
>   		if (valid && valid->mc == mc) {
>   			 /*
>   			  * We've found a map entry that has been removed from
> -			  * the current cache so it isn't really valid. Set the
> -			  * mapent negative to prevent further mount requests
> +			  * the current cache so it isn't really valid. Flag the
> +			  * mapent stale to prevent further mount requests
>   			  * using the cache entry.
>   			  */
> -			debug(ap->logopt, "removed map entry detected, mark negative");
> -			if (valid->mapent) {
> -				free(valid->mapent);
> -				valid->mapent = NULL;
> -			}
> +			debug(ap->logopt, "removed map entry detected, mark stale");
> +			valid->flags |= MOUNT_FLAG_STALE;
>   			cache_unlock(valid->mc);
>   			valid = NULL;
>   		}
> diff --git a/include/automount.h b/include/automount.h
> index 9548db8..007d020 100644
> --- a/include/automount.h
> +++ b/include/automount.h
> @@ -548,6 +548,9 @@ struct kernel_mod_version {
>   /* Indicator for applications to ignore the mount entry */
>   #define MOUNT_FLAG_IGNORE		0x1000
>   
> +/* map has been removed, but we can't clean up yet */
> +#define MOUNT_FLAG_STALE		0x2000
> +
>   struct autofs_point {
>   	pthread_t thid;
>   	char *path;			/* Mount point name */
