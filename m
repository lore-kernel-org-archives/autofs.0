From: raven@themaw.net
Subject: [ANNOUNCE] autofs4 2.4 updated module build kit and kernel patches
Date: Tue, 4 Jan 2005 23:58:11 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501042238370.20210@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi all,

I have updated the autofs4 kernel module patches to match the 
implementation in 2.6.10.

The most significant change is the addition of code to handle compatible 
ioctls for architectures that need it. It is important for systems like 
Gentoo or Debian on Ultra sparc, for example.

The files are located in:

http://www.kernel.org/pub/linux/daemons/autofs/v4

and are

the build kit:
     autofs4-2.4-module-20041227.tar.[bz2|gz]

vanila kernel patches:
     autofs4-2.4.18-20041227.patch
     autofs4-2.4.19-20041227.patch
     autofs4-2.4.20-20041227.patch
     autofs4-2.4.21-20041227.patch
     autofs4-2.4.22-20041227.patch
     autofs4-2.4.27-20041227.patch

RedHat 9:
     autofs4-2.4.20-redhat9-20041227.patch

Fedora Core 1:
     autofs4-2.4.22-fc1-20041227.patch


Ian



