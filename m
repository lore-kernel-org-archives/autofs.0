Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F411BE857
	for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177741; cv=none; b=KTxAr4lv+XofHHpryttdhGkgFgSEOiUvVOhCB0aI+YHky4bDfmeDllOLggbO9yHnYr24y0jCStFF/TeToX0a9NiA1mbXlTgPyRExnpMvuFsElBpxl4EUEReGsbcS/mgWtiZrSf2LajeSmBHCq3Tg00d2rdEkeh2nL83QAaYOlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177741; c=relaxed/simple;
	bh=A3kXMnRCd6iA+9Q1YUeKkOSjsCNckFTGNyUWObsLFUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCPXeTYoHsCyUr10A5xI5i3ICXDjTFPo2CzqE42917zDsuL3VjP1fViKcP395YmAFZ/GP7MRARZUVBHgQbevQGTq2FZSIAvuoLNKH7K+eNcS1VUXP1Ho3NOIYD6xRKbBtC0Nl9gTEcodmkY4IkIEj0WCrQLWenKucY+HIBUwPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYQvb/3f; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYQvb/3f"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so1868829a12.2
        for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177738; x=1726782538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LmphLjy4FI+CYhnqweQ89KePE0/Vpkw200LA/S39w9c=;
        b=fYQvb/3fJwEfhg4KhRoFtg89JSJ2ua3F/xrQ34lqGwuv0+99bFf3zX/Ql3KmKFMcFo
         ldVANdiP7TdBsX71c365kTk/XuFq0xhhHkOWAcFinjbaetKSVe1/yZP08wdtokts9hZW
         GTH0HimavKVM13jWIibxgqIhj2kO7dl0fbaUSDbGuFSJsUfUqODleAgUQ3+8dspmawx4
         ph663Ey4I1ucvNJK7odiinBzj1B22Ba/sdKMNVSE8c0Exa8Gs/sl8HEDP2HzSoi5oBhT
         yZTOMPBIBLeUf0i1tm4yKxYGLOyJQsc+FmtO/LBVefv9ffClb7ib3hpuZ0E/pYnSnksn
         Y5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177738; x=1726782538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmphLjy4FI+CYhnqweQ89KePE0/Vpkw200LA/S39w9c=;
        b=HJDzrpAzIiHs8SYvo1S0I1yIICCqIRbszYCtuQ6DFEqkOx72uKxy3fAU8pRSh8iqki
         IDxzr18b2Wo3Q9sbcZulcHq/fDrTLdXCADRsr53HOtEEQtm64qjhBzP19GsL2EQRHKgV
         MhBv9A56me9Q/iXNS+mdvzo2lnYH41ssLhZ7KvEPWJT+0SusFEk4hLW5jiiQxgBz7V3f
         aK64l3SCLZ9n8hNU16cFAcsWwnL1Ze6QMUtKuSjcFC5+xtELMsg/Z+ZhnmG5bSCn0PVJ
         RlaZPW5XktDJ/FmhooLsONwLN1nMThI/pMtAtKDYKkUYs11orezlgs0C6HzJ+LFIYKvM
         kB1A==
X-Gm-Message-State: AOJu0Yx4R90qeQ8uC46ykDjX7U4QsB4E3CnykWbLhXF/tEB6TZQwOfeW
	EchDS8BhZnWMAPenpXXa25FWzCtOYZXXxBtM0/n19YqRZ6iGuxXa
X-Google-Smtp-Source: AGHT+IHzKj0nY0JzIqenC+4upHsMwwOkTgm47DEj3DwwrhqMo0+38VIc9EJwyhdUagmA4MTofcuBlg==
X-Received: by 2002:a05:6402:27ce:b0:5c0:ab6f:652a with SMTP id 4fb4d7f45d1cf-5c413e06ca6mr3179301a12.3.1726177737645;
        Thu, 12 Sep 2024 14:48:57 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cd43sm7020684a12.93.2024.09.12.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:48:56 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C0208BE2DE0; Thu, 12 Sep 2024 23:48:55 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2] sample/auto.smb: Use AUTOFS_ prefixed environment variables
Date: Thu, 12 Sep 2024 23:48:31 +0200
Message-ID: <20240912214830.3586792-2-carnil@debian.org>
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
Changes in v2:
 - Fix typo 'prevised' -> 'prefixed'

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

