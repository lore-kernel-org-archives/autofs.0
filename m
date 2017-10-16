From: Ian Kent <raven@themaw.net>
Subject: [PATCH 33/35] autofs-5.1.3 - make map source reference message
 debug only
Date: Mon, 16 Oct 2017 13:09:23 +0800
Message-ID: <150813056310.25695.7785290347023826393.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The message "map source used without taking reference" was added during
development of an additional amd format map feature.

It appears far too often but hasn't been seen to be a real problem so
make it a debug only message and postpone deeper investigation until
later.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    |    1 +
 lib/master.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 56af6b94..37816bce 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -31,6 +31,7 @@ xx/xx/2017 autofs-5.1.4
 - make open_lookup() error handling more consistent.
 - be silent about sss library not found.
 - be silent about nis domain not set.
+- make map source reference message debug only.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/master.c b/lib/master.c
index a144a39d..76717d57 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -234,7 +234,7 @@ master_add_map_source(struct master_mapent *entry,
 
 		this = __master_find_map_source(entry, type, format, argc, tmpargv);
 		if (this) {
-			error(entry->ap->logopt,
+			debug(entry->ap->logopt,
 			      "map source used without taking reference");
 			this->age = age;
 			master_free_map_source(source, 0);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
