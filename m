From: SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 0/5] Fix dead URLs to ftp.kernel.org
Date: Mon, 27 Mar 2017 14:47:26 +0900
Message-ID: <20170327054731.31882-1-sj38.park@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xzURXji9oxN/jKRTCoIELTchtVi0CpIfHtJykH9cN4c=;
        b=KqbEoMc4dI2kcFN8nMZS3Wst0iQtWy9hgQvQrSMNueODOhyoCivC8ol5DpI5k7TRkq
         eDJ3Vak0moEdce0slh3vA7R0MTupmw+tV+x7gZPscQI84kapgImJBTIkDouLeWFD6KSD
         TSrDe8IKrZX2UQlkZ/WtqyRQy0Z/FMSKiXlqC5JlTk2eGJ+5o2w9SWfr+a9gwuUIuD1C
         iD9pr8JL6tbkMmosBgm6w4o/4NwE6k2DomC+U3i0ZKnChUPsSf5UHZLPoPGBz0v/FlNX
         hC7dAvqEbP2syaJj9NTtEfaerqKJ/XA7o5wV5Thdk9Q2jx5WWCvxaj6HtJrmSy7+9xSm
         Ra0A==
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rml@tech9.net, axboe@fb.com, shli@kernel.org, raven@themaw.net, yamada.masahito@socionext.com, mmarek@suse.com
Cc: linux-raid@vger.kernel.org, autofs@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>

URLs to `ftp.kernel.org` exist here and there though `ftp.kernel.org` is
already dead [0].  This patchset fixes those URLs to use `www.kernel.org`
instead.

The change is splitted into multiple patches for independent review and merge
of each maintainer, though the change is trivial.

[0] https://www.kernel.org/shutting-down-ftp-services.html

SeongJae Park (5):
  MAINTAINERS: Fix a dead URL to ftp.kernel.org
  drivers/block: Fix a dead URL to ftp.kernel.org
  drivers/md: Fix a dead URL to ftp.kernel.org
  fs/autofs4: Fix a dead URL to ftp.kernel.org
  scripts: Fix dead URLs to ftp.kernel.org

 MAINTAINERS              | 2 +-
 drivers/block/Kconfig    | 2 +-
 drivers/md/Kconfig       | 2 +-
 fs/autofs4/Kconfig       | 2 +-
 scripts/ksymoops/README  | 5 ++---
 scripts/package/builddeb | 4 ++--
 6 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.10.0

