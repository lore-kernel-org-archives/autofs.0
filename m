From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/20] autofs-5.1.4 - fix monotonic_elapsed
Date: Wed, 14 Feb 2018 14:43:59 +0800
Message-ID: <151859063931.8026.10136388707859346180.stgit@pluto.themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: NeilBrown <neilb@suse.com>

When automount probes multiple hosts to find the one which
responds most quickly, it currently ignores the nanoseconds.
This often makes the cost "0", which makes weights ineffective.

The cause is that monotonic_elapsed() casts tv_nsec to a
double *after* dividing by 1 billion, rather than before.

With this change, weights become effective for choosing
between hosts which respond in under one second.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 lib/rpc_subs.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 104fca90..313730b1 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -10,6 +10,7 @@ xx/xx/2018 autofs-5.1.5
 - add error handling for ext_mount_add().
 - account for recent libnsl changes.
 - use_hostname_for_mounts shouldn't prevent selection among replicas.
+- fix monotonic_elapsed.
 
 19/12/2017 autofs-5.1.4
 - fix spec file url.
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 73097c9d..60ede9f8 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1093,9 +1093,9 @@ double monotonic_elapsed(struct timespec start, struct timespec end)
 	double t1, t2;
 
 	t1 =  (double) start.tv_sec +
-		(double) (start.tv_nsec/(1000*1000*1000));
+		((double) start.tv_nsec/(1000*1000*1000));
 	t2 =  (double) end.tv_sec +
-		(double) (end.tv_nsec/(1000*1000*1000));
+		((double) end.tv_nsec/(1000*1000*1000));
 	return t2 - t1;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
