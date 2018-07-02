From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
Date: Mon, 02 Jul 2018 18:20:20 +0800
Message-ID: <1530526820.9527.4.camel@themaw.net>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
         <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
         <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8FUfl8hjvL1b474kMa0XmRPm7xL3/
        zxaAeN/blF/Ffo=; b=AqkynUMbc8LspsZW0OxdKNMJyOAAf2xTcl0iqGANvbdKM
        hxLbNpT0SAwJrBRk7d/F/xfsVjH5J7Bvp2QqmF4D7R/LJEvMCIvEvryFxxxoeR01
        yIw1Vb8dsIcqzVpgWsqgSqjU1YkfImqmLrhh67ds8We4zdpxEwb80wejRmK744kj
        jhl9MrQxxOHxdLFohca7O1GPVzjGb6pApGQHq0MlzxkZzENddxcvz2Wi5PKDamfr
        QIvSCeqVxFJem8TNloIvYm6/vL4SAiy3QgxwWD9FS8etMmcbnOQu1enzAfc0NVOE
        l2ByItNZ2IUwVlnusL9Ja0tcoZGQ+5NViLzQk+8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8FUfl8
        hjvL1b474kMa0XmRPm7xL3/zxaAeN/blF/Ffo=; b=ncH8TPjB/Izwv7yrR90HE0
        zhiIZc6reGnjMtORxFvtol4IyHN5dZvzk0o9Zu60iyuVxWQT2WJO2v83WD2DmWoj
        hZRbuyiWvvp8tluAOv1F/dkVbtA+5+AnBjl/n1T9QLxWwj5f4rC7nQLgwqnlDkG9
        dKVoRAes8RyPRYYHYCP6cxxg2tZwut0eF5qqB1QRU5D8yyR7DfqieSFhjQED1WeE
        YYAobYARiBymfkAT78YvlYpTxq77kp6OQqJHBo24D+Z/GaV3QECNrvJLt58q4VNk
        wnbptJzXNdC5wPl7ZGYxRMkc0pJZnnlEcS3TRsNKfy7WDXmpy5XG/AOKLsYde63A
        ==
In-Reply-To: <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tomas <tomasbortoli@gmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, autofs@vger.kernel.org

On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
> Hi Ian,
> 
> you are welcome!
> 
> yes your patch is much better. You should just put the "_IOC_NR" macro
> around "cmd" in the lines added to "validate_dev_ioctl" to make it work.

LOL, yes, that was a dumb mistake.

I'll send it to Andrew Morton, after some fairly simple sanity testing,
with both our Signed-off-by added.

> 
> Tomas
> 
> 
> On 07/02/2018 03:42 AM, Ian Kent wrote:
> > On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
> > > On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> > > > Hi,
> > > > 
> > > > I've looked into this issue found by Syzbot and I made a patch:
> > > > 
> > > > https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425
> > > > b116
> > > > 3
> > > 
> > > Umm ... oops!
> > > 
> > > Thanks for looking into this Tomas.
> > > 
> > > > 
> > > > The autofs subsystem does not check that the "path" parameter is present
> > > > within the "param" struct passed by the userspace in case the
> > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
> > > > path is always provided (though a path is not always present, as per how
> > > > the struct is defined:
> > > > https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_de
> > > > v-io
> > > > ct
> > > > l.h#L89).
> > > > Skipping the check provokes an oob read in "strlen", called by
> > > > "getname_kernel", in turn called by the autofs to assess the length of
> > > > the non-existing path.
> > > > 
> > > > To solve it, modify the "validate_dev_ioctl" function to check also that
> > > > a path has been provided if the command is
> > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> > > > 
> > > > 
> > > > --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200around
> > > > +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> > > > @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
> > > >              goto out;
> > > >          }
> > > >      }
> > > > +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> > > > +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> > > > +        return -EINVAL;
> > > 
> > > My preference is to put the comment inside the else but ...
> > > 
> > > There's another question, should the check be done in
> > > autofs_dev_ioctl_openmount() in the same way it's checked in other
> > > ioctls that need a path, such as in autofs_dev_ioctl_requester()
> > > and autofs_dev_ioctl_ismountpoint()?
> > > 
> > > For consistency I'd say it should.
> > > 
> > > >  
> > > >      err = 0;You should just put the "_IOC_NR" directive around "cmd" in
> > > > the lines added to "validate_dev_ioctl" to make it work.
> > > >  out:
> > > > 
> > > > 
> > > > Tested and solves the issue on Linus' main git tree.
> > > > 
> > > > 
> > 
> > Or perhaps this (not even compile tested) patch would be better?
> > 
> > autofs - fix slab out of bounds read in getname_kernel()
> > 
> > From: Ian Kent <raven@themaw.net>
> > 
> > The autofs subsystem does not check that the "path" parameter is
> > present for all cases where it is required when it is passed in
> > via the "param" struct.
> > 
> > In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> > ioctl command.
> > 
> > To solve it, modify validate_dev_ioctl() function to check that a
> > path has been provided for ioctl commands that require it.
> > ---
> >  fs/autofs/dev-ioctl.c |   15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> > index ea4ca1445ab7..61c63715c3fb 100644
> > --- a/fs/autofs/dev-ioctl.c
> > +++ b/fs/autofs/dev-ioctl.c
> > @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
> > autofs_dev_ioctl *param)
> >  				cmd);
> >  			goto out;
> >  		}
> > +	} else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
> > +		   cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
> > +		   cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
> > +		err = -EINVAL;
> > +		goto out;
> >  	}
> >  
> >  	err = 0;
> > @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
> >  	dev_t devid;
> >  	int err = -ENOENT;
> >  
> > -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > +	/* param->path has already been checked */
> >  
> >  	devid = sbi->sb->s_dev;
> >  
> > @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file
> > *fp,
> >  	unsigned int devid, magic;
> >  	int err = -ENOENT;
> >  
> > -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > +	/* param->path has already been checked */
> >  
> >  	name = param->path;
> >  	type = param->ismountpoint.in.type;
> 
> 
