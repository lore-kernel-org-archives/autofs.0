Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501FD51D
	for <autofs@vger.kernel.org>; Wed,  8 Nov 2023 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeQfD1kP"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4DE131
	for <autofs@vger.kernel.org>; Wed,  8 Nov 2023 08:29:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9df8d0c556eso591369766b.2
        for <autofs@vger.kernel.org>; Wed, 08 Nov 2023 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699460969; x=1700065769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JznNn1VUPyffRbTPFM8pEbsrutBVuwljz1cicHLr4U=;
        b=jeQfD1kPT7T+G6nrljR8UEp3AL9iNSFBRFHy4HtMd9nvJK6G6nYelcQUdpvF33/cf0
         F1j2lhoaP4++zkjKIj9eli5+6bMS14Quhpn3HR3PC/iqjYbH2tzvncyfzDAORHRicaoX
         5JjJ958MsKcGU0OWYUjCYi64pqDtvGLDvuJxAoXYRvnQE2HftEb7wBkZK7SwnYzMp3bk
         PFDEczpWw/R+JpzOtdrMy+C09u3bbPx163o/4Vewh1L47CzmK2jMs/XYOGaAbCsNRxV+
         HXGllCcG4nTHmwsA0kToKrJPKo3jWLOnkuzpaAmKQgZ4tM3aR+BlPNdyEr3Qd0uDlLza
         Wbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460969; x=1700065769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JznNn1VUPyffRbTPFM8pEbsrutBVuwljz1cicHLr4U=;
        b=DfkHop2/dUf6qbcBfj5Pv3ypmz2WStbQXpsMrAN6b6aU7iU0XZF/TnmKBybzdXQIka
         OCnyf1RBfqnpC3fXHvkoRTN/h7f7sUECTHGTnWraTPNOU0E4J6RnCV8zKamvGI0G+0sS
         isD6k8aRpadUnStIlrjKDmEKmIFwUlPu+BcUgE78wN9ISuRaSJNJ4fOS3NpR+wvMK/d+
         7irBd1ytcYAiouq4BVDjyoxJFx8FvKFVMu8N24jhDgh/y/GSB5CmHh2gd5CCtm08Qr+L
         ao2xdxrm5iwhczkFp4pLUxXPm/1UEN+YuHimb6q+nlqopd0PFh5IygU4JvgbTRz2yn6H
         kb2Q==
X-Gm-Message-State: AOJu0YwlNvQj3UOONP4DFWevPc/NOrFH6jU1W6GZLAFJpge8XHrgxOsu
	6HOymOJf+LuFA//fFu/3Og2+U0SJkST1FoXxNiDEMHtoRzG+ew==
X-Google-Smtp-Source: AGHT+IFyvKUYIWBvoBhtnEhJOPTMlZxjn+XkljBsemiEFC5a2aSssRxngxxLgXVWYfmCDZ8c3BbYP0Sq7mktqLgOG2Y=
X-Received: by 2002:a17:907:2ce2:b0:9e2:d087:86de with SMTP id
 hz2-20020a1709072ce200b009e2d08786demr1703729ejc.42.1699460969289; Wed, 08
 Nov 2023 08:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVsYmhjjKYUCHGWmzeTHXuQNAiR6ELbGzyy+m30ar+yaYLBzQ@mail.gmail.com>
 <aeb5af36-4686-9d69-22fd-89adf5fd2c80@themaw.net>
In-Reply-To: <aeb5af36-4686-9d69-22fd-89adf5fd2c80@themaw.net>
From: Robert Vasek <rvasek01@gmail.com>
Date: Wed, 8 Nov 2023 17:29:17 +0100
Message-ID: <CADVsYmiTK0UtkkxZfMqMEniVNMd7f=vJ8tm-TmDNXkYhkh-hBQ@mail.gmail.com>
Subject: Re: Skip autofs unmount on daemon exit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

> That sounds unusual, please tell me more about how this works?

Essentially, you have two roles for containers:
* mount provider: mounts a volume in a path; provided by a storage vendor
* consumer: makes use of the mounted volume; user application

There are also two directories on the host:
* /staging: publisher mounts the volume once into /staging/{volume_id}
* /publish: the mounts from /staging/{volume_id} are bind-mounted into
/publish/{consumer_id}/{volume_id}

The provider container(s) gets access to /staging and /publish as a
shared bind-mount, while the consumer gets access only to its own
/publish/{consumer_id} as a slave bind-mount. This is it as far as how
things are connected together. Here's a bit more concrete example:
* the provider we're developing has the map definitions, runs the
automount daemon and exposes an indirect map mount in /staging/x
* when a new consumer is scheduled on the node, the provider receives
a request to expose volume x for container y, and so it runs `mkdir
/publish/y/x && mount --rbind --make-slave /staging/x /publish/y/x`,
* the container runtime then makes sure /publish/y/x is exposed to the
consumer container.

All this is of course a bit simplified, but should be enough to
illustrate the setup. automount's reconnect feature here is critical,
as the provider may be restarted (due crash or upgrade, etc.). If
there are any more questions about this, I'm happy to give more
details!

> By all means, send it over.

Cool, I should have something ready in the coming days, thanks!

PS: more details on how this works can be found here (in general,
unrelated to autofs):
* https://github.com/kubernetes/design-proposals-archive/blob/main/storage/=
container-storage-interface.md
* https://github.com/container-storage-interface/spec/blob/master/spec.md

Cheers,
Robert

ut 7. 11. 2023 o 3:15 Ian Kent <raven@themaw.net> nap=C3=ADsal(a):

>
> On 7/11/23 01:05, Robert Vasek wrote:
> > Dear autofs community,
> >
> > We run an instance of the automount daemon inside a container (a part
> > of a storage plugin in Kubernetes). The autofs mount root is shared
> > between different containers, and must survive restarting the daemon.
>
> That sounds unusual, please tell me more about how this works?
>
>
> My thought was always that there are two ways one would use autofs in
>
> a container.
>
>
> One is mapping an indirect mount root (from the init mount namespace)
>
> as a volume into the container thereby using the daemon present in the in=
it
>
> namespace. Yes, this has had an expire problem for a long time but that w=
ill
>
> change (soon I hope).
>
>
> The second way is to run an instance of the daemon completely independent=
ly
>
> within the container.
>
>
> But this sounds like a combination of both of these which is something I
>
> hadn't considered.
>
>
> >
> > The problem is that when the daemon exits, it tries to clean up all
> > its mounts -- including the autofs root, so there is nothing to
> > reconnect to. At the moment, we're getting around the issue by sending
> > it a SIGKILL upon the daemon container exit, which skips the mount
> > cleanup, leaving it available for reconnect when the container comes
> > back.
>
> Yes, it does.
>
>
> My preferred configure setup is to leave mounts in use mounted at
>
> exit but that's not what you need ...
>
>
> While the SIGKILL usage won't change I agree it would be better
>
> to be able to tell automount to just leave everything mounted at
>
> exit. You might need to send a HUP signal at container start in
>
> case of map updates but indirect mounts should detect changes
>
> anyway.
>
>
> >
> > While this works nicely for the moment, we don't want to rely on some
> > random signal which may be handled differently in the future, and I
> > didn't see anything in the options that would explicitly skip mount
> > clean up at exit. Would you accept a patch that adds a dedicated
> > command line flag for this?
>
> By all means, send it over.
>
>
> I'm not sure how this will fit in with the configure options for
>
> mount handling at exit ... we'll see what we get, ;)
>
>
> Ian
>
