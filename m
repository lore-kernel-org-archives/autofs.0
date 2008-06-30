From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/2] Update to submount patches
Date: Mon, 30 Jun 2008 14:50:52 +0800
Message-ID: <20080630064340.20857.84258.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

Hi Jim,

These two patches replace the autofs-5.0.3-submount-shutdown-recovery-8.patch.

The first patch "make handle_mounts startup condition distinct" is a
backport of part of another patch that I'm working on. Since it is
related to the mounting and startup of submounts I thought it a good
idea to add this now. The updated "submount shutdown handling" patch
fixes a bug with using the barriers.

I doubt that these will fix the problem we are seeing but a quick test
in your environment would be very much appreciated.

---

Ian Kent (2):
      autofs-5.0.3 - fix submount shutdown handling.
      autofs-5.0.3 - make handle_mounts startup condition distinct


 daemon/automount.c     |  153 ++++++++++++++++++++++++++++++++++--------------
 daemon/direct.c        |    4 +
 daemon/indirect.c      |   93 ++++++++++++++++++++++-------
 daemon/lookup.c        |    3 -
 daemon/state.c         |    5 +-
 include/automount.h    |    8 ++-
 include/master.h       |    3 -
 lib/master.c           |   79 +++++++++++--------------
 modules/mount_autofs.c |   35 +++++------
 9 files changed, 242 insertions(+), 141 deletions(-)

-- 
