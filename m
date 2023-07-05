From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is
 updated
Date: Wed, 5 Jul 2023 22:25:51 +0200
Message-ID: <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
References: <20230609125023.399942-1-jlayton@kernel.org>
 <20230609125023.399942-8-jlayton@kernel.org>
 <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
 <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <cluster-devel-bounces@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688588771;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:list-help:
	 list-unsubscribe:list-subscribe:list-post;
	bh=t45r9A2YvfoSJv2GZo8UC8AtO/lxGa/2A2TsFaxOzFQ=;
	b=LucSyPy06sA24SyclYm/hHMDFjr79/dQzuQLd4ABB7QCYFkPyoH/xvy+ketxT+lIHvWhG/
	zvA387H/SpEKuFqTS1NAFCJcXHtFfX05wE8o4MT3NtVHsTkW2dYL+GMq0fguzOPBWk4ED/
	iSCohQg8tDt3MY+oUA6cJridwW9zda4=
In-Reply-To: <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
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
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-efi@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, Ruihan Li <lrh2000@pku.edu.cn>, Ard Biesheuvel <ardb@kernel.org>, Ian Kent <raven@themaw.net>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Ritu Agarwal <rituagar@linux.ibm.com>, James Morris <jmorris@namei.org>, cluster-devel@redhat.com, Namjae Jeon <linkinjeon@kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>, Shyam Prasad N <sprasad@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, apparmor@lists.ubuntu.com, Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, John Johansen <john.johansen@canonical.com>, Wolfram Sang <wsa+renesas@sang-engineering.>

On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > Jeff,
> >
> > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/gfs2/quota.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > index 1ed17226d9ed..6d283e071b90 100644
> > > --- a/fs/gfs2/quota.c
> > > +++ b/fs/gfs2/quota.c
> > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *i=
p, loff_t loc,
> > >                 size =3D loc + sizeof(struct gfs2_quota);
> > >                 if (size > inode->i_size)
> > >                         i_size_write(inode, size);
> > > -               inode->i_mtime =3D inode->i_atime =3D current_time(in=
ode);
> > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =
=3D current_time(inode);
> >
> > I don't think we need to worry about the ctime of the quota inode as
> > that inode is internal to the filesystem only.
> >
>
> Thanks Andreas.  I'll plan to drop this patch from the series for now.
>
> Does updating the mtime and atime here serve any purpose, or should
> those also be removed? If you plan to keep the a/mtime updates then I'd
> still suggest updating the ctime for consistency's sake. It shouldn't
> cost anything extra to do so since you're dirtying the inode below
> anyway.

Yes, good point actually, we should keep things consistent for simplicity.

Would you add this back in if you do another posting?

Thanks,
Andreas

> Thanks!
>
> > >                 mark_inode_dirty(inode);
> > >                 set_bit(QDF_REFRESH, &qd->qd_flags);
> > >         }
> > > --
> > > 2.40.1
> > >
> >
> > Thanks,
> > Andreas
> >
>
> --
> Jeff Layton <jlayton@kernel.org>
>

