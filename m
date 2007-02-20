From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.1 release
Date: Tue, 20 Feb 2007 16:18:59 +0900
Message-ID: <200702200718.l1K7Ixlk029511@raven.themaw.net>
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

There will always be bugs and the line must be drawn at some point and a
release issued and that time is now.

This release is an important milestone for autofs. At last we are at a point
where can expect Linux autofs to function in a multi-vendor environment
without having to maintain separate configurations. This was no easy task
and was made possible by the help and patience of many people, thank you
all.

I particularly want to thank RedHat for making it possible for me to devote
enough time to the development to make it happen, otherwise this release
would have taken much, much longer. Also, I'd like to thank Jeff Moyer for
his seemingly limitless patience, innovative testing and continual code
reviews.

Known issues
============

Quoted strings in the master map are not yet handled.
This will be delayed until the first bug fix release following the initial
release.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.1.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.1.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.1.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Note:
The rc3 tar and patches have been moved to the "old" subdirectory so any
automated build processes that are looking for the tar or patches in the
location above will need to be updated.

Here are the entries from the CHANGELOG which outline the updates:

20/2/2007 autofs-5.0.1
----------------------
- fix typo in Fix typo in var when removing temp directory.
- remove redundant rpath link option.
- ignore "winbind" if it appears in "automount" nsswitch.conf.
- fix another expire regression introduced in the "mitigate manual umount"
  patch.
- correct check for busy offset mounts before offset umount.
- make double quote handing consistent.
- fix handling of trailing white space in wildcard lookup.
- check fqdn of each interface when matching export access list.
- fix race when setting task done.
- correct return status from do_mkdir.
- fix localhost replicated mounts not working.
- add "condrestart" to RedHat init script.
- add "@network" and .domain.name export check.
- fix display map name in mount entry for "-hosts" map.
- update kernel patches.

Ian
