From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 3/3] Man update for dir map-type
Date: Fri, 14 Jan 2011 23:39:45 +0900 (JST)
Message-ID: <20110114.233945.907587178645889112.yamato@redhat.com>
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

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 man/auto.master.5.in |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 453ff98..e8d7bea 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -107,6 +107,13 @@ appropriate certificate must be configured in the LDAP client.
 .B multi
 This map type allows the specification of multiple maps separated
 by "--". These maps are searched in order to resolve key lookups.
+.TP
+.B dir
+This map type can be used at 
+.BR + 
+master map including notation. The contents of files under given directory are included
+to the master map. The name of file to be included must be started with "auto.". A file
+will be ignored if its name is not started with the prefix.
 .RE
 .TP
 \fBformat\fP
@@ -118,7 +125,7 @@ left unspecified, it defaults to \fBsun\fP for all map types except
 .TP
 \fBmap\fP
 Name of the map to use.  This is an absolute UNIX pathname
-for maps of types \fBfile\fP or \fBprogram\fP, and the name of a database
+for maps of types \fBfile\fP, \fBdir\fP, or \fBprogram\fP, and the name of a database
 in the case for maps of type \fByp\fP, \fBnisplus\fP, or \fBhesiod\fP or
 the \fBdn\fP of an LDAP entry for maps of type \fBldap\fP.
 .TP
-- 
1.7.3.4
