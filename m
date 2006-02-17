From: Ian Kent <raven@themaw.net>
Subject: [RFC:PATCH 0/4] autofs4 - add direct mount functionality to autofs
Date: Fri, 17 Feb 2006 15:00:47 +0800
Message-ID: <200602170700.k1H70lnw004000@eagle.themaw.net>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

These patches are for autofs version 5.

This is the second set of patches for autofs to support the user
space daemon (automount from the autofs package) implementation of
direct mounts and lazy mount and expire of nested mount maps, such
as those found in mounting the NFS exports from a host, known as
a "hosts" map.

I'd like to thank my collegue, Jeff Moyer at RedHat for his efforts
reviewing all the autofs patches, both this set and previous patches.
His efforts have made a big difference to the quality and accuracy
of autofs in general for a long time now.

The changes implemented in the patch set are:

1) update-nameidata-on-follow_link - autofs needs the nameidata
   struct to be up to date wrt the dentry passed to the inode
   follow_link operation.
2) v5-follow_link - defines the version 5 inode follow_link
   operation used to trigger direct mounts.
3) v5-expire - update expire to handle version 5 direct mounts.
4) v5-packet-proto - update communication packet to support
   version 5 extended packet information.

Ian

