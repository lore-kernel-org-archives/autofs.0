From: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: [PATCH 4.1.0] Get autofs RPMs building on x86_64
Date: Tue, 17 Feb 2004 21:21:34 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1077081694.3069.5.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@kernel.org

This patch also works on i386, and on other multilib architectures such
as s390.

--- autofs.spec.orig    2004-02-17 21:16:15.000000000 -0800
+++ autofs.spec 2004-02-17 21:16:58.000000000 -0800
@@ -51,7 +51,7 @@
 %patch0 -p1
  
 %build
-CFLAGS="$RPM_OPT_FLAGS" ./configure --prefix=/usr
+CFLAGS="$RPM_OPT_FLAGS" ./configure --prefix=/usr --libdir=%{_libdir}
 make initdir=/etc/rc.d/init.d
  
 %install
