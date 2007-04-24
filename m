From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: Strange issue with autofs5/fc6
Date: Mon, 23 Apr 2007 21:02:54 -0300
Message-ID: <20070424000254.GA2501@sleipnir.redhat.com>
References: <46264599.90105@kmaclub.com>
	<x49zm4zni6f.fsf@segfault.boston.devel.redhat.com>
	<462CEB64.2020103@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <462CEB64.2020103@kmaclub.com>
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
To: autofs mailing list <autofs@linux.kernel.org>

On Mon, Apr 23, 2007 at 10:22:44AM -0700, Michael wrote:
> =

> root@client /]# mount -o =

> rsize=3D16384,wsize=3D16384,proto=3Dtcp,timeo=3D600,retrans=3D2  filer:/e=
xport /mnt
> =

> mount | grep mnt
> filer:/export on /mnt type nfs =

> (rw,rsize=3D16384,wsize=3D16384,proto=3Dtcp,timeo=3D600,retrans=3D2,addr=
=3D192.168.101.1)
> =

> grep mnt /proc/mounts
> filer:/export /mnt nfs =

> rw,vers=3D3,rsize=3D262144,wsize=3D262144,hard,proto=3Dtcp,timeo=3D600,re=
trans=3D2,sec=3Dsys,addr=3Dfiler =

> 0 0

Is the same volume from the same server already mounted somewhere else
in this box? If so, the kernel is sharing the superblock for these two
mounts of the same volume, and both the mount flags and nfs parameters
have been set by the first mount.

For more information, check upstream commit
54ceac4515986030c2502960be620198dd8fe25b. =


Cheers,
F=E1bio
-- =

ex sed lex awk yacc, e pluribus unix, amem
