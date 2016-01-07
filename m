From: Stanislav Kinsburskiy <skinsbursky@odin.com>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Thu, 7 Jan 2016 16:46:08 +0100
Message-ID: <568E8840.3010801@odin.com>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
Reply-To: <skinsbursky@virtuozzo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20151216120222.19097.54512.stgit@localhost.localdomain>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>, raven@themaw.net
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

Good day, gentlemen.

Could you update, what's the status with this patch?
Without it it's impossible to match process pipe with kernel pipe, whil=
e=20
this is "must have" to be able to migrate AutoFS via CRIU.



16.12.2015 13:02, Stanislav Kinsburskiy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> This is required for CRIU to migrate a mount point, when write end in=
 user
> space is closed.
> To be able to migrate such mount, read end of the pipe have to be sea=
rched
> within autofs master process, and pipe inode will be used as a key.
>
> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
> ---
>   fs/autofs4/inode.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index a3ae0b2..16f875a 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -77,6 +77,10 @@ static int autofs4_show_options(struct seq_file *m=
, struct dentry *root)
>   		return 0;
>  =20
>   	seq_printf(m, ",fd=3D%d", sbi->pipefd);
> +	if (sbi->pipe)
> +		seq_printf(m, ",pipe_ino=3D%ld", sbi->pipe->f_inode->i_ino);
> +	else
> +		seq_printf(m, ",pipe_ino=3D-1");
>   	if (!uid_eq(root_inode->i_uid, GLOBAL_ROOT_UID))
>   		seq_printf(m, ",uid=3D%u",
>   			from_kuid_munged(&init_user_ns, root_inode->i_uid));
>

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
