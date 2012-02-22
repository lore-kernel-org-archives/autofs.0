From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 17:32:19 +0800
Message-ID: <1329903139.2193.66.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	 <20120221.221609.218135609185671883.davem@davemloft.net>
	 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	 <1329889428.2193.45.camel@perseus.themaw.net>
	 <1329890027.2193.48.camel@perseus.themaw.net>
	 <1329890251.2193.50.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=5wiHHCcunzV1XjXEBOP9Fo0MHtY=; b=r7l1Wr+pj7ZgoXrP7FrUhZhpi+QE
	FnybLGwBZRiqwwi7F/NZaM1qE/9j0NmjcUQHvZWCmAXDEo3P9kiOBo916VEWcCKW
	/EGRsLlpWfs5OASKg3k8JxV+gI1+Ms6wHaaid/OLYbR7o9MTSV7PM9r9WRW7zFVc
	pACEw4sP3Xuua0w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=5wiHHCcunzV1XjXEBOP9Fo0MHtY=; b=Saw
	f/dZMu9EvlCKnLUAjlpRMKz1f6xVaESGNlDAsVQuJ16f2uqq1pQbVoi6y2ZALFZa
	LTg/T8MoeG1McoL7joLRlKCdTap2p7meiRasdm5102qIlSKFIP+vop/ZfDsrnjHO
	EYjrcFEkVCOsHZwSqa2WIe/s4fVXzkz0AZZRmQPw=
In-Reply-To: <1329890251.2193.50.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, 2012-02-22 at 13:57 +0800, Ian Kent wrote:
> On Wed, 2012-02-22 at 13:53 +0800, Ian Kent wrote:
> > On Wed, 2012-02-22 at 13:43 +0800, Ian Kent wrote:
> > > On Tue, 2012-02-21 at 20:56 -0800, Linus Torvalds wrote:
> > 
> > Ahh ... forgot to set the file_operations structure member .. oops
> > 
> > >  
> > > +static int autofs4_root_dir_open(struct inode *inode, struct file *file)
> > > +{
> > > +	struct autofs_sb_info *sbi= autofs4_sbi(file->f_path.dentry->d_sb);
> > > +	if (sbi->compat_daemon < 0)
> > > +		sbi->compat_daemon = is_compat_task();
> > > +	return dcache_dir_open(inode, file);
> > > +}
> > > +
> > 
> 
> Lets try that again.

Oh, DOH ... 

The process mounting the autofs mount is passing the pipe it will use
for communication via a mount option so we can do this right in
fill_super.

I'm out for a while, I'll update the patch when I'm back.

Ian

