From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 3/6] fix compile error with LDAP enabled but SASL disabled
Date: Mon, 22 Jul 2013 22:59:51 +0800
Message-ID: <1374505194-22668-4-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LlXi5OnI3+gheAct5BcJN98ELfR1E8LDlgNUy4QmZ6Q=;
        b=ude7PSFTZHY4k+9gbEBqnEFEdg7Z3AY2Pr55d68uB3Fjvyb9sE1VCJPlBHeFJ1yWRj
         zJKDyfpnDbm7Vlya4U82LXMMqiyC+tdjp6nkD6Jl7Y0QhV+ZbIo4FahNvwGVSOwxKYcs
         62qSXRRKZnRrs2tA07PIWCS79kHzND/ENrR0uUdAEiCrPzrKPjpNxyqQ8ToNRhVDNCFQ
         IMKR64Qy74R1C3AwQVab0p4U535cazcy+4PRuxLzkgQMoLlXOO4dD7h3uJ8W6l+P7wTO
         Vemw/J3vrN7xjnnL0vDFpCnyV2MzpagU7D7YPU8X5CnAn6ORs8bzyZeXi4uza+WB+jXZ
         SLog==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

automount[10812]: open_lookup:90: cannot open lookup module ldap
(/usr/lib64/autofs/lookup_ldap.so: undefined symbol: parse_ldap_config)

---
Gentoo Bugs:
  https://bugs.gentoo.org/show_bug.cgi?id=381315

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 modules/lookup_ldap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index a2bfafd..b8970a6 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -1484,6 +1484,7 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 		}
 	}
 
+#ifdef WITH_SASL
 	/*
 	 *  First, check to see if a preferred authentication method was
 	 *  specified by the user.  parse_ldap_config will return error
@@ -1496,7 +1497,6 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 		return 1;
 	}
 
-#ifdef WITH_SASL
 	/* Init the sasl callbacks */
 	if (!autofs_sasl_client_init(LOGOPT_NONE)) {
 		error(LOGOPT_ANY, "failed to init sasl client");
-- 
1.8.2.1

