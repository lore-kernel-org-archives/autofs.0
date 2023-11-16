Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E5187
	for <autofs@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7fb057153so762889a12.1
        for <autofs@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128269; x=1700733069;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNHOjfzTCRSZhLxgg5CyThWc28KBQzyvt0Gk1pd2sA=;
        b=Xyo8XraInrfRkmApmGtzD6RieHUfnMnSWJt3N3H/9MgC036dy/AtWf5D7788lVUAJX
         Dm0/Y6LUDwZjVzByG+IpcQaJvfbBzcrjX0+Iw1Ciw16VUuQ0P74IHS+sumuPINHrcd8j
         rInRKMqQ0FpRqL4GfdeJJq/Y4XUc0pfPVkA8rU0nlo6FphjYpl7aLHib9fC6af6u3TVX
         8sUGXR/xcYhznqntiO+7lnxa2rYMljVfvLm4UqEhMFEZ1GcSzAXWMgEtkVwUWULmr/fr
         D+EYMdQHiwc/q+HxKaRt6uO0Y/0mvc85IwsMyNxsAQ7V8dr7tWljzBWdRPNlMLwfgcuU
         I3iw==
X-Gm-Message-State: AOJu0Yyf5OfwcMSMNSE1xQ1m3hbfjrJl9fktKPhHzAOULqhpGC5+1l66
	Z1J43Xr3KooxDWOlkQau2D4vXImv61Fb6KDKQVEmEKigLIStdCM=
X-Google-Smtp-Source: AGHT+IGFkiPFsgApk8aUnzxiA3nQo2YGU1aJ7rbgvlaLBurc6k5+bkMItSzH20RLWujRkf0/mfiX8H+dDfidMqvoyI7pX9pP4ert
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:dd4a:0:b0:5c1:589d:b3e5 with SMTP id
 g10-20020a63dd4a000000b005c1589db3e5mr253325pgj.2.1700128269720; Thu, 16 Nov
 2023 01:51:09 -0800 (PST)
Date: Thu, 16 Nov 2023 01:51:09 -0800
In-Reply-To: <000000000000ae5995060a125650@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096e7d5060a41f594@google.com>
Subject: Re: [syzbot] [autofs?] general protection fault in autofs_fill_super
From: syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, billodo@redhat.com, bodonnel@redhat.com, 
	brauner@kernel.org, eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e6ec453bd0f03a60a80f00f95ae2eaa260faa3c2
Author: Ian Kent <raven@themaw.net>
Date:   Fri Sep 22 04:12:14 2023 +0000

    autofs: convert autofs to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d04220e80000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d04220e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d04220e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=662f87a8ef490f45fa64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14384a7b680000

Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Fixes: e6ec453bd0f0 ("autofs: convert autofs to use the new mount api")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
