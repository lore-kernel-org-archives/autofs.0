From: Ian Kent <raven@themaw.net>
Subject: [PATCH] vfs - and export user_path_mntpointat()
Date: Sun, 08 Sep 2013 17:22:04 +0800
Message-ID: <20130908092203.16435.73547.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=zmd0Nos/AaojobRkrbgPMbI
	Mhok=; b=qaYWaf8lj7rL1FEBqSqR5RVqzKgjZdbSeg1kANGCtn1p+ECbNfGIAyk
	tK1bDYIXPnX1VRaZ3xQCq1kgzhpLzq97eQadsSumwJNhevGyhORGYexG3ty8zOCR
	5pKHCsly+LwgsxIdI23f7QNM13IudpKmEdsCEPxSPoCD+EqMbPww=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=zmd0Nos/AaojobRkrbgPMbIMhok=; b=sTGYTdgJHYN2beQmzlE80f9kfQdW
	u0hjpzKV+M0psHXz3/wfzlvSwd08mAGAOUQAcQ+9SbAdl1vkzKPAQdnTZep6lBv6
	OmpORHntX9GpftsNbDbgB+TwKOgfgGGFepEa3lfcb0c1L+F2z6jFUJANNrqhkdyw
	E7D6XJv0ypHbszo=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

And, of course, export the function for module use, oops!
---
 fs/namei.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index 24f7562..849eadcf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4347,6 +4347,7 @@ const struct inode_operations page_symlink_inode_operations = {
 };
 
 EXPORT_SYMBOL(user_path_at);
+EXPORT_SYMBOL(path_mntpointat);
 EXPORT_SYMBOL(follow_down_one);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);

