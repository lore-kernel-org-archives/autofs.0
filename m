Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF76CE7B1F
	for <autofs@archiver.kernel.org>; Fri, 29 Sep 2023 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjI2KBc (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Fri, 29 Sep 2023 06:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2KBc (ORCPT
        <rfc822;autofs@vger.kernel.org>); Fri, 29 Sep 2023 06:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84B1A8
        for <autofs@vger.kernel.org>; Fri, 29 Sep 2023 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695981645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U7PG4XhiuwITQruukIgQNMS6ELVbk/iCvSd1qbxGs5M=;
        b=PL/SrTcecQd5ZS9dwjx9bVtdhF2b9ASX0v8E9cFtsaBzlCoz9f50NJRwoM0C26XAOKN4bA
        HNCSgyWX5iWJVFFS02Ksn1uFtk0SU/LMMu1E4GABi0Bcdk157TnZtDzNysT1DcSVC0RSkW
        xhsIivKVB7JX/av4jzjDUGuIe56N0mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-p9jjEaJTPK2eOdFenpaKRg-1; Fri, 29 Sep 2023 06:00:44 -0400
X-MC-Unique: p9jjEaJTPK2eOdFenpaKRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E79FC811E91
        for <autofs@vger.kernel.org>; Fri, 29 Sep 2023 10:00:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 740512156702;
        Fri, 29 Sep 2023 10:00:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     autofs@vger.kernel.org
Cc:     Arjun Shankar <ashankar@redhat.com>
Subject: autofs-5.1.8 - define LDAP_DEPRECATED during LDAP configure check
Date:   Fri, 29 Sep 2023 12:00:42 +0200
Message-ID: <87v8bt1eph.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

From: Arjun Shankar <arjun@redhat.com>

This commit defines LDAP_DEPRECATED as 1 during a configure check for
ldap_parse_page_control.  This is in line with how lookup_ldap.c is
compiled at build time.  Also tweak the type of ct to avoid an
-Wint-conversion warning.

The configure script is regenerated with autoconf 2.69.

The regeneration of the configure script also includes changes due to
commit 69fda4f090e3.  That commit intended to run checks with implicit
function declaration warnings enabled in order to recognize missing
libldap functions.  However, the in-tree copy of the configure script
was not regenerated at that time.

Signed-off-by: Arjun Shankar <arjun@redhat.com>
Signed-off-by: Florian Weimer <fweimer@redhat.com>

---
Resubmitting because apparently this got never merged, also added
the -Wint-conversion fix.

 aclocal.m4 |  5 +++--
 configure  | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 33561aaeb9f5eaa4..1920672d37d25a27 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -368,9 +368,10 @@ af_check_ldap_parse_page_control_save_libs="$LIBS"
 LIBS="$LIBS -lldap"
 
 AC_TRY_LINK(
-  [ #include <ldap.h> ],
+  [ #define LDAP_DEPRECATED 1
+    #include <ldap.h> ],
   [ LDAP *ld;
-    ber_int_t ct;
+    ber_int_t *ct;
     struct berval *c;
     int ret;
     LDAPControl **clp;
diff --git a/configure b/configure
index 394a8d55121c12ed..c84ef2a94d1df1b4 100755
--- a/configure
+++ b/configure
@@ -5407,6 +5407,8 @@ $as_echo_n "checking for ldap_create_page_control in -lldap... " >&6; }
 # save current libs
 af_check_ldap_create_page_control_save_libs="$LIBS"
 LIBS="$LIBS -lldap"
+af_check_ldap_create_page_control_save_cflags="$CFLAGS"
+CFLAGS="$CFLAGS -Werror=implicit-function-declaration"
 
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -5443,6 +5445,7 @@ fi
 
 # restore libs
 LIBS="$af_check_ldap_create_page_control_save_libs"
+CFLAGS="$af_check_ldap_create_page_control_save_cflags"
 
 	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for ldap_parse_page_control in -lldap" >&5
 $as_echo_n "checking for ldap_parse_page_control in -lldap... " >&6; }
@@ -5450,15 +5453,18 @@ $as_echo_n "checking for ldap_parse_page_control in -lldap... " >&6; }
 # save current libs
 af_check_ldap_parse_page_control_save_libs="$LIBS"
 LIBS="$LIBS -lldap"
+af_check_ldap_parse_page_control_save_cflags="$CFLAGS"
+CFLAGS="$CFLAGS -Werror=implicit-function-declaration"
 
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
- #include <ldap.h>
+ #define LDAP_DEPRECATED 1
+    #include <ldap.h>
 int
 main ()
 {
  LDAP *ld;
-    ber_int_t ct;
+    ber_int_t *ct;
     struct berval *c;
     int ret;
     LDAPControl **clp;
@@ -5486,6 +5492,7 @@ fi
 
 # restore libs
 LIBS="$af_check_ldap_parse_page_control_save_libs"
+CFLAGS="$af_check_ldap_parse_page_control_save_cflags"
 
 fi
 

base-commit: ab70c4c070d8e21cd51df93f7a603788aa50dd5f

