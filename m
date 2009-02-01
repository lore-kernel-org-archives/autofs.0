From: Ian Kent <raven@themaw.net>
Subject: Re: Segfaults in lookup_hosts.c, probably caused by
Date: Sun, 01 Feb 2009 12:20:18 +0900
Message-ID: <1233458418.2967.44.camel@zeus.themaw.net>
References: <4984CB32.8080709@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4984CB32.8080709@inria.fr>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Sat, 2009-01-31 at 23:05 +0100, Guillaume Rousse wrote:
> Hello list.
> 
> I just released a 5.0.4 package with all current patches applied, and I 
> had this report:
> https://qa.mandriva.com/show_bug.cgi?id=47423
> 
> I can reproduce the issue with this simple master map:
> [root@oberkampf guillaume]# cat /etc/autofs/auto.master
> /net	-hosts

Thanks to the backtrace you provided I see this looks exactly like one
of the issues that was identified by the code analysis that Paul
Wankadia was kind enough to do for us. Thanks Paul.

I've pulled out that particular hunk of the patch that resulted from
that effort so if you could have your customer test it I'll commit it
straight away if it resolves the problem.

I've called the patch autofs-5.0.4-fix-hosts-map-use-after-free.patch.
You may need to delete the hunk that modifies CHANGELOG for it to apply
cleanly (or change it so it does apply, your choice).

autofs-5.0.4 - fix hosts map use after free

From: Paul Wankadia <junyer@google.com>

This patch fixed use a map entry after it has been freed in the
hosts map lookup module.
---

 CHANGELOG              |    1 +
 modules/lookup_hosts.c |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index af77b55..b950449 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -8,6 +8,7 @@
 - make hash table scale to thousands of entries (Paul Wankadia,
   Valerie Aurora Henson).
 - clear the quoted flag after each character from program map input.
+- fix hosts map use after free (Paul Wankadia).
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/modules/lookup_hosts.c b/modules/lookup_hosts.c
index 93b975a..d3ae0e2 100644
--- a/modules/lookup_hosts.c
+++ b/modules/lookup_hosts.c
@@ -138,17 +138,19 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, name, LKP_DISTINCT);
 	if (me) {
+		struct mapent_cache *fmc = me->mc;
+
 		if (me->status >= time(NULL)) {
-			cache_unlock(me->mc);
+			cache_unlock(fmc);
 			return NSS_STATUS_NOTFOUND;
 		}
 
 		if (!me->mapent) {
-			cache_delete(me->mc, name);
+			cache_delete(fmc, name);
 			me = NULL;
 		}
 
-		cache_unlock(me->mc);
+		cache_unlock(fmc);
 	}
 
 	cache_readlock(mc);
