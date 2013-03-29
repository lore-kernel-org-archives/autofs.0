From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Mounts not expiring in setups with nested submounts
Date: Fri, 29 Mar 2013 17:33:54 -0300
Message-ID: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=byfzcp6pXQmCjMc3MumDHQ0nMQ1ow5DpMZ/O/6Hk2U4=;
        b=zHJZWxdUTPPoItdlbfd2BLkV95NK4E5CdNadpP4H/cvRuZpp2JThdUyd43Yi6j80X+
         PQxlyhNJtbU7sX4hiGDA07ZcggRVNPcKFVN2SNZBRhyRbnzF50SJsy6dxXQxaz7HHEPA
         MKu+iT/lOQBTeU3ZMFUbUugNQj+R5TR4ayAOuqCZqniHiRVfZOZ3j1gRMRX7Vm/z/P+S
         jYmGCpjdLlg7jdnOWY+PkhWOHgmfjDCmA+kgaf44a6KLnugLd0bEBxwhNR7GZq4wddra
         Bh2gL+N+iltJBHmJfY3m3AKMvKMBcQgVYQOkKOZXLjP+MDiE/jDeZDF1684SysGzfXAU
         AWqA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hi,

In some configurations that use nested submounts, a busy volume
can prevent AutoFS from expiring other mounts. This was reported
by a customer and I'm able to reproduce it with a "minimal" config:

In your NFS server, export the following structure of directories:
/nfs/vol/a/mount1
/nfs/vol/a/mount100
/nfs/vol/b/mount1
/nfs/vol/b/mount100
/nfs/vol/b/mount200

AutoFS configuration:
BROWSE_MODE="yes"
TIMEOUT=60

auto.master:
/vol /etc/auto.vol
--
auto.vol:
a -fstype=autofs file:/etc/auto.vol.a
b -fstype=autofs file:/etc/auto.vol.b
--
auto.vol.a:
disk1 -fstype=autofs file:/etc/auto.vol.a.disk1
mount1 server:/nfs/vol/a/mount1
--
auto.vol.b:
disk1 -fstype=autofs file:/etc/auto.vol.b.disk1
disk2 -fstype=autofs file:/etc/auto.vol.b.disk2
mount1 server:/nfs/vol/b/mount1
--
auto.vol.a.disk1:
mount100 server:/nfs/vol/a/mount100
--
auto.vol.b.disk1:
mount100 server:/nfs/vol/b/mount100
--
auto.vol.b.disk2:
mount200 server:/nfs/vol/b/mount200
--

Steps to reproduce the problem:

1. Trigger mount of /vol/b/disk2/mount200 first and keep it busy
2. Mount all the other exported volumes

mount(8) output must be something like this (I think the order matters):
server:/nfs/vol/b/mount200 on /vol/b/disk2/mount200 type nfs
(rw,addr=10.121.8.27)
server:/nfs/vol/b/mount1 on /vol/b/mount1 type nfs (rw,addr=10.121.8.27)
server:/nfs/vol/b/mount100 on /vol/b/disk1/mount100 type nfs
(rw,addr=10.121.8.27)
server:/nfs/vol/a/mount1 on /vol/a/mount1 type nfs (rw,addr=10.121.8.27)
server:/nfs/vol/a/mount100 on /vol/a/disk1/mount100 type nfs
(rw,addr=10.121.8.27)

After the timeout, /vol/b/disk1/mount100 will be correctly unmounted,
but the other mounts will never expire (not even with SIGUSR1).
In this example only 4 mounts are blocked, but in some occasions
we've seen dozens of non-expiring mounts because of this bug.

I debugged the problem and discovered that it happens because
the recursion implemented in master_notify_submount() stops
on purpose after the first level of nested submounts. This was
implemented in autofs-5.0.4-expire-specific-submount-only.patch.

The patch below fixes the problem, but re-introduces recursion to
deeper levels. Tests didn't reveal any regression so far.

Ian: do you think the "occasional deadlocks" mentioned in the
expire-specific-submount-only patch might have been addressed
by other changes (so we can use the patch below)? Or do you
see another way to fix the problem?

diff --git a/lib/master.c b/lib/master.c
index a0e62f2..99b1092 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -906,8 +906,10 @@ int master_notify_submount(struct autofs_point
*ap, const char *path, enum state
 		p = p->prev;

 		if (!master_submount_list_empty(this)) {
-			mounts_mutex_unlock(ap);
-			return master_notify_submount(this, path, state);
+			if (!master_notify_submount(this, path, state)) {
+				ret = 0;
+				break;
+			}
 		}

 		/* path not the same */

Thanks,
Leonardo
