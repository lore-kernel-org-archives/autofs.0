From: raven@themaw.net
Subject: [ANNOUNCE] autofs4 - updated module build kit and kernel patches
Date: Sun, 10 Apr 2005 22:03:49 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102202260.18122@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


Hi all,

I have updated the autofs4 kernel module build kit (kernel 2.4) and
kernel patches (2.4 and 2.6).

The changes include a memory leak fix, a fix for expireing multi-mounts
when the tree is not n fact busy and a fix for lost mount notifications.

The files are located in:

http://www.kernel.org/pub/linux/daemons/autofs/v4

and are

the build kit:
      autofs4-2.4-module-20050404.tar.[bz2|gz]

vanila kernel patches:
      autofs4-2.4.18-20050404.patch
      autofs4-2.4.19-20050404.patch
      autofs4-2.4.20-20050404.patch
      autofs4-2.4.21-20050404.patch
      autofs4-2.4.22-20050404.patch
      autofs4-2.4.27-20050404.patch
      autofs4-2.4.29-20050404.patch
      autofs4-2.6.0-20050404.patch
      autofs4-2.6.4-20050404.patch
      autofs4-2.6.7-20050404.patch
      autofs4-2.6.9-20050404.patch
      autofs4-2.6.10-20050404.patch

RedHat 9:
      autofs4-2.4.20-redhat9-20050404.patch

Fedora Core 1:
      autofs4-2.4.22-fc1-20050404.patch


Ian


