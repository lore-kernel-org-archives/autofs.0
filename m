From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: autofs-5.0.8 - get_exports: lookup(hosts): exports lookup failed for $(hostname)
Date: Mon, 23 Dec 2013 14:41:19 +0800
Message-ID: <CAF1ZMEcaxaTw5qVzdPgaeM90B0TTeG_nJgxXbOqGt7fLqK5i+g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ccHF1scvkak9ufb4N5VKHUfXv9wqu7+RUdEPPV0tuJw=;
        b=ECA3817gZ07fkGnm5bnhrr9Ttn4tqUe53uIpxMz6AS2VnmxCMyhfVGUddvPQQ1pgx1
         ohJsqWURpXEgM9LYNYUb6iMCYhJM8njBcBpZ0N5xacT126CDioMBxRV/uoR+VDobhmas
         GBMT0ibPXnJr2tLfAOXTxNVpgTTmK5ltGEl7yahBuAkYyhoPo0Kf4G5dEopnQ1q7gZKS
         jvaE4BtCI0S8PIaB4z3L0W53DG6j/O+Vie+ASJEmrhDb2cx1vRNz7VCpZtK4QNdsmvef
         YWrl/jMreAdMb5/8Z0Cn0rt/O8O7koSn0aVGlBBFnOJTHEF1YQf07PUmo5SFmHsYn5um
         Dvcg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@vger.kernel.org>

Hi Ian:
  A user hit a bug[1] in autofs-5.0.8, while not in autofs-5.0.7,
even it works with commit [2]
  My best guess it could be introduced by commit[3] (but not sure),
also I've seen you queued a few patches after 5.0.8, is there any
relevant?
  most obvious log can be found here [4], or check [1] for more information.
  Thanks

Lan


[1] https://bugs.gentoo.org/show_bug.cgi?id=488886

[2] commit 3247f7cb7e779d2340bd673324045f7617e74ce4
Author: Ian Kent <raven@themaw.net>
Date:   Mon May 27 17:47:20 2013 +0800

    autofs-5.0.7 - fix spelling error in last commit

[3] commit 7acfa6cba07a3ad8cb7976046852ce2830bd2f7e
Author: Ian Kent <ikent@redhat.com>
Date:   Mon Sep 23 12:18:52 2013 +0800

    autofs-5.0.7 - fix portmap lookup

    The autofs RPC library has fallen behind some.

    When using IPv6 (rpbbind) version 3 or 4 is available whereas with IPv4
    (portmap) verions 2 and 3 are available.


[4] error message

Dec 21 09:10:43 impala automount[31374]: get_exports: lookup(hosts):
exports lookup failed for caiman
Dec 21 09:10:43 impala automount[31374]: key "caiman" not found in map
source(s).
Dec 21 09:13:06 impala automount[31374]: get_exports: lookup(hosts):
exports lookup failed for caiman
Dec 21 09:13:06 impala automount[31374]: key "caiman" not found in map
source(s).
Dec 21 09:13:35 impala automount[31374]: create_client: hostname lookup failed:
