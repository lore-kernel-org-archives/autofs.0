From: Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH 0/1] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
Date: Sat, 11 Feb 2023 22:59:49 +0300
Message-ID: <20230211195950.452364-1-pchelkin@ispras.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F329840737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1676145607;
        bh=9zZWgSw2dv+vNDtDe9Rvl8F7Fv/omJW33B6s3CwSepw=;
        h=From:To:Cc:Subject:Date:From;
        b=UV8cC8i/VJR6dOw5qrWQVjrvZobF4sAHOKO77Dx2Olqw71vl+31G7UsLhS1nkWpfW
         58CMu34LCak4dnoqrykA+37uVW1/2/CCWuw5liMg7ovorVKf7PD1Qt4rqtzhfgDTa+
         TthFD0JyphXqEbDSU4MvCRhHQmYy9m44AKjWDDzw=
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Matthew Wilcox <willy@infradead.org>, Andrei Vagin <avagin@gmail.com>, Takeshi Misawa <jeliantsurux@gmail.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org

Syzkaller reports the leak [1]. It is reproducible.

The following patch fixes the leak. It was proposed by Takeshi Misawa and
tested by Syzbot.

In other places of the code the waitqueue is freed when its wait_ctr
becomes zero (see autofs_wait_release). So I think it is not actually
supposed that inside autofs_catatonic_mode wait_ctr cannot be decreased to
zero. Please correct me if I'm wrong.

Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
instead of wake_up_interruptible', shouldn't wake_up_interruptible()
inside autofs_catatonic_mode() be replaced with wake_up()?

[1] https://syzkaller.appspot.com/bug?id=a9412f636e2d733130f8def7975897d0b57f6e37
[2] https://www.spinics.net/lists/autofs/msg01875.html
