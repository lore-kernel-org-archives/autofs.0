Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1147DA9C
	for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177535; cv=none; b=X1OEP3iT87R3XzPW+LUPlUFmXncKGBgkRYMZpWyPkEqzKdXVuuPlkQbQ+aHjgm7lCGIiVBk1bXi5CNc4yrBLCI2uJ+5heyIyPDG9IQsLjaAyVs0D+LlcJoRrWaYLORdvqwrDpQiPy5hDWIJxNMyGzwMal93ONB6DF/WfwqS40i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177535; c=relaxed/simple;
	bh=pzfKU/0TA8MwrO3YQSE73IF/qF9RRSG7Y2uMgwRSdI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nI5+lHNTHyfAkMVpL01w9M6ppXq3JVngzuf+n8YpTSC6wMivvZGwPJMsVMcSawxO3wytmfYqeI/8Wb22xzGbYbERBEu7klo/6Dn7/BCUesGGAUjnU0A0ZqRWjlRwqF0hgQxryfgfwL5uqutZSf5MXgjRVtFizi5S+8Tt7TAhELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHCPUC9x; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHCPUC9x"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53659867cbdso409964e87.3
        for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177532; x=1726782332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5ObH+aPY1Wo8LjMBkDtC3K7EZHKERSYDEW5fNJE8Aj4=;
        b=ZHCPUC9x3gLe1ejnp7UMiOrJdo/dfX5E2g+1S8heKtzpA/WxV4Sgiz8aYdDE1KWgZt
         /afpk8Lr9LDLKHEf8b8BV1SmEk6eDr0fnthuB5q4EsfOc71ZHVd9aPp3m0fKkvsFxTpc
         GPV8pgwsd/ge6mNjZtAU4bYcTxl3H7HuXDgVfEbSvOh/pSlWmjH/8v1zUa5/VBzzLb9a
         xGuNn8Wbe8xgjvQN1g+zIxNTurR/+nGW7LsEmHbYPZ41eWLb7p4c+cwLDGxKmxJpGqDp
         qVwXlargBQfIXIfB/CC1ymzW7fZSolnd+SRs2zy3XRetiVIsFn2YBEp/o9Wg5wxAPUJ9
         sfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177532; x=1726782332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ObH+aPY1Wo8LjMBkDtC3K7EZHKERSYDEW5fNJE8Aj4=;
        b=PF4pSQ1RWiIQuwmUupxFwhA1a5+uzlQ0u4+mzT0dkRiTOHWNFEbB+ZaFdYNtf1bx/S
         m0PoJl9OTFKTLkVF5SYb3CmTwggd8Ra4TeJXXHnxszCG+QjiXFZrH8+nlTJ74v5pVxKL
         XpPnRD56DtOtcR+4v5MESrv/zKu8cmJoEqONBSS3w6JgrTdSudLsg4oolHm0IL6UH54m
         aCev6a2armt43GC0qcSkAJGTKpl+b7bx7K/i1335cxe4ihJxW4ouzVc+DgYYlx2uRDqO
         QzewSgwChOj5Fb4fNRWR8ZpAAQBbLV+rwa/yl100gZsgz7dSPHMteTWqYyKyaYeL78V9
         7ADA==
X-Gm-Message-State: AOJu0YzW/nS3DdYROiS+BE0S8IAHTxbolc2SYF1a6RLWdGEr7EG32VSz
	Pk/YtzDy/DccgEEecBoax4SekNJAZ0MSaCb3GAshDpOEu2sKeJSYZSoQJfNG
X-Google-Smtp-Source: AGHT+IH6rB1plFxmiWvSS/sceG7mwkx8LQXPZidIm6jrh9XZY911fuZM/oYrpTwbAih3l+ub3GLKPg==
X-Received: by 2002:a05:6512:10cb:b0:536:5625:511f with SMTP id 2adb3069b0e04-5367ff24cabmr473826e87.45.1726177531747;
        Thu, 12 Sep 2024 14:45:31 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced41esm808379066b.171.2024.09.12.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:45:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 977C6BE2DE0; Thu, 12 Sep 2024 23:45:30 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] sample/auto.smb: Use AUTOFS_ prevised environment variables
Date: Thu, 12 Sep 2024 23:45:29 +0200
Message-ID: <20240912214529.3586463-1-carnil@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the default value for 'force_standard_program_map_env' from
autofs.conf(5) is 'no', for a program map that uses the UID and GID
standard environment variables they are prefixed with "AUTOFS_".

To match the behaviour under default conditions of
'force_standard_program_map_env' use AUTOFS_UID and AUTOFS_GID in the
sample code for the auto.smb program map.

Link: https://bugs.debian.org/949075
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 samples/auto.smb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/auto.smb b/samples/auto.smb
index f6d41d35f121..faa5a0acebc6 100755
--- a/samples/auto.smb
+++ b/samples/auto.smb
@@ -24,7 +24,7 @@
 
 get_krb5_cache() {
     cache=
-    uid=${UID}
+    uid=${AUTOFS_UID}
     for x in $(ls -d /run/user/$uid/krb5cc_* 2>/dev/null); do
         if [ -d "$x" ] && klist -s DIR:"$x"; then
 	    cache=DIR:$x
@@ -53,12 +53,12 @@ done
 
 creds=/etc/creds/$key
 if [ -f "$creds" ]; then
-    opts="$opts"',uid=$UID,gid=$GID,credentials='"$creds"
+    opts="$opts"',uid=${AUTOFS_UID},gid=${AUTOFS_GID},credentials='"$creds"
     smbopts="-A $creds"
 else
     get_krb5_cache
     if [ -n "$cache" ]; then
-        opts="$opts"',multiuser,cruid=$UID,sec=krb5i'
+        opts="$opts"',multiuser,cruid=${AUTOFS_UID},sec=krb5i'
         smbopts="-k"
         export KRB5CCNAME=$cache
     else
-- 
2.45.2

