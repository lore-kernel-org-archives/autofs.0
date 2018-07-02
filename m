From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
Date: Mon, 02 Jul 2018 09:42:06 +0800
Message-ID: <1530495726.2749.13.camel@themaw.net>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
         <1530493827.2749.8.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=fT+fysjxMG/V5Mok7bKcfIpThTlzA
        qqqWt1e9HthhgM=; b=FkVt6nSbyyUGQIH+Hn7Avv/PxjQQa3Yx/aopR2iT6hi5s
        w97PozpXEPfk+bMBvO03KR13APHZspr3k+IIp5Y82nIusxHMpJLTER/DGoHU9FP6
        YEkaIf4w52zUZqKvO43O/l2QbrWrb8uz/5htjcJmAsVmJv/pzi/bndenlvnhQWqb
        9BdPW6xpqCCPFSezvA20wx3KA/gstuhPlVw0l+C4qp0z/seqeFVxoSiBDFGw+1hy
        0GUC1O1SNU6oSABanlXCav+uOUw0LFfzouBFzGbizhyjm6TLoDgLXzk3ai1RAfBG
        zpYAykMoETQ5dve3oq0A1+Xl20DcU6KhKxtQkG8bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fT+fys
        jxMG/V5Mok7bKcfIpThTlzAqqqWt1e9HthhgM=; b=hePIlbPpwrEkAhnLggh77M
        ivo2fWhkzYqMChZ2eXzuxVZxVjEl9r4T+s6UL6u4f/RTwrzoHEeRUvLHlvrRLjqN
        jdkmqf/8KFMBhBvoDFaRbvSjR0oYeOrlolUFfYFdoiCtw261lBuVVpDnn128GLWj
        EAmKC6X0CrunURnMF3hCwZzO8O/BVX6AasMaHE/F57b5v5Su1df8RBON1TvYlLOd
        PB/WOo6mMD/zJreiw4Dd/wyFVDf34DwMkWn+ihDGVwHc5bq13A01Qo0ZfTYWOr9a
        gO820TzXAJOJS9WjiOYN7oM5/omaAfvSmnJmi+koJqxIhrWHbB2LID0s/Zrya2FA
        ==
In-Reply-To: <1530493827.2749.8.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tomas <tomasbortoli@gmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, autofs@vger.kernel.org

On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
> On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> > Hi,
> > 
> > I've looked into this issue found by Syzbot and I made a patch:
> > 
> > https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425b116
> > 3
> 
> Umm ... oops!
> 
> Thanks for looking into this Tomas.
> 
> > 
> > 
> > The autofs subsystem does not check that the "path" parameter is present
> > within the "param" struct passed by the userspace in case the
> > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
> > path is always provided (though a path is not always present, as per how
> > the struct is defined:
> > https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_dev-io
> > ct
> > l.h#L89).
> > Skipping the check provokes an oob read in "strlen", called by
> > "getname_kernel", in turn called by the autofs to assess the length of
> > the non-existing path.
> > 
> > To solve it, modify the "validate_dev_ioctl" function to check also that
> > a path has been provided if the command is AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> > 
> > 
> > --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200
> > +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> > @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
> >              goto out;
> >          }
> >      }
> > +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> > +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> > +        return -EINVAL;
> 
> My preference is to put the comment inside the else but ...
> 
> There's another question, should the check be done in
> autofs_dev_ioctl_openmount() in the same way it's checked in other
> ioctls that need a path, such as in autofs_dev_ioctl_requester()
> and autofs_dev_ioctl_ismountpoint()?
> 
> For consistency I'd say it should.
> 
> >  
> >      err = 0;
> >  out:
> > 
> > 
> > Tested and solves the issue on Linus' main git tree.
> > 
> > 

Or perhaps this (not even compile tested) patch would be better?

autofs - fix slab out of bounds read in getname_kernel()

From: Ian Kent <raven@themaw.net>

The autofs subsystem does not check that the "path" parameter is
present for all cases where it is required when it is passed in
via the "param" struct.

In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
ioctl command.

To solve it, modify validate_dev_ioctl() function to check that a
path has been provided for ioctl commands that require it.
---
 fs/autofs/dev-ioctl.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index ea4ca1445ab7..61c63715c3fb 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 				cmd);
 			goto out;
 		}
+	} else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
+		   cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
+		   cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
+		err = -EINVAL;
+		goto out;
 	}
 
 	err = 0;
@@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	dev_t devid;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has already been checked */
 
 	devid = sbi->sb->s_dev;
 
@@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 	unsigned int devid, magic;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has already been checked */
 
 	name = param->path;
 	type = param->ismountpoint.in.type;
