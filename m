From: Ian Kent <raven@themaw.net>
Subject: [PATCH 22/37] autofs-5.1.2 - update and add README for old autofs
 schema
Date: Tue, 25 Oct 2016 09:19:22 +0800
Message-ID: <20161025011921.7778.54651.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=uNI6wIx7cU/Bbwo0jU+P40xuYp8=; b=bNesuJE6h98+tvhseN
        yXgKKT+AjWbOcogjQjRiA0mODijqJ19f3y4dNITJC4j+tWTDXGK4tolL3xExJJZ3
        +SC8XWk2AZXDliK45dJPS62Ip65EWJnIZk2QZowaC8A0KOtWY9JYvvlOyyk3JM/a
        pOgWX9cuUv4DHQ9GO5Zq8BT4Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=uNI6wIx7cU/Bbwo0jU+P40
        xuYp8=; b=KH2A1TbHusK/dLOFY+N31NBJ5CVgWI8PZ8J6Er/rkkVPaPujBFXCWx
        8T0HKiNpkSdEEaawE+G2muty/A/S1zu+0ETVvjdCqUbBIjQrRNRrSZBZGmaGErFw
        l11ZwqQevPXLzVIhFEU4ZMe9CO34sfUU1NM616l5S2MuKtk4q5eUo=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The distribution file samples/autofs.schema is very old and is
incorrect.

This schema was added to the discribution long ago when it was
not clear what schema to use for Linux autofs information.

The schema was updated (at least to have consistent OIDs) somewhere
along the line but the autofs distribution copy was never updated.
The schema has now been updated in autofs but it is not recommended
for use as the schema for autofs map information.

The rfc2307 or, preferably the, rfc2307bis schema is the recommened
schema to use.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG             |    1 +
 README.autofs-schema  |   18 ++++++++++++++++++
 samples/autofs.schema |   24 ++++++++++--------------
 3 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 README.autofs-schema

diff --git a/CHANGELOG b/CHANGELOG
index 4e2e482..686d404 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -19,6 +19,7 @@ xx/xx/2016 autofs-5.1.3
 - fix argc off by one in mount_autofs.c.
 - fix _strncmp() usage.
 - fix create_client() RPC client handling.
+- update and add README for old autofs schema.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/README.autofs-schema b/README.autofs-schema
new file mode 100644
index 0000000..c121e1c
--- /dev/null
+++ b/README.autofs-schema
@@ -0,0 +1,18 @@
+autofs schema
+=============
+
+The distribution file samples/autofs.schema is very old and is
+incorrect.
+
+This schema was added to the discribution long ago when it was
+not clear what schema to use for Linux autofs information.
+
+The schema was corrected somewhere along the line but the autofs
+distribution copy was never updated. The schema has now been
+updated but it is not recommended for use as the schema for autofs
+map information.
+
+The rfc2307 or, preferably the, rfc2307bis schema is the recommened
+schema to use.
+
+Ian
diff --git a/samples/autofs.schema b/samples/autofs.schema
index 98d78c4..07e23b4 100644
--- a/samples/autofs.schema
+++ b/samples/autofs.schema
@@ -1,6 +1,3 @@
-#
-# $id$
-#
 # Depends upon core.schema and cosine.schema
 
 # OID Base is 1.3.6.1.4.1.2312.4
@@ -11,17 +8,16 @@
 
 # Attribute Type Definitions
 
-attributetype ( 1.3.6.1.1.1.1.25 NAME 'automountInformation'
-        DESC 'Information used by the autofs automounter'
-        EQUALITY caseExactIA5Match
-        SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 SINGLE-VALUE )
+attributetype ( 1.3.6.1.4.1.2312.4.1.2 NAME 'automountInformation'
+	DESC 'Information used by the autofs automounter'
+	EQUALITY caseExactMatch
+	SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 SINGLE-VALUE )
 
-objectclass ( 1.3.6.1.1.1.1.13 NAME 'automount' SUP top STRUCTURAL
-        DESC 'An entry in an automounter map'
-        MUST ( cn $ automountInformation $ objectclass )
-        MAY ( description ) )
+objectclass ( 1.3.6.1.4.1.2312.4.2.3 NAME 'automount' SUP top STRUCTURAL
+	DESC 'An entry in an automounter map'
+	MUST ( cn $ automountInformation $ objectclass )
+	MAY ( description ) )
 
 objectclass ( 1.3.6.1.4.1.2312.4.2.2 NAME 'automountMap' SUP top STRUCTURAL
-        DESC 'An group of related automount objects'
-        MUST ( ou ) )
-
+	DESC 'An group of related automount objects'
+	MUST ( ou ) )

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
