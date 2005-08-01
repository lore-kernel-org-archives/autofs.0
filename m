From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] clear whatstr in get_best_mount when host name
	lookup fails
Date: Mon, 1 Aug 2005 22:20:23 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0508012214140.2061@donald.themaw.net>
References: <17116.9480.197620.834203@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0507301403390.2871@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0507301403390.2871@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Sat, 30 Jul 2005, Ian Kent wrote:

> On Mon, 18 Jul 2005, Jeff Moyer wrote:
> 
> > Hi, Ian,
> > 
> > A "bug" was introduced into the get_best_mount function at some point.
> > Basically, if is_local_mount returns failure, we should be setting *what to
> > NULL, since this is what the caller checks:
> > 
> >         colon = strchr(whatstr, ':');
> >         if (!colon) {
> >                 /* No colon, take this as a bind (local) entry */
> >                 local = 1;
> >         } else if (!nosymlink) {
> >                 local = get_best_mount(whatstr, what, 0);
> >                 if (!*whatstr) {                <---------------
> >                         warn(MODPREFIX "no host elected");
> >                         return 1;
> >                 }
> >                 debug(MODPREFIX "from %s elected %s", what, whatstr);
> >         }
> > 
> > Prior to the patches in this area of code, we did indeed set *what to NULL
> > before returning in this specific case (the host name resolution failed,
> > and this was the only entry).
> > 
> > The way the code stands, you will end up failing the mount (for the very
> > same reason, the host name lookup will fail).  So, this patch is relatively
> > low on the priority scale.  However, it seems like a correctness issue to
> > me.  Otherwise, we should get rid of the check for *whatstr.
> 
> Looks like this bug it`s a bit worse.
> 
> If we have a replcated mount with two hosts where, say, the first is 
> dowm and the second fails name lookup then we try to mount the first 
> (instead of failing) leading to a hang of a couple of minutes while mount 
> times out.
> 
> > 
> > Let me know what you think.
> 
> Ouch!

I added the hunk at the bottom to the patch.
I haven't had time to test it yet.

Check it out and let me know what you think.
Interestingly, I might have missed this except that I have a dual boot box 
in the a replicated list map and this caused mount to and hang in the case 
described above. Takes about 2 mins to timeout. I was testing something 
else when I stumbled on it.

--- autofs-4.1.4/modules/mount_nfs.c.whatstr	2005-07-30 14:17:40.000000000 +0800
+++ autofs-4.1.4/modules/mount_nfs.c	2005-07-30 14:24:50.000000000 +0800
@@ -197,12 +197,14 @@ int get_best_mount(char *what, const cha
 	 *  do anything except strip whitespace from the end of the string.
 	 */
 	if (!is_replicated_entry(p)) {
+		int ret;
 		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) 
 			if (isspace(*pstrip))
 				*pstrip = '\0';
 
 		/* Check if the host is the localhost */
-		if (is_local_mount(p) > 0) {
+		ret = is_local_mount(p);
+		if (ret > 0) {
 			debug(MODPREFIX "host %s: is localhost", p);
 
 			/* Strip off hostname and ':' */
@@ -213,7 +215,9 @@ int get_best_mount(char *what, const cha
 				what++;
 			}
 			return 1;
-		}
+		} else if (ret < 0)
+			*what = '\0';
+
 		return 0;
 	}
 
@@ -344,8 +348,14 @@ int get_best_mount(char *what, const cha
 	}
 
 	/* No winner found so return first */
-	if (!winner)
-		winner = what;
+	/* No - this will lead to mount hanging if the first host
+	 *	is not available. Since we tried to ping it and
+	 *	failed that's likely the case.
+	 */
+	if (!winner) {
+		*what = '\0';
+		return 0;
+	}
 
 	/*
 	 * We now have our winner, copy it to the front of the string,
