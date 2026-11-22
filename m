Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.167.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795322208;
	b=oJMXSKYHNlo3C+3ZzN0ppJ1SejdtUDG9IPUdGzu37OxdBcAtncwqHK9qfcfGnBS0cd5+
	 WuwX3YTsmQA94KFHtf2luo4tpAiRY6iIYu7SaHrzEgaBQrgcmT+67KvH7aTpI1yOjtxSX
	 QNukBIZ+btw4Yo7bxuVisTKO/VNGjm2Ya48VA173cqp8QEUhBMH8gnRag3b3h3vuQcy35
	 PoAQfZYviNOpCSpVgQvL1uoK1ty9qCy+Luc7KpT4QWGrZEau/c1wZMK/lMjBOevFt/dZf
	 +jle8Vp2/cVG+vHXfRHLIa2iChBhFqVno+tAhctBbGQO0xTiFGisWgKZhV5qtIugcag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795322208;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=giH9R+gmvRzh9Dj5Z/v9KXsiGv45j3sekQkFQo6OB5k=;
	b=ToHsCJUt44SMkKuals+MfT6zJfd29fe8HtnCxPtOavMOlpWCW8wyrSFSkB5ud8uEc24h
	 iy0Pjzd75Oy0PqCDJUDK7uYZWpbB+nf3pdWb7IdGH5lH+ktlgeNKHpgMX3EexgqhWPCr4
	 w8YGdoyiDNsA226jhRDYKyktQDiNDSjuycmtschvlKPbZZ0UWLLV9fEKz+TrIucdr69Wy
	 VOYEgzkmSZG1nEi7SeZRDBRHx58Wd2K3blfV2oy4Rcdn0hX+XfMuCCav+/ybyIjEtKovN
	 A3RGHroFa2IElCv4ioaqFyTrbVwJ3Jd/F20fuykGBfA0Dcz9NKAXU2XENvEoC6v5Pnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=moonlit-rail.com;
	spf=pass smtp.mailfrom=moonlit-rail.com;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=rsa-sha256 header.s=rsa2021a header.b=UGS5jbR2;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=ed25519-sha256 header.s=edd2021a header.b=JnCgF9A6;
	arc=none smtp.remote-ip=45.79.167.250
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FC606A320
	for <autofs@vger.kernel.org>; Sun, 22 Nov 2026 04:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=rsa-sha256 header.s=rsa2021a header.b=UGS5jbR2;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=ed25519-sha256 header.s=edd2021a header.b=JnCgF9A6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=giH9R+gmvRzh9Dj5Z/v9KXsiGv45j3sekQkFQo6OB5k=; t=1795322201;
	x=1797914201; b=UGS5jbR23Yh+wz1Pn6p6mfaKFwdMa1gZbDOKyLt9IB77IWJIsXx8HCtO3y3vR
	peC9PwiA/O9kj7hZQOziNd4+VYu/SYSUVWbkuhI6YNen1ThwDWboeyfxsrGJdM9wflyrZGq4pVjIE
	UaroGkdgiXqeo9K9/GnZc3ZUgEcxnHQAlZcbRz5ugfSdBmrWTrS0KIpPOmLTkF3PkKg3l9UzTPA/g
	YoPp5RN3w6bJuHV3QFDmD3aiCqolLya1jW4U3/lcV9DWDwRgHpP/WF4M4SD9xHXnAvialjIBnLOPN
	VPudxZ/jtpE954TqzRAJD2Rv7vbpKJYr6grbSKiS6zoKFL81bg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=giH9R+gmvRzh9Dj5Z/v9KXsiGv45j3sekQkFQo6OB5k=; t=1795322201;
	x=1797914201; b=JnCgF9A6rIbw+fxk7qiRbEzitwWa7S2uwLr9DCCeY8CFbARY6OGcrebUMNAiV
	FVCrbm/UQ7nJa/1pWpGbzHXCA==;
Message-ID: <6d9fb16a-b705-4fc0-92ad-2d68eb7ffebc@moonlit-rail.com>
Date: Sat, 21 Nov 2026 23:36:40 -0500
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in 5.2.0, SIGSEGV in master.c line 619
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
References: <4c791661-cdaf-45fc-8c1d-1a2d8a9b48ae@moonlit-rail.com>
 <d078dbfaebb342300ee8d89526afdb81b28c1197.camel@themaw.net>
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
In-Reply-To: <d078dbfaebb342300ee8d89526afdb81b28c1197.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> Sorry to be slow to get back to you.

No problem.  Thanks for the patch!

> If you can, please test the attached patch so I can move along the
> posting it upstream and committing it to the autofs repo. etc.

Tested just now, and it working fine here.

Kris

     ~/autofs# automount --version

     Linux automount version 5.2.0

     Directories:
             config dir:     /etc/default
             maps dir:       /etc
             modules dir:    /usr/lib64/autofs

     Compile options:
       WITH_LDAP LIBXML2_WORKAROUND WITH_LIBTIRPC

