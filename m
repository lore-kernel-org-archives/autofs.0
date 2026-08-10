Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2C3C37B3
	for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362598; cv=pass; b=UBZRRh07YiFXdgIi2yIxGtE6BMpzzTQjD2s0bTZ0qC5GVZRiyDb7DlcXjMgHflrV1kjdp9iVDA4uxLtzMCiGqTLKv4jPBPQm9cKRrWXMTfgYkfgZlWtRYP5NNUKg7c8VqpM38Dd+OxpSwZzokiXiUUpLyFDM2clm33OdF8Q9KEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362598; c=relaxed/simple;
	bh=bqxhj80OHCfs2l0pmZXo9T6EE/Q+XSI4ASVci9J8bsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YudJwXs3eDRKF9EBCJwAFJiaMpD7PXpwVf66RHbGnMbZcmlHwkEaMeuYU4G9dmjlZR/abs78JjWAbtcymV9YJyFAuKZNY8hZwRvfnGAHivWq7jt/CYf+urrpihzym8jVjwjQUae6Ky2ViaQLsVzW8f2PWQMU9twN5kYeex/xSlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JbIlTHjY; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JbIlTHjY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930f618435cso95121585a.3
        for <autofs@vger.kernel.org>; Mon, 10 Aug 2026 04:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786362595; cv=none;
        d=google.com; s=arc-20260327;
        b=ZP9kRXJy0evqOEVesV3A97oTjp+iIIOCopVeDvdILX4AauQtle9CqFD6X9ZqzVMBGn
         1dGiorihyMy7Ytm6sSx3dNNhRuGISdYO3HNFlBxAOOwjbk2DMchL2JRwHSP8B7o06sWB
         Ayo82bxUKlchf0eb9gXdYnGY6vZ06OWJfjJzYgTy/qEJdeVuF7kOEh5kaZHrqiJjtVWx
         t9cLE/amwz7QKDuCBeHHN492r+Ot3WCo1QsaTyRuLAPhAfo8YKhYc9GOBRq7pcbiuJ+O
         gP3D5omTDFZryUnUJxex1naXD90nAZTTHSPrso4UsdQCaFRhuTCABdHIatT/Fo0e+rNj
         22NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        fh=b7ZkR2Wf5E0h1eWiWX5IG9gVxqLIQubZabFpRQSRrog=;
        b=o63vMeo/kup727KvcXZkvZCLwPHXIBenuy44W34xH+YYBjBOCcWf/55K/uyfhVK5UJ
         wQmc4DMEgf40O+9tt+lrcF8pGEnQwV2/oUUvTiWr6QSGzm/2hVthSSrgEOfxVG3JSZGo
         vEHAX2kZZlY1H2NUyjHS39TWzgkGNALc9tlv6TU8cUjAe+YZz0fcwvvRx0W/Ai4PenLz
         D0FcpI17SpohqmiUILH731uA5/3lrv0q67Sth56576A3G/jf9RH83bKjz2dCqhHOpVl/
         GBe+8dlceIxKrSdz0cE5fNlLDAsadxYo89pW3/AWyvg1+MIYavbm/1a5QbrFcY2E3YVA
         7lUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786362595; x=1786967395; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=JbIlTHjYRbq+ZIsCxsszUYyLNHxgDCPjN9Ma1WEhKH7MRmWe7joIBbYWWomP9gcZOk
         LFfIYMBfmj2D+xlKmRu9u/RX7WEdZqwmK+o11C1r04InwcwfFNVdcqh2Sg5WKYqi1/Rt
         KFQGIwIBoE4APpF/F9Jcwrx5z06thfkeft49Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362595; x=1786967395;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=KbdeJX4Bkk/gxKKoY3JM+wrLGYgPRuQZE25ybTy1oD4I256n2AVzgaCuqBTAxDc+YQ
         JVVAcXNelTLkgV9PyivvCbJMcn6q18bxeOOd2G07mQPOIfTljPrYeOngbfUXN3nymWz3
         +5FjWP1k27Ns2yege5I+JeP0+fwa/Rj77jgCxHhI8b6DAApaNcvbxiEZxOy8jr5584/K
         KqKXeBmh8j7xXuLrUdDmssW7KzdYtgqhBeTC6iC+JlCryhzQjLGpIf87GZ+1QQ+VB3cF
         buk7vIhNpj3OdJsOcSumDnAZIKKnobZzRqj/iJLYQQPPRuG9Ad2jqDmKiQlGmZJsYTcP
         BCzA==
X-Forwarded-Encrypted: i=1; AHgh+RrEnAH+IKBC1WKXXNR1o9EIlDh4DhU+Do3fD9BQ/l/0mU1mho6igzweSTu3tzWYOeAE89XhQs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOT7mKpfaBcm9dikAOomzJjh5/k8hCUIJAmbwTrUxAfI1Sz11q
	YYcxJR79BknOrMh5/Une3PLe3c1F0bv85csrCzun2+9s9pCGpttLfZ/XW06/Wo0mZNvlz7VDq6J
	nYg28+PzhMOA/z7Mq0XcomHdi25bomV/YFYTxu66jFg==
X-Gm-Gg: AR+sD13y6lAtuf/zoRwdBoWRVNMyLQUZA8dQ3UDAlWdGWmKq+DipROIixWtEIHfoJIp
	MdAIU4CJ262m6JsY1054R0L7tQKpv3lnC0A9A6FrgCariIetmg2C0JOHJlQcRpq7USfOIjn5P4g
	J4AYgVDECayaSv+K2ZGeXEGDKc35xlOPxThQiQNKdV3R3GYyny4rSWaPO5zbZjGZf1t/UW41aDZ
	UhATkd8X5KzIUQwtlGOkdbVTG8JxiqLFuLplEIdz1rcnxJ/7DHVVWqjQfqZIEsdP1qI8MhiwZIi
	CKPN1sjOPrDkC7/QUsD1X4u5hl4TQbIKhfoQwVhklpBS0FWHXkvrDo3hV438e+qeBaBj2jhs4RM
	=
X-Received: by 2002:a05:620a:818d:b0:914:bf8a:ba81 with SMTP id
 af79cd13be357-9369d1ba3femr59440385a.27.1786362595054; Mon, 10 Aug 2026
 04:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-2-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 13:49:42 +0200
X-Gm-Features: AUfX_mzmgezsTeEsc_HIV9oG5qNwHpchZPEJUwGx53Ztx5haBzb4JhKil_bknQc
Message-ID: <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eb44720658aff3f2"

--000000000000eb44720658aff3f2
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:37, NeilBrown <neilb@ownmail.net> wrote:

> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first and so never needs to adjust the refcount on the parent.  If it
> remains on the list until dput() it could be the last child to be
> removed, in which case normal handling applies in dentry_unlist() (where
> it has been moved from dentry_kill().

Not handling the parent refcount together with cursor removal can
result in inconsistency, e.g:

 - add cursor (seek between two positive dentries)
 - remove all real children (parent refcount not touched, since cursor
is still on d_children)
 - remove cursor (seek to zero offset)
 - close directory (dentry_unlist() will skip parent refcount update
since dentry->d_sib is no longer linked)

Repro attached, produces "BUG: Dentry ffff888107ef75d0{i=143e,n=dir}
still in use (1) [unm
ount of hugetlbfs hugetlbfs]".

Thanks,
Milklos

--000000000000eb44720658aff3f2
Content-Type: text/x-csrc; charset="US-ASCII"; name="rmwhilereaddir.c"
Content-Disposition: attachment; filename="rmwhilereaddir.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msn63w320>
X-Attachment-Id: f_msn63w320

I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgoKI2RlZmluZSBDSEVDS19F
UlIoX2V4cHIpIFwKCSh7IHR5cGVvZihfZXhwcikgX3JldCA9IChfZXhwcik7IGlmIChfcmV0ID09
IC0xKSB7IGVycigxLCAjX2V4cHIpOyB9IF9yZXQ7IH0pCiNkZWZpbmUgQ0hFQ0tfTlVMTChfZXhw
cikgXAoJKHsgdHlwZW9mKF9leHByKSBfcmV0ID0gKF9leHByKTsgaWYgKF9yZXQgPT0gTlVMTCkg
eyBlcnJ4KDEsICNfZXhwciAiIHJldHVybmVkIE5VTEwiKTsgfSBfcmV0OyB9KQoKaW50IG1haW4o
dm9pZCkKewoJaW50IGRmZDsKCURJUiAqZHA7CglzdHJ1Y3QgZGlyZW50ICpkZTsKCglDSEVDS19F
UlIobWtkaXIoImRpciIsIDA3NzcpKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2ZvbyIsIDA2NjYs
IDApKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2JhciIsIDA2NjYsIDApKTsKCWRmZCA9IENIRUNL
X0VSUihvcGVuKCJkaXIiLCBPX1JET05MWSkpOwoJZHAgPSBDSEVDS19OVUxMKGZkb3BlbmRpcihk
ZmQpKTsKCWRvIHsKCQlkZSA9IENIRUNLX05VTEwocmVhZGRpcihkcCkpOwoJfSB3aGlsZSAoZGUt
PmRfbmFtZVswXSA9PSAnLicpOwoJQ0hFQ0tfRVJSKGxzZWVrKGRmZCwgZGUtPmRfb2ZmLCBTRUVL
X1NFVCkpOyAvKiBsaW5rcyBjdXJzb3IgYmV0d2VlbiBmb28gYW5kIGJhciAqLwoJQ0hFQ0tfRVJS
KHVubGluaygiZGlyL2ZvbyIpKTsKCUNIRUNLX0VSUih1bmxpbmsoImRpci9iYXIiKSk7CglDSEVD
S19FUlIobHNlZWsoZGZkLCAwLCBTRUVLX1NFVCkpOyAvKiByZW1vdmVzIGN1cnNvciAqLwoJQ0hF
Q0tfRVJSKGNsb3NlZGlyKGRwKSk7CglDSEVDS19FUlIocm1kaXIoImRpciIpKTsKfQo=
--000000000000eb44720658aff3f2--
