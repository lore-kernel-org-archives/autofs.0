From: James Pearson <james-p@moving-picture.com>
Subject: Re: [NFS] Re: Busy inodes after unmount followed by Oops
Date: Fri, 21 May 2004 17:58:26 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40AE3532.8EBA0D7B@moving-picture.com>
References: <3FFE8B28.1E645E4E@moving-picture.com>
	<1085157843.3666.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

Trond Myklebust wrote:
>=20
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

Not quite sure what you mean by this - I had tried Greg's patch
(http://marc.theaimsgroup.com/?l=3Dlinux-nfs&m=3D107604754127538&w=3D2)
previously - but it made no difference in my case. The kernel I'm using
now has both Greg's patch and Ian's recent autofs4 patch.

James Pearson
