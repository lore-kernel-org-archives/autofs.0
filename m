From: Ian Kent <raven@themaw.net>
Subject: [PATCH 22/25] autofs-5.0.7 - improve timeout option description
Date: Mon, 19 Aug 2013 09:14:23 +0800
Message-ID: <20130819011422.6472.13375.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=yuMbwwneqagnJ2JaQ8yuvguMt7s=; b=sf1h/2+vxEAfVziNrVZQYbMTRy7w
	hDh+vt8jrKpsDZLssDFjovuDNpLjyJoCNC9MQc1v9liQgkWJ5cidf5CyKzaGaLFr
	PziuhrhYQJTqskpdf61ETUWGA9i15fEHXJnV5GgdXYr7OedvKMLdDNs9yshg4BMu
	sWYQCTTzM3gVg8M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=yuMbwwneqagnJ2JaQ8yuvg
	uMt7s=; b=MGX76AD/HNklFg9Lkvh7OJ5+WwualMun4prkzUusPtc05geyBRPlSP
	tXFTh9/0XM5zL/RV6N/0z0DkkwuEcN/8/Qk3GZEI61CEzLWv+Dgc0ZN33l39Ymrz
	ZDs5LTdGy0MeYP5cY16E99F5k3VMmqFze7u8EEDxtaaMYuTaUpXOs=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

The description of the configuration option is a little misleading.
So add some explaination about the internal default and the reason
the default installed configuration overrides it.
---
 CHANGELOG                      |    1 +
 man/auto.master.5.in           |    5 ++++-
 man/automount.8                |    5 ++++-
 redhat/autofs.sysconfig.in     |    5 ++++-
 samples/autofs.conf.default.in |    5 ++++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c3f12e5..9639703 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -73,6 +73,7 @@
 - teach dumpmaps to output simple key value pairs.
 - fix syncronize handle_mounts() shutdown.
 - fix fix wildcard multi map regression.
+- improve timeout option description.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 7907ffa..65a86b2 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -212,7 +212,10 @@ configuration file
 They are:
 .TP
 .B TIMEOUT
-sets the default mount timeout (program default 600).
+Sets the default mount timeout in seconds. The internal program
+default is 10 minutes, but the default installed configuration
+overrides this and sets the timeout to 5 minutes to be consistent
+with earlier autofs releases.
 .TP
 .B NEGATIVE_TIMEOUT
 Set the default timeout for caching failed key lookups (program default
diff --git a/man/automount.8 b/man/automount.8
index 48f5c5a..abb40bc 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -29,10 +29,13 @@ Print brief help on program usage.
 .I "\-p, \-\-pid-file"
 Write the pid of the daemon to the specified file.
 .TP
-.I "\-t, \-\-timeout"
+.I "\-t <seconds>, \-\-timeout <seconds>"
 Set the global minimum timeout, in seconds, until directories
 are unmounted. The default is 10 minutes. Setting the timeout
 to zero disables umounts completely.
+The internal program default is 10 minutes, but the default
+installed configuration overrides this and sets the timeout
+to 5 minutes to be consistent with earlier autofs releases.
 .TP
 .I "\-n <seconds>, \-\-negative\-timeout <seconds>"
 Set the default timeout for caching failed key lookups. The default is 60 seconds.
diff --git a/redhat/autofs.sysconfig.in b/redhat/autofs.sysconfig.in
index a8992c4..9d8d704 100644
--- a/redhat/autofs.sysconfig.in
+++ b/redhat/autofs.sysconfig.in
@@ -5,7 +5,10 @@
 #
 #MASTER_MAP_NAME="auto.master"
 #
-# TIMEOUT - set the default mount timeout (default 600).
+# TIMEOUT - set the default mount timeout in secons. The internal
+#	    program default is 10 minutes, but the default installed
+#	    configuration overrides this and sets the timeout to 5
+#	    minutes to be consistent with earlier autofs releases.
 #
 TIMEOUT=300
 #
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index 1da89cf..695b010 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -5,7 +5,10 @@
 #
 #MASTER_MAP_NAME="auto.master"
 #
-# TIMEOUT - set the default mount timeout (default 600).
+# TIMEOUT - set the default mount timeout in secons. The internal
+#	    program default is 10 minutes, but the default installed
+#	    configuration overrides this and sets the timeout to 5
+#	    minutes to be consistent with earlier autofs releases.
 #
 TIMEOUT=300
 #

