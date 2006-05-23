From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.0 beta3
Date: Tue, 23 May 2006 14:48:03 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605231446270.4758@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi all,

It's time for an updated beta again.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.0_beta3.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.0_beta3.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.0_beta3.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

23/5/2006 autofs-5.0.0_beta3
----------------------------
- add config and compile time info to output of -V.
- add "-Dvar=value" comand line option to define global
  macro definitions.
- remove "nofg" and "bg" options as they aren't relevant for
  autofs.
- fix handling of numeric ip address strings in name translation.
- fix error handling for gethostbyname_r.
- change option processing to be inline with standard automount
  option processing. ie. mount entry options override global
  mount options.
- replicated server selection re-write.

Ian

