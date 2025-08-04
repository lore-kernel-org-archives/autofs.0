Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319352E36EB
	for <autofs@vger.kernel.org>; Mon,  4 Aug 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271092; cv=none; b=nhkJYx2smWNJPLEOd5oIuEUbFnv/uPj1pNtvgMoM9hGt8LF5CbFogINDP/JMTZ4ioNev+Li5ikyujQC7wJZ7KYd+q0Rv9H5g78ccUcpjfxCNHeFagGlbVfIa5Yxh2h9baYgtiktHdhfBua71u1DBn942MnmJE3P/njrX9/O7H9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271092; c=relaxed/simple;
	bh=qgmyxEV4oXXQmsEx9ciHUwnOebxqTV+3fI4nchJtkR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tO2Byu9FCPPO4d4sDLEcUHrF03KPcYA4/anrdn4PrP3mzTpK5mhv6ExaFEBFKbdL21bKyC/iBh+qtUSRS25OHF8aJXOboG0I9sA6P10MELQBLhO58ENspy7/JFmrQN7oJYJ2Bp6tmglv8nNXpqSc7uJnQMUeEHN6wxXxhfKFpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=rKs48K9o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+avpgJT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="rKs48K9o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+avpgJT"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EECD97A0025;
	Sun,  3 Aug 2025 21:31:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 03 Aug 2025 21:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754271087;
	 x=1754357487; bh=ZVL9694FBG/IISAQVI0uFYn2kp064xTjyRP1168QVUE=; b=
	rKs48K9oxRxtIZMsrkzQcUwD12YiUfDzWIevPhKywbIQ5PVJu4KdPDT4dPVCDt+r
	1Pj0H+HKwPJxzn6qQmUa9EPxTACxJPmYFlmDyfMIfXNTbflIGMP9D+ZH1Sp/Hs6W
	NIh4XQNAGLt30s+et3zY7DhFt6w3a+US66oHbZyEFQkuuiZbjKj41dU4fzlBDeiU
	nHmSppBsRp7GHkoBNN3d+yA/sS2fTJINmx0ZeiJK4V1G3e3jqs1BrKeb6o9E6D7B
	ATB5Z7BMOy5MCtdqjMmPmtJ09Ox1IhLY4fhVuEgypsAZqKBv8nOtun2ij3eanqT3
	XFtDguUtARCicMQ9Xkt1pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754271087; x=1754357487; bh=Z
	VL9694FBG/IISAQVI0uFYn2kp064xTjyRP1168QVUE=; b=P+avpgJToGaUADdIc
	BPTM2pPApKH/lkubUryLhXXbuFtSiVg2PeA6r0jx1wG7NJNsl1s1edrHspOwmElf
	HFNNIMfkkRA5GtAIR8jXbsUvCTD54PHUeF2hQpD+Zw+SDMuxg/RtL0dAybMLvOZ2
	ujXc3w9MbCobiL4KKT0CZ4NNQ/7/sidW9jjVz1WJfG2HLpJkAc8HKuKX7SwSF/Ko
	9qMiSJH3zDE5cDhIMHVPdIXDL+MlDhr6MXks2NRDiYexq+gYHmwy068mtNNG63TI
	FZnaExYHkPQdIm/r+Pb4aMc/y+jte6qbMrjBBDX0Scq33FelyVXAvQ+jFYGyNupe
	7lc4w==
X-ME-Sender: <xms:bw2QaDo8mbOSY3dCu21VXAVklANCx8p9QeXfuDu3HJ8djIhfCStlnw>
    <xme:bw2QaN22GyouF8j5zoym4x0L9813C0rV-Zzebff0bN492j2GRQZCbYvlmo_T67Yu2
    BrizRd6_OUA>
X-ME-Received: <xmr:bw2QaCCzrTWkirWn_zDPyAqO74k4vL-PDQ6jMvsYaCrgxUZ8tKjmKGZ4WWLtxrP2x-tzdE62ZOqyYcKuNvCJ73f0ym92L8_pWIxFjOaf5iYQX8z6_ADBfvlV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeejue
    euteffueegjeehkeetiedufeehvdehteejtdejteelleehkefgfeefuedtgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bw2QaFeCKrWsqxAREOyamfFwbPe5_onP3CBHxPMLZmzU1d3E11ckUw>
    <xmx:bw2QaHiU_4tWP9-VAZ8co-VuSbd64PlqKDqq-8XsRg47Aiqv5wmI8A>
    <xmx:bw2QaNq5agUpWh9XjRvzlLmtuY3LMCDYFHY1fAInYazfSufG2oPzbQ>
    <xmx:bw2QaHH1NES1C287FwmhrUCbscUcjDMivuj5bMEvoxG84A1MONt93g>
    <xmx:bw2QaOPcTgwCJYl5Enk3hx14Q451h0VL0LQiBA-MVtjuUKw0QJbQ_l0U>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 21:31:26 -0400 (EDT)
Message-ID: <8754561f-4be7-4d41-9330-a0e5691ca48b@themaw.net>
Date: Mon, 4 Aug 2025 09:31:22 +0800
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

Hi David,


I was surprised to see this because I'm working on the very same problem.

But since I didn't have a reproducer I've painstakingly worked through

the map reload related code.


I don't know if my changes have fixed the problem but I can post them

for you to try them out. The main reason I would prefer to use my changes

(if they do fix the problem) is that I found quite a few problems with the

map reload not working properly which lead to spending a bunch of time on

that. One of the changes fixes the valid entry lookup and removes setting

the entry negative in lookup_prune_one_cache() and I think fixes the devid

handling in do_readmap_mount().

I'm not quite finished the series yet so I'll post it when I have, hopefully
today.

Umm, I probably should give your reproducer a go ... perhaps later ...

Ian


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
