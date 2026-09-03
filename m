Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282637188A
	for <autofs@vger.kernel.org>; Thu,  3 Sep 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415090; cv=none; b=jSCvJ89l1klYC2vgwnVylRJVALZpBPF5pye1yc3q5dAD6PxzLhFG9JVYxJzPgwSER0SuWDGUgWguN93I3gk2m74yYPz4ZafTX+D7gGlHfLIwn0KkdaKveu2ca0OSFF9qahSNwqf3k5hDYxtBXXG2zUOOwDdD0JFnNbMLIc+Rvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415090; c=relaxed/simple;
	bh=qaTHQi+jLbkTKqwtqLEUebeIF4mMcYRbrR+s7DnFioM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRclfeQZWESQsbMoXtx/rEjA7v5b+hFfNfPPUfWE9UQt42Wk/UbYND5Z8Z20HDKUudi5g+oj0ggrLRVgs3JCF8F9Ei7ykYvpXPzAwMFV7pbCseDgQOqvjOw741yeDR2wLphrl5iNBshGEEZ3vZJU+oyYniLfPKi3VaIOV2cj/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPcZ90ov; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPcZ90ov"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so17764285ad.1
        for <autofs@vger.kernel.org>; Wed, 02 Sep 2026 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788415088; x=1789019888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYvqnN15+8YH3+7tkplnMuDYJlYMSxL+jshlEhlA8FA=;
        b=rPcZ90ovUg7j4oL/Xhdh4c8hMO5mnr+q3Rj9OQvyE4/bAehYq5N17yM/agzXlYr0Gy
         lVfx90Y1qItLZks2cD1DA25XFvd+71hBSJLkLbunkne6YHctXaiAQCfpJz3JUvzxSQOF
         u1jWO4xP+PukJsvhcaRRaxawmK63vn5a0WD35N5hKhALBBe3+B3qNlFquK0c19rXmXNP
         zwPf5irCDcDgBkWSF1gyxJ8bEBInzJ9M6reAaNGRG3UfMYblWbEHdObopMv+x6a/3Ci1
         SNh1fm/zx67wGiKUTIZyxh4uy/wy4bb7kg/hW0OapPweV0Kla6DdaBydzfP9DY91IP7V
         Lx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788415088; x=1789019888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HYvqnN15+8YH3+7tkplnMuDYJlYMSxL+jshlEhlA8FA=;
        b=Aqe94ieyQgsn4JQTuUxvm49EbErxO+KHx7ESNiHZnl2cjyEUEkxctzyrr7VEOiSutM
         aIgGc+mT3DPQ70jdW4zc7j05RljStuKcrtjLGmEqfyMXy4kltXvHbgJhaeG3/4J3UN5k
         vmXaADWkpHOdu07QAWh/sHRsM+qVQflTiwb/gCcnAGM8qWaGol+3jKMyrOAX80v0QCyq
         72VERVjfViR1FNjQ88f0eM3WJrps5oVIr4rS5dzPAfuqkEZIlxfx/syxdweYIO2JGe6I
         A3SKPONu3WG3X2aJX7pMedTloUFSeKn0n595Dr9gXGFNiBddDOxFukwsi6hnQM1VZXJ1
         LEYA==
X-Gm-Message-State: AFuF++k+fWgIj0G+nwvdDzV4bIYMJUAXTlYZdoJeQ1yuw5Sh8zZRC2A8
	KTXhVEJ79kvG2yQfK1hEyy0YVb1GKYY2Q5irG1WyGzKXkHgecYVrtmD/
X-Gm-Gg: AYBFou0DpPuQAuvpOqz/fupOPoT8lQ9SSiV6f++urusv9vmzDbx04kaSZXLoToUwjtg
	XM5S1NeDseV2ayVlCCX9EQPRk3BBf44V5jKPAluv6RDGc56dMC+43QiKc7vqnhmdTYxUv7dODM7
	ueZMezq6WZug9aSMNgF3UG5YBKCiK+kov4FkCuPSBgHRCMUKOBwUVoPZH+JNJxdHk1UAZ9RHkn4
	nPV4rKvQe+iocsgt1q24XbeE/F4bHZqB6IQvtw1qNM8wj9JcfmueWGJDrvJiRcjZtZh0LUX6Td0
	7n/SFva//avofEYlWbqL2dLSJxQVsbyQhtyjQKwWpfRYMkffHGifwRoZX1Cz+9j0dr+d5rZVs6M
	Ro+tX0nNc/N3WGABqEo0z/tYdIK+6V6J5hJ11ZMtnTTzlCOZtmIMWlFuK6NNqxMhwiGDnip6Dzf
	QMN+xyDp8GotxCQVd2e8SRWkkxPfLYbCnDzJUTDwTCVhEHJToeDnpvghOSCTpv+WDcpw==
X-Received: by 2002:a17:902:e804:b0:2d1:134:b86e with SMTP id d9443c01a7336-2daec5ad579mr130242775ad.2.1788415087854;
        Wed, 02 Sep 2026 22:58:07 -0700 (PDT)
Received: from Default ([2409:40f4:10fc:1508:9046:d212:f625:4fad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255d39d21sm3659634eec.16.2026.09.02.22.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:58:07 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raven@themaw.net,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [autofs?] memory leak in autofs_new_ino
Date: Thu,  3 Sep 2026 11:27:51 +0530
Message-ID: <20260903055751.10197-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a984fda.27a413cd.1e878c.000a.GAE@google.com>
References: <6a984fda.27a413cd.1e878c.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream 8d3ae59288f1

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index c1e210cec436..d93b5ec3cec7 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -324,6 +324,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	if (!root_inode)
+		autofs_free_ino(ino);
 		return -ENOMEM;
 
 	root_inode->i_uid = ctx->uid;
