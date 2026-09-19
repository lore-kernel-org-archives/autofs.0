Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CA3939BD
	for <autofs@vger.kernel.org>; Sat, 19 Sep 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850892; cv=none; b=f9B2O7IEwifdlH5nwDeL66Vyws12l8+v3vMaRp9DtcQVsmRne/8pRdiqemelBC2DPdVX1R4RCReXMNNauHWol1Es0d5wLleS8NdwMJ6zGG0jB2ncIWuStbrtdteG0Vg61ivi15sQ6WK5IdRMeQz6gu9qUNOJID9ulsxMV13Gjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850892; c=relaxed/simple;
	bh=WHFKCdJIxJZts25V574gufTxt/e+kvWyiWNqWg4+FaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jku2IwFysjhDc5R7EahepfT6b2W1r24RWlwg/0i+b06M5u3zP0PtXWDRjYacW3dNfaVYkB4CIIUlz9a0F6LxHKHMCd9kPrc++EjnJWv448DOpizyAfJVK69YDbTGP+zdg+L9vOFSE9DZr9alCzqs9LVAOJ9/V3lMo/jCjHTxpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb0SpgOk; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb0SpgOk"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1629149a91.1
        for <autofs@vger.kernel.org>; Sat, 19 Sep 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850890; x=1790455690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UklQyeMvhqLuej0je0ggi0hTj3VJTG/i2EoA/FxL8jY=;
        b=cb0SpgOkmSpx4HbI+vXW9P+Sy8sbUPwjOyXOs8dOCOqmceKIRpPDLumdTUjeuMK/Lo
         EDPOvc2eISYzH0sl8SQ35AGjeSqBz6FIbbKf9xh+Otc5xr7tqoo+HtTtIPIDM2LxK4Ct
         +J9kLPVG2pOyxFnD8hWZtW3JtY1Wo6t/oddpt2SJJUEWTAko0MKS3KStTcf0mNe4aP3O
         HHKeAFE+1/3Elb3vT05k0XiHZYHZ568cbiHHPOQER4GljuNlvNPSJEBjSVMktkz2EqjI
         FVOTyOrTImqq6fUvwB9vTHudhQvhBV+xTJ7sShb0/VrG0pkD1j9n2acXsX6E/tH18XRW
         e4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850890; x=1790455690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UklQyeMvhqLuej0je0ggi0hTj3VJTG/i2EoA/FxL8jY=;
        b=aqzugVIshAGNOQVSwuul9l5uuUYLRkHnq4JeGObirAwOZT0qXNiS4lNqz4V4nRJbJP
         NtunGSzWa3czv+zZSRdgandBxzpzZ2osst8sOkkO4H60+R3RlzlT2OOOXHi7TD7SbVDv
         3sgh5tOMpHkXzn4gcg6hKCfQCxf5tUqUoZmItnUKZ/zFSQktS9bmgflG/YzasrG1uS+I
         GUpsBvWESXgFuHnC+vnognC3LR66WQ5bvLApBh01L0fIBmZ/SGXcVI9nVw4it2kti4DT
         968FhNvnp7MM/L9qDEASzs4gonlJR4sMKzss+eOKPQ4Rn4shtxdfHpXB5stbtmLfe0Nt
         dYyw==
X-Gm-Message-State: AFuF++nP77wBs6CcoSRMZBEmK6qrarNX+/SkTmwdM4gGRKtv+UGs5FKV
	z0sFQ5PdvZnUkebNL8FmnwRM6+GKKhztL7NWgvADNpTYYIo2KTC/Bp+QAwtjSv7n
X-Gm-Gg: AYBFou1LU+R1vaIYKjHB8UC/oFww+Zu25I3m7DomWDmGGERkN33TBrXfjBUlYhroxBK
	GS6V1Qi3JOtY9LLKZoHbrYiBL8kMDF8pK/Z430Bb3a3nQLPiWAx+5XVkH0dPFWOBdkcE8b2hhJ0
	DWuVbUiVuc8F9lg9/2QLlIJMOiqd1ePcXhLGOEfMDRwpiv23ZJ8mY201EzE1556q19M98EA+s31
	cfCiBH6134kJCGx6YAPtnYxxgibRKTJ+tmWz1awy62SHqQQNXC43Uh8/6AwMK1zkvdi+AvRJLTE
	+9uX6j5ZmTrZhpWo74wbnI+S7Ha7WpHRPC7ZKVvBoPqUbwj5mU5AoI/320x6NQXR2+61FThpCZn
	auBUtn23jQjYwoqn3VyExP9KZUNDKdfgjdEmwAk6xn5B3fXiYJyLgped/DvgOHT7YzJSaDQxTFt
	lLJ5Qkh1eIg6M2QwQDjdfKQfHkyaQkO2+PTo93oFNk3jV0nG1EDlDWi3Fjtl0QsuPCbFGvJ343w
	7aHpiOjwLbDT2cgdwRlH4kJx8VF17dWUWr6n7dqUUjhNJhwAmDnDpY1uMDQOEDCS71nEvylRTkG
	WtHUujMD7m/GCRzAWuq3
X-Received: by 2002:a17:90b:4b45:b0:39d:f7dc:61e4 with SMTP id 98e67ed59e1d1-39e54b204c5mr10849177a91.9.1789850890079;
        Sat, 19 Sep 2026 13:48:10 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm6848858a91.2.2026.09.19.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:48:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
Date: Sat, 19 Sep 2026 20:48:08 +0000
Message-ID: <20260919204808.2812930-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When autofs_fill_super() fails before clearing AUTOFS_SBI_CATATONIC (for
example, when find_get_pid() fails on an invalid pgrp mount option, or
when an fs_context is closed before mounting), deactivate_locked_super()
invokes autofs_kill_sb() -> autofs_catatonic_mode(sbi).

Because AUTOFS_SBI_CATATONIC is still set in sbi->flags,
autofs_catatonic_mode() returns early without calling fput(sbi->pipe),
permanently leaking the pipe struct file reference.

Explicitly release sbi->pipe in autofs_kill_sb() if it is still non-NULL
after autofs_catatonic_mode().

Fixes: ebc921ca9b92 ("autofs: copy autofs4 to autofs")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -51,6 +51,10 @@ void autofs_kill_sb(struct super_block *sb)
 	if (sbi) {
 		/* Free wait queues, close pipe */
 		autofs_catatonic_mode(sbi);
+		if (sbi->pipe) {
+			fput(sbi->pipe);
+			sbi->pipe = NULL;
+		}
 		put_pid(sbi->oz_pgrp);
 	}
 
-- 
2.43.0
