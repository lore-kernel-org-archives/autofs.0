From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [PATCH 0/4] autofs scaling and cleanup patches
Date: Fri,  9 Jan 2009 13:46:59 -0500
Message-ID: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
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
To: autofs@linux.kernel.org

This is a small collection of patches generated from discussions with
Google folks.  The first makes the mount entry cache scale to
thousands of entries.  The second is prep for the next patch; it just
cleans up use of fixed buffer sizes so that it's easier to tell what's
going on.  The third removes some instances of alloca() - I had the
help of Coccinelle on this one.  The fourth fixes an include to use
the userland include instead of the kernel include.

Valerie Aurora Henson (4):
  Make hash table scale to thousands of entries
  Make MAX_ERR_BUF and PARSE_MAX_BUF use easier to audit
  Easy alloca() replacements
  Replace <linux/string.h> with <string.h>

 daemon/automount.c             |    6 ++--
 daemon/direct.c                |    8 ++----
 daemon/flag.c                  |   12 +++++-----
 daemon/indirect.c              |    8 ++----
 daemon/module.c                |   42 +++++++++------------------------
 include/automount.h            |    2 +-
 include/linux/auto_dev-ioctl.h |    2 +-
 lib/cache.c                    |   49 +++++++++++++++++++--------------------
 lib/cat_path.c                 |    1 -
 modules/lookup_ldap.c          |   49 ++++++++++++++++++----------------------
 modules/lookup_nisplus.c       |   22 ++++++++++++++----
 modules/mount_autofs.c         |    1 -
 modules/mount_bind.c           |    7 +----
 modules/mount_changer.c        |    5 +---
 modules/mount_ext2.c           |    5 +---
 modules/mount_generic.c        |    5 +---
 16 files changed, 97 insertions(+), 127 deletions(-)
