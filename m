From: Ian Kent <raven@themaw.net>
Subject: [PATCH 30/35] autofs-5.1.3 - make open_lookup() error handling more
 consistent
Date: Mon, 16 Oct 2017 13:09:05 +0800
Message-ID: <150813054518.25695.18076142455132738021.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If the open of a lookup module fails then open_lookup() should return
an NSS status that causes the source to be skipped as it is most likely
due to the map source not being configured.

Currently open_lookup() returns NSS_STATUS_UNAVAIL for failures whereas
much of the other lookup code returns NSS_STATUS_UNKNOWN for similar
errors encountered by open_lookup().

But NSS_STATUS_UNAVAIL will result in waiting for the lookup module to
become avaiable when trying to read the master map at startup even
though it isn't likely to become available. So NSS_STATUS_UNKNOWN is
more appropriate becuase that will cause the source to be skipped and
is used for the same purpose elsewhere.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 daemon/module.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5a2bf171..25e5a8c7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -28,6 +28,7 @@ xx/xx/2017 autofs-5.1.4
 - only take master map mutex for master map update.
 - revert fix argc off by one in mount_autofs.c.
 - fix nisplus lookup init not configured check.
+- make open_lookup() error handling more consistent.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/module.c b/daemon/module.c
index 8879b64c..b1a94f56 100644
--- a/daemon/module.c
+++ b/daemon/module.c
@@ -73,7 +73,7 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			logerr("%s%s", err_prefix, estr);
 		}
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	type = strdup(name);
@@ -83,7 +83,7 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			logerr("%s%s", err_prefix, estr);
 		}
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	size = snprintf(fnbuf, sizeof(fnbuf),
@@ -95,7 +95,7 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			logerr("%s%s", err_prefix, estr);
 		}
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	if (!(dh = dlopen(fnbuf, RTLD_NOW))) {
@@ -104,7 +104,7 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 			       err_prefix, name, dlerror());
 		free(mod);
 		free(type);
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	if (!(ver = (int *) dlsym(dh, "lookup_version"))
@@ -115,7 +115,7 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 		dlclose(dh);
 		free(mod);
 		free(type);
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	if (!(mod->lookup_init = (lookup_init_t) dlsym(dh, "lookup_init")) ||
@@ -129,14 +129,14 @@ int open_lookup(const char *name, const char *err_prefix, const char *mapfmt,
 		dlclose(dh);
 		free(mod);
 		free(type);
-		return NSS_STATUS_UNAVAIL;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	if (mod->lookup_init(mapfmt, argc, argv, &mod->context)) {
 		dlclose(dh);
 		free(mod);
 		free(type);
-		return NSS_STATUS_NOTFOUND;
+		return NSS_STATUS_UNKNOWN;
 	}
 
 	mod->type = type;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
