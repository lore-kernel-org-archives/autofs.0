From: Ian Kent <raven@themaw.net>
Subject: [PATCH 18/25] autofs-5.0.7 - try and cleanup after dumpmaps
Date: Mon, 19 Aug 2013 09:13:55 +0800
Message-ID: <20130819011354.6472.33734.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=IKTEVdzch3OY3e8hD/uz6KH8T30=; b=Ji7r3p5dtyVtTO0vVXAbm3mOrVHm
	p7qY0uLdJLUg5jbrGf+9uNbRb5/87v+gVAWBmaFSsOA38eOdvirwZiSiJNO08d0j
	Gkc2JCuTUOE+R5vwd2D3Fd2XN3KWi5/YxzCd6NGu9ewNpe14wS4eo4Ex1YyWAAwZ
	b++bhyhBamrtHhk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=IKTEVdzch3OY3e8hD/uz6K
	H8T30=; b=cmovJslMcuCpA/MxUXZn39TA65Uc4f2jBuy6HmbcYkF5y0pBPNP87l
	0dLvYDLM2JqHIlDN2JmLSdinnESlOIVycMOKfpaxgzbmxjw/FABxSI6oIU8KpHy6
	6EdE5gU1oAOt6CccPTGqGEibRTkpdlxYaO+hj48rTjMgOEu/SBZnU=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

Try and cleanup a little after dumping maps.
It's not really necessary but but can help by reducing the noise
from valgrind when checking code.
---
 CHANGELOG          |    1 +
 daemon/automount.c |   13 +++++++++++++
 lib/master.c       |    2 ++
 3 files changed, 16 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 5e58aca..1583c76 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -69,6 +69,7 @@
 - unbundle NOTSTRIP from DEBUG so they dont depend on each other.
 - fix compilation of lookup_ldap.c without sasl.
 - fix dumpmaps multi output.
+- try and cleanup after dumpmaps.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 1d0b64e..6849272 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -2136,6 +2136,8 @@ int main(int argc, char *argv[])
 	}
 
 	if (dumpmaps) {
+		struct master_mapent *entry;
+		struct list_head *head, *p;
 		struct mapent_cache *nc;
 
 		open_log();
@@ -2152,6 +2154,17 @@ int main(int argc, char *argv[])
 
 		lookup_nss_read_master(master_list, 0);
 		master_show_mounts(master_list);
+
+		head = &master_list->mounts;
+		p = head->next;
+		while (p != head) {
+			entry = list_entry(p, struct master_mapent, list);
+			p = p->next;
+			master_free_mapent_sources(entry, 1);
+			master_free_mapent(entry);
+		}
+		master_kill(master_list);
+
 		exit(0);
 	}
 
diff --git a/lib/master.c b/lib/master.c
index df6c141..734485e 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1426,6 +1426,8 @@ int master_show_mounts(struct master *master)
 			source = source->next;
 		}
 
+		lookup_close_lookup(ap);
+
 		printf("\n");
 	}
 

