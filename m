From: Ondrej Mosnacek <omosnace@redhat.com>
Subject: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Mon, 21 Sep 2020 16:51:35 +0200
Message-ID: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600699913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fS4tEIUXzLiN1infPPE8WhHFvu+7kD6d4GBJkxQpXVA=;
        b=KV2uFtsWWSJdosHNJQuTLJumbPAuyvJoqzsgxIesY/hS1BeyprizTk8mauzmawV2SDJkT/
        53iolt05h6eTZohQqww9LziYi/UjnImBf/zlcHDgrCLHeXs10OKn5O42KAKT1sDJ113r3k
        KUBTtiSB76iZJFLHoIeYmSw0BTowXRI=
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

Hi folks,

It seems that after commit 13c164b1a186 ("autofs: switch to
kernel_write") there is now an extra LSM permission required (for the
current task to write to the automount pipe) for processes accessing
some yet-to-to-be mounted directory on which an autofs mount is set
up. The call chain is:
[...]
autofs_wait() ->
autofs_notify_daemon() ->
autofs_write() ->
kernel_write() ->
rw_verify_area() ->
security_file_permission()

The bug report that led me to this commit is at [1].

Technically, this is a regression for LSM users, since this is a
kernel-internal operation and an LSM permission for the current task
shouldn't be required. Can this patch be reverted? Perhaps
__kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
so that the name is more descriptive?

Thanks,

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1874338

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

