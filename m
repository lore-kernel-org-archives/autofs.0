From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 23:16:04 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502152315060.8319@donald.themaw.net>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
	<Pine.LNX.4.61.0502152253120.8175@donald.themaw.net>
	<Pine.LNX.4.61.0502152303450.8273@donald.themaw.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0502152303450.8273@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Tue, 15 Feb 2005 raven@themaw.net wrote:

> On Tue, 15 Feb 2005 raven@themaw.net wrote:
>
>> On Tue, 15 Feb 2005, Steinar H. Gunderson wrote:
>> 
>>> - The check for /proc/modules does not seem to have went in (see
>>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=292762).
>> 
>> I though I checks this?
>> 
>> Or have you changed the bug id?
>
> I've read the bug report you refer to but if I'm to get it right you need to 
> provide a patch.

Is this what you're seeking?

Index: samples/rc.autofs.in
===================================================================
RCS file: /home/cvs/root/autofs/samples/rc.autofs.in,v
retrieving revision 1.47
retrieving revision 1.48
diff -u -r1.47 -r1.48
--- samples/rc.autofs.in	10 Feb 2005 14:30:07 -0000	1.47
+++ samples/rc.autofs.in	15 Feb 2005 15:27:34 -0000	1.48
@@ -1,6 +1,6 @@
  #!/bin/bash
  #
-# $Id: rc.autofs.in,v 1.47 2005/02/10 14:30:07 raven Exp $
+# $Id: rc.autofs.in,v 1.48 2005/02/15 15:27:34 raven Exp $
  #
  # rc file for automount using a Sun-style "master map".
  # We first look for a local /etc/auto.master, then a YP
@@ -604,7 +604,7 @@
  		# autofs filesystem support not loaded
  		echo -n ' loading autofs4 kernel module,'
  		modprobe autofs4 || true
-	elif lsmod | grep -q autofs[^4]; then
+	elif ([ -f /proc/modules ] && lsmod) | grep -q autofs[^4]; then
  		# wrong autofs filesystem module loaded
  		echo
  		echo "WARNING: autofs kernel module is loaded, autofs4 needed"
