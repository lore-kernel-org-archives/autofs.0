Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A32E9ED7
	for <autofs@vger.kernel.org>; Thu, 21 Aug 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763786; cv=pass; b=B3Fw133caPTJ6geq+nUSABAwfWXC4pnO5HPTdlUOYzcIYGuDk4fENIHdEHuIcTDQEDoHFap20EDJeOB/2fH+umm8QkHorU5uwTbfj/dMTYcDpRgWXtIAsxQhuN1KEVjq4kROoARi74GLV8/OeKMsebXP9+AyP8hcoL+sSAdVgkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763786; c=relaxed/simple;
	bh=ByIlTuut10mitMJ5VgXN30BouWWoxM56LFqXsOv6Oco=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=miXtn2ovC6rvOYw+I0Vtlx1APyJ0sIglTwWU5PIo3yfiSUdJ918EEv2+V5yUwXw9/5sgvgxQ1XW9YXIl/jBN+r6pmT9BRZlU30tANl+vf5G2pQIfXoMA+tPFBFud0ob2uQA8JbXi2+tOyTmwwAnXZLNWnFBpddd+FLKZNo4Mqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=c1XQAWIl; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="c1XQAWIl"
ARC-Seal: i=1; a=rsa-sha256; t=1755762840; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SIwZiQ/wOi+VfCzGhdLbFu8vzCTxN9QfBq5F/xmFQ7lEkMb8u/gZ39IKLfXwLowtrlUub7VYpRdWJJIitmoi6tBlCLcu78l1u3tYc4ZVS3cBd4RW4Qdsy4kgtizdGSMbcWkqSyrODynGGjCQXOCrl9NpZpmugGzy473JQzRPLhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755762840; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ByIlTuut10mitMJ5VgXN30BouWWoxM56LFqXsOv6Oco=; 
	b=QH4dG4wvaXGHeT+V6nVHNW23P66rhv04My9rC9uRMV/TogzQIagSSqEWBianw42wDYgmntq465CDBb412bt33ufywKgcwTrG059JXcQr89m35rRrlQE9N8mV2eZLC6wIOrhFRb7vWez6Lp9aAWW2L0g9W565QMNbr91TvIKzV3U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755762840;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ByIlTuut10mitMJ5VgXN30BouWWoxM56LFqXsOv6Oco=;
	b=c1XQAWIl1TRYJtK2PcZnD4IdXQJ8yWEja40d8vwdd1IsCHBOI6CPF81tS19ZgBvI
	35BVnJcnp8py68EibNkkQwjItogp+VDfibqxrysy/mHtxVCEmGFbfLmX8wFD4lLvUVJ
	5mhG5GCmtpipOxIKxnVe1uAG7gR2xGX8bSOCfPbI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755762838350148.54268594130883; Thu, 21 Aug 2025 00:53:58 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 00:53:58 -0700 (PDT)
Date: Thu, 21 Aug 2025 11:53:58 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Ian Kent" <raven@themaw.net>
Cc: "autofs mailing list" <autofs@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"cyphar" <cyphar@cyphar.com>, "viro" <viro@zeniv.linux.org.uk>
Message-ID: <198cb9ecb3f.11d0829dd84663.7100887892816504587@zohomail.com>
In-Reply-To: 
Subject: Serious error in autofs docs, which has design implications
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227b2d2fca8b18d2b918a7a07350000d02a1b5b4804ed5d9cd074adc6e811c1276d652845d7662084:zu080112278e8398b6583a74f01e74011f000082b712e1f9b3cc5761894bdda92474ff633a4d06199a7ae9ff:rf0801122cdc325dddc41d7172a753f6fb0000aa9258eb201d4c47637105abbbd5245d9aae768ee31be6bdaa69532943a3:ZohoMail

Hi, Ian Kent and other autofs people.

autofs.rst says:
> mounting onto a directory is considered to be "beyond a `stat`"
in https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/filesystems/autofs.rst#L109

This is not true. Mounting does not trigger automounts.

mount syscall (
https://elixir.bootlin.com/linux/v6.17-rc2/source/fs/namespace.c#L4321
) calls "do_mount" (
https://elixir.bootlin.com/linux/v6.17-rc2/source/fs/namespace.c#L4124
), which calls "user_path_at" without LOOKUP_AUTOMOUNT.
This means automounts are not followed.
I didn't test this, but I'm pretty sure about this by reading code.

But what is worse, autofs.rst then proceeds to use this as an argument in
favor of introducing DCACHE_MANAGE_TRANSIT!

I. e. it seems that introducing DCACHE_MANAGE_TRANSIT rests on
wrong premise.

Thus, it seems (from reading autofs.rst) that DCACHE_MANAGE_TRANSIT and all accociated logic
can be removed from kernel.

--
Askar Safin
https://types.pl/@safinaskar

