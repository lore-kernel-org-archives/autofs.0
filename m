From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/19] autofs-5.1.3 - fix spec file url
Date: Wed, 02 Aug 2017 10:17:09 +0800
Message-ID: <150164022981.6106.8514647022467533445.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The host ftp.kernel.org is no longer available, fix it.
And fix 5.1.3 release date year in CHANGLOG (oops!).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG   |    5 ++++-
 autofs.spec |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index f999eed4..e796fb36 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,4 +1,7 @@
-24/05/2016 autofs-5.1.3
+xx/xx/2017 autofs-5.1.4
+- fix spec file url.
+
+24/05/2017 autofs-5.1.3
 =======================
 - fix release date in CHANGELOG.
 - build: check for clock_gettime in librt.
diff --git a/autofs.spec b/autofs.spec
index c40fc9f3..591ffbaa 100644
--- a/autofs.spec
+++ b/autofs.spec
@@ -24,7 +24,7 @@ Version: %{version}
 Release: %{release}
 License: GPL
 Group: System Environment/Daemons
-Source: ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5/autofs-%{version}.tar.gz
+Source: https://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-%{version}.tar.gz
 Buildroot: %{_tmppath}/%{name}-tmp
 %if %{with_systemd}
 BuildRequires: systemd-units

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
