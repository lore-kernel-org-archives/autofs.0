From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/8] autofs - convert to to use mount api
Date: Thu, 21 Sep 2023 15:03:26 +0800
Message-ID: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>

There was a patch from David Howells to convert autofs to use the mount
api but it was never merged.

I have taken David's patch and refactored it to make the change easier
to review in the hope of having it merged.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (8):
      autofs: refactor autofs_prepare_pipe()
      autofs: add autofs_parse_fd()
      autofs - refactor super block info init
      autofs: reformat 0pt enum declaration
      autofs: refactor parse_options()
      autofs: validate protocol version
      autofs: convert autofs to use the new mount api
      autofs: fix protocol sub version setting


 fs/autofs/autofs_i.h |  15 +-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 423 +++++++++++++++++++++++++------------------
 3 files changed, 266 insertions(+), 181 deletions(-)

--
Ian

