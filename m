From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/35] autofs-5.1.3 - fix mount.nfs blocks on first mount
Date: Mon, 16 Oct 2017 13:07:25 +0800
Message-ID: <150813044536.25695.12107979124347235625.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The first time an NFS mount is tried mount.nfs tries to start rpc.statd
using systemctl. If /usr/local is being used to provide automounts in
that directory the first mount will hang becuase some directories under
/usr/local are included in the path used by systemctl.

Add rpc-statd.service (and for good measure rpcbind.service) to the
autofs Wants line in the unit file to work around this.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                 |    1 +
 samples/autofs.service.in |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 4a57ca0b..d5dca873 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -12,6 +12,7 @@ xx/xx/2017 autofs-5.1.4
 - fix incorrect status return in get_nfs_info().
 - fix a couple of compiler warnings.
 - set systemd KillMode to process.
+- fix mount.nfs blocks on first mount.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/samples/autofs.service.in b/samples/autofs.service.in
index b37d970a..918fc93c 100644
--- a/samples/autofs.service.in
+++ b/samples/autofs.service.in
@@ -1,7 +1,7 @@
 [Unit]
 Description=Automounts filesystems on demand
 After=network.target ypbind.service sssd.service network-online.target remote-fs.target
-Wants=network-online.target
+Wants=network-online.target rpc-statd.service rpcbind.service
 
 [Service]
 Type=forking

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
