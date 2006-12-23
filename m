From: Jens Tautenhahn <shogun@tausys.franken.de>
Subject: Patch for autofs 4.1.4 to mount Windows administrative
	shares
Date: Sat, 23 Dec 2006 09:39:59 +0100
Message-ID: <458CEB5F.9050201@tausys.franken.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070301080504020005050107"
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

This is a multi-part message in MIME format.
--------------070301080504020005050107
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello!

For each local drive letter Windows starting from Version 2000 provides
automatically a share with the names C$, D$, etc. In order to be able to
access these shares, the file /etc/auto.smb needs a small patch, which I
attached.

Jens

--------------070301080504020005050107
Content-Type: text/x-patch;
 name="auto.smb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="auto.smb.patch"

23c23
< 	/Disk/	{ if (first) { print opts; first=0 }; print " \\\n\t /" $2, "://" key "/" $2 }
---
> 	/Disk/	{ if (first) { print opts; first=0 }; gsub(/\$$/, "\\$", $2); print " \\\n\t /" $2, "://" key "/" $2 }

--------------070301080504020005050107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070301080504020005050107--

