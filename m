From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/25] autofs-5.0.7 - fix dumpmaps multi output
Date: Mon, 19 Aug 2013 09:13:48 +0800
Message-ID: <20130819011348.6472.81004.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=fIj9KB4nlukMUtRrPhFnsF8YZP8=; b=xNhn6BvJY+R/BsBzuhzaBwrEWEaz
	CFGHK9hSy7WTS2F8C/BglPL0cRxeF8IFSVdpblpXNg4MLP6Sz9kMUWFzxDCH8OJ/
	GTmV8Ymp5YhecjR/QYFUTZ1uzI5NHPLCeYrpyA+qiQuIAZ0I/B1tD+o20/BlThgC
	mTqyHNfPxT1jYec=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=fIj9KB4nlukMUtRrPhFnsF
	8YZP8=; b=GAQ61G5cJ4V2M4/oTJkxH0LnAd/asNocgTOcdXS/eRHAHjIpDIyqoe
	JNrjH1dkKlSBIVT+eYzGLPPZsgHW6h56mzeQPacNsK/IoM+Km+zkmHBimigPj6+y
	slxFh3VXKjsejR1JVw+hqJA6nXCwumR1eOP152fiJQ625cnQAqClM=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

If the maps contain the old style "multi" type the dumped map information
isn't right.
---
 CHANGELOG    |    1 +
 lib/master.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5764cb0..5e58aca 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -68,6 +68,7 @@
 - use LIBS for link libraries.
 - unbundle NOTSTRIP from DEBUG so they dont depend on each other.
 - fix compilation of lookup_ldap.c without sasl.
+- fix dumpmaps multi output.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/lib/master.c b/lib/master.c
index eca3523..df6c141 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1281,6 +1281,54 @@ static void list_source_instances(struct map_source *source, struct map_source *
 	return;
 }
 
+static void print_map_info(struct map_source *source)
+{
+	int argc = source->argc;
+	int i, multi, map_num;
+
+	multi = (source->type && !strcmp(source->type, "multi"));
+	map_num = 1;
+	for (i = 0; i < argc; i++) {
+		if (source->argv[i] && *source->argv[i] != '-') {
+			if (!multi)
+				printf("  map: %s\n", source->argv[i]);
+			else
+				printf("  map[%i]: %s\n", map_num, source->argv[i]);
+			i++;
+		}
+
+		if (i >= argc)
+			return;
+
+		if (!strcmp(source->argv[i], "--"))
+			continue;
+
+		if (source->argv[i]) {
+			int need_newline = 0;
+			int j;
+
+			if (!multi)
+				printf("  arguments:");
+			else
+				printf("  arguments[%i]:", map_num);
+
+			for (j = i; j < source->argc; j++) {
+				if (!strcmp(source->argv[j], "--"))
+					break;
+				printf(" %s", source->argv[j]);
+				i++;
+				need_newline = 1;
+			}
+			if (need_newline)
+				printf("\n");
+		}
+		if (multi)
+			map_num++;
+	}
+
+	return;
+}
+
 int master_show_mounts(struct master *master)
 {
 	struct list_head *p, *head;
@@ -1311,7 +1359,6 @@ int master_show_mounts(struct master *master)
 		struct autofs_point *ap;
 		time_t now = time(NULL);
 		unsigned int count = 0;
-		int i;
 
 		this = list_entry(p, struct master_mapent, list);
 		p = p->next;
@@ -1357,20 +1404,10 @@ int master_show_mounts(struct master *master)
 			}
 
 			if (source->argc >= 1) {
-				i = 0;
-				if (source->argv[0] && *source->argv[0] != '-') {
-					printf("  map: %s\n", source->argv[0]);
-					i = 1;
-				}
+				print_map_info(source);
 				if (count && ap->type == LKP_INDIRECT)
 					printf("  duplicate indirect map entry"
 					       " will be ignored at run time\n");
-				if (source->argc > 1) {
-					printf("  arguments: ");
-					for (; i < source->argc; i++)
-						printf("%s ", source->argv[i]);
-					printf("\n");
-				}
 			}
 
 			printf("\n");

