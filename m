From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Wed, 10 Dec 2003 18:35:07 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312101829270.3247-100000@raven.themaw.net>
References: <3FD2ADE5.6050403@kmaclub.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD2ADE5.6050403@kmaclub.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Blandford <michael@kmaclub.com>
Cc: autofs@linux.kernel.org

On Sat, 6 Dec 2003, Michael Blandford wrote:

> Hello,
> 
> I am currently running autofs 3.1.7 from Fedora Core 1.  I am trying to 
> upgrade to 4.1.0-beta2 from atrpms.
> 
> I recently switched to using ldap.  I admit I dont understand it the way 
> I do NIS..but anyway.  Here is what my "map" looks like:
> 
> auto.services:
> /       fileserver:/export/services/&
> a       fileserver:/export2/a
> b       fileserver:/export2/b
> c       fileserver:/export2/c
> d       fileserver:/export2/d
> 
> This works fine under 3.1.7.  With 4.1.0, cd'ing into 
> /services/<anything> results in /export2/b getting mounted.  I can't 
> understand this at all.
> 
> Any thoughts on how to fix this or debug the problem?

Could you try this patch please.

I'll add it to my source rpm at kernel.org if it works OK for you.
You will need to grab a src rpm, build it, install the bin, got to the rpm 
build directory and do make clean, apply the patch, and make then make 
install. Be aware this will toast youre autofs init script, auto.master 
and auto.net (if you have changed them.

diff -Nur autofs-4.1.0.orig/lib/cache.c autofs-4.1.0/lib/cache.c
--- autofs-4.1.0.orig/lib/cache.c	2003-12-09 23:13:37.000000000 +0800
+++ autofs-4.1.0/lib/cache.c	2003-12-10 17:57:10.000000000 +0800
@@ -148,11 +148,15 @@
 
 int cache_update(const char *key, const char *mapent, time_t age)
 {
-	struct mapent_cache *me = NULL;
+	struct mapent_cache *s, *me = NULL;
 	char *pkey, *pent;
 	unsigned int hashval;
 
-	if ((me = cache_lookup(key)) == NULL) {
+	for (s = mapent_hash[hash(key)]; s != NULL; s = s->next)
+		if (strcmp(key, s->key) == 0)
+			me = s;
+
+	if (me == NULL) {
 		me = (struct mapent_cache *) malloc(sizeof(struct mapent_cache));
 		if (me == NULL) {
 			return 0;
@@ -348,14 +352,11 @@
 				       "cache_ghost: entry in %s not valid map format, key %s",
 				       gc.mapname, gc.key);
 			} else if (match == LKP_WILD) {
-				/* Wildcard must be last key in map */
 				if (*me->key == '/')
 					syslog(LOG_NOTICE,
 					       "cache_ghost: wildcard map key not valid in direct map");
-				else
-					syslog(LOG_NOTICE,
-					       "cache_ghost: cannot ghost wildcard map key");
-				break;
+				me = me->next;
+				continue;;
 			}
 
 			switch (match) {

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
