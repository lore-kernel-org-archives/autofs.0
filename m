From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 2/8] Set LDAP_DEPRECATED to
	prevent coredumps with modern ldap libraries
Date: Tue, 14 Dec 2010 15:36:13 +1300
Message-ID: <9c0a7032055f8463bd67d3bd959d1aef0e6aac36.1295972820.git.bill.ryder.nz@gmail.com>
References: <cover.1295972820.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1295972820.git.bill.ryder.nz@gmail.com>
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

---
 CHANGELOG        |    5 +++++
 configure.in     |    1 +
 samples/Makefile |    2 +-
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 467e90a..9dd8185 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,8 @@
+17/6/2010 autofs-4.1.4 - bryder p38
+---------------------------
+Added LDAP patch to stop the autofs-ldap-auto-master and lookup_ldap.so from crashing on modern ldap libraries. 
+It sets the LDAP_DEPRECATED macro to 1. Obviously the ldap stuff needs some updating.
+
 16/6/2010 autofs-4.1.4 - bryder p37
 -------------------------
 Moved the autofs-4.1.3 version of the dump map patch to 4.1.4 (without the lookup_files hack)
diff --git a/configure.in b/configure.in
index eb56ac7..623e92b 100644
--- a/configure.in
+++ b/configure.in
@@ -118,6 +118,7 @@ AC_ARG_WITH(openldap,
 )
 if test -z "$HAVE_LDAP"; then
 	HAVE_LDAP=0
+	LDAP_FLAGS="$LDAP_FLAGS -DLDAP_DEPRECATED=1"
 	AC_CHECK_LIB(ldap, ldap_init, HAVE_LDAP=1 LIBLDAP="$LIBLDAP -lldap -llber -lresolv", ,
 		     -llber -lresolv $LIBS)
 fi
diff --git a/samples/Makefile b/samples/Makefile
index d69d6e7..f5aa2ba 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -16,7 +16,7 @@ LIBS = -lldap -llber
 all: $(BINS) rc.autofs
 
 autofs-ldap-auto-master: $(OBJS)
-	$(CC) $(LDFLAGS) -o autofs-ldap-auto-master $(OBJS) $(LIBS)
+	$(CC) $(LDFLAGS) $(LDAP_FLAGS) -o autofs-ldap-auto-master $(OBJS) $(LIBS)
 	$(STRIP) autofs-ldap-auto-master
 
 rc.autofs: rc.autofs.in
-- 
1.7.3.4
