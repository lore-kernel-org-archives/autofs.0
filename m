From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.1 rc3 release candidate
Date: Thu, 4 Jan 2007 22:09:28 +0900
Message-ID: <200701041309.l04D9S9i031351@raven.themaw.net>
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
Cc: linux-fsdevel@vger.kernel.org

Hi all,

While there are still some issues the number of patches is hard
to manage so I'm consolidating again.

Known issues
============

Quoted strings in the master map are not yet handled.
This may be delayed unlil the first bug fix release following
the initial release.

There will always be bugs so I need to draw a line at some point
and issue a release of 5.0.1. That means this might be the last
oppertunity to test before the release so please find time to
check this out.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.1-rc3.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.1-rc3.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.1-rc3.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Note:
The rc2 tar and patches have been moved to the "old" subdirectory
so any automated build processes that are looking for the tar or
patches in the location above will need to be updated.

Here are the entries from the CHANGELOG which outline the updates:

4/1/2007 autofs-5.0.1 rc3
-------------------------
- fix handling of autofs specific mount options.
- fix include check full patch for file map of same name.
- fix cache entrys not being cleaned up on submount expire.
- fix LDAP lookup delete cache entry only if entry doesn't exist. 
- add missing socket close in replicated host check (Jeff Moyer).
- remove unused option UNDERSCORETODOT from default config files.
- make default installed master map for /net use "-hosts" instead
  of auto.net.
- fix included map recursive map key lookup.
  - and fix the recursive map key lookup for browsable map case.
- review and fix master map options update for map reload.
- fix "-fstype=nfs4" handling.
- fix get_query_dn not looking in subtree for LDAP search.
- allow syntax "--timeout <secs>" for backward compatibility.
- make masked_match independent of hostname for exports comparison.
- fix file handle leak in nsswitch parser.
- fix memory leak in mount and expire request processing.
- add additional check to prevent running of cancelled tasks.
- fix potential file handle leakage in rpc_subs.c for some failure cases.
- fix file handle leak in included map lookup.
- fix "-fstype=nfs4" server probing.
- set close-on-exec flag on open files where possible.
- fix parsing of numeric host names in LDAP map specs.
- fix get_query_dn not looking in subtree for LDAP search (missed second
  occurance).
- allow additional common LDAP attributes in map dn.
- deal with changed semantics of mkdir in 2.6.19.
- fix macro table locking.
- fix nsswitch parser locking.
- allow only one master map read task at a time.
- fix misc memory leaks.
- mitigate manual umount of automounts where possible.
- fix multiply recursive bind mounts.
- check kernel module version and require 5.00 or above.
- fix expire regression introduced in the "mitigate manual umount" patch.
- still more on multiply recursive bind mounts.
- fix tokenizer to distinguish between global option and dn string.
- fix incorrect return from spawn (Gordon Lack).
- fix parsing of bad mount mount point in master map.
- fix use after free memory access in cache.c and lookup_yp.c.
- eliminate use of pthread_kill to detect task completion.
- alter nfs4 host probing to not use portmap lookup and add options
  check for "port=" parameter.
- correct semantics of "-null" map handling.
- remove ability to use multiple indirect mount entries in master map.
- expand export access checks to include missing syntax options.
- make "-hosts" module try to be sensitive to exports list changes.
- change mount "device" from "automount" to the map name.
- check for buffer overflow in mount_afs.c.
- update master map tokenizer to admit "slasify-colons" option (Capelle Bonoit).
- update location validation to accept "_" (Fabio Olive Leite).
- set close-on-exec flag on open sockets.
- fix nonstrict multi-mount handling.
- reduce thread stack to less excessive size.
- update kernel patches.

Ian
