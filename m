From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/19] autofs-5.1.3 - set systemd KillMode to process
Date: Wed, 02 Aug 2017 10:18:15 +0800
Message-ID: <150164029569.6106.7612233544880548328.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

It's been reported that fuse based filesystem mounts are lost when
restarting autofs.

This behaviour is due to systemd default KillMode being control-group
rather than process.

While changing this from control-group to process might occassionally
not kill some processes that should be killed on shutdown or restart
these processes are much less common and less problematic than processes
managing fuse based mounts.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                 |    1 +
 samples/autofs.service.in |    1 +
 2 files changed, 2 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 823b0832..4a57ca0b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -11,6 +11,7 @@ xx/xx/2017 autofs-5.1.4
 - use pkg-config to search for libtirpc to fix cross-compilation.
 - fix incorrect status return in get_nfs_info().
 - fix a couple of compiler warnings.
+- set systemd KillMode to process.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/samples/autofs.service.in b/samples/autofs.service.in
index f9fa96c4..b37d970a 100644
--- a/samples/autofs.service.in
+++ b/samples/autofs.service.in
@@ -9,6 +9,7 @@ PIDFile=@@autofspiddir@@/autofs.pid
 EnvironmentFile=-@@autofsconfdir@@/autofs
 ExecStart=@@sbindir@@/automount $OPTIONS --pid-file @@autofspiddir@@/autofs.pid
 ExecReload=/usr/bin/kill -HUP $MAINPID
+KillMode=process
 TimeoutSec=180
 
 [Install]

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
