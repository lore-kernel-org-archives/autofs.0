Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBE1BFDE3
	for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171387; cv=none; b=Gyf1jOYfzGR1Ves8vT+P0YYdY0Jf05N7Gn18f/BmDiub9XsziW33RCbhnlgpFw2K7maEW90P4sMMsSyT8sHzGnuv+ftat5VhLZfGLwwCtvOhsBFgE7wXQk4vO6Y2J7TRiZNxwyIUvmpyxCm84QRfOWuIWMAWmuE4UH0FW9Nh8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171387; c=relaxed/simple;
	bh=y1dTnlq4OW9UE4obMGsT+qx7oHSniUjZwV8ZJv33aPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxG2A7iDyCYrdyT9Ozs5YrH0qyVSQeiV1vbHgOpX5s5JzibVNZf5UeACxKHgFbQYEinAmrZk5idU6Y1U8tL/jHze6Gm6sGUEYS3x8WaH9W4HBlW4Fde+8aOLTdhUtyeel0loPbqC0ycUa8MN7+YLbItiyYB2bHIFfefBn/n0Z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3Xl0PHK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3Xl0PHK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so186856f8f.3
        for <autofs@vger.kernel.org>; Thu, 12 Sep 2024 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726171384; x=1726776184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ka7y7QYauElCtxf0PGckhaOaKAcUmRSEUuH9zVHmnqQ=;
        b=X3Xl0PHKD5h7FJCMocqB6FFQ9/yjkRThXmidwDQ75PFaWoywHqlCs45QoUGLbv031u
         zf3e+usyoJbUr7y5qmWEr7CYrMW956K8m5/dI4im4OPlhpHoIQOsmsPojYU0VhxOzy2P
         giygEkinnTfVfkzUhjkaARHZfgT4nwKAdp6ZzrI+9z0tJwvGJJnk9Grhc7fGO0/JQfxR
         cwra2WWh/4FGGmcvAArz9rlGqTa71H3rMNR6Ax8urK/2QBOx1QgNmqZlJUmzeltSpNc4
         jTBRNbMdznFdTFjxyJKOIf6hvsewfoCU5g4hdiY5839/zErVzXZU1z/CEp01/aPTYAiB
         8+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171384; x=1726776184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka7y7QYauElCtxf0PGckhaOaKAcUmRSEUuH9zVHmnqQ=;
        b=iO1e91johPViYtInqLH5YK9fVfoWDJTCaP9GwfiKfpxIe5ksjr3LNXNqVOd3+Scfl2
         EgWV1miLukaJlJZrLZPr3Po5rVkBZPuK+fRnKsHTfG7Wox+h5in/LyEI1HD6/5WJbD+n
         8QQ6D1JtK8OUxudQMRjK/Mr2LT3HPM2reCCglEzs9nVHshf0Q/ZFLkvHKsj0L5qn6wSl
         IHyTsJ42zg0DEU1qW6nBZnhphAct/lkX/yLnfnZyk9zXXZGRYpIQ01dUHyrzLY4vyd1U
         09Ql1oqbJM4k8WhN1Ds1uNcmopvuxlHR/ESo1cR3UDvlLCxWXcGUlzbHuuuKQ6yI3rA2
         +8WQ==
X-Gm-Message-State: AOJu0YyMfetk17pRA4/6N+HZngh2Arlfjp9VPdudVOBeExeKM9lteZBE
	4wRqXuO96dlWUsPQCP7xptpzgnV8sYdS4y1p5XM3bFQ8nlGNR/ee
X-Google-Smtp-Source: AGHT+IEwOkdIp8SGUnJ/rr3P/Skr8opYLK8Efw7EokEpGXo9R8NmcNdBvNToDk6FJBz3rTTV35nLxg==
X-Received: by 2002:a05:6000:2ca:b0:378:81aa:2653 with SMTP id ffacd0b85a97d-378d61d49dbmr345712f8f.9.1726171384005;
        Thu, 12 Sep 2024 13:03:04 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c726f8sm788034966b.121.2024.09.12.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:03:03 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 85C5BBE2DE0; Thu, 12 Sep 2024 22:03:02 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] samples/auto.net: Remove mentioning of 'nosymlink' option
Date: Thu, 12 Sep 2024 22:02:52 +0200
Message-ID: <20240912200252.3570157-1-carnil@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'nosymlink' option is deprecated since 61e6b979b441 ("autofs-5.0.7 -
depricate nosymlink pseudo option"). When using the 'nosymlink' option
we warn about its deprecation and to use 'nobind' instead. As such drop
the comment from the sample auto.net file.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 samples/auto.net | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/auto.net b/samples/auto.net
index c5b145d545fc..dc7adf20d960 100755
--- a/samples/auto.net
+++ b/samples/auto.net
@@ -7,7 +7,6 @@
 
 key="$1"
 
-# add "nosymlink" here if you want to suppress symlinking local filesystems
 # add "nonstrict" to make it OK for some filesystems to not mount
 opts="-fstype=nfs,hard,nodev,nosuid"
 
-- 
2.45.2

