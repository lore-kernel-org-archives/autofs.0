From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/6] fix dead LDAP symbol link with LDAP support disabled
Date: Tue, 23 Jul 2013 18:39:04 +0800
Message-ID: <1374575944.3418.13.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-3-git-send-email-dennis.yxun@gmail.com>
	 <1374573038.3418.3.camel@perseus.fritz.box>
	 <1374574224.3418.5.camel@perseus.fritz.box>
	 <CAF1ZMEdhiNLJdmrETYoQnOFHuFzquVTm1S5yuYFdLC3-7nohCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Jl/ffpTJudLl3PoWJ6dvDk8adFk=; b=nmGfJ65OVjbh7n6BcmthBKqV2VWx
	I/A5m46NJCK39CO66IUWzmTrsWIaGaFq9e/zxtW6zbNUTIyxunbPZqBLfZY7EeyT
	0jVtKNv1HRwE+ycKEp0gDQiCdicALn/UXFoc6pNIUNhF0lsUtlHclD/UWASx7O+w
	mtxuQOVVkdigA4k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Jl/ffpTJudLl3PoWJ6dvDk
	8adFk=; b=uH8R4lkjJQTauwmdPmZHK1+QJwedyanZp9YEhNndoCfSdYK5/jIxKu
	LpdQIUD4EvawVFQsJBKgd/98quJxD0/gxFMI4iM5TkwPLP42WLr4wqYZjuxeLu3A
	5FNy0de1TDVda+gAib4oUWfswnfDdml5+9NPpXwK2badvS9VlFXOA=
In-Reply-To: <CAF1ZMEdhiNLJdmrETYoQnOFHuFzquVTm1S5yuYFdLC3-7nohCQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2013-07-23 at 18:30 +0800, Dennis Lan (dlan) wrote:
> On Tue, Jul 23, 2013 at 6:10 PM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2013-07-23 at 17:50 +0800, Ian Kent wrote:
> >> On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> >> > From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> >> >
> >> > autofs will create symbol link mandatory no matter ldap support
> >> > is enabled or not. so, without this patch, lookup_ldaps.so will become
> >> > a dead link.
> >>
> >> I have added this to my patch queue.
> >> It will be committed next time I push patches to the repo.
> >
> > On second thoughts, what if WITH_LDAP is defined and WITH_SASL is not?
> >
> 
> HI Ian:
>   current logic is: if SASL is not enabled, then the symbol
> lookup_ldaps.so (which link to lookup_ldap.so) will not be created.
>   what are you suggesting here?  should symbol of lookup_ldaps.so be
> controlled by LDAP ?

Ha, yes, I was thinking ldap not ldaps, I'll check again.

>   Thanks
> 
> Dennis
> 
> >> Thanks
> >>
> >> >
> >> > ---
> >> > Upstream Discussion:
> >> >   http://thread.gmane.org/gmane.linux.kernel.autofs/5371
> >> >
> >> > Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> >> > ---
> >> >  modules/Makefile | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >> >
> >> > diff --git a/modules/Makefile b/modules/Makefile
> >> > index c5deb24..4bb1096 100644
> >> > --- a/modules/Makefile
> >> > +++ b/modules/Makefile
> >> > @@ -74,7 +74,9 @@ install: all
> >> >     -rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
> >> >     ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so
> >> >     ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so
> >> > +ifeq ($(SASL), 1)
> >> >     ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
> >> > +endif
> >> >     ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so
> >> >  ifeq ($(EXT2FS), 1)
> >> >   ifeq ($(EXT3FS), 1)
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe autofs" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >


