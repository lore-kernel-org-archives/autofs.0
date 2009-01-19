From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/4] Current state of Vals patches and the file map
	lookup	patches
Date: Mon, 19 Jan 2009 21:24:33 +0900
Message-ID: <20090119121918.31454.61737.stgit@zeus.themaw.net>
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
To: Valerie Aurora Henson <vaurora@redhat.com>, Paul Wankadia <junyer@google.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

I've pulled in the patches that Val posted and made a couple of
minor changes. I also have what I think is just about what we
need to reduce the overhead of file map scanning.

Check'em out please folks.

I'm a little concerned about the "fix kernel includes" patch because
there should be more to it and I've altered it in line with that. I'm
not sure if we should post a kernel patch first, pull in the updated
kernel header files to the tar and finally make the other couple of
changes then. But then I may have it wrong so check it out.

Ian

---

Ian Kent (1):
      autofs-5.0.4 - always read file maps

Valerie Aurora Henson (3):
      autofs-5.0.4 - fix kernel includes
      autofs-5.0.4 - easy alloca replacements
      autofs-5.0.4 - make MAX_ERR_BUF and PARSE_MAX_BUF use easier to audit


 daemon/automount.c             |   29 ++++----
 daemon/direct.c                |   12 +--
 daemon/flag.c                  |   13 ++--
 daemon/indirect.c              |   12 +--
 daemon/lookup.c                |    9 ++-
 daemon/module.c                |   45 ++++---------
 include/automount.h            |    2 -
 include/linux/auto_dev-ioctl.h |   10 +++
 include/linux/auto_fs.h        |    5 +
 lib/cache.c                    |   31 +++------
 lib/cat_path.c                 |    1 
 modules/lookup_file.c          |  141 +++++++++++++---------------------------
 modules/lookup_ldap.c          |  142 +++++++++++++++++++++++-----------------
 modules/lookup_nisplus.c       |   71 ++++++++++++--------
 modules/mount_autofs.c         |    1 
 modules/mount_bind.c           |    7 +-
 modules/mount_changer.c        |    5 -
 modules/mount_ext2.c           |    5 -
 modules/mount_generic.c        |    5 -
 19 files changed, 248 insertions(+), 298 deletions(-)

-- 
Signature
