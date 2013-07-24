From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 5/7] use += to accumulate the LIBS, otherwise we may lost early set
Date: Wed, 24 Jul 2013 10:38:16 +0800
Message-ID: <1374633498-28385-5-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PlSjp6fvGaWCDSWiq64kxOB7wShREyFeiq7vdfbt3jM=;
        b=Ex1uX5Ca9OsoEyw6V51rcRSnuOmpSdOQA75jPJ+8kcmQtb5uC6nLiBVILoQ4pBo/85
         EFOa3LDUWzWq5YskKtxYAIKa7o/P5be24xmgRYgRGW0h4wMWpqVhZiHVYHpC8IYhm0GR
         QR0KTESliC9zUzuJQRuvYI1QP/1R7xVh6lNt1kJf68CqRjIsgLAbqoNvSnFPDzSLSKNQ
         fo1DoBMM+vd6ZyMqJFYZKMQsfqMm68j6mRNtWFi6tAKYD2EVkrBvSjti45CsM5Jlq/Hc
         GYHlMKEBx6mduXjaPCUpM13s+5JqyGsGXbO1UcnJJXq+Zo2u8dRZaSYqcg+IhucTsKdp
         aZEw==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 daemon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon/Makefile b/daemon/Makefile
index 9e9d635..6604c9a 100644
--- a/daemon/Makefile
+++ b/daemon/Makefile
@@ -20,7 +20,7 @@ CFLAGS += -DAUTOFS_FIFO_DIR=\"$(autofsfifodir)\"
 CFLAGS += -DAUTOFS_FLAG_DIR=\"$(autofsflagdir)\"
 CFLAGS += -DVERSION_STRING=\"$(version)\"
 LDFLAGS += -rdynamic
-LIBS = -ldl
+LIBS += -ldl
 
 ifeq ($(LDAP), 1)
     CFLAGS += $(XML_FLAGS)
-- 
1.8.3.2

