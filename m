From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 2/3] Introduce /etc/auto.master.d
Date: Fri, 14 Jan 2011 23:38:52 +0900 (JST)
Message-ID: <20110114.233852.1150397032728723539.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

This patch introduces /etc/auto.master.d as default place where files
to be included to master map are put.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 autofs.spec         |    5 +++++
 samples/auto.master |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/autofs.spec b/autofs.spec
index a72a0c8..e54871f 100644
--- a/autofs.spec
+++ b/autofs.spec
@@ -67,6 +67,7 @@ mkdir -p -m755 $RPM_BUILD_ROOT%{_sbindir}
 mkdir -p -m755 $RPM_BUILD_ROOT%{_libdir}/autofs
 mkdir -p -m755 $RPM_BUILD_ROOT%{_mandir}/{man5,man8}
 mkdir -p -m755 $RPM_BUILD_ROOT/etc/sysconfig
+mkdir -p -m755 $RPM_BUILD_ROOT/etc/auto.master.d
 
 make install mandir=%{_mandir} initdir=/etc/rc.d/init.d INSTALLROOT=$RPM_BUILD_ROOT
 make -C redhat
@@ -104,8 +105,12 @@ fi
 %dir %{_libdir}/autofs
 %{_libdir}/autofs/*
 %{_mandir}/*/*
+%dir /etc/auto.master.d
 
 %changelog
+* Fri Jan 14 2011 Masatake YAMATO <yamato@redhat.com>
+- Added /etc/auto.master.d
+
 * Thu Sep 3 2009 Ian Kent <raven@themaw.net>
 - Update package to version 5.0.5.
 
diff --git a/samples/auto.master b/samples/auto.master
index 9fe5609..a6ea2d7 100644
--- a/samples/auto.master
+++ b/samples/auto.master
@@ -12,6 +12,10 @@
 #
 /net	-hosts
 #
+# Include /etc/auto.master.d/auto*
+#
++dir:/etc/auto.master.d
+#
 # Include central master map if it can be found using
 # nsswitch sources.
 #
-- 
1.7.3.4
