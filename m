From: raven@themaw.net
Subject: Re: [NFS] Re: Busy inodes after unmount followed by Oops
Date: Sat, 22 May 2004 11:41:56 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405221134240.1524@donald.themaw.net>
References: <3FFE8B28.1E645E4E@moving-picture.com>
	<40AE23DC.6C240DAE@moving-picture.com>
	<1085157843.3666.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1085157843.3666.75.camel@lade.trondhjem.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: autofs@linux.kernel.org, James Pearson <james-p@moving-picture.com>, nfs@lists.sourceforge.net

On Fri, 21 May 2004, Trond Myklebust wrote:

> P=E5 fr , 21/05/2004 klokka 11:44, skreiv James Pearson:
>=20
> > We've been running this patch on over 400 machines for the last 10 or=
 so
> > days, and have not seen any instance of this 'VFS: Busy inodes after
> > unmount/Oops' problem above - previously, we would have seen a
> > significant number of these in the same time scale (and we are still
> > seeing the problem on machines not using the patch).
>=20
> Note  that Greg's patch for solving the NFS client issues that were
> revealed by this bug is in 2.4.26 (and in 2.6.5)...
>=20

Yes I'm sure that Gregs' patch helps for the rename race it's meant to=20
fix. However, I believe the main issue revealed at James' site is a race=20
for the wait q struct (ref. waitq.c in autofs4). This struct has gone=20
entirely unprotected in 2.4 until I syned my 2.4 patch with what I've don=
e=20
for 2.6. This is what James is using.

Ian
