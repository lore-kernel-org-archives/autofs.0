From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 10:47:06 -0500
Message-ID: <17283.15738.978933.591442@segfault.boston.redhat.com>
References: <1132670358.4039.37.camel@brilong-lnx>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1132670358.4039.37.camel@brilong-lnx>
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
Content-Type: text/plain; charset="us-ascii"
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] stat of /users/no-such-user takes 15 seconds; Brian Long <brilong@cisco.com> adds:

brilong> I have an auto.master deployed to thousands of hosts and it looks
brilong> like this:

brilong> /misc /etc/auto.misc --timeout=60 /auto /etc/auto.indirect
brilong> rsize=32768,wsize=32768,tcp /users auto_home
brilong> rw,hard,intr,rsize=32768,wsize=32768,tcp

brilong> As you can see, /users comes from NIS auto.home map.  In our case,
brilong> auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5
brilong> and beyond (autofs-4.1.3-130), trying to stat (ls)
brilong> /users/no-such-user takes roughly 12-15 seconds.  In RHEL 3 U3
brilong> (autofs-4.1.3-12), it returns immediately.  This is a regression
brilong> in my opinion.

brilong> After looking at tcpdump data, it appears automounter is
brilong> downloading the entire auto.home map when it fails to lookup
brilong> "no-such-user".  This results in a > 700KB transfer from the NIS
brilong> server :(

brilong> In the older autofs version, it does NOT do this.  I have opened a
brilong> Red Hat issue tracker (82760), but in parallel I wanted to ask
brilong> this list if this is known behavior and if there is any way I can
brilong> disable the download of the entire auto.home map using
brilong> /etc/sysconfig/autofs or auto.master options to the automount
brilong> program.

This is likely a side-effect of the cache expiry code.  Try this patch on
for size.

-Jeff

--- autofs-4.1.3/modules/lookup_yp.c.orig	2005-11-22 10:40:57.000000000 -0500
+++ autofs-4.1.3/modules/lookup_yp.c	2005-11-22 10:44:16.000000000 -0500
@@ -224,7 +224,7 @@ int lookup_mount(const char *root, const
 	int key_len;
 	char *mapent;
 	int mapent_len;
-	struct mapent_cache *me;
+	struct mapent_cache *me, *exists;
 	int ret;
 	time_t now = time(NULL);
 	time_t t_last_read;
@@ -240,7 +240,13 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
-	/* check map and if change is detected re-read map */
+	/*
+	 * check map and if change is detected re-read map
+	 */
+
+	/* First check to see if this entry exists in the cache */
+	exists = cache_lookup(key);
+
 	ret = lookup_one(root, key, key_len, ctxt);
 
 	debug("ret = %d", ret);
@@ -270,8 +276,8 @@ int lookup_mount(const char *root, const
 		if (ap.type == LKP_INDIRECT)
 			lookup_wild(root, ctxt);
 
-		/* Have parent update its map */
-		if (t_last_read > ap.exp_runfreq)
+		/* Have parent update its map if the key existed before */
+		if (exists && t_last_read > ap.exp_runfreq)
 			kill(getppid(), SIGHUP);
 	}
