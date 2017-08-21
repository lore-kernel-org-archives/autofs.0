From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/2] Map update problem patches
Date: Mon, 21 Aug 2017 13:37:41 +0800
Message-ID: <150329377379.7451.10096062127149809722.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>

Here is what I believe to be a better solution to the recent direct map
update problem that was reported.

Unfortunately, the NSS map instance handling is overly complicated and
I don't see a way to improve it. Becuase of this resolving problems in
this area often introduces side effects.

So please look at these patches carefully.

---

Ian Kent (2):
      autofs-5.1.3 - fix possible map instance memory leak
      autofs-5.1.3 - check map instances for staleness on map update


 daemon/lookup.c  |   11 +++++++----
 daemon/state.c   |    2 +-
 include/master.h |    1 +
 lib/master.c     |    2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
