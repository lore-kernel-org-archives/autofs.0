From: NeilBrown <neilb@suse.com>
Subject: [PATCH 2/3] Fix monotonic_elapsed.
Date: Mon, 29 Jan 2018 18:19:54 +1100
Message-ID: <151721039460.27355.12976027743239873668.stgit@noble>
References: <151721021295.27355.1968703903360394469.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151721021295.27355.1968703903360394469.stgit@noble>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

When automount probes multiple hosts to find the one which
responds most quickly, it currently ignores the nanoseconds.
This often makes the cost "0", which makes weights ineffective.

The cause is that monotonic_elapsed() casts tv_nsec to a
double *after* dividing by 1 billion, rather than before.

With this change, weights become effective for choosing
between hosts which respond in under one second.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rpc_subs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 73097c9d4238..60ede9f8c085 100644
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
