From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Sat, 15 Jan 2011 09:14:01 +1100
Message-ID: <AANLkTinwkPWRGqzj9UgS2MLLBQVNCoAye003_LqLUo=8@mail.gmail.com>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
	<20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
	<AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
	<AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com>
	<16508.1294931527@redhat.com>
	<AANLkTi=ZiOZ08WEkTt8nVWkaeSG9mnM0JQ-ov=kO2mpc@mail.gmail.com>
	<20110114162403.GF19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=12gXjnILIWG2cQgzgBfER4+b8HXtoxY21vaVZ1l4S2M=;
        b=ds2Fgi61z0rnNh4KNR07z3rx3gcXWOTmHb5E/4mcCrD5IMp1BDCU20DR07ZI4q9MlP
         k54V/KOgYs+xaq5+5tZObykRr0b34C735ojqzDYNWc0mErjwE1FzGmjmMIz4E+EDoOHx
         RQroqRLcptsdQcNbEP4BSkIzlrK9WrYmK5vbY=
In-Reply-To: <20110114162403.GF19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, npiggin@kernel.dk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2011 at 3:24 AM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Fri, Jan 14, 2011 at 12:19:43PM +1100, Nick Piggin wrote:
>
>> Also, I don't like how you return a vfsmount * and use that in path =
walking. If
>> you just returned success and allowed the path walk to continue look=
ing up
>> mounted directories, it would be cleaner code, IMO.
>
> No. =A0Filesystem has no business touching mount tree; leave that to =
core VFS.
> Analysis of what's going on is messy enough as it is, let's *NOT* com=
plicate
> it even further.
>
> I think we should take do_add_mount() calls into follow_automount(), =
making
> the API
> =A0 =A0 =A0 =A0NULL =3D> nothing to do here, just follow mount
> =A0 =A0 =A0 =A0ERR_PTR() =3D> sod off
> =A0 =A0 =A0 =A0mnt =3D> here's the thing I want mounted, do it and go=
 there. =A0If
> something's allready got mounted here, just disregard this one and fo=
llow
> mount as usual (=3D=3D we'd lost the race)

That would be fine. I just want the path walk to follow the mount in th=
e
usual way, rather than following something that the filesystem hands ba=
ck
directly.

David explains that was a micro optimisation to avoid the lookup, and t=
hat
the vfsmount should always be mounted at that point, which basically so=
lved
my conceptual problem with it.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
