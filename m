From: raven@themaw.net
Subject: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Wed, 26 Jan 2005 22:17:53 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


Hi all,

It's been a long time between releases so there are many changes that need 
testing and so this is labeled a beta so we can test it.

For more information look at the CHANGELOG in the distribution.

There are still a few problems that I'm aware of such as:

- the init script for Debian and Gentoo doesn't handle the reload
   option quite right.
- there seems to be a bug with the selection of the default map
   type when using submounts. I still need to investigate this.

So let me know when you find more and I'll fix`em as quick as I can!

The distribution can be found at the usual place at:

http://www.kernel.org/pub/linux/daemons/autofs/v4

in the tars

autofs-4.1.4_beta1.tar.[gz|bz2]

also there is a tarball called:

autofs-4.1.4-beta1-deb.tar.[gz|bz2]

that can be used to build binary debs (see below).

It is possible to build packages for testing from the distribution. 
I'm not the maintainer of any of these distribution packages so please be 
aware that this is for convenience and testing.

To build an rpm package use:

rpmbuild -tb autofs-4.1.4_beta1.tar.gz

and the binary rpms will end up in the usual location.

To merge the package into Gentoo use:

tar zxf autofs-4.1.4_beta1.tar.gz
cd autofs-4.1.4_beta1/gentoo
export PORTDIR_OVERLAY=`pwd`
ebuild net-fs/autofs/autofs-4.1.4_beta1.ebuild digest
ebuild net-fs/autofs/autofs-4.1.4_beta1.ebuild clean install
ebuild net-fs/autofs/autofs-4.1.4_beta1.ebuild qmerge
unset PORTDIR_OVERLAY

To build binary debs for Debian download the tar refered to above and:

tar zxvf autofs-4.1.4-beta1-deb.tar.gz
dpkg-source -x autofs_4.1.4-beta1-1.dsc
cd autofs-4.1.4-beta1
dpkg-buildpackage -b

and the binary debs will be placed in the directory the tar was unpacked.

Hopefuly this will help with the testing

Ian

