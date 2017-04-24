From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/34] autofs-5.1.2 - don't return until after master map
 retry read
Date: Mon, 24 Apr 2017 09:00:33 +0800
Message-ID: <149299563367.23475.4850136028844039439.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=wQjJR+dcj7kqJeleSG
        Mda+KfqjrY4lRTdmRB6Xp8lc0=; b=a2iXQLWijJqukrRjCkXi72buTgskenmwoJ
        NZlJR50Kw/l7sk7sADA47PUvBeT5rZl52Oaeup20t6dTqQoIbJGeU/dJ+Kc3GMVP
        p/mghn97Og7KMbbOB/qXw/FB78KBf9NjWYJl8udTw6bVc2usqAcNbeM7VEa0HRad
        K0xdUJZDJw5Avg5dLB15WszR1PqFzm1Zapt2mOOpp6ZaJeSf/MC/6nB6a4e1aR5L
        6+C6Exhs2jMnMLacA3Gx0jkCCIIUgkOt+/6Mx6USgGXs4wtO7aoXSppMFIhS9DJl
        8gjowoDjfYD/zjxa5jk5JM3LI+dEz22ZlbIibXb6s4j3uFrlR8LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=wQjJR+dcj7kqJeleSGMda+KfqjrY4lRTdmRB6Xp8lc0=; b=ifkvMa/8
        /Zc9OBEjc+GHWAIridtOf7Z69ovdM9RG/+UGU8eXI3AzrgBh0ZwD4y5CLnRSXccE
        f5GBihz8VqTi81qVTnsTpPAM7UaWEWBLcGhVc3fO6n7xVptnYgVYGVoF+7/BP5jH
        Ey92lFiGU6iq2PwNFWt8fEUldMVUVjODb0WeQJ0UAcMEsSzh4H19IFNc9dz1j6TJ
        EA40P1ZFka3+0WmsCQ7HiURMOhTqlYU7L/TE1wGrTuOVC6OdJIEggBoOy/slXYIl
        se7r9xUHEoMS16xRwvqO7DbMLXsz3BE/FIM+nbS9OlfWdO4pa7ABRQmViYjJxoNu
        DaxehMENGx466A==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The master map read retry needs to be done before returning success
at startup or there can be problems trying to access automount mounts
before they are mounted.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |   31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 92a6ea9..7337ec6 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -30,6 +30,7 @@ xx/xx/2016 autofs-5.1.3
 - fix included master map not found return.
 - dont exit on master map read fail timeout.
 - set sane default master read wait timeout.
+- don't return until after master map retry read.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 95b8969..15dadb5 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -2506,27 +2506,6 @@ int main(int argc, char *argv[])
 
 	master_read = master_read_master(master_list, age, 0);
 	if (!master_read) {
-		if (foreground)
-			logerr("%s: failed to read master map, "
-			       "will retry!",
-			       program);
-		else
-			logerr("%s: failed to read master map, "
-			       "will retry in background!",
-			       program);
-	}
-
-	/*
-	 * Mmm ... reset force unlink umount so we don't also do this
-	 * in future when we receive a HUP signal.
-	 */
-	do_force_unlink = 0;
-
-	st_stat = 0;
-	res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
-	close(start_pipefd[1]);
-
-	if (!master_read) {
 		/*
 		 * Read master map, waiting until it is available, unless
 		 * a signal is received, in which case exit returning an
@@ -2544,6 +2523,16 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/*
+	 * Mmm ... reset force unlink umount so we don't also do this
+	 * in future when we receive a HUP signal.
+	 */
+	do_force_unlink = 0;
+
+	st_stat = 0;
+	res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
+	close(start_pipefd[1]);
+
 	state_mach_thid = pthread_self();
 	statemachine(NULL);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
