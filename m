From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Fri, 08 Jan 2016 15:20:40 +0800
Message-ID: <1452237640.2973.19.camel@themaw.net>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	 <568E8840.3010801@odin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9aa4RE2RaN41hoiHWbpsM4FQ+cg=; b=v5EarW
	P7H/TvOZM+Du/Zlfytd5CxmK2ipMkb5GsubD0+y8ap29Tli89yWk2HLBoHCbM7q8
	8Hs3HUZoMTjod1P5O731oxa2mFPApm1cHsNvPQNoxFe5u4VEsJ/O215ExsTfH1eS
	SAiht3t4Fy4LmZmx2MSMxKudrtGZ/n+mGrlNA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9aa4RE2RaN41hoi
	HWbpsM4FQ+cg=; b=KLSwM9RrtwphKKE+gXSPg0uDsJGBbKAKCfme9d4dlwetvoS
	Ok0e0qqHxTv3fzetTfKiBtwkDhgCfP1dP8yKKmJkyo707OGXytukOoVbbpMZ9Ox3
	QFs7U4PGRTs8aahH/Zd9IsMqkrlMomcEv5La3oIoZ/9kMrCGORmbF0qUWgro=
In-Reply-To: <568E8840.3010801@odin.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: skinsbursky@virtuozzo.com
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

On Thu, 2016-01-07 at 16:46 +0100, Stanislav Kinsburskiy wrote:
> Good day, gentlemen.
>=20
> Could you update, what's the status with this patch?
> Without it it's impossible to match process pipe with kernel pipe,
> while=20
> this is "must have" to be able to migrate AutoFS via CRIU.

Right, I did mean to reply to this mail but have been distracted by
family stuff.

I don't know what CRIU is and people looking at changelog entries
shouldn't need to do a web search to find out.

Could you change it a little.

I'm also not sure whether to forward this (assuming the description is
updated a little) to Al or to include it in the series to rename
autofs4 to autofs that I'm hoping to ask be included in linux-next
fairly soon.

Passing it on to Al will likely interfere with the series coming from
linux-next so that could be bit of a hassle.

Another thing I'm wondering about is the order this entry will appear
at in the options. You order choice is sensible though and autofs
shouldn't have a problem with the inserted option but other
applications might.

=46inally, and perhaps most importantly, I don't get what your trying t=
o
do, you also haven't given any clues to that in the patch dscription.

IOW how do you expect to use this.

>=20
>=20
> 16.12.2015 13:02, Stanislav Kinsburskiy =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> > This is required for CRIU to migrate a mount point, when write end
> > in user
> > space is closed.

Like I said what does this mean.

autofs doesn't need this when it re-constructs a mount tree from
existing mounts on re-start or after a SIGKILL on the automount
process.

How is this different and how will it be used?

The question to be answered here is "is this the best way to do it and
will it work for the autofs mount types you expect it to"?

> > To be able to migrate such mount, read end of the pipe have to be
> > searched
> > within autofs master process, and pipe inode will be used as a key.
> >=20
> > Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
> > ---
> >   fs/autofs4/inode.c |    4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> > index a3ae0b2..16f875a 100644
> > --- a/fs/autofs4/inode.c
> > +++ b/fs/autofs4/inode.c
> > @@ -77,6 +77,10 @@ static int autofs4_show_options(struct seq_file
> > *m, struct dentry *root)
> >   		return 0;
> >  =20
> >   	seq_printf(m, ",fd=3D%d", sbi->pipefd);
> > +	if (sbi->pipe)
> > +		seq_printf(m, ",pipe_ino=3D%ld", sbi->pipe->f_inode
> > ->i_ino);
> > +	else
> > +		seq_printf(m, ",pipe_ino=3D-1");
> >   	if (!uid_eq(root_inode->i_uid, GLOBAL_ROOT_UID))
> >   		seq_printf(m, ",uid=3D%u",
> >   			from_kuid_munged(&init_user_ns,
> > root_inode->i_uid));
> >=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
