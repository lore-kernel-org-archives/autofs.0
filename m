From: raven@themaw.net
Subject: [ANNOUNCE] autofs 4.1.4 release
Date: Sun, 10 Apr 2005 21:38:50 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


Hi all,

Here is autofs 4.1.4.

For more information look at the CHANGELOG in the distribution.

I'm sure there are problems that I've missed but a relaese is long 
overdue.

So let me know when you find problems and I'll fix`em as quick as I can!

The distribution can be found at the usual place at:

http://www.kernel.org/pub/linux/daemons/autofs/v4

in the tars

autofs-4.1.4.tar.[gz|bz2]

also there is a tarball called:

autofs-4.1.4-deb.tar.[gz|bz2]

that can be used to build binary debs (see below).

It is possible to build packages for testing from the distribution.
I'm not the maintainer of any of these distribution packages so please be
aware that this is for convenience and testing.

To build an rpm package use:

rpmbuild -tb autofs-4.1.4.tar.gz

and the binary rpms will end up in the usual location.

To merge the package into Gentoo use:

tar zxf autofs-4.1.4.tar.gz
cd autofs-4.1.4_beta2/gentoo
PORTDIR_OVERLAY=`pwd` \
 	ebuild net-fs/autofs/autofs-4.1.4.ebuild digest
PORTDIR_OVERLAY=`pwd` \
 	ebuild net-fs/autofs/autofs-4.1.4.ebuild clean install
PORTDIR_OVERLAY=`pwd` \
 	ebuild net-fs/autofs/autofs-4.1.4.ebuild qmerge

To build binary debs for Debian download the tar refered to above and:

tar zxvf autofs-4.1.4-deb.tar.gz
dpkg-source -x autofs_4.1.4-1.dsc
cd autofs-4.1.4-beta2
dpkg-buildpackage -b

and the binary debs will be placed in the directory the tar was unpacked.

Ian
