Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB83F6C3D
	for <autofs@vger.kernel.org>; Wed, 19 Aug 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130564; cv=pass; b=sd6Ilc/EXb9qh2Yf4bDfzPohGHfER4OJvoB0YPUcbJj8aEREGcYrX52/0TNQztLoopBe8PS/uZeR+2KtdAOW8yOcVmK7V8mm7dcxk6FmdgClYEWPjh2ohP9guKqwt3SSrERakw2jSluxEZqOMI950HgDwVo6bmum2Si5rixc450=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130564; c=relaxed/simple;
	bh=VxLcxGFnv3Wh0dZXLmW4jadAYRYlp87Z88fRFCOtk5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhHpwhKkJhHlVx8c4VZ5SqsuvkG4I4B1KCcOSFS0Iaamg/KL167VmHAiwjcQSjRIYtm/la6a5v+tq1i+N9bNpRYcrr4dmi/4GMYysk3WuK8fIR4TR9eW1qyQn03klNGZ2L3eyTGWF9EEqJXQoxdsBlsoJhaYe+SD2dJpextL5rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtVWTOmL; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtVWTOmL"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so960809a12.1
        for <autofs@vger.kernel.org>; Wed, 19 Aug 2026 02:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787130560; cv=none;
        d=google.com; s=arc-20260327;
        b=G81d9Lr/NbGiNGGVwNKeywbhbqCa0qvRAYqmk9SjhBAPTKuTTKqXHJqy8Q3OXTAhCl
         ynuA82TpVWzTmZ6bUDvy0ZpXa1gWwk3tgQCpCDuMkGJxGIxY/df5m0/AtP90+yGeGr12
         6yOvIFfX76y+iSVjjwpWdeOF0RTHfMv8LaIiK8neNg8TNTkng6hp8jsw/GwaQcIz3ZWl
         jmQRnnMuCSQI7ehZyoIMAXK4wBC55gw4TNyUSR/Kbuh1AqnH2U56pBA7RL0nDZOaOQfu
         y9IVl6cqhZhOmcLV0Wm4jCtHqRB+jYHpDRRSKtDaM6wAlwcmdmvQ9T14+Qcfl9tjUnR0
         v2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z/UsJEaKgDYrOY++OeFAHhZg4Up52swLtR2aOkPIYIA=;
        fh=6v1tFRWl/Pn6ooh8gBC43gQZphT2bh8vKwdLGox9hNQ=;
        b=RecTfF4un9cOlHtyXYdlcv3Ix6BwR3kUHe/RkR58L0MYA5b6f2zY75iTIrJtOqPdnx
         7GgNsBr0lszk9YknK/n3tsQLAaHHIdj9zXD17wOKgapWLo/8HeYwgX8FIEpEddCKUP9o
         BuOVF8qtO5Umj5GxiesKPjXhdHoyL1ghG7ClucmjQNi9sydQ+FeWXS5xPYavmLpcDfJN
         aOg29bRGmtIn9ZrrIDdbyuuMibD2tav3HaN2O79kb9PDWF7pdYsr6SihBGeX6O4JzD5I
         nlKxBLvFZAFlWRQDBc3ku3HaYZuvHpP0tovKbKy16Yl/BzjtGqYpBzVloiXYP+fw9jn+
         oigQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787130560; x=1787735360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/UsJEaKgDYrOY++OeFAHhZg4Up52swLtR2aOkPIYIA=;
        b=gtVWTOmL788KLv4NfTwmw/VAmIfd1pHqdPi3Rr3XtN5wYHrDRW59QKo1c4Fj9sU9jE
         kV5CVAt8Y7w9oWKG9+I0t12HAF7rod5dP6mowRiB882ls08rn8fBR/S+mgolFK4B9JwK
         KPIMYjryCFvEMgCQCQhrfL/jSkDPw9+BPcwrYuiIKGpdC0KXL4krCWRJRCUPD9wLmI/I
         6FDn9mqwsUKs4rL0+NFlHC8oOb1FYZjDYFXHqXNv9kvgroxQR9MiKMhjVjchnKoWen4O
         5t7Yl71UFhNnevaI7DQVM0f5YL88dDeGKpc3hs9w2hTozvrc38wSW13KJzT5PPYPPoCo
         ycnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130560; x=1787735360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z/UsJEaKgDYrOY++OeFAHhZg4Up52swLtR2aOkPIYIA=;
        b=nxaMbtb6PmuvXKjBg+Cm6yv82nNyC6Rxlv+ArsMNxcMwb3mkUq4cSJKvZy72SY0Dsc
         HgoYVExk5h3aa57sIyRu4IKPOCTrF6E5D0Q3xAJt+CTtD6D7fF5bcJzANCEP8QuvUqJx
         QRiuj+Vx1UEGITBcFZhrbSe0znMU07cEcLtR8s9EpPwAzKp2Voy5Wqf1V2cyvQKQn9AR
         I76xehJCWeVe8BU4vAZb29R8wCv4muzHI6KEv4YZ8l26ChLCEhopYe8Ijw3XTkp9RvSV
         gtujuxulcYM6lc5ChecumP0qvw9rewHs6lDTTUa3P9MWZGcXUCNxy5PIbjWRneN23+ox
         0c/Q==
X-Forwarded-Encrypted: i=1; AHgh+RosSfOr9uAQc/Mru6Wf0ifTzf6OtqETwdmixh7m/ofiH+vvNDjxXHRaFw89vNEkkG7IAD0cQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWjh73Pei3y5pZvL5hNRNxXDC4mslzVQ98K+1WuarO9QnUfYP
	b1RqMNZXCU87u7ryGtHGk4I06p5JelhdepJLhEgKL9NsT/p7sz96UJNFB6R2KqIyUiFLbBFW5hW
	i1wxOFa+8QqcvDu9xZf+1Wa2ycPijcd4=
X-Gm-Gg: AR+sD12vvbyaULLf7PMhh2wnFy4n9E0Pu6Fwmjh5zb2PREHehsxymoUNVWQdubfiVAu
	cUvbnlTOr6NWXLKiR+3CXO0vHyo/60W5mmKoUtJ3rNMr/9ejyyh8haaDwt220wB2F8vmE4klsAj
	oX+BV8/jK1C3IitXhhbJpr+fPpgcqhJC6jAY7d5oCfGAz3SQ8HA6lempec1wLc0/mQNX/gu1Egv
	bKsiBItQxcOq7AtTd/GhRiq+Tw9jtcyogm4U9PeEsCAi8vnHXlOOrKm+kl61gtRGXxHjtg4ETiC
	iiPv0pWfOh6E31kXeTGrNu10n/GWFkKwpYqgDRNnz4FsxQ==
X-Received: by 2002:a05:6402:c4f:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a4032a67ddmr1633322a12.5.1787130560235; Wed, 19 Aug 2026
 02:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-4-neilb@ownmail.net>
 <CAJfpegs-k3skRGiwZvQLzD7OrAK4KL8zwmpmJKyjRHSQ-rqX+Q@mail.gmail.com>
 <178642552869.2852630.11443303758249822243@noble.neil.brown.name>
 <178675372176.2852630.1305553887009521382@noble.neil.brown.name>
 <oh2lg2agqxwqopecacq6sfdnky5faxidwsybkvbwbq24r6tw6o@4swfog5ocwwb>
 <CAOQ4uxgtKvKmPaK8rPAZDSwu0Hr9JAmqJi0a1VX_Rg7jDo8HrQ@mail.gmail.com> <178709583480.2852630.4575326968116183366@noble.neil.brown.name>
In-Reply-To: <178709583480.2852630.4575326968116183366@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Aug 2026 11:09:08 +0200
X-Gm-Features: AcwNN1UFDFH9Q8rKf4JEYrfWaPzn8I4k7H_DXxMVUtNUKHAd4oHCJiy2cVmJC48
Message-ID: <CAOQ4uxj6O8Ukbn-vWU-o+zOAYyofokCTAGnSifSDh9-PACCTdg@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] fsnotify: don't hold a spin_lock across
 fsnotify_recalc_mask() calls.
To: NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
	Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000035f8d4065962c2b9"

--00000000000035f8d4065962c2b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 1:30=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Mon, 17 Aug 2026, Amir Goldstein wrote:
> > On Mon, Aug 17, 2026 at 1:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 15-08-26 10:28:41, NeilBrown wrote:
> > > > On Tue, 11 Aug 2026, NeilBrown wrote:
> > > > > On Tue, 11 Aug 2026, Miklos Szeredi wrote:
> > > > > > On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrot=
e:
> > > > > >
> > > > > > > @@ -116,11 +117,15 @@ static int dnotify_handle_event(struct =
fsnotify_mark *inode_mark, u32 mask,
> > > > > > >                 else {
> > > > > > >                         *prev =3D dn->dn_next;
> > > > > > >                         kmem_cache_free(dnotify_struct_cache,=
 dn);
> > > > > > > -                       dnotify_recalc_inode_mask(inode_mark)=
;
> > > > > > > +                       need_recalc =3D true;
> > > > > > >                 }
> > > > > > >         }
> > > > > > >
> > > > > > > +       if (need_recalc)
> > > > > > > +               need_recalc =3D dnotify_recalc_inode_mask(ino=
de_mark);
> > > > > > >         spin_unlock(&inode_mark->lock);
> > > > > > > +       if (need_recalc)
> > > > > > > +               fsnotify_recalc_mask(inode_mark->connector);
> > > > > >
> > > > > > Is the fsnotify_group_lock() held in this case?   I don't see i=
t.
> > > > >
> > > > > It isn't held.  Doesn't it need to be...
> > > > > It seems to protect marks, so maybe it does.
> > > > >
> > > > > srcu seems to be used to protect this section, so maybe we can re=
ly on
> > > > > that.
> > > >
> > > > I dug into this some more, and we do rely on srcu, but don't need t=
he
> > > > extra code below.
> > > > inode_mark->lock doesn't protect inode_mark->connector, so moving t=
he
> > > > dereference out of the lock has no effect.
> > > > srcu_read_lock is taken before we get the ref to the mark, so the m=
ark
> > > > and the connector cannot disappear underneath us.
> > > > A race could result in inode_mark->connector reading as NULL, but
> > > > fsnotify_recalc_mask() checks for NULL, so there is no risk for har=
m.
> > > >
> > > > Thanks for encouraging me to dig into this.
> > >
> > > Sorry for not replying earlier but I was on vacation. The lifetime ru=
les
> > > around marks & connectors are subtle so we have to be really careful =
and
> > > dnotify with its single shot marks is peculiar which makes things eve=
n
> > > harder. fsnotify_recalc_mask() has a comment about locking in front o=
f it:
> > >
> > > /*
> > >  * Calculate mask of events for a list of marks. The caller must make=
 sure
> > >  * connector and connector->obj cannot disappear under us.  Callers a=
chieve
> > >  * this by holding a mark->lock or mark->group->mark_mutex for a mark=
 on this
> > >  * list.
> > >  */
> > >
> > > and you very obviously start violating these rules with your changes.=
 Now I
> > > admit I've forgotten all the details why I did it like this so let me
> > > reconstruct it :).
> > >
> > > Connector stays alive as long as there's any mark in its list. Both m=
arks
> > > and connectors are protected by the srcu. Mark also has
> > > FSNOTIFY_MARK_FLAG_ATTACHED flag which is set iff the connector->obj =
is
> > > pointing to valid inode/mount/... FSNOTIFY_MARK_FLAG_ATTACHED changes=
 only
> > > under mark_mutex so that's why mark_mutex is stabilizing the connecto=
r (and
> > > also connector->obj). This is what is used by most places calling
> > > fsnotify_recalc_mask(). But dnotify needs to mess with notification m=
ark
> > > mask from event handling and there we cannot take mark_mutex due to l=
ock
> > > ordering constraints. That's where the mark->lock rule comes into pla=
y
> > > because mark->lock also needs to be acquired to clear
> > > FSNOTIFY_MARK_FLAG_ATTACHED. That being said this dnotify use of
> > > fsnotify_recalc_mask() still looks somewhat racy because
> > > dnotify_handle_event() can get called after FSNOTIFY_MARK_FLAG_ATTACH=
ED is
> > > cleared.
> > >
> > > Anyway if you move fsnotify_recalc_mask() call outside of mark->lock,=
 you
> > > seem to make the race with dnotify clearing the mark from
> > > fcntl_dirnotify() easier to hit. Now in the notification path the ino=
de
> > > itself is guaranteed to stay alive and the rest is protected by the S=
RCU so
> > > there's no direct UAF. But fsnotify_recalc_mask() simply isn't prepar=
ed for
> > > the connector changing under it due to object getting detached and so=
 we
> > > could end up doing weird things like NULL ptr derefs or similar stuff=
.
> > >
> > > So this call to fsnotify_recalc_mask() from dnotify needs a more care=
ful
> > > handling. Which is sad because I doubt anybody still uses dnotify...
> >
> > Maybe this is the way out.
> >
> > dnotify_recalc_inode_mask() can only remove bits from i_fsnotify_mask,
> > so it is an optimization.
> >
> > If we just remove fsnotify_recalc_mask() call from
> > dnotify_recalc_inode_mask(), then i_fsnotify_mask will be updated when
> > dnotify_mask gets removed eventually.
>
> I had thought something along these lines too.  I don't think we need to
> drop all of fsnotify_recalc_mask(), only the
> fsnotify_conn_set_children_dentry_flags() part that walks the d_children
> list.  And that only happens when we add to the mask, not when bits are
> cleared.  So maybe the fsnotify_conn_set_children_dentry_flags() simply
> never happens in this context so it doesn't need fixing.
>
> I would prefer to make that clear from the code with a patch like the
> following.
>
> Note that I'm not (yet) convinced by the locking argument, but maybe we
> don't need to pursue it.
>
> Thanks,
> NeilBrown
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 9fb73bafd41d..be66d4142563 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -75,7 +75,7 @@ static void dnotify_recalc_inode_mask(struct fsnotify_m=
ark *fsn_mark)
>                 return;
>         fsn_mark->mask =3D new_mask;
>
> -       fsnotify_recalc_mask(fsn_mark->connector);
> +       fsnotify_recalc_mask_inatomic(fsn_mark->connector);

I don't think skipping update_children is correct when called
from fcntl_dirnotify().

>  }
>
>  /*
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index b2640d836a71..7ba79828b07d 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -322,7 +322,8 @@ static void fsnotify_conn_set_children_dentry_flags(
>   * this by holding a mark->lock or mark->group->mark_mutex for a mark on=
 this
>   * list.
>   */
> -void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> +static void do_fsnotify_recalc_mask(struct fsnotify_mark_connector *conn=
,
> +                                   bool in_atomic)
>  {
>         bool update_children;
>
> @@ -339,10 +340,20 @@ void fsnotify_recalc_mask(struct fsnotify_mark_conn=
ector *conn)
>          * When parent stops watching, we clear false positive PARENT_WAT=
CHED
>          * flags lazily in __fsnotify_parent().
>          */
> -       if (update_children)
> +       if (update_children && !WARN_ON(in_atomic))
>                 fsnotify_conn_set_children_dentry_flags(conn);
>  }
>

I think I prefer the straight forward semantics in the attached patch.

Thanks,
Amir.

--00000000000035f8d4065962c2b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-update-children-flags-only-when-adding-mask.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-update-children-flags-only-when-adding-mask.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mszvb4y70>
X-Attachment-Id: f_mszvb4y70

RnJvbSA3M2JiZmNkMWIyMWEwZmM3MjM5OTlhZWUzNmFmNjYyZjM2YmE0ZGQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDE5IEF1ZyAyMDI2IDEwOjU2OjQwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IHVwZGF0ZSBjaGlsZHJlbiBmbGFncyBvbmx5IHdoZW4gYWRkaW5nIG1hc2sgYml0cwoK
U2luY2Ugd2Ugb25seSBldmVyIHNldCB0aGUgUEFSRU5UX1dBVENIRUQgZmxhZyBmcm9tCmZzbm90
aWZ5X3JlY2FsY19tYXNrKCksIHRoZXJlIGlzIG5ldmVyIGEgbmVlZCB0byB1cGRhdGUgY2hpbGRy
ZW4gZmxhZ3MKd2hlbiByZW1vdmluZyBtYXJrIG1hc2sgYml0cyBvbmx5IHdoZW4gYWRkaW5nIHRo
ZW0uCgpGaXhlczogMTcyZTQyMmZmZWEyMCAoImZzbm90aWZ5OiBjbGVhciBQQVJFTlRfV0FUQ0hF
RCBmbGFncyBsYXppbHkiKQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxA
Z21haWwuY29tPgotLS0KIGZzL25vdGlmeS9kbm90aWZ5L2Rub3RpZnkuYyAgICAgICAgfCAxMCAr
KysrKy0tLS0tCiBmcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNlci5jIHwgIDQgKystLQog
ZnMvbm90aWZ5L2lub3RpZnkvaW5vdGlmeV91c2VyLmMgICB8ICAyICstCiBmcy9ub3RpZnkvbWFy
ay5jICAgICAgICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKy0tLS0tLS0tLQogaW5jbHVkZS9s
aW51eC9mc25vdGlmeV9iYWNrZW5kLmggICB8ICA4ICsrKysrKy0tCiA1IGZpbGVzIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlm
eS9kbm90aWZ5L2Rub3RpZnkuYyBiL2ZzL25vdGlmeS9kbm90aWZ5L2Rub3RpZnkuYwppbmRleCA5
ZmI3M2JhZmQ0MWQyLi4wNjBlYTlhNDU1MzIyIDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZG5vdGlm
eS9kbm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5L2Rub3RpZnkvZG5vdGlmeS5jCkBAIC01OSw3ICs1
OSw3IEBAIHN0cnVjdCBkbm90aWZ5X21hcmsgewogICogaXQgY2FsbHMgdGhlIGZzbm90aWZ5IGZ1
bmN0aW9uIHNvIGl0IGNhbiB1cGRhdGUgdGhlIHNldCBvZiBhbGwgZXZlbnRzIHJlbGV2YW50CiAg
KiB0byB0aGlzIGlub2RlLgogICovCi1zdGF0aWMgdm9pZCBkbm90aWZ5X3JlY2FsY19pbm9kZV9t
YXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrICpmc25fbWFyaykKK3N0YXRpYyB2b2lkIGRub3RpZnlf
cmVjYWxjX2lub2RlX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmsgKmZzbl9tYXJrLCBib29sIGFk
ZCkKIHsKIAlfX3UzMiBuZXdfbWFzayA9IDA7CiAJc3RydWN0IGRub3RpZnlfc3RydWN0ICpkbjsK
QEAgLTc1LDcgKzc1LDcgQEAgc3RhdGljIHZvaWQgZG5vdGlmeV9yZWNhbGNfaW5vZGVfbWFzayhz
dHJ1Y3QgZnNub3RpZnlfbWFyayAqZnNuX21hcmspCiAJCXJldHVybjsKIAlmc25fbWFyay0+bWFz
ayA9IG5ld19tYXNrOwogCi0JZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3Rv
cik7CisJZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3RvciwgYWRkKTsKIH0K
IAogLyoKQEAgLTExNiw3ICsxMTYsNyBAQCBzdGF0aWMgaW50IGRub3RpZnlfaGFuZGxlX2V2ZW50
KHN0cnVjdCBmc25vdGlmeV9tYXJrICppbm9kZV9tYXJrLCB1MzIgbWFzaywKIAkJZWxzZSB7CiAJ
CQkqcHJldiA9IGRuLT5kbl9uZXh0OwogCQkJa21lbV9jYWNoZV9mcmVlKGRub3RpZnlfc3RydWN0
X2NhY2hlLCBkbik7Ci0JCQlkbm90aWZ5X3JlY2FsY19pbm9kZV9tYXNrKGlub2RlX21hcmspOwor
CQkJZG5vdGlmeV9yZWNhbGNfaW5vZGVfbWFzayhpbm9kZV9tYXJrLCBmYWxzZSk7CiAJCX0KIAl9
CiAKQEAgLTE3NCw3ICsxNzQsNyBAQCB2b2lkIGRub3RpZnlfZmx1c2goc3RydWN0IGZpbGUgKmZp
bHAsIGZsX293bmVyX3QgaWQpCiAJCWlmICgoZG4tPmRuX293bmVyID09IGlkKSAmJiAoZG4tPmRu
X2ZpbHAgPT0gZmlscCkpIHsKIAkJCSpwcmV2ID0gZG4tPmRuX25leHQ7CiAJCQlrbWVtX2NhY2hl
X2ZyZWUoZG5vdGlmeV9zdHJ1Y3RfY2FjaGUsIGRuKTsKLQkJCWRub3RpZnlfcmVjYWxjX2lub2Rl
X21hc2soZnNuX21hcmspOworCQkJZG5vdGlmeV9yZWNhbGNfaW5vZGVfbWFzayhmc25fbWFyaywg
ZmFsc2UpOwogCQkJYnJlYWs7CiAJCX0KIAkJcHJldiA9ICZkbi0+ZG5fbmV4dDsKQEAgLTM3Nyw3
ICszNzcsNyBAQCBpbnQgZmNudGxfZGlybm90aWZ5KGludCBmZCwgc3RydWN0IGZpbGUgKmZpbHAs
IHVuc2lnbmVkIGludCBhcmcpCiAJZWxzZSBpZiAoZXJyb3IgPT0gLUVFWElTVCkKIAkJZXJyb3Ig
PSAwOwogCi0JZG5vdGlmeV9yZWNhbGNfaW5vZGVfbWFzayhmc25fbWFyayk7CisJZG5vdGlmeV9y
ZWNhbGNfaW5vZGVfbWFzayhmc25fbWFyaywgdHJ1ZSk7CiBvdXQ6CiAJc3Bpbl91bmxvY2soJmZz
bl9tYXJrLT5sb2NrKTsKIApkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5
X3VzZXIuYyBiL2ZzL25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeV91c2VyLmMKaW5kZXggYTMyYzY2
MzRkNTkyNy4uNzAwZTM1M2M0MjVhNiAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zh
bm90aWZ5X3VzZXIuYworKysgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNlci5jCkBA
IC0xMjY0LDcgKzEyNjQsNyBAQCBzdGF0aWMgaW50IGZhbm90aWZ5X3JlbW92ZV9tYXJrKHN0cnVj
dCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJcmVtb3ZlZCA9IGZhbm90aWZ5X21hcmtfcmVtb3Zl
X2Zyb21fbWFzayhmc25fbWFyaywgbWFzaywgZmxhZ3MsCiAJCQkJCQkgdW1hc2ssICZkZXN0cm95
X21hcmspOwogCWlmIChyZW1vdmVkICYgZnNub3RpZnlfY29ubl9tYXNrKGZzbl9tYXJrLT5jb25u
ZWN0b3IpKQotCQlmc25vdGlmeV9yZWNhbGNfbWFzayhmc25fbWFyay0+Y29ubmVjdG9yKTsKKwkJ
ZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3RvciwgZmFsc2UpOwogCWlmIChk
ZXN0cm95X21hcmspCiAJCWZzbm90aWZ5X2RldGFjaF9tYXJrKGZzbl9tYXJrKTsKIAlmc25vdGlm
eV9ncm91cF91bmxvY2soZ3JvdXApOwpAQCAtMTUzOCw3ICsxNTM4LDcgQEAgc3RhdGljIGludCBm
YW5vdGlmeV9hZGRfbWFyayhzdHJ1Y3QgZnNub3RpZnlfZ3JvdXAgKmdyb3VwLAogCiAJcmVjYWxj
ID0gZmFub3RpZnlfbWFya19hZGRfdG9fbWFzayhmc25fbWFyaywgbWFzaywgZmFuX2ZsYWdzKTsK
IAlpZiAocmVjYWxjKQotCQlmc25vdGlmeV9yZWNhbGNfbWFzayhmc25fbWFyay0+Y29ubmVjdG9y
KTsKKwkJZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3RvciwgdHJ1ZSk7CiAK
IG91dDoKIAlmc25vdGlmeV9ncm91cF91bmxvY2soZ3JvdXApOwpkaWZmIC0tZ2l0IGEvZnMvbm90
aWZ5L2lub3RpZnkvaW5vdGlmeV91c2VyLmMgYi9mcy9ub3RpZnkvaW5vdGlmeS9pbm90aWZ5X3Vz
ZXIuYwppbmRleCA1ZjE5YzI0ZWMxODdmLi42ZDg0YzUxMTY3NDlkIDEwMDY0NAotLS0gYS9mcy9u
b3RpZnkvaW5vdGlmeS9pbm90aWZ5X3VzZXIuYworKysgYi9mcy9ub3RpZnkvaW5vdGlmeS9pbm90
aWZ5X3VzZXIuYwpAQCAtNTYyLDcgKzU2Miw3IEBAIHN0YXRpYyBpbnQgaW5vdGlmeV91cGRhdGVf
ZXhpc3Rpbmdfd2F0Y2goc3RydWN0IGZzbm90aWZ5X2dyb3VwICpncm91cCwKIAlmc25fbWFyay0+
ZmxhZ3MgfD0gaW5vdGlmeV9hcmdfdG9fZmxhZ3MoYXJnKTsKIAlzcGluX3VubG9jaygmZnNuX21h
cmstPmxvY2spOwogCi0JZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3Rvcik7
CisJZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3RvciwgdHJ1ZSk7CiAKIAkv
KiByZXR1cm4gdGhlIHdkICovCiAJcmV0ID0gaV9tYXJrLT53ZDsKZGlmZiAtLWdpdCBhL2ZzL25v
dGlmeS9tYXJrLmMgYi9mcy9ub3RpZnkvbWFyay5jCmluZGV4IGIyNjQwZDgzNmE3MTIuLjczMWU0
MzBmMmYzYzYgMTAwNjQ0Ci0tLSBhL2ZzL25vdGlmeS9tYXJrLmMKKysrIGIvZnMvbm90aWZ5L21h
cmsuYwpAQCAtMzE3LDIwICszMTcsMjEgQEAgc3RhdGljIHZvaWQgZnNub3RpZnlfY29ubl9zZXRf
Y2hpbGRyZW5fZGVudHJ5X2ZsYWdzKAogfQogCiAvKgotICogQ2FsY3VsYXRlIG1hc2sgb2YgZXZl
bnRzIGZvciBhIGxpc3Qgb2YgbWFya3MuIFRoZSBjYWxsZXIgbXVzdCBtYWtlIHN1cmUKLSAqIGNv
bm5lY3RvciBhbmQgY29ubmVjdG9yLT5vYmogY2Fubm90IGRpc2FwcGVhciB1bmRlciB1cy4gIENh
bGxlcnMgYWNoaWV2ZQotICogdGhpcyBieSBob2xkaW5nIGEgbWFyay0+bG9jayBvciBtYXJrLT5n
cm91cC0+bWFya19tdXRleCBmb3IgYSBtYXJrIG9uIHRoaXMKLSAqIGxpc3QuCisgKiBDYWxjdWxh
dGUgbWFzayBvZiBldmVudHMgZm9yIGEgbGlzdCBvZiBtYXJrcy4KKyAqIElmIEB1cGRhdGVfY2hp
bGRyZW4gaXMgdHJ1ZSwgdXBkYXRlIGNoaWxkcmVuIGRlbnRyeSBmbGFncyBpZiBuZWVkZWQuCisg
KiBUaGUgY2FsbGVyIG11c3QgbWFrZSBzdXJlIGNvbm5lY3RvciBhbmQgY29ubmVjdG9yLT5vYmog
Y2Fubm90IGRpc2FwcGVhciB1bmRlcgorICogdXMuICBDYWxsZXJzIGFjaGlldmUgdGhpcyBieSBo
b2xkaW5nIGEgbWFyay0+bG9jayBvciBtYXJrLT5ncm91cC0+bWFya19tdXRleAorICogZm9yIGEg
bWFyayBvbiB0aGlzIGxpc3QuCiAgKi8KLXZvaWQgZnNub3RpZnlfcmVjYWxjX21hc2soc3RydWN0
IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQordm9pZCBmc25vdGlmeV9yZWNhbGNfbWFz
ayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4sCisJCQkgIGJvb2wgdXBkYXRl
X2NoaWxkcmVuKQogewotCWJvb2wgdXBkYXRlX2NoaWxkcmVuOwogCiAJaWYgKCFjb25uKQogCQly
ZXR1cm47CiAKIAlzcGluX2xvY2soJmNvbm4tPmxvY2spOwotCXVwZGF0ZV9jaGlsZHJlbiA9ICFm
c25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oY29ubik7CisJdXBkYXRlX2NoaWxkcmVuICY9
ICFmc25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oY29ubik7CiAJZnNub3RpZnlfcmVjYWxj
X21hc2tfc2V0X2lyZWYoY29ubik7CiAJdXBkYXRlX2NoaWxkcmVuICY9IGZzbm90aWZ5X2Nvbm5f
d2F0Y2hlc19jaGlsZHJlbihjb25uKTsKIAlzcGluX3VubG9jaygmY29ubi0+bG9jayk7CkBAIC0z
NjgsNyArMzY5LDcgQEAgdm9pZCBmc25vdGlmeV9tb2RpZnlfbWFya19tYXNrKHN0cnVjdCBmc25v
dGlmeV9tYXJrICptYXJrLCB1MzIgc2V0LCB1MzIgY2xlYXIpCiAJc3Bpbl91bmxvY2soJm1hcmst
PmxvY2spOwogCiAJaWYgKHJlY2FsYykKLQkJZnNub3RpZnlfcmVjYWxjX21hc2sobWFyay0+Y29u
bmVjdG9yKTsKKwkJZnNub3RpZnlfcmVjYWxjX21hc2sobWFyay0+Y29ubmVjdG9yLCAhIXNldCk7
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChmc25vdGlmeV9tb2RpZnlfbWFya19tYXNrKTsKIApAQCAt
OTk4LDcgKzk5OSw3IEBAIGludCBmc25vdGlmeV9hZGRfbWFya19sb2NrZWQoc3RydWN0IGZzbm90
aWZ5X21hcmsgKm1hcmssCiAJaWYgKHJldCkKIAkJZ290byBlcnI7CiAKLQlmc25vdGlmeV9yZWNh
bGNfbWFzayhtYXJrLT5jb25uZWN0b3IpOworCWZzbm90aWZ5X3JlY2FsY19tYXNrKG1hcmstPmNv
bm5lY3RvciwgdHJ1ZSk7CiAKIAlyZXR1cm4gcmV0OwogZXJyOgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmggYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tl
bmQuaAppbmRleCA2MThlZWQ0ZDZkNzI0Li44MjYzMjg3ZTE2MmJmIDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5
X2JhY2tlbmQuaApAQCAtODg1LDggKzg4NSwxMiBAQCBzdGF0aWMgaW5saW5lIF9fdTMyIGZzbm90
aWZ5X2NhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFyaykKIAogLyogR2V0IG1hc2sg
b2YgZXZlbnRzIGZvciBhIGxpc3Qgb2YgbWFya3MgKi8KIGV4dGVybiBfX3UzMiBmc25vdGlmeV9j
b25uX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKTsKLS8qIENhbGN1
bGF0ZSBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzICovCi1leHRlcm4gdm9pZCBm
c25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4p
OworLyoKKyAqIENhbGN1bGF0ZSBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzIGFu
ZCB1cGRhdGUgY2hpbGRyZW4gZGVudHJ5CisgKiBmbGFnIGlzIG5lZWRlZC4KKyAqLworZXh0ZXJu
IHZvaWQgZnNub3RpZnlfcmVjYWxjX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9y
ICpjb25uLAorCQkJCSBib29sIHVwZGF0ZV9jaGlsZHJlbik7CiBleHRlcm4gdm9pZCBmc25vdGlm
eV9pbml0X21hcmsoc3RydWN0IGZzbm90aWZ5X21hcmsgKm1hcmssCiAJCQkgICAgICAgc3RydWN0
IGZzbm90aWZ5X2dyb3VwICpncm91cCk7CiAvKiBGaW5kIG1hcmsgYmVsb25naW5nIHRvIGdpdmVu
IGdyb3VwIGluIHRoZSBsaXN0IG9mIG1hcmtzICovCi0tIAoyLjU1LjAKCg==
--00000000000035f8d4065962c2b9--
