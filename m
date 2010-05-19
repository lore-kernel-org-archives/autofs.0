From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 2/8] autofs: Pushdown the bkl from ioctl
Date: Wed, 19 May 2010 21:03:09 +0200
Message-ID: <20100519190307.GC9752@nowhere>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com> <1274289855-10001-3-git-send-regression-fweisbec@gmail.com> <4BF4279C.2000805@zytor.com> <20100519180832.GA9752@nowhere> <4BF42A5E.6060503@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4q/CzXUpxb6AnwBTGUH+KUxUH00rbvO6YNE2Z3As7NA=;
        b=IMjfX8327NFpPEmw2n+v7zOBtYVYxj01G18y3ten2RauIbCmnoYEBpRennvYz33SoD
         bKIriMfGKQrIQu9sMgQ+LNoMFTyKgH6kEgRIeiHVeA/fC3knyDjpCeNDYACv8PN3KJ7r
         kxgzVViFWd/glpdZ1im/xqBVDAkZP8ukoJ4Rw=
Content-Disposition: inline
In-Reply-To: <4BF42A5E.6060503@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Autofs <autofs@linux.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>

On Wed, May 19, 2010 at 11:13:50AM -0700, H. Peter Anvin wrote:
> On 05/19/2010 11:08 AM, Frederic Weisbecker wrote:
> > On Wed, May 19, 2010 at 11:02:04AM -0700, H. Peter Anvin wrote:
> >> On 05/19/2010 10:24 AM, Frederic Weisbecker wrote:
> >>>   * generate kernel reactions
> >>>   */
> >>> -static int autofs_root_ioctl(struct inode *inode, struct file *filp,
> >>> +static int autofs_root_ioctl_unlocked(struct inode *inode, struct file *filp,
> >>>  			     unsigned int cmd, unsigned long arg)
> >>>  {
> >>>  	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
> >>> @@ -579,3 +579,16 @@ static int autofs_root_ioctl(struct inode *inode, struct file *filp,
> >>>  		return -ENOSYS;
> >>>  	}
> >>>  }
> >>> +
> >>> +static long autofs_root_ioctl(struct file *filp,
> >>> +			     unsigned int cmd, unsigned long arg)
> >>> +{
> >>
> >> The choice of naming here seems reverse in my opinion.
> > 
> > 
> > Oh, why?
> > 
> > The function that holds the bkl calls its unlocked version.
> > 
> 
> But it's not ... it is locked at that point.  It's not lock*ing*, but it
> is not *unlocked*, either.  Furthermore, it is directly contradicting
> the naming scheme of the ops structure.
> 
> 	-hpa
> 


Would you prefer me to resend a patch?
