From: Jason Spashett <jason@spashett.com>
Subject: Patch: Correctly escape $ in auto.smb
Date: Thu, 11 Jun 2009 15:54:33 +0100
Message-ID: <4A311AA9.90701@spashett.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/385244

auto.smb does not escape the $ common in windows administrative shares. 
auto.smb has been changed to do this.

--- auto.smb.orig    2009-06-11 14:18:39.000000000 +0100
+++ auto.smb    2009-06-11 15:21:47.000000000 +0100
@@ -29,7 +29,7 @@
 
 $SMBCLIENT $smbopts -gL $key 2>/dev/null| awk -v key="$key" -v 
opts="$mountopts" -F'|' -- '
     BEGIN    { ORS=""; first=1 }
-    /Disk/    { if (first) { print opts; first=0 }; sub(/ /, "\\ ", 
$2); print " \\\n\t /", $2, "://" key "/" $2 }
+    /Disk/    { if (first) { print opts; first=0 }; gsub(/[ $]/, 
"\\\&", $2); print " \\\n\t /" $2, "://" key "/" $2 }
     END     { if (!first) print "\n"; else exit 1 }
     '
