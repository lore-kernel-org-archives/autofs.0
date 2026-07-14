Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406830AAB8
	for <autofs@vger.kernel.org>; Tue, 14 Jul 2026 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006122; cv=none; b=ZdEr2qpDESwPYSzwTyXj8Yc7ahtx9CZ4/j2RTFO/db140I5mWXYjKToco0RMACiKfzI0Qt3UkjCB+mjx3B9jGrlNBWNJv2x4YKTCVeqgkXNj++iWoHpi2dZPmE5f9eIqCbBNeNJ88sXD2nntrdq2ZUBSQq8iAFs2RfMdkdt5mcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006122; c=relaxed/simple;
	bh=5OJcpnIFmBEUHpJSFfOi2cIqrhpjDJBmioY4TC1OVsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8QC74cSiExeEomikX8w0yIP1KrDqvvp1JtWToBD0YgKVTjoWZU5pmRPCTp+uCa1GYQqKtVTuNMf8vHVSGhqr+sITzjAjSBwExIgNj/gytGQV7ZAkz9GOYSTBYT8tX3p5muL+RCI84SSQPDT+Q59ley2DHtWWHOpUqkvL78i1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=bJZlIUNw; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="bJZlIUNw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5OJcpnIFmBEUHpJSFfOi2cIqrhpjDJBmioY4TC1OVsY=; b=bJZlIUNwL8Egc8o1jj6Jm+dhJd
	3mDR4EWFJjB9RgzdCnnBlj6tmeb1sWgVe8Sx0lmuq0CKe+FKhFFvfuPBfYFgGqnCfNIw8PBB7FXrn
	1o9zW2d+smxEtp6QULAs5dIdG186fuUDxCkPJmq44gFWThauVvYSMTEWqUeoilCQzhmBS981GXvR6
	6mR2A7AxIEMpgAmLgDfuO+6rj95MTRf0hPob1ham99S4VtixwaW8xUXDLX7ThHBEwC4qKX+manbhG
	jhk2Xg5tKrQphUhtwKsxjozEIRisw1y5WBwL/rAECAh8l0hPTMQvdxcAMgkSdNQqhekukiOe01zL9
	cSSA9rGg==;
Received: from [207.189.26.187] (port=60603)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVUE-0000000FqqX-1iP6
	for autofs@vger.kernel.org;
	Tue, 14 Jul 2026 12:15:17 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: autofs@vger.kernel.org
Subject: Dear autofs@vger.kernel.org, 
Date: 14 Jul 2026 00:15:14 -0500
Message-ID: <20260714001514.9694875E7E705CEA@inbox.org>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day autofs,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


