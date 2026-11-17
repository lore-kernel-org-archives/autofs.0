Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.167.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794894165;
	b=BChQN9ozEE4lmqpRYq3RwRGIDlG7adlfi0/ZAlo2QObT97db99NTrb29s5zlQdkH8e4T
	 Eb17Z7+kl8QLcoW3+n1IDmI/HbS5Tv5iav9yHPmHKAhPaTOgGliI9PD4gXeVPNi4X58Ky
	 uLnPj74rgBQzAGQgMU72Zw4+CbYw8f46wFUcrdOAdh7aCQhbEcudf64cA9/71IK7GDQgn
	 akPZuB16b/q3RMD2qQ6J0ZsboQXnI3poFpitqMqJ2gK6P+IHGXist51RKYsHj34GMe7Ps
	 likXlWf/0IfKjS54ggfQKrVj1vQoaXBieqQAfBYePEzN3exQqZx98u4qv+peAPPGS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894165;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Content-Language:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=/8QGmljror58X+gk4JO5nY2sGQKga22YaPM1nbyocXk=;
	b=oNMiEXYMbXUCClL9HkksO1ZTowQb1EUt4EhpKCqjyq4hIlwHzq/uKBhLiFtKNkaAUhI5
	 kOPYf4rvkuYXFcwQ3ZiHHKn+qTfGKldzoupZfaWwlFHWgPpatsCT7cqEHEASmTBgjw4iQ
	 1D52vdCEvcGTZoCYg0UtIsg8C1haj3gmwk1mRW0Hgl6nxZLwp73MgVQ7WpJwCX5gJKwPT
	 W9gvsNmcIr4Ap6Hn0pGxhXx/zYA4bfXZPq/XlmBKJdEeAnGdJrNt7xfUgfOMRZKFDHm+L
	 ooN49foQicMWB+chnXXRfyE8/avDzVqNB2vXuHJvTogDT6Hnp9m9VeiNWij5I3nYOuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=moonlit-rail.com;
	spf=pass smtp.mailfrom=moonlit-rail.com;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=rsa-sha256 header.s=rsa2021a header.b=hQ8xdwqB;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=ed25519-sha256 header.s=edd2021a header.b=MukJmREg;
	arc=none smtp.remote-ip=45.79.167.250
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDA606A31C
	for <autofs@vger.kernel.org>; Tue, 17 Nov 2026 05:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=rsa-sha256 header.s=rsa2021a header.b=hQ8xdwqB;
	dkim=pass header.d=moonlit-rail.com header.i=@moonlit-rail.com header.a=ed25519-sha256 header.s=edd2021a header.b=MukJmREg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/8QGmljror58X+gk4JO5nY2sGQKga22YaPM1nbyocXk=; t=1794894157; x=1797486157; 
	b=hQ8xdwqB7ZYIKFVvNHLbyJGByRde5v0bFADR1rwnuMvzMgxtIEcM64YP0Eo2o+3UivD2LFmUk7e
	aOTXbHBHX7VsCy9y79WFBVXqnck5pAeKYebf5PxuqdWPPv/3wNowbX3WZJVAyXVPsVERRAKURmj2q
	ZzYT7846KBlvoh+mtfGmPJYggODr5jlCaXyrfUh8UzQhXVVNCQbUnSY+j7bO1s2289vw6CtiuCHnV
	cmgltO++7Fileqf1IIJREmyCZEsXQwodSmaGC+NQ3534tz5TRAV0qFS+1XXb1Sku4W1bk6qTGbqdd
	P+TME1FeK1JSZK5+EBntVsQsmmULTN8ApG0g==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/8QGmljror58X+gk4JO5nY2sGQKga22YaPM1nbyocXk=; t=1794894157; x=1797486157; 
	b=MukJmREgjknskT1qbJ8ECwcS2Hc9oY+fdlXjfG9+zDnuUewmY8+3/LIxxzPJ2sNQEJKgFU1Z+oE
	32RTgUHIpBA==;
Message-ID: <4c791661-cdaf-45fc-8c1d-1a2d8a9b48ae@moonlit-rail.com>
Date: Tue, 17 Nov 2026 00:42:36 -0500
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
To: autofs@vger.kernel.org
Subject: Regression in 5.2.0, SIGSEGV in master.c line 619
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

After upgrading autofs-5.1.9 to autofs-5.2.0, automount successfully 
shows --ghost subdirectories under a configured indirect map.  But any 
attempt to view files under one of the mount points crashes automount 
and causes the file access to hang.

Interestingly, the mountpoint actually does get mounted, so killing the 
wedged file access and re-running will show the mounted contents.  But 
the automount daemon is dead at this point.

~# gdb /usr/sbin/automount
(gdb) set args -f -v
(gdb) run
    [boilerplate here trimmed]
    [doing  <ls /amnt/slack>  in another terminal window]
(gdb)
Thread 9 "automount" received signal SIGSEGV, Segmentation fault.
[Switching to thread 9 (Thread 0x7fffe7fff6c0 (LWP 16086))]
0x00007ffff7b90c47 in __strcmp_avx2 () from /lib64/libc.so.6
(gdb) up
#1  0x00005555555710f4 in send_map_update_request (ap=0x5555555bf920) at 
master.c:619
619             if (!strcmp(ap->entry->maps->type, "hosts"))
(gdb) print ap->entry->maps
$1 = (struct map_source *) 0x5555555bfa20
(gdb) print ap->entry->maps->type
$2 = 0x0
(gdb)

No changes to config files, using the unaltered ones in
autofs-5.2.0/samples/* that ship with the package.

It's a Slackware64-current distro here.
The only customizations are these:

---- Start /etc/auto.master.d/amnt.autofs

/amnt  /etc/auto.master.d/amnt.map  --timeout=60 --ghost

---- End /etc/auto.master.d/amnt.autofs

---- Start /etc/auto.master.d/amnt.map ----

slack  -fstype=nfs,nfsvers=4.2,ro  fileserver:/srv/slackware

---- End /etc/auto.master.d/amnt.map ----


Kindly CC me on any replies you wish me to see, as I'm not subbed to the 
mailing list.

Kris
