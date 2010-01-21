From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: debugging the automounter
Date: Thu, 21 Jan 2010 03:39:57 -0800
Message-ID: <4B583D0D.1050700@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:to:subject:content-type
	:content-transfer-encoding;
	bh=zgT4F0+Oiq7IxXJlXSXoCPMjm2atCwjh5SgxHk2wbOU=;
	b=OraA0Wk6MTY2CiOyP1jAaSZJDLuY9CrIWIFnb6yXGPjJXA+YsPuODBzfLDKWOPEd17
	ASrwywofOLUnElJpH5mkK1/yDLxsQb3tm4mjCSF7sWRY3zTTfO77vtJZR2mCYRzbwVGj
	NlfkjMIwXO77MqnINlt/z5jvF6R27Yvj2HOm4=
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
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

Are there any good links on how to go about setting up debugging the =

automounter using the gdb?

I=92m running rhel3 and trying to figure out an automounter problem. I=92ve =

installed the debuginfo package so the binary won=92t be stripped.

Does the debuginfo package install another binary to debug the =

automounter using gdb because the binary looks stripped to me=85?

# file /usr/sbin/automount
/usr/sbin/automount: ELF 32-bit LSB shared object, Intel 80386, version =

1 (SYSV), stripped

This is NOT stripped=85but I=92m not sure what this is used for or how to =

use it=85
# file /usr/lib/debug/usr/sbin/automount.debug
/usr/lib/debug/usr/sbin/automount.debug: ELF 32-bit LSB shared object, =

Intel 80386, version 1 (SYSV), not stripped

Basically, I=92d like to get to the point where I can have an non-stripped =

automounter and how to verify it is not stripped or how to build and =

debug it.

#gdb /usr/sbin/automount
GNU gdb Red Hat Linux (6.3.0.0-0.30.1rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain =

conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB. Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...(no debugging =

symbols found)
Using host libthread_db library "/lib/tls/libthread_db.so.1".
(gdb) quit

#uname -a
Linux l-sim-33-075 2.4.21-53.ELsmp #1 SMP Thu Feb 21 19:01:38 EST 2008 =

i686 athlon i386 GNU/Linux

# automount -V
Linux automount version 4.1.3-216

# rpm -qa | grep autofs
autofs-4.1.3-216
autofs-debuginfo-4.1.3-216

I=92d appreciate any help.

Thanks
Phil
