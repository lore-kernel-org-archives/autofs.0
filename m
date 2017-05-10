From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 10 May 2017 12:18:48 +0800
Message-ID: <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=S1F+XydPslgv0zFO/i
        gMr8MEBffMLSvxuyPJCJryMYA=; b=KpdZ68qgBFj3DEwES1ywX/kVBnqD1NSkDM
        iOdic4GtbfMGvXIKKiqtFI76tJzMmAcK8Tt8+5ZoGRVVDl/6SFTuhbf9xouMVpIL
        pFgD2RUrlS3hthS5doqW6UhXuVI5J84ZcZ0w2q25UIQIHT/jvhKCKk1dqY2jQjx9
        i2G8NDejPLW7ptY1Z6Q08jHiCCqY1QvAMflsAwHh6TucSQS7Weor14eDAVcqQp7v
        /TCeaLk11LB+7dK46g0zU3PcHFwmjHNSd+3j/RbLucu2bjURPb74XaqYZnxxnGpP
        myeDbhthMw1BOGGiCZNZiLMdbxAH7em0Hj/tsa0WT1qH4OPMq4XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=S1F+XydPslgv0zFO/igMr8MEBffMLSvxuyPJCJryMYA=; b=MY3Sh6yf
        D93JyVTbkOlPyyFUOrKHQkQ5CAdJPX1Kf0oCevEDQMZ+ndEOe6tpYiknij5CeBHg
        YjZQt0i6riXWg9EfYYwk+UyL25mvBlaNtsGRD7m8MCfAoN8jdJ28wcUadzxNp5dr
        2Q5ByBKWpZDHhP8XQYbPxsbIK2PvPzBd7kkzS8iACh+ey1fikQdKE7A1KkWTc9ES
        hKI2JY3bn8YdM9KC/79p8Al6L68nQ45u7nrSxmwN+EGR7ozZAifxHuixxs+pJeFL
        83rxsQjjMG5TlHYvHn2WLzsvAF+dxRGRU8IFJIh5qLEf5nGz3wZ3scq8UDyDqEwQ
        ObZf9igcTYqC0Q==
In-Reply-To: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
of an automount by the call. But this flag is unconditionally cleared
for all stat family system calls except statx().

stat family system calls have always triggered mount requests for the
negative dentry case in follow_automount() which is intended but prevents
the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.

In order to handle the AT_NO_AUTOMOUNT for both system calls the
negative dentry case in follow_automount() needs to be changed to
return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
required flags are clear).

AFAICT this change doesn't have any noticable side effects and may,
in some use cases (although I didn't see it in testing) prevent
unnecessary callbacks to the automount daemon.

It's also possible that a stat family call has been made with a
path that is in the process of being mounted by some other process.
But stat family calls should return the automount state of the path
as it is "now" so it shouldn't wait for mount completion.

This is the same semantic as the positive dentry case already
handled.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
Cc: stable@vger.kernel.org
---
 fs/namei.c         |   15 ++++++++++++---
 include/linux/fs.h |    3 +--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7286f87..cd74838 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1129,9 +1129,18 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 	 * of the daemon to instantiate them before they can be used.
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
-			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
-	    path->dentry->d_inode)
-		return -EISDIR;
+			   LOOKUP_OPEN | LOOKUP_CREATE |
+			   LOOKUP_AUTOMOUNT))) {
+		/* Positive dentry that isn't meant to trigger an
+		 * automount, EISDIR will allow it to be used,
+		 * otherwise there's no mount here "now" so return
+		 * ENOENT.
+		 */
+		if (path->dentry->d_inode)
+			return -EISDIR;
+		else
+			return -ENOENT;
+	}
 
 	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
 		return -EACCES;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 26488b4..be09684 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2935,8 +2935,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 static inline int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
 }
 static inline int vfs_fstat(int fd, struct kstat *stat)
 {

