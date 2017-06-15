From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs: sanity check status reported with
 AUTOFS_DEV_IOCTL_FAIL
Date: Thu, 15 Jun 2017 16:34:00 -0700
Message-ID: <20170615163400.e2f024125581f452d48f1aca@linux-foundation.org>
References: <871sqwczx5.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <871sqwczx5.fsf@notabene.neil.brown.name>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>
Cc: Ian Kent <raven@themaw.net>, LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

On Wed, 07 Jun 2017 12:08:38 +1000 NeilBrown <neilb@suse.com> wrote:

> 
> If a positive status is passed with the AUTOFS_DEV_IOCTL_FAIL
> ioctl, autofs4_d_automount() will return
>    ERR_PTR(status)
> with that status to follow_automount(), which will then
> dereference an invalid pointer.
> 
> So treat a positive status the same as zero, and map
> to ENOENT.
> 
> See comment in systemd src/core/automount.c::automount_send_ready().
> 
> ...
>
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -344,7 +344,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
>  	int status;
>  
>  	token = (autofs_wqt_t) param->fail.token;
> -	status = param->fail.status ? param->fail.status : -ENOENT;
> +	status = param->fail.status < 0 ? param->fail.status : -ENOENT;
>  	return autofs4_wait_release(sbi, token, status);
>  }

Sounds serious.  Was the absence of a cc:stable deliberate?
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
