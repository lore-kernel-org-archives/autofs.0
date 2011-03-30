From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/2] Series for the non-expiring mounts problem
Date: Wed, 30 Mar 2011 13:49:23 +0800
Message-ID: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

These two patches should fix the problem you reported where a USR1
signal fails to trigger an expire. They should also fix the unnecessary
map reload problem.

Please test these for me.

---

Ian Kent (2):
      autofs-5.0.5 - fix stale map read
      autofs-5.0.5 - fix next task list update


 CHANGELOG        |    2 ++
 daemon/lookup.c  |    1 +
 daemon/state.c   |    9 +++++----
 include/master.h |    1 +
 lib/master.c     |   37 +++++++++++++++++++++++++------------
 5 files changed, 34 insertions(+), 16 deletions(-)

-- 
Ian
