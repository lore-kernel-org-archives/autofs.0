From: Olaf Hering <olh@suse.de>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Sat, 20 Sep 2003 01:36:52 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20030919233652.GA27676@suse.de>
References: <Pine.LNX.4.33.0309171251290.25153-100000@wombat.indigo.net.au>
	<3F689E40.6090802@intel.com> <3F68C6EB.2080706@zytor.com>
	<20030917210023.GA15099@suse.de> <shsd6dyabju.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <shsd6dyabju.fsf@charged.uio.no>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="macroman"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arun Sharma <arun.sharma@intel.com>, autofs@linux.kernel.org, nfs@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>, Olaf Kirch <okir@suse.de>, Ian Kent <raven@themaw.net>

 On Thu, Sep 18, Trond Myklebust wrote:

> >>>>> " " =3D=3D Olaf Hering <olh@suse.de> writes:
>=20
>      >  On Wed, Sep 17, H. Peter Anvin wrote:
>     >> Okay... let me ask this so I get it straight...
>     >>
>     >> Has anyone seen this (busy inodes after stopping the
>     >> automounter) using autofs v3 kernel module and daemon?
>=20
>      > I'm not sure, but everyone who has seen this should fiddle this
>      > patch into the kernel and see how it goes.  The whole thing
>      > started very recently (post 2.4.21) for us.

After thinking more about the conditions, I got a crash with 2.4.19
client. the codebase was unchanged for a long time. But the server side
was updated to 2.4.21 with lots of nfs patches. Possible that the newer
server side causes trouble for the client.
--=20
USB is for mice, FireWire is for men!

sUse lINUX ag, n=C3=9CRNBERG
