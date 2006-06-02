From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.0 beta4 another beta release
Date: Fri, 2 Jun 2006 18:43:01 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606021839030.17530@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi all,

Another beta.

I think we are getting close to a release but we need more testing
in more areas on this or we will be stuck with annoying bugs in
the v5 release for longer than we should.

Please find a little time to check this out.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.0_beta4.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.0_beta4.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.0_beta4.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

2/6/2006 autofs-5.0.0_beta4
---------------------------
- fix memory alloc error in nis lookup module.
- add "_" to "." mapname translation to nis lookup module.
- fix white space handling in replicated server selection code.
- merge don't strip debug info macro patch (Jeff Moyer).
- merge patch to add sanity checks on rmdir_path and unlink (Jeff Moyer).
- merge patch fix e2fsck error code check (Jeff Moyer).
- update hesiod module (Jeff Moyer).
  - add mutex to protect against overlapping mount requests.
  - update return from mount request to give more sensible NSS_*
    values.
- fix handling of autofs filesystem mount fail on init.
- add back test test for nested mount in program map lookup.
  - I must have commented this out for a reason. I guess we'll
    find out soon enough.
- fix "-hosts" map not finding entry for the "nobrowse" case.
- update man page with description of "-hosts" map type.
- complete logging, including per mount logging.
  - still needs some more work but that will need to wait.
- change init script to check for read on config file instead
  of execute.
- fix lookup of wildcard map entry for several map types.
- fix fail to realease cache read lock on indirect map expire.
- fix incorrect cache update of wildcard map entry.
- alter master map lookup semantics to be a little more like
  version 4. The way we should locate the master map needs
  more investigation and may change again.

Ian

