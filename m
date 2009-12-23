From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] fix strdup() return value check
Date: Wed, 23 Dec 2009 18:00:59 -0200
Message-ID: <20091223200059.GB26944@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=pf9FuIy+ZiQqX1Gd+45oOyHVYoBBfGVizwl9rfdBmdc=;
	b=H48UuSryTj/CxanTWAPzcw7m8nyOA1fHVC13hQbZbxnwSapLTb9uTPMO7Vr0k0lJ0P
	q58vy72c3KugWbzgwLhGfzGQToXFCExILPhXScL1D0mAyKRVfU1AEDAWgFhICzm733P+
	SJ58qPnPWz7MSfxmZH6SB6rhNjsAI5PXF49tQ=
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

Ian,

  Please consider the following patch.

Thanks,
Leonardo


    autofs-5.0.5 - fix strdup() return value check

    Fix copy and paste error when checking strdup() return value, originally
    reported by David Binderman in:

    http://bugzilla.novell.com/show_bug.cgi?id=523348

Index: autofs/lib/defaults.c
===================================================================
--- autofs.orig/lib/defaults.c
+++ autofs/lib/defaults.c
@@ -65,7 +65,7 @@ static char *get_env_string(const char *
 		return NULL;
 
 	res = strdup(val);
-	if (!val)
+	if (!res)
 		return NULL;
 
 	return res;
