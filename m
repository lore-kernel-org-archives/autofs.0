From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Wed, 21 Jan 2009 12:49:07 +0900
Message-ID: <1232509747.3931.5.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232504588.3931.0.camel@zeus.themaw.net>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Wed, 2009-01-21 at 11:23 +0900, Ian Kent wrote:
> On Tue, 2009-01-20 at 16:48 +1100, Paul Wankadia wrote:
> > A friend of mine was kind enough to run some analysis for me. A couple
> > of problems jumped out immediately.
> > 
> > 
> >     991 static char *make_fullpath(const char *root, const char *key)
> > ...
> >    1000                 path = malloc(l);
> >    1001                 strcpy(path, key);
> > ...
> >    1006                 path = malloc(l);
> >    1007                 sprintf(path, "%s/%s", root, key);
> > 
> > Those are unchecked malloc(3) calls. How would you prefer to handle
> > failures?
> > 
> > 
> >    1012 int lookup_prune_cache(struct autofs_point *ap, time_t age)
> > ...
> >    1075                                 cache_unlock(mc);
> >    1076                                 free(key);
> >    1077                                 if (next_key)
> >    1078                                         free(next_key);
> >    1079                                 free(path);
> >    1080                                 goto next;
> > ...
> >    1103 next:
> >    1104                         cache_readlock(mc);
> >    1105                         me = cache_lookup_distinct(mc,
> > next_key);
> >    1106                         free(key);
> >    1107                         free(path);
> >    1108                         free(next_key);
> > 
> > Those are double free(3) calls. Oh, and `next_key' is used after being
> > freed.
> 
> Thanks, I'll fix these.

Fortunately, these cases usually don't happen so we haven't seen a
problem with it already.

Anyway, i think this is all we need although continuing after an malloc
fail is a bit questionable. Suggestions?

autofs-5.0.4 - couple of lookup.c corrections

From: Ian Kent <raven@themaw.net>

A couple of mistakes in lookup.c were reported:
- a malloc(3) allocation return was not being checked in make_fullpath().
- a double free and a use after free was identified in lookup_prune_cache().
---

 daemon/lookup.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)


diff --git a/daemon/lookup.c b/daemon/lookup.c
index 741d846..d55feb9 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -998,12 +998,16 @@ static char *make_fullpath(const char *root, const char *key)
 		if (l > KEY_MAX_LEN)
 			return NULL;
 		path = malloc(l);
+		if (!path)
+			return NULL;
 		strcpy(path, key);
 	} else {
 		l = strlen(key) + 1 + strlen(root) + 1;
 		if (l > KEY_MAX_LEN)
 			return NULL;
 		path = malloc(l);
+		if (!path)
+			return NULL;
 		sprintf(path, "%s/%s", root, key);
 	}
 	return path;
@@ -1073,10 +1077,6 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 			this = cache_lookup_distinct(mc, key);
 			if (!this) {
 				cache_unlock(mc);
-				free(key);
-				if (next_key)
-					free(next_key);
-				free(path);
 				goto next;
 			}
 
@@ -1094,18 +1094,14 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 			}
 			cache_unlock(mc);
 
-			if (!next_key) {
-				free(key);
-				free(path);
-				cache_readlock(mc);
-				continue;
-			}
 next:
 			cache_readlock(mc);
-			me = cache_lookup_distinct(mc, next_key);
+			if (next_key) {
+				me = cache_lookup_distinct(mc, next_key);
+				free(next_key);
+			}
 			free(key);
 			free(path);
-			free(next_key);
 		}
 		pthread_cleanup_pop(1);
 		map->stale = 0;
