Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6713E4C7F
	for <autofs@vger.kernel.org>; Mon, 18 May 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094919; cv=none; b=kuOHxVBlPoFkKnl+btK56Xl9ANLKm8/If1ols+YI/EbzOIZpbOTa+T4xU54BOR3HOeHvlByDxyUiaKNPTG3gF9ML0AyMXfTwR4SEPW8K5grV63+nWm6WzLyVSp6EKOj+nxSW5CW1+GSOP6FZkzsk8PPG7LWCmsVOu/PK2yJXQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094919; c=relaxed/simple;
	bh=15ghJhbT2NsYCqPoDcqAwzmVKqCw0LtNKzduPnSDCDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GM2EXdWKfZszX1TH6+O9VQU2ZE8trehlcOg9JEOySE63RRzzEgLfbc66GQhRiDsYxBf73H7mNte3ujeIT788UAqU53YTGa34pZ8V/MAKiNiE9xKV+08tmBdJUvDUcaIWBg9oKascRCrNu/IoKi6X+Wvk5SO9T0us4TjkppN0KKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Lfu1rkUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgO2nAod; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Lfu1rkUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgO2nAod"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DE997EC0105;
	Mon, 18 May 2026 05:01:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 05:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779094915;
	 x=1779181315; bh=68+I6qEthTNpP7lgi3yfO6a4gzUR6q5n+RGYaxnQkmc=; b=
	Lfu1rkUQ7ZXQsf7VRnBa5c/Xg2adxzc5jMuTlxSeMGcSYxHUjCQJeUkHsAiDye7h
	bIiW6RrH+EP15wB/M/WTxXoVuYEHh0oZt4uEsxGgAn3YuC+GfAdf2DTOq6Sh5d3k
	wJS0x/mZICfsu4lIQP34B38LJzoTaKU6WngAziRX409LBf6iaddu5sRzmYCEI3tZ
	EusHGeuSqjqtuzvzUtneC9IfdigsZuiv4M14KiD4E3PGEe3y2G5rGpH/y+eSNhF7
	hW/9tj+Us3nsbYmxdoP1UJsanz+2VKkP7DQfIvSWJbTcBdLci+0MrL7KnVP8VsyJ
	DjkCMD4uYMW3/GFvCV3PdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779094915; x=
	1779181315; bh=68+I6qEthTNpP7lgi3yfO6a4gzUR6q5n+RGYaxnQkmc=; b=R
	gO2nAodoCWIhPfRl8b/M950oTHa8SxDFThPXcVECcs2fdZA/X+5R+3yGZJOg7kmV
	3xxjmi6ySX1mJWxvYOfhZaz4X7Wx71BVUsozzMVs83BtqhoA/j1l5E9s4Zwb2iyt
	Ylp/9sVQqrYpTylPXUJqP6opZT8J5NHBlAmp9Nnb/JfTvfaG2pJyBxVvB90O3IIY
	45GBTETi/gHXjhPQATFhInXns2/+OIFW+aS89H9J1LMBnVZoYoaL0XEvXj1mavIe
	Zj0vdUUarXBtqFt4hg8XM5mMM+M7GQ9Wp2YJfbYG0d0LhkY3IhA+43rODB2adYsi
	4moBREQ/Hf8nOkVn1vtXw==
X-ME-Sender: <xms:g9UKajyv9rBvz3t6zDhnFTQ9xHEYaFMpV-inWClCy0FwcgRiXI0ltw>
    <xme:g9UKait8mj_078KVobgCxoRS_H1J4VNSIwh7ZixWDVm618iWE1y4C4CsmHJWYg9nQ
    QFxlnRfRyFYD3x8nW8d-fxXR-17Bpi5s0bmUCDI9mUeBIPS>
X-ME-Received: <xmr:g9UKaquId9ZF6CSLmbiDJQklGQIzlHo2Hin9U0vgpLpVSB78jxHwPDn5b5qEPQM5qu8m8y5nvL5_3gu2rt8Ur1CTJw2A2O-um6gUV2C7CFhTlkIWKD8kQT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrghholhgufiihnhesshhushgvrdguvgdprhgtphhtthhopegruhhtoh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihguohhnghdriihh
    ohhnghesshhushgvrdgtohhm
X-ME-Proxy: <xmx:g9UKanNWHebmjWRjAiFNXHCaKXKwFHPbiIDXpUYfry9HdOiELW7h9A>
    <xmx:g9UKao2cjixr_LGaF0CQsc7fb2eB7R9a5PkNSLQy9t3iT5vvFGa8CQ>
    <xmx:g9UKajPX7LvK3f4kLWrK_zFApfnOdEXe7nZedfmpyFdgyoAfrS9Muw>
    <xmx:g9UKao18Btj7_e77CeuSoEBw_01gPf_rrGHkRPmsx-wABX127UjRWQ>
    <xmx:g9UKag4I86um5u6Kb__TiocTnuux08OYDa0eUfGfyRsCG3oHlQA8gLbx>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:01:54 -0400 (EDT)
Message-ID: <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
Date: Mon, 18 May 2026 17:01:50 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to set log priority for all direct mounts
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, autofs@vger.kernel.org
Cc: lidong.zhong@suse.com
References: <agYonWw9_WVrWyub@zuko.lan>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <agYonWw9_WVrWyub@zuko.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/5/26 04:01, Goldwyn Rodrigues wrote:
> Hello,
>
> Since the work to have a single FIFO file for setting log priority
> (16ea4156 ("autofs-5.1.8 - switch to application wide command pipe"), to
> be more precise 16ea4156 (autofs-5.1.8 - switch to application wide
> command pipe), automount has lost the ability to set the log priority of
> all direct mounts using the path "/-".
>
>
> # sudo automount -l info /-
> Could not find device id for mount /-
>
> This is because automount attempts to mount and get verifies the real
> path which is non-existent in case of direct mounts "/-".
>
> In the automount program, the log priority is set pretty early and much
> before the master map is setup. So we cannot check on the autofs dev
> either.
>
> What would be the best way to solve this? Should we just document it
> as a feature loss?
>

Haven't actually tested this but it should work to fix the log priority

for /-.

Could you give it a try please.


autofs-5.1.9 - fix handling of direct mount path in command handler

From: Ian Kent <raven@themaw.net>

Commit 16ea4156471e ("autofs-5.1.8 - switch to application wide command
pipe") broke the ability to set the log priority from the command line
for all direct mounts.

As Goldwyn Rodrigues points out the autofs_point structure for direct
mounts doesn't have a real mount associated with it so it needs special
handling which was ommitted in commit 16ea4156471e.

Fixes: 16ea4156471e ("autofs-5.1.8 - switch to application wide command pipe")
Reported-By: Goldwyn Rodrigues <rgoldwyn@suse.de>
Signed-off-by: Ian Kent <raven@themaw.net>
---
  CHANGELOG          |    1 +
  daemon/automount.c |   17 +++++++++++++++--
  daemon/master.c    |   11 +++++++++++
  include/master.h   |    3 ++-
  4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index d6d594e9e..0fc529f32 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -89,6 +89,7 @@
  - do_reconnect() expiry check of dclist BEFORE lookup using it.
  - fix mailing list subscription address.
  - fix table_lookup_ino() fd reference.
+- fix handling of direct mount path in command handler.
  
  02/11/2023 autofs-5.1.9
  - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index 517764119..a01d176ae 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1487,7 +1487,13 @@ static void handle_cmd_pipe_fifo_message(int fd)
  		return;
  	}
  
-	ap = master_find_mapent_by_devid(devid);
+	/* There's no "real" devid for the top level direct mount
+	 * container so we use -1.
+	 */
+	if (devid == -1)
+		ap = master_find_mapent_by_path("/-");
+	else
+		ap = master_find_mapent_by_devid(devid);
  	if (!ap) {
  		error(LOGOPT_ANY, "can't locate autofs_point for device id %ld.", devid);
  		return;
@@ -1548,7 +1554,14 @@ static int set_log_priority(const char *path, int priority)
  	if (!ops) {
  		fprintf(stderr, "Could not get ioctl ops\n");
  		return -1;
-	} else {
+	}
+
+	/* There's no "real" devid for the top level direct mount
+	 * container so we use -1.
+	 */
+	if (!strcmp(path, "/-"))
+		devid = -1;
+	else {
  		ret = ops->mount_device(LOGOPT_ANY, path, 0, &devid);
  		if (ret == -1 || ret == 0) {
  			fprintf(stderr,
diff --git a/daemon/master.c b/daemon/master.c
index d85dd8975..8b7450e73 100644
--- a/daemon/master.c
+++ b/daemon/master.c
@@ -711,6 +711,17 @@ struct master_mapent *master_find_mapent(const char *path)
  	return NULL;
  }
  
+struct autofs_point *master_find_mapent_by_path(const char *path)
+{
+	struct autofs_point *ap = NULL;
+	struct master_mapent *entry;
+
+	entry = master_find_mapent(path);
+	if (entry)
+		ap = entry->ap;
+	return ap;
+}
+
  struct autofs_point *master_find_mapent_by_devid(dev_t devid)
  {
  	struct master *master = master_list;
diff --git a/include/master.h b/include/master.h
index 71610611f..3ca7ad8d6 100644
--- a/include/master.h
+++ b/include/master.h
@@ -105,7 +105,8 @@ void master_source_readlock(struct master_mapent *);
  void master_source_unlock(struct master_mapent *);
  void master_source_lock_cleanup(void *);
  struct master_mapent *master_find_mapent(const char *);
-struct autofs_point *master_find_mapent_by_devid(dev_t devid);
+struct autofs_point *master_find_mapent_by_path(const char *);
+struct autofs_point *master_find_mapent_by_devid(dev_t);
  struct master_mapent *master_new_mapent(const char *, time_t);
  void master_add_mapent(struct master_mapent *);
  void master_remove_mapent(struct master_mapent *);

