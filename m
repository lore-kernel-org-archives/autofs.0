Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645615AF2
	for <autofs@vger.kernel.org>; Mon,  6 Nov 2023 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/G4RiNB"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9ED45
	for <autofs@vger.kernel.org>; Mon,  6 Nov 2023 09:05:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9db6cf8309cso676953266b.0
        for <autofs@vger.kernel.org>; Mon, 06 Nov 2023 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699290353; x=1699895153; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=blbZ40FgCk5BFlMJfglC/r9zWAKtXuG5aisFMqikZIs=;
        b=l/G4RiNBxHP+TmVxymITFknV0rlwEYNaDAJCMKmWNQ1+Z69PCIHoiGZem8/U/2u1Tv
         A+3z7NHpA2gtbW0dzHO42je5b29R6J+Wq29qD9A9iidYi/heAXW1BKBjZq81xbu5m5ma
         dA9qCYgHuG3Gf7jQKypetTeQvnqubXLKM1Mzpru1A6Z17exEOfuPPGjRGwsfbw+Xr6xM
         eF+cs+c/SR8xbY5FQ+FG0G1DiaY6Xv8alInwnjokt9iWA0Lo6sOOonJGUQg/F76ksOBu
         xG2JWY1yzyHqo511K8APNdkiCAIN3grVW9hJ1Y369pL463lvs9geQeD+S/wAG3GQIl2T
         M+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699290353; x=1699895153;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blbZ40FgCk5BFlMJfglC/r9zWAKtXuG5aisFMqikZIs=;
        b=J8jQE1RNELJZB7ZQD/M/2kL2XAm7TRklXcmhHM7XIEB6oa7wKN6o58bS5A1rK4Nx+k
         SZce2343eh2Gd1Vp9J2SZ7pU9KDLxRP8E7K/fGb5Z/h1Bsgw1EcXuH5rr5eRJyT/St3b
         /orQheBopg4A4MsOgPbxl7wfxr/nKn4bKTLwL2rxLvmoFxGgGaoAq6HiYreWWfLjADOS
         z8h80roGu/drWPEvW0Vk4MnffQDMiwQaWAN651dGPRP9fqp4D22+3jNHsBIVUUZFP6EZ
         h6zADn/4K3oTzMQzHfnLaSZNINvs8Yv8jEZgenurcjvm52/xNbDYegUxScNAGcLxJJ4j
         D7bw==
X-Gm-Message-State: AOJu0YyENfD8UmxzhF1UR3GMMurp3ShY7M4ou8UdoqBJxFD8clSqccxV
	FQNMvr22FkxpabgRTw9m2AuOxTb038x9j+dpRsg2TQ7DQsA=
X-Google-Smtp-Source: AGHT+IEuiK3DA4rNGqKKvsE/4Ss26QjYuw5K1f3i+k8toGPi2EfxdvV+vjTV3/hFe9Dv6Z7y1Bh/qwZ0wZAk/PI5ek0=
X-Received: by 2002:a17:907:6ea2:b0:9a5:846d:d823 with SMTP id
 sh34-20020a1709076ea200b009a5846dd823mr15648609ejc.45.1699290353209; Mon, 06
 Nov 2023 09:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert Vasek <rvasek01@gmail.com>
Date: Mon, 6 Nov 2023 18:05:41 +0100
Message-ID: <CADVsYmhjjKYUCHGWmzeTHXuQNAiR6ELbGzyy+m30ar+yaYLBzQ@mail.gmail.com>
Subject: Skip autofs unmount on daemon exit
To: autofs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear autofs community,

We run an instance of the automount daemon inside a container (a part
of a storage plugin in Kubernetes). The autofs mount root is shared
between different containers, and must survive restarting the daemon.

The problem is that when the daemon exits, it tries to clean up all
its mounts -- including the autofs root, so there is nothing to
reconnect to. At the moment, we're getting around the issue by sending
it a SIGKILL upon the daemon container exit, which skips the mount
cleanup, leaving it available for reconnect when the container comes
back.

While this works nicely for the moment, we don't want to rely on some
random signal which may be handled differently in the future, and I
didn't see anything in the options that would explicitly skip mount
clean up at exit. Would you accept a patch that adds a dedicated
command line flag for this?

Cheers,
Robert Vasek
