From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: mtab corruption
Date: Thu, 4 Jan 2007 09:03:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701040855170.23215@simba.math.ucla.edu>
References: <459BD3C9.9090201@conterra.de>
	<1167874477.3546.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1635810564-781230220-1167930239=:23215"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1167874477.3546.10.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1635810564-781230220-1167930239=:23215
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id l0634GJP027090

On Thu, 4 Jan 2007, Ian Kent wrote:
> On Wed, 2007-01-03 at 17:03 +0100, Dieter St=FCken wrote:
> > I frequently end up with a broken mtab. This results in a message lik=
e:
> > mount(nfs): warning: /home/stueken is already mounted

Sorry, I don't have anything useful to add on the mtab corruption issue.
We do a ton of NFS automounting and don't see this issue.

> > I'm using a SuSE-10.1 x86_64-smp system with a 2.6.16.21-0.25-smp ker=
nel.
> > I upgraded from autofs-4.1.4-23 to autofs-4.1.4-37, but the mtab
>=20
> I don't know what this means, I don't use SuSE.

The trailing numbers differentiate variants of the "same" software versio=
n,=20
e.g. security patches.  SuSE has a policy of backporting patches to old=20
versions, if feasible, in contrast to Debian, which I think would send=20
out the latest version including the latest patch.  The idea is to minimi=
ze=20
feature changes except at distro version transitions.

> Does your system use mount.nfs from nfs-utils?
> There is an mtab locking error I spotted in nfs-utils recently.

SuSE 10.1 uses /bin/mount from util-linux-2.12r-35 which does NFS=20
intrinsically, and not mount.nfs from nfs-utils-1.0.7, which is installed=
=20
but minus mount.nfs.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-15=
55
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP=
 key)
--1635810564-781230220-1167930239=:23215
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--1635810564-781230220-1167930239=:23215--

