From: raven@themaw.net
Subject: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Mon, 14 Feb 2005 22:39:51 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

Here is autofs 4.1.4 beta2.

There haven't been many changes since beta1.

For more information look at the CHANGELOG in the distribution.

There are still a few problems that I'm aware of such as:

- the init script for Debian and Gentoo works better but still
    ins't handling the reload option completely.

- the bug with the selection of the default map type when using
    submounts still hasn't been resolved.

So let me know when you find more and I'll fix`em as quick as I can!

The distribution can be found at the usual place at:

http://www.kernel.org/pub/linux/daemons/autofs/v4

in the tars

autofs-4.1.4_beta2.tar.[gz|bz2]

also there is a tarball called:

autofs-4.1.4-beta2-deb.tar.[gz|bz2]

that can be used to build binary debs (see below).

It is possible to build packages for testing from the distribution. 
I'm not the maintainer of any of these distribution packages so please be 
aware that this is for convenience and testing.

To build an rpm package use:

rpmbuild -tb autofs-4.1.4_beta2.tar.gz

and the binary rpms will end up in the usual location.

To merge the package into Gentoo use:

tar zxf autofs-4.1.4_beta2.tar.gz
cd autofs-4.1.4_beta2/gentoo
export PORTDIR_OVERLAY=`pwd`
ebuild net-fs/autofs/autofs-4.1.4_beta2.ebuild digest
ebuild net-fs/autofs/autofs-4.1.4_beta2.ebuild clean install
ebuild net-fs/autofs/autofs-4.1.4_beta2.ebuild qmerge
unset PORTDIR_OVERLAY

To build binary debs for Debian download the tar refered to above and:

tar zxvf autofs-4.1.4-beta2-deb.tar.gz
dpkg-source -x autofs_4.1.4-beta2-1.dsc
cd autofs-4.1.4-beta2
dpkg-buildpackage -b

and the binary debs will be placed in the directory the tar was unpacked.

Hopefuly this will help with the testing

Ian
