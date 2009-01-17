From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [RFC PATCH 0/3] Remove alloca(), fix includes
Date: Fri, 16 Jan 2009 19:58:47 -0800
Message-ID: <1232164730-9397-1-git-send-email-vaurora@redhat.com>
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
Cc: Paul Wankadia <junyer@google.com>

Respin of the alloca() and include changes, with obvious problems
fixed.  This is just an RFC patchset; I want to get review before I
get Jeff Moyer to run this through the RHTS again.

Is there any chance of getting a minimal test suite in the public
source?  It'd certainly make it easier to contribute from outside of
Red Hat.

Valerie Aurora Henson (3):
  Make MAX_ERR_BUF and PARSE_MAX_BUF use easier to audit
  Easy alloca() replacements
  Don't include kernel header files during userspace compiles

 daemon/automount.c             |   26 ++++----
 daemon/direct.c                |   12 +--
 daemon/flag.c                  |   12 ++--
 daemon/indirect.c              |   12 +--
 daemon/module.c                |   42 ++++---------
 include/linux/auto_dev-ioctl.h |    3 +
 lib/cache.c                    |   30 +++------
 lib/cat_path.c                 |    1 -
 modules/lookup_file.c          |   43 ++----------
 modules/lookup_ldap.c          |  142 ++++++++++++++++++++++-----------------
 modules/lookup_nisplus.c       |   32 ++++++---
 modules/mount_autofs.c         |    1 -
 modules/mount_bind.c           |    7 +--
 modules/mount_changer.c        |    5 +-
 modules/mount_ext2.c           |    5 +-
 modules/mount_generic.c        |    5 +-
 16 files changed, 166 insertions(+), 212 deletions(-)
