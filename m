Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2851A9F86
	for <autofs@vger.kernel.org>; Tue, 16 Sep 2025 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066862; cv=none; b=lOwELQU/iQlyjuso6uCyWXLT6RY7nNGjlaVV6/pz9dkWL109moufcfXRnVxfhTxxa2Un1DnEGGcDFMcPRndkx26bZ3mzXREcLZLFrtqXnphlOI4GFKDmvor7QhaHDmiFe6aFfgQIuCachM9h4iMKoqTJKtL97VTaZ7yYrm0FnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066862; c=relaxed/simple;
	bh=yRzBOKKt1YPnPCbN0yYWBx+yaA9EHxfceGe1XTLj+88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fekPFuwuF1MsxrbF819eg80Vls2z0tnspjBt3Ju2+Dy29ZwWgKVPMAA22vLwikNZS0lkIzTpLNEcTLeSFy2VEd/vrBU+ZCYuvjCh8E8J/soKhC6XCOwkr6H9gqiO9CpysxAuiCg0DVBAN4DLAVQ5e44WrHq+zT6rtXnZ2msE4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=y9IavDzQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8iDEAYe; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="y9IavDzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8iDEAYe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D87EE7A02B7;
	Tue, 16 Sep 2025 19:54:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 16 Sep 2025 19:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758066857;
	 x=1758153257; bh=hGVPFw7rvdQXUBO3vXDMZ4PcUj+r+zyLBRQdggOStDA=; b=
	y9IavDzQCZSPjkuTvGdavkiQTqO+J/sB/BrJVwEXb4WGUJ657TIYYlYapEEW1pFd
	wCaLxCvoD9DOYKfjBFZpJAMciIlqrH7Q9b+CMGsaRtNgEn09TL1PVUed9ts3SOo5
	8DS4/arvk6tqRn3zuiVpoESLXK/53PR9GKO5b2mJYno+br8k55LjBiTN6wnl9AJl
	feP+XHppwTJDpTv1MjQiwyqBy+uzsayAyyn5jrq60MMvtwxEz6Tw27sfuyCx1LwV
	mDhHgVl8WXO4DH0kZXKYHEYnhIr6DXco6n2d9O75KDfSLg9QltBGtILrknhJsxDU
	WfEiw6HOP2vX0yNLSRY1MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758066857; x=
	1758153257; bh=hGVPFw7rvdQXUBO3vXDMZ4PcUj+r+zyLBRQdggOStDA=; b=f
	8iDEAYeqHXIBzSEk0PwdM62idB9AdARMVTpVaZA2kY3n4KIwhSoDG7+nNRCk9iXR
	ysnWgvLVUX/j/BrZWAM1x6PhLbfY68KS7ZGnulHzqjEhaxEvt5lth/p5g3kcElSi
	uU9sBtj+94rmlEBa1VXugjyAHE0k83s/VbMSfcqBADTJcwVUpMQ41ukLBxm17NUt
	0k4OtL961R5kugaSFP+njFA+KEl7nconyG8amaLVDhLEiR33LP0V6TCX6atKbEkK
	ZyLzAf++Mes7KdjDal1tKUNGZ+nI2W5Qjmh2FNe2SLTcLLXyrrOaZM5iTvufbTFF
	t9PEIO08+NfKhNoq8bWhA==
X-ME-Sender: <xms:qfjJaAu24HL7R4kkcPSZKWCK-sDRoMRD9yMWzq_YLidC1AkHjn0uBA>
    <xme:qfjJaNpaqF3d1bO0cFP9jbhxDzCpyemt8O9fCTvIF2by4UGFxGUFfe_8Pf07KlHqD
    lpIgmGcxQJ_>
X-ME-Received: <xmr:qfjJaNnTIBc67RCf69mHGbAm8v0mtYWRAl9-YJrKFNoLlGOHC5HcB70fGB3vvxz5OvF9ijA7EBVBNOZyif4CZOsajFOkQwbxaxcFicdEz7WH6qEa2BxOkDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtud
    fghedtudfgfefgtdejgedutddtveefheetvdefueefgffggfdvieelteffgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgvvghosehjrghnvghsthhrvggvthdrtghomhdprhgtphhtthhopegruh
    htohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qfjJaBynIbtooYVFmew1e-CCX_h_fPhexm57O5WvG7jz-j6xYINWuA>
    <xmx:qfjJaFk639w0aNcM9pmgnTR0XAbudkneUICWovZxM5alJFV6PP3OJw>
    <xmx:qfjJaKeAGG1umLOFBv3hn250YkfBoZ0ojfTmPftWDXBQmA2hRCnZ8g>
    <xmx:qfjJaLrIypQgWT9fGhGd_HbZg-tK4ISOYyIb8COZ470_Pc7Bot9I4g>
    <xmx:qfjJaEKQA3zQ4717uWNIHYPZ1ULlmzr7bKCYc6VZTxgolzjfPwVX8Y1k>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 19:54:16 -0400 (EDT)
Message-ID: <0db04b8e-6390-469b-89ac-0c46de334593@themaw.net>
Date: Wed, 17 Sep 2025 07:54:13 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Helper for reproducing
To: Jun Eeo <jeeo@janestreet.com>
Cc: autofs@vger.kernel.org
References: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
 <20250915132136.3128316-1-jeeo@janestreet.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250915132136.3128316-1-jeeo@janestreet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/9/25 21:21, Jun Eeo wrote:
> (Apologies for the spam!)
>
> One way to easily reproduce the issue is to run the autofs service
> as a systemd unit (i.e. with the --systemd-service flag set), compile
> this and add to LD_PRELOAD in the unit:

Thanks for your effort and the problem descriptions.

It would be best if the second patch also had a description.


I try hard to ensure every patch has a description and I also always

add development attribution (Signed-off-by) to patches. Patches can

hang around for ages of before being committed or be implicated

in problems in some way long after they are committed and having at

least something to help work out what was happening at the time is

useful.


Anyway, I'll have a look at these soon as I can get time.


Thanks,

Ian

>
> ----8<----
> #define _GNU_SOURCE
> #include <dlfcn.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> int
> sd_notify(int unset_environment, const char* state)
> {
> 	fprintf(stderr, "sd_notify(%d, %s)\n", unset_environment, state);
> 	int (*fn)(int, const char*) = dlsym(RTLD_NEXT, "sd_notify");
> 	int rv = (*fn)(0, state);
> 	fprintf(stderr, "doing the unsetenv loop\n");
> 	if (unset_environment)
> 		while (1)
> 			unsetenv("NOTIFY_SOCKET");
> 	return rv;
> }
> ---->8----
>
> That helper just makes the unsetenv in sd_notify a bit more apparent:
>
> ----8<----
> _public_ int sd_pid_notify_with_fds(
>                  pid_t pid,
>                  int unset_environment,
>                  const char *state,
>                  const int *fds,
>                  unsigned n_fds) {
>          // bunch of work
> finish:
>          if (unset_environment)
>                  unsetenv("NOTIFY_SOCKET");
>
>          return r;
> }
>
> // ...
>
> _public_ int sd_notify(int unset_environment, const char *state) {
>          return sd_pid_notify_with_fds(0, unset_environment, state, NULL, 0);
> }
> ---->8----
>
> At least in my version of glibc -- this produced the same coredump
> deadlocks we were seeing in production. If you trigger an automount,
> the systemd service should then look like:
>
>      $ systemctl status autofs
>      ● autofs.service - Automount daemon
>         Loaded: loaded (/usr/lib/systemd/system/autofs.service; enabled; vendor preset: disabled)
>         Active: active (running) since Mon 2025-09-15 13:07:30 BST; 31min ago
>       Main PID: 3115468 (automount)
>          Tasks: 15 (limit: 615964)
>         Memory: 4.5M
>         CGroup: /system.slice/autofs.service
>                 ├─3115468 /usr/sbin/automount --systemd-service --dont-check-daemon -n 1 -t 0 /tmp/my-config
>                 └─3115724 /usr/sbin/automount --systemd-service --dont-check-daemon -n 1 -t 0 /tmp/my-config
>
> (i.e. the child process remains stuck forever). The stack trace in the
> child process should then be something like:
>
> (gdb) bt
> #0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
> #1  0x00007f110f6505ce in __add_to_environ (name=0x55f89b8643c0 "autodir", value=0x55f89b8643e0 "/a",
>      combined=0x0, replace=1) at setenv.c:133
> #2  0x0000002600000025 in ?? ()
> #3  0x00007f10df7fb4f0 in ?? ()
> #4  0x00007f1110e10540 in ?? () at dl-open.c:200 from /lib64/ld-linux-x86-64.so.2
> #5  0x00007f10df7fb460 in ?? ()
> #6  0x0000000000000000 in ?? ()
