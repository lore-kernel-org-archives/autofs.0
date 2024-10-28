Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8B1DD867
	for <autofs@vger.kernel.org>; Mon, 28 Oct 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119430; cv=none; b=ZAecBsMjvQa6cK+Ge4UWsOqoxXe8yO3OxR56roMgc27flFT5gjpIzYhJC/2oLXbAAxo1u/i3P1p6T/Gbt9mzXaqs0gngbX0hGfCuweryllnNs9MNTI+xOeftf9jZERJHwPxsUgE0MmAaLZoHoOjgkOLbSoZerKVBhzW4BoDGY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119430; c=relaxed/simple;
	bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=n1n4tETvQFoYvvKHVYHr3iNdaJ95vaMX5fBbCs8NZnYVEhQVUWgX2SnVKdvZDPUssf6nNpwh7x81AXF+uijvpONxJJOVzK/6Vigsn8bV9n7ikZj6Hw8u/OSyQJ6J4TTA6LLIyQXwupOAfLUW5uUAp//9YdIIJgfX7fpbZSWC1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlgISpdl; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlgISpdl"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso2744206a12.1
        for <autofs@vger.kernel.org>; Mon, 28 Oct 2024 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119428; x=1730724228; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=jlgISpdlD6yYFgGwvSgpqdnxOQTExW/Ti8uqY8LQs4RdcR85KsxlWtGFs+zC3WCbE3
         pYYlrMJ361r7ScShn1V3fEY4jg0fmWc8NDyj7s6pIMUyZGMt80B1IEymvq4KkPBHZ89f
         s/QSzBw5ODMX/67/vh2m1TFFOmZqOyrT1VOsk3St0eX/WV6PIDuxVaGQo+AE9PKqBJc7
         AgpsbuwtTaWolv4JFPmdg3S+exCU7bslQCwSSOn2fS6G5HGFUPuaNPKXvGlQb7qnzUSI
         5WTPfqqaHfdw0QXqSrkcfczfry6IlKSijtxH+pfyE3lnjqADfhPkSst+NhUJG9XrQqwM
         z+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119428; x=1730724228;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=AiJZVQmu4R6NKB01Rwp5S4w2nT3A1P7CrQV7Ogrb9lAo4a5h8mvY7XkbaGgW364ZBu
         KJx6/rQ7FgZ24dllDMev7QpWucylmeG1TpGE+kezz5J9Q0WTcKCEo8/r9TG9wEE0ztd0
         d2IrUq29V0F3DHwHYKfE/3ju9NOPJqsXz/cRBqxYPQ0RQ3d/Asb0vWSuHG+d/Ip69o8f
         GmNCtfbaOGCwwOaYtBBKbfGgbrB1EqYkTdhcHb0s+a1YxtspcpUxBexLpyFGY0374ILZ
         /rRgvwkwv3BqsCteoesh2/Gq3rkLUKT97liI9ehHMWFgGYO1v88tpKTX38HfJj17zPOS
         1loA==
X-Gm-Message-State: AOJu0YymTTPzbKoeGJWuPAJWqxKVcvvFB1w2/slc4HXLMjxhH07Uc5G1
	Cjsddna23KVZY93grSuOrmQSInf5ylsAYAPCbeG9POkPH0o4MaQqfl9m2ThX
X-Google-Smtp-Source: AGHT+IEveoTOXMgFkgjiXwyCbtgrw1N8vhuOwJ6bKZdDImDpCcdByrcStEH67729DnCg9L5sYECrow==
X-Received: by 2002:a05:6a20:bb06:b0:1d9:c743:860f with SMTP id adf61e73a8af0-1d9c7438653mr3228176637.11.1730119428534;
        Mon, 28 Oct 2024 05:43:48 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791d4d9sm5824449b3a.15.2024.10.28.05.43.47
        for <autofs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:43:48 -0700 (PDT)
From: Debbie Magoffin <naghamtony726256@gmail.com>
X-Google-Original-From: Debbie Magoffin <dmagoffin@outlook.com>
Message-ID: <ce9c0447ceda14523ffd89664f61636e335871d11603d8d77055f12961fcbe2e@mx.google.com>
Reply-To: dmagoffin@outlook.com
To: autofs@vger.kernel.org
Subject: Yamaha Piano 10/28
Date: Mon, 28 Oct 2024 08:43:44 -0400
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Debbie
