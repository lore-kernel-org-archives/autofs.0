From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 13:53:47 +0800
Message-ID: <1329890027.2193.48.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	 <20120221.221609.218135609185671883.davem@davemloft.net>
	 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	 <1329889428.2193.45.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=3eHQpR6pf6DSiNVVkHPHz5zEg2I=; b=hNxYmMa3pmo5pC2+GmauMbBLxIuc
	knINRzGnMQjjuAUWl38PtAyTONHb5x7YFGlVlOUM/znXIrQ71S5u7b64cVVsSRNJ
	EoTxqWtyMPQ9QHhnNCZxzOFRfjAY9T89WeuCyfD+poIqeOtr3D6j/ZVM9kfmWF57
	LLRDqBbIBM7ZF40=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=3eHQpR6pf6DSiNVVkHPHz5zEg2I=; b=bVd
	yTqKD6zJjE6ALYO7W9Ph0V8jhWTfs5oDIFLz4ni9RksG8f7JtipKiKmkQBtP7whT
	EzbHZXg0mwo99ajmiB3Hk9iW8TGS934DD6Rb+69g1yFYT+8JOnxcrtfFlV1J81K1
	LSuEdIURqF5+2uRRTrDtACmsmrWD44uxcgSnEA9g=
In-Reply-To: <1329889428.2193.45.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, 2012-02-22 at 13:43 +0800, Ian Kent wrote:
> On Tue, 2012-02-21 at 20:56 -0800, Linus Torvalds wrote:

Ahh ... forgot to set the file_operations structure member .. oops

>  
> +static int autofs4_root_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct autofs_sb_info *sbi= autofs4_sbi(file->f_path.dentry->d_sb);
> +	if (sbi->compat_daemon < 0)
> +		sbi->compat_daemon = is_compat_task();
> +	return dcache_dir_open(inode, file);
> +}
> +

