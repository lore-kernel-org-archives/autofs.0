From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/5] Patch series to attempt to fix submount hang
Date: Thu, 12 Jun 2008 13:04:23 +0800
Message-ID: <20080612045519.27161.92549.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

Jim,

Here is the latest patch series I'm using to try and fix the submount hang
that your seeing.

After our initial investigation I was able to use one of the tests in the
connectathon test suite to fairly easily reproduce the problem. I've used
that to test these current patches and I hope they are an improvement.

One of my test runs (the latest one) produced a totally different error
after only 17 hours so it looks like there is another issue. I'll continue
to work on that but in the mean time could you give these patches a try.

They were made against the source of the SuSE autofs-5.0.3-6.1 rpm.

Ian

---

Ian Kent (5):
      autofs-5.0.3 - fix submount shutdown handling.
      autofs-5.0.3 - don't abuse the ap->ghost field on NFS mount
      autofs-5.0.3 - mount thread create condition handling fix
      autofs-5.0.3 - Fix incorrect pthreads condition handling for mount requests.
      autofs-5.0.3 - Another fix for don't fail on empty master map.


 daemon/automount.c     |   82 ++++++++++++------------
 daemon/direct.c        |  100 +++++++++++++++++------------
 daemon/indirect.c      |  164 ++++++++++++++++++++++++++++++++++--------------
 daemon/lookup.c        |    3 -
 daemon/state.c         |    5 +
 include/automount.h    |   19 +++++-
 lib/master.c           |   63 +++++++++++-------
 modules/lookup_file.c  |    1 
 modules/mount_autofs.c |    4 +
 modules/mount_bind.c   |    2 -
 modules/mount_nfs.c    |   11 ---
 11 files changed, 277 insertions(+), 177 deletions(-)

-- 
