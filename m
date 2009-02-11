From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/13] Current status of patches awaiting commit
Date: Thu, 12 Feb 2009 01:00:08 +0900
Message-ID: <20090211154853.12578.50525.stgit@zeus.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

Hi all,

Here are the pacthes I'm wanting to commit to the git repo.
I think they are OK but any time that anyone has to review any of
them would be much appreciated.

Clearly the configure script changes are the result of autoconf
configuration changes so that bit doesn't really count. Try to
find the actual changes amongst the patch.

The libtirpc configure patch adds an dlopen() (and a dlclose())
for libtirpc but it has become clear this method doesn't resolve
the tsd SEGV we see that I still believe is due to libraries
not handling these keys correctly. So there will be more to come
on that front.

The ipv6 changes probably need more work as, and when, nfs over
ipv6 becomes a reality and people start using it. I have done my
best to verify these changes work against various current map
configurations.

Ian

---

Ian Kent (10):
      autofs-5.0.4 - ipv6 parse
      autofs-5.0.4 - ipv6 name and address support
      autofs-5.0.4 - configure libtirpc
      autofs-5.0.4 - code analysis corrections
      autofs-5.0.4 - always read file maps
      autofs-5.0.4 - force unlink umount at startup
      autofs-5.0.4 - library reload fix update
      autofs-5.0.4 - renew sasl creds upon reconnect fail
      autofs-5.0.4 - uris list locking fix
      autofs-5.0.4 - use CLOEXEC flag for setmntent

Paul Wankadia (1):
      autofs-5.0.4 - fix hosts map use after free

Valerie Aurora Henson (2):
      autofs-5.0.4 - easy alloca replacements
      autofs-5.0.4 - make MAX_ERR_BUF and PARSE_MAX_BUF use easier to audit


 CHANGELOG                |    8 
 Makefile.conf.in         |    3 
 Makefile.rules           |    5 
 aclocal.m4               |   81 ++
 autofs.spec              |    2 
 configure                | 1548 +++++++++++++++++++++++++---------------------
 configure.in             |    6 
 daemon/automount.c       |   91 ++-
 daemon/direct.c          |   27 -
 daemon/flag.c            |   13 
 daemon/indirect.c        |   24 -
 daemon/lookup.c          |   29 -
 daemon/module.c          |   45 -
 daemon/state.c           |   13 
 include/automount.h      |   23 +
 include/config.h.in      |    6 
 include/lookup_ldap.h    |    3 
 include/master.h         |    3 
 include/parse_subs.h     |    8 
 include/replicated.h     |    2 
 include/rpc_subs.h       |    4 
 lib/alarm.c              |    6 
 lib/cache.c              |   35 -
 lib/cat_path.c           |    1 
 lib/defaults.c           |    1 
 lib/macros.c             |    2 
 lib/master.c             |   38 +
 lib/master_tok.l         |   10 
 lib/mounts.c             |   13 
 lib/parse_subs.c         |   99 +++
 lib/rpc_subs.c           |  484 +++++++++-----
 man/automount.8          |   13 
 modules/cyrus-sasl.c     |   17 -
 modules/lookup_file.c    |  187 ++----
 modules/lookup_hosts.c   |    8 
 modules/lookup_ldap.c    |  250 ++++---
 modules/lookup_multi.c   |   15 
 modules/lookup_nisplus.c |   71 +-
 modules/lookup_program.c |    4 
 modules/mount_autofs.c   |   34 -
 modules/mount_bind.c     |    7 
 modules/mount_changer.c  |    7 
 modules/mount_ext2.c     |    5 
 modules/mount_generic.c  |    5 
 modules/mount_nfs.c      |    5 
 modules/parse_hesiod.c   |   79 ++
 modules/parse_sun.c      |   34 +
 modules/replicated.c     |  263 ++++++--
 redhat/autofs.init.in    |   10 
 samples/rc.autofs.in     |   10 
 50 files changed, 2221 insertions(+), 1436 deletions(-)

-- 
Signature
