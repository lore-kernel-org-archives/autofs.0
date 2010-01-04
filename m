From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] add -F/--force option to help/usage
Date: Mon, 4 Jan 2010 15:13:54 -0200
Message-ID: <20100104171353.GA28088@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=8sK3MtcT5wijyfop+hX+ENRIt3HPq8VLK1cWd0/B+PU=;
	b=azsisXijZUshikzYv7wGhnsUzBOwxtU/dx6/aHahlAPTaEUGOPZZWo+cFKcnvwp/l1
	LW4M9Vyt4FqSQfb5UKEcDe/ILxvFBjfYWkYr3a9h5zoUQmuJX5pbfw3dCk62SuTFIvfF
	tuLE7S2RM1BbnZN4HVq1gwrQtC9/brUCVRHqw=
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


    autofs-5.0.5 - add -F/--force option to help/usage

    Add -F/--force option to automount's help/usage.  This is a missing
    bit in commit 675c1355ff.

    Signed-off-by: Leonardo Chiquitto <lchiquitto@suse.de>

Index: autofs/daemon/automount.c
===================================================================
--- autofs.orig/daemon/automount.c
+++ autofs/daemon/automount.c
@@ -1678,6 +1678,7 @@ static void usage(void)
 		"			set daemon log verbosity\n"
 		"	-C --dont-check-daemon\n"
 		"			don't check if daemon is already running\n"
+		"	-F --force	force unlink of mount tree at startup\n"
 		"	-V --version	print version, build config and exit\n"
 		, program);
 }
