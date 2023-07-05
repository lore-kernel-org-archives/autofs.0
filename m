From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is
 updated
Date: Wed, 05 Jul 2023 17:48:24 -0400
Message-ID: <9711e5f19dd2c040b4105147129a8db0aaf94b53.camel@kernel.org>
References: <20230609125023.399942-1-jlayton@kernel.org>
 <20230609125023.399942-8-jlayton@kernel.org>
 <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
 <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
 <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <cluster-devel-bounces@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688593721;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:list-help:
	 list-unsubscribe:list-subscribe:list-post;
	bh=fjEypqX3nmfXsQhKnncBC2ATKOwiEVIpHqBcuYS07OE=;
	b=LpgiQy3QKbZ3XWC8co6KWnSVB+ekkheBMF+Pp1ks++qDUxAx2DNocMz46zE7sX7sLWEdQz
	G6nwGgRrjAJXjkLQlc9iTLYOF73TdiQwJeJz7bxO6xJ6ATWq1qx6WQ4Eu1g+qdNvVF96uM
	ydXzIj1BaDy9p1bLJw1CdbcfuWaoNn0=
In-Reply-To: <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://listman.redhat.com/mailman/options/cluster-devel>, 
 <mailto:cluster-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <http://listman.redhat.com/archives/cluster-devel/>
List-Post: <mailto:cluster-devel@redhat.com>
List-Help: <mailto:cluster-devel-request@redhat.com?subject=help>
List-Subscribe: <https://listman.redhat.com/mailman/listinfo/cluster-devel>,
 <mailto:cluster-devel-request@redhat.com?subject=subscribe>
Errors-To: cluster-devel-bounces@redhat.com
Sender: "Cluster-devel" <cluster-devel-bounces@redhat.com>
Content-Type: text/plain; charset="utf-8"
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-efi@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, Ruihan Li <lrh2000@pku.edu.cn>, Ard Biesheuvel <ardb@kernel.org>, Ian Kent <raven@themaw.net>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Ritu Agarwal <rituagar@linux.ibm.com>, James Morris <jmorris@namei.org>, cluster-devel@redhat.com, Namjae Jeon <linkinjeon@kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>, Shyam Prasad N <sprasad@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, apparmor@lists.ubuntu.com, Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, John Johansen <john.johansen@canonical.com>, Wolfram Sang <wsa+renesas@sang-engineering.>

On Wed, 2023-07-05 at 22:25 +0200, Andreas Gruenbacher wrote:
> On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > > Jeff,
> > >=20
> > > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/gfs2/quota.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > > index 1ed17226d9ed..6d283e071b90 100644
> > > > --- a/fs/gfs2/quota.c
> > > > +++ b/fs/gfs2/quota.c
> > > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode =
*ip, loff_t loc,
> > > >                 size =3D loc + sizeof(struct gfs2_quota);
> > > >                 if (size > inode->i_size)
> > > >                         i_size_write(inode, size);
> > > > -               inode->i_mtime =3D inode->i_atime =3D current_time(=
inode);
> > > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctim=
e =3D current_time(inode);
> > >=20
> > > I don't think we need to worry about the ctime of the quota inode as
> > > that inode is internal to the filesystem only.
> > >=20
> >=20
> > Thanks Andreas.  I'll plan to drop this patch from the series for now.
> >=20
> > Does updating the mtime and atime here serve any purpose, or should
> > those also be removed? If you plan to keep the a/mtime updates then I'd
> > still suggest updating the ctime for consistency's sake. It shouldn't
> > cost anything extra to do so since you're dirtying the inode below
> > anyway.
>=20
> Yes, good point actually, we should keep things consistent for simplicity=
.
>=20
> Would you add this back in if you do another posting?
>=20

I just re-posted the other patches in this as part of the ctime accessor
conversion. If I post again though, I can resurrect the gfs2 patch.=C2=A0If
not, we can do a follow-on fix later.

Since we're discussing it, it may be more correct to remove the atime
update there. gfs2_adjust_quota sounds like a "modify" operation, not a
"read", so I don't see a reason to update the atime.

In general, the only time you only want to set the atime, ctime and
mtime in lockstep is when the inode is brand new.
--=20
Jeff Layton <jlayton@kernel.org>

