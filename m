From: Stef Bon <stefbon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [autofs] [PATCH 00/17] Introduce automounter dentry ops
Date: Fri, 1 Oct 2010 20:01:55 +0200
Message-ID: <AANLkTinoJCY=Fy_0UPWdasJg3GE5WQP0pQA8cLnir1BL@mail.gmail.com>
References: <20100930181455.30939.53914.stgit@warthog.procyon.org.uk>
	<4CA59482.1040508@bononline.nl>
	<8948.1285921904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-cifs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a5axSqo7ru0C44Wtv7lv2fNCuOsnzbv/iOl9GK0b8wk=;
        b=cFFouZKhtIq+N9yV+moDO+Ijgth8cZ31KItLl2IVGg7TtZTjQtIynYEuqpUk7vpC6r
         wCXJkSmfR1I/8QmppHRRvZFYwJjkFk6fIJcAqJeRmT2pX4QTFa+8HxrcHu/8AamjRdmq
         pxjjmCXmPIl7XACSLRjRtQuHh2IUQdQRIIorE=
In-Reply-To: <8948.1285921904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-cifs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Stef Bon <stef-/E4qUF3RmbfcqV2Q6a4srg@public.gmane.org>, autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks a lot for your answer. It's becoming more clear to me now.

As I understand it, it gives a framework to allow the fs (cifs, nfs
afs) do sub-auto-mounting right?

Stef

2010/10/1 David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> Stef Bon <stef-/E4qUF3RmbfcqV2Q6a4srg@public.gmane.org> wrote:
>
>> Cifs is the target filesystem, and handled by the automounter, thus =
the
>> automounter is the initiator, not cifs.
>>
>> As you describe it (well it looks like it, I may not understand...) =
cifs is
>> the initiator, and the patches to the automounter make autofs handle=
 cifs
>> requests handle better?
>
> CIFS has DFS referrals, by which one point in a CIFS mount can refer =
you to a
> point in another volume, possibly on another server. =C2=A0Linux auto=
matically
> mounts the referred volume on the directory corresponding to the refe=
rral when
> you try and cross into it.
>
> AFS and NFS do similar things.
>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
