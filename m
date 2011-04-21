From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Lockdep splat in autofs with 2.6.39-rc2
Date: Thu, 21 Apr 2011 17:25:37 -0400
Message-ID: <20110421212537.GC24898@home.goodmis.org>
References: <20110407194403.GA29404@elliptictech.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110407194403.GA29404@elliptictech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Bowler <nbowler@elliptictech.com>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, Peter Zijlstra <peterz@infradead.org>

On Thu, Apr 07, 2011 at 03:44:03PM -0400, Nick Bowler wrote:
> Just saw this on 2.6.39-rc2 after half a day or so of uptime.  I've
> never seen it before today so it may be a regression from 2.6.38.
> Nothing seems have failed as a result.  Please let me know if you
> need any more info.
>

Could you try this patch. I know it may be hard to reproduce, but the
issue is that we are recursing down the locks in a tree/list and we changed a
lock from being nested to being a parent. This patch tells lockdep about
what we did.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 450f529..1feb68e 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -124,6 +124,7 @@ start:
 	/* Negative dentry - try next */
 	if (!simple_positive(q)) {
 		spin_unlock(&p->d_lock);
+		lock_set_subclass(&q->d_lock.dep_map, 0, _RET_IP_);
 		p = q;
 		goto again;
 	}
@@ -186,6 +187,7 @@ again:
 	/* Negative dentry - try next */
 	if (!simple_positive(ret)) {
 		spin_unlock(&p->d_lock);
+		lock_set_subclass(&ret->d_lock.dep_map, 0, _RET_IP_);
 		p = ret;
 		goto again;
 	}
