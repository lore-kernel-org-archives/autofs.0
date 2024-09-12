Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249F18BBBA
	for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171903; cv=none; b=WvQB3PVNMOtwwid/8RLsDyCLdhX/GrnZAKJOXgNM76gZTM8dDJAVxVpwqi2yNiT++X02M5IXlEe8OSVNjA5YvPfDqU0twgveKZQuIM9UJ4nMlS/u6V0/6xI+1NvE2ydvQL+h7X/mWhvMX7HCoHzRhQe+UiE1aTzltb+juWHssfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171903; c=relaxed/simple;
	bh=0vRv/3PsdZUvsBSYQsLrdk3DUZQujtw8Ldbs4243Jrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYR/vTSTQsZW6OUrCXCFfEwQvV3OsAVMN1WtmsOZ3xeHpLNMmw12sZaYHu2PZQuropv6H54vUuAd0N5o0DjUSNDsysxIYQJNZ51fEb0unD7P9ToLSrWSHdlN0aBcBFqgqpchu5QEotJKCOMrPzinVqLmOD5HNgbXi6T4cvmK+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moTjIKbV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moTjIKbV"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53653ff0251so284804e87.0
        for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726171900; x=1726776700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5BBZ1GyJoK+FYv2zy1JQBkf2AcLPIk/pO9g1egDix9g=;
        b=moTjIKbVOyUB6jqxTELiFoZbizWdvLmwyhNzmRBBYIYm6XbK9awXYucmk0nFrbEvb6
         gzvXZUcPTfuW9pKF9I71ow/ZEFxifVt73fFmW7JY+ZsSS6hJGi4MHomWx9jcKjU00+hG
         ZC/rfS17DlK/5fYbuAXNE9UnDbxTy/5g2yY16Da3ktiI5FX8v5HQ87P4Fk6q9s5XF/TW
         lRp1UoihVp5vvu3p9W3b0StYBHM9s99zEoGadsxKtlPpHLbH/UjrO3tm8k6vLRlSxAiV
         75EfS6E3aD6tuVGbuzgT3XeMtYVn32Dgvsm31x48jhCUXbJipjlhN/bjQgJEnR7Ng8Vj
         KBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171900; x=1726776700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BBZ1GyJoK+FYv2zy1JQBkf2AcLPIk/pO9g1egDix9g=;
        b=nO4aSokd49Dhj10bFEc2bbkGwHDqwSk/+oxO08ZnTl/IPb/sJbaLaST5Ubd1irg4W9
         GUIO6qv+b3fhilxdNpgNvHLH84l4OvAP7fhwVFDOwdGZASXvJ+MWTI6bCeACCHYV7S9N
         g6dRTCu1ussL1ufwZDp4Lm5ERvChwh9BBJVVxKoggaBUDPHWcKz1YDRDNeXRgSnfQP7G
         u5uxpeJlwTsERS4qh+6AakH1hbh99xvUaKzjd42rExmGNeuQDq/ltr7Xo12L0fe+bR9Z
         9JJTrzsPTxGFNkjMuOW8LOnC6ssG7az4KfM63eDBY+L/WlgmQcTm+6W8P8jHqUD72r5U
         4BmQ==
X-Gm-Message-State: AOJu0YzXlRMmttKGKo8XXCGXsVEYHKD7OzhNMO057Pje/ziGD1KRTNZW
	r1f6xbFf5hC5D9wDYhKlNSnpm9hCmeFLjMPnE8epR4/Q7L0c5L3F
X-Google-Smtp-Source: AGHT+IFxYkv+u3zpiX1unO5qPMNmUrmOhiogGCaWVBfBdbEFjC34FbDuGYErD4gLFDcQOTTU50NmZQ==
X-Received: by 2002:a05:6512:2207:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-5367feb957fmr236698e87.4.1726171899717;
        Thu, 12 Sep 2024 13:11:39 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c60f0bsm786097066b.125.2024.09.12.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:11:39 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 38343BE2DE0; Thu, 12 Sep 2024 22:11:38 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] samples/auto.net: Remove mentioning of nonstrict option in comment
Date: Thu, 12 Sep 2024 22:11:36 +0200
Message-ID: <20240912201136.3571920-1-carnil@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 8e7823c2a317 ("Make nonstrict the default for multi-mount map
entries.") 'nonstrict' is the default for for multi-mount map entries
and the '-strict' option was introduced in autofs(5).

Link: https://bugs.debian.org/603091
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 samples/auto.net | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/auto.net b/samples/auto.net
index c5b145d545fc..5635c4344b3f 100755
--- a/samples/auto.net
+++ b/samples/auto.net
@@ -8,7 +8,6 @@
 key="$1"
 
 # add "nosymlink" here if you want to suppress symlinking local filesystems
-# add "nonstrict" to make it OK for some filesystems to not mount
 opts="-fstype=nfs,hard,nodev,nosuid"
 
 for P in /bin /sbin /usr/bin /usr/sbin
-- 
2.45.2

