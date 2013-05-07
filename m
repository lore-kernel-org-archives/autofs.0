From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/2] autofs4: translate pids to the right namespace for the
 daemon
Date: Tue, 7 May 2013 15:56:54 +0200
Message-ID: <20130507135654.GB6129@tucsk.piliscsaba.szeredi.hu>
References: <20130507135446.GA6129@tucsk.piliscsaba.szeredi.hu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NMJ2S1PW8fh0isFjRZUKFZvL3bFlKERx99k7iR3DxNg=;
        b=Z9izNwNBkBYBsjInkHriwCunneI20xNC7EpMWdpFbtCtf+W6KDxRJc59idap213HRk
         MU39jYjjP84jajtVvLeHp7oOHfOjoXf/CafzeVGNetV4Fzu6+jawi4BiIe9WawIVFIbu
         HdmHjqLU68VRQ5b62SzN8gY/+xg7Iyii7TQDc=
Content-Disposition: inline
In-Reply-To: <20130507135446.GA6129@tucsk.piliscsaba.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

From: Miklos Szeredi <mszeredi@suse.cz>

The PID and the TGID of the process tringgering the mount are sent to the
daemon.  Currently the global pid values are sent (ones valid in the initial pid
namespace) but this is wrong if the autofs daemon itself is not running in the
initial pid namespace.

So send the pid values that are valid in the namespace of the autofs daemon.

The namespace to use is taken from the oz_pgrp pid pointer, which was set at
mount time to the mounting process' pid namespace.

If the pid translation fails (the triggering process is in an unrelated pid
namespace) then the automount fails with ENOENT.

Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---
 fs/autofs4/waitq.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -353,11 +353,23 @@ int autofs4_wait(struct autofs_sb_info *
 	struct qstr qstr;
 	char *name;
 	int status, ret, type;
+	pid_t pid;
+	pid_t tgid;
 
 	/* In catatonic mode, we don't wait for nobody */
 	if (sbi->catatonic)
 		return -ENOENT;
 
+	/*
+	 * Try translating pids to the namespace of the daemon.
+	 *
+	 * Zero means failure: we are in an unrelated pid namespace.
+	 */
+	pid = task_pid_nr_ns(current, ns_of_pid(sbi->oz_pgrp));
+	tgid = task_tgid_nr_ns(current, ns_of_pid(sbi->oz_pgrp));
+	if (pid == 0 || tgid == 0)
+		return -ENOENT;
+
 	if (!dentry->d_inode) {
 		/*
 		 * A wait for a negative dentry is invalid for certain
@@ -423,8 +435,8 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->ino = autofs4_get_ino(sbi);
 		wq->uid = current_uid();
 		wq->gid = current_gid();
-		wq->pid = current->pid;
-		wq->tgid = current->tgid;
+		wq->pid = pid;
+		wq->tgid = tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
 		wq->wait_ctr = 2;
 		mutex_unlock(&sbi->wq_mutex);
