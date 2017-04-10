From: Ian Kent <raven@themaw.net>
Subject: Re: Changes to special character escaping?
Date: Mon, 10 Apr 2017 16:07:17 +0800
Message-ID: <1491811637.4382.3.camel@themaw.net>
References: <CAFVxx_NaVK6J=tvfCa7AUQDaGLPE0ipZjpcqc1N55N4KrY5kKA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=0DmZMuPcA4SRsIuM/3
        HQd2nCXa8kVDNwoYZNvLp7ncY=; b=Kcm4FNDaeBu+73Eao3XLY2Sma75xtNgcw1
        JM1xLh5xZAHUYcuLPnQESbAm3MlXi473UxbizCe3oa6Y5+9XBpww++6eBBuJL+IL
        WvQ7HjTJ4SAImrL2ZPh0DBbROh8Tm9F4jXVt/6PrOBs16AEk+7PUG1/0vJ+EzoDb
        h2CqJ/PlN0eFHB1c4BSMGgCUMWoKIj8BluHSKnTwzOxJebMFVCjVSBmbu/n7DQb0
        6xsW50HzNmRHVMfMUTrkgnbkWWQTST6JUOD2jd80btFzpwtQYuIFUEqCiQK/91rF
        FfXOBBzBFAPoVZIjmYAJODwP0g93Qk2W2Esop+5qYiiUqAjT3xAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=0DmZMuPcA4SRsIuM/3HQd2nCXa8kVDNwoYZNvLp7ncY=; b=S1bulyjF
        K23lW65c6iZ2lV/cQut/cvg4qXB4jhbBjywBZ0f5gK2SReRBFgvFdjd+bpzy4T3G
        3Deu+DPejzgH1REKmFOVzcoLz4nzi1xfvabbRv0yXW0pUT3cMc46DCoYX/U5MDsX
        lUbY4+/XRCgUs+ur8JzYdJqBRzVRBpuE2T2c4wXrXjnBEBvGkOSpGotv848UjT4L
        4jIzbrjoPLQ0B6h1mNpQw+12M8Q3TIERrz7sMdLw+kGnuoZKR/51djk5S4XLWFZn
        TILUBdecnXHR8RsftCka/E+F30eZxUaPPKWQubakFCKs2GJf6BqBz3jYniKt7iB5
        gXmc+pJKW0P0xw==
In-Reply-To: <CAFVxx_NaVK6J=tvfCa7AUQDaGLPE0ipZjpcqc1N55N4KrY5kKA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mark Fox <mfox@customdatacentre.com>, autofs@vger.kernel.org

On Fri, 2017-04-07 at 16:56 -0600, Mark Fox wrote:
> Has something changed regarding escaping of special characters? The
> methods used to deal with special characters in maps that are included
> in distributions (ie. Ubuntu 16.04.2, so automount 5.1.1) no longer
> seem to work.

The problem is probably this patch, as you can see from the description
(spelling mistakes and all) there's a conflict depending on how the map entry
key is obtained, not sure what to do about it yet since I think this will be (at
least) the third time cifs escaping has been a problem .... lets look at a log.

autofs-5.1.0 - revert special case cifs escapes

From: Ian Kent <ikent@redhat.com>

The patch this reverts added an additional dquote on the mount location
to revolve "\"s but this causes inconsistent quoting between the lookup
key and the mount location when it is substituted using the &.

As described in the original patch:
"Since "\" is a valid seperator for cifs shares it can't be used to escape
characters in the share name passed to mount.cifs. So we have no choice
but to require that the seperator we use is "/" and de-quote the string
before sending it to mount.cifs."

We do need to require that the seperator "/" is used which alone should
eliminate the need for an additional dequote and expect that invalid
share name mounts will fail.
---
 CHANGELOG               |    1 +
 modules/mount_generic.c |   36 ++++++------------------------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 8080743..e21752b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -46,6 +46,7 @@
 - add config option to force use of program map stdvars.
 - fix incorrect check in parse_mount().
 - handle duplicates in multi mounts.
+- revert special case cifs escapes.
 
 04/06/2014 autofs-5.1.0
 =======================
diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index 2473b80..c4108e6 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -39,7 +39,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 {
 	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
-	char *loc;
 	int err;
 	int len, status, existed = 1;
 
@@ -75,44 +74,22 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	if (!status)
 		existed = 0;
 
-	/*
-	 * Special case quoting for cifs share names.
-	 *
-	 * Since "\" is a valid seperator for cifs shares it can't be
-	 * used to escape characters in the share name passed to
-	 * mount.cifs. So we have no choice but to require that the
-	 * seperator we use is "/" and de-quote the string before
-	 * sending it to mount.cifs.
-	 */
-	loc = NULL;
-	if (strcmp(fstype, "cifs"))
-		loc = strdup(what);
-	else
-		loc = dequote(what, strlen(what), ap->logopt);
-	if (!loc) {
-		error(ap->logopt,
-		      MODPREFIX "failed to alloc buffer for mount location");
-		return 1;
-	}
-
 	if (options && options[0]) {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s -o %s %s %s",
-		      fstype, options, loc, fullpath);
+		      fstype, options, what, fullpath);
 
 		err = spawn_mount(ap->logopt, "-t", fstype,
-				  "-o", options, loc, fullpath, NULL);
+				  "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt, MODPREFIX "calling mount -t %s %s %s",
-		      fstype, loc, fullpath);
-		err = spawn_mount(ap->logopt, "-t", fstype, loc, fullpath, NULL);
+		      fstype, what, fullpath);
+		err = spawn_mount(ap->logopt, "-t", fstype, what, fullpath, NULL);
 	}
 
 	if (err) {
 		info(ap->logopt, MODPREFIX "failed to mount %s (type %s) on %s",
-		     loc, fstype, fullpath);
-
-		free(loc);
+		     what, fstype, fullpath);
 
 		if (ap->type != LKP_INDIRECT)
 			return 1;
@@ -123,8 +100,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		return 1;
 	} else {
 		debug(ap->logopt, MODPREFIX "mounted %s type %s on %s",
-		     loc, fstype, fullpath);
-		free(loc);
+		     what, fstype, fullpath);
 		return 0;
 	}
 }
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
