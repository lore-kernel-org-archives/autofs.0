From: raven@themaw.net
Subject: [PATCH 0/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 20:40:59 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102030350.540@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Michael Blandford <michael@kmaclub.com>, autofs mailing list <autofs@linux.kernel.org>


A problem with tree mounts expiring from under a process has uncovered a
couple of problems with the autofs4 module. These patches are a result of 
the investigation.

1) autofs4-2.6.12-rc1-mm4-wait-order.patch

It's possible for an event wait request to arive before the event
requestor. If this happens the daemon never gets notified and autofs
hangs.

2) autofs4-2.6.12-rc1-mm4-tree-race.patch

For tree mount maps, a call to chdir or chroot, to a directory above the
moint point directories at a certain time during the expire results in 
the expire incorrectly thinking the tree is not busy. This patch adds a 
check to see if the filesystem above the tree mount points is busy and 
also locks the filesystem during the tree mount expire to prevent the 
race.

3) autofs4-2.6.12-rc1-mm4-version.patch

Bump autofs4 version so we know what's going on.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian


