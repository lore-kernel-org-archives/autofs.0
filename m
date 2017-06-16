From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: sanity check status reported with
 AUTOFS_DEV_IOCTL_FAIL
Date: Fri, 16 Jun 2017 11:20:02 +0800
Message-ID: <1497583202.2553.1.camel@themaw.net>
References: <871sqwczx5.fsf@notabene.neil.brown.name>
         <20170615163400.e2f024125581f452d48f1aca@linux-foundation.org>
         <87fuf07k84.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Ndg0TMsZOVRlK59V6o
        Xz0qbgIjS4YYrUWFab93UPYZY=; b=kJhDuy75AS0RJwXhFa2ura//zzYicS952i
        7XBexGayVi4wqg2y1I2T9dcKSzNepb+aBK5tgsYwpRPPRBmXSLE+tgHBQ8OEq8rT
        b/LmpH2Qi5I5K+wnfFC/1dUytrUpomh+qGQOPhYq3ZCPuHrbnl8hlAFJkDBoLb+Q
        HWrYlPkTnKicQefAhW7g/WFV9BhAeNw6I+Qx2ztW2aUazW+e69slMOhlKk/kY5lZ
        JuVgGTUKSnANIqsZN+/XZtUdeVcRfaW6KbTKx8AT+Amue/rcSskJUFXUL101WLMb
        H+nT7uF7vOB0wOwnlJf7JQO7PnbOgPcmaMXWFbZk0lTH1ndHcP4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Ndg0TMsZOVRlK59V6oXz0qbgIjS4YYrUWFab93UPYZY=; b=XVmfZW3M
        bqexXIEv97QxXVcXBzkwjwgcI58QEPPmpfTPyzOwzs4PLgv07sDVvuqP6+0ghb7i
        zmyYIEbyRWFF3cbbps3BTeT5K+JxDK6oMTALo/JHfkubWGYsfFmFm4TYF2vrl2g9
        IEAq6S1HGLuPf01p3D2Ge00nPw3bgigvKt1mqSA61G8D62+6zs5os4sjEiXzrJFK
        F+oMzS1b01H0YNV08iUfpuPzR6rdkJSZ5lpDKsGndB7jVayE6SHnqn5TyisIPz4F
        kcYLfxoz1lPOp6FD3qc+6Cj+hbeXP7FwoG3ZwGSCbgRdFA0ofyZdBCgr11j2apDY
        L5U5tVo9ItYx+A==
In-Reply-To: <87fuf07k84.fsf@notabene.neil.brown.name>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

On Fri, 2017-06-16 at 12:13 +1000, NeilBrown wrote:
> On Thu, Jun 15 2017, Andrew Morton wrote:
> 
> > On Wed, 07 Jun 2017 12:08:38 +1000 NeilBrown <neilb@suse.com> wrote:
> > 
> > > 
> > > If a positive status is passed with the AUTOFS_DEV_IOCTL_FAIL
> > > ioctl, autofs4_d_automount() will return
> > >    ERR_PTR(status)
> > > with that status to follow_automount(), which will then
> > > dereference an invalid pointer.
> > > 
> > > So treat a positive status the same as zero, and map
> > > to ENOENT.
> > > 
> > > See comment in systemd src/core/automount.c::automount_send_ready().
> > > 
> > > ...
> > > 
> > > --- a/fs/autofs4/dev-ioctl.c
> > > +++ b/fs/autofs4/dev-ioctl.c
> > > @@ -344,7 +344,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
> > >  	int status;
> > >  
> > >  	token = (autofs_wqt_t) param->fail.token;
> > > -	status = param->fail.status ? param->fail.status : -ENOENT;
> > > +	status = param->fail.status < 0 ? param->fail.status : -ENOENT;
> > >  	return autofs4_wait_release(sbi, token, status);
> > >  }
> > 
> > Sounds serious.  Was the absence of a cc:stable deliberate?
> 
> You need CAP_SYS_ADMIN to  get the ioctl even looked at.  Doesn't that
> mean the bug can only be triggered by a process that could easily do
> worse?

Think so, yes.

> 
> Or do containers allow admins to give out CAP_SYS_ADMIN to untrusted
> people??  I haven't been keeping up.

Maybe, with docker root can start a container with --privileged to give the
container admin capabilities. It may be the case that capabilities can be used
now I don't know.

> 
> Given how simple the patch is, it probably makes sense to add a
> cc:stable, just in case.

IMHO it needs to be applied to stable as well.

> 
> Thanks,
> NeilBrown
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
