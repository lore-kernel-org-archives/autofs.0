Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D528BEC
	for <autofs@vger.kernel.org>; Thu, 13 Jun 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239831; cv=none; b=rRhkss0a3Rg4zgs6VQi8W6qsz3+c3WaZTUNyIgq2CT5MyDjLIRjNQmM/BU4opXBgXDMkeBQvg+tL/GPQ0WJEBoWlC3czzusj/tOfz6buGIQ8tKmu++aYPL30aQAdy/ikudtoyFFjpTdSlgdf6Slxn884n+dFvb3ubev0BBkMaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239831; c=relaxed/simple;
	bh=2goadx2RYQONj/Kon/cb+aB6Xek0OWfQLVbgzr8Knqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zr5nbXQI5eS+MfJ4FoQacIu/ne6uabYLEet9dzV7avO6KqCsqhYYjdPFE10N2KVlIVs5ucFd7sEVVSjNzgcDZvbLN5jtt5uMAR/+/I6y3DJMX25LHfX6zWj1vnMbSGVTIXYD+615Y+FwaVFjx5FpLwBLW+O8pV+V1/MuZe4FWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=HlkWzlDq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlPQR41c; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="HlkWzlDq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlPQR41c"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 44A7B18000E1;
	Wed, 12 Jun 2024 20:50:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 20:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718239827;
	 x=1718326227; bh=x5M2AluM/v6ethnoYPm1h7tNPOVG9djGYe7jm4R07uM=; b=
	HlkWzlDqlYK09s7vnJ9JcQXshTtkmxSAb12gmfbzemNe4Iay8X6lwfieVnFQ8rMb
	lJkK38yiHg62jQpqJTH2h5LaKJynEzBCooB2XLL3BNRncf9na51iraJ+HSZ1NXFS
	UuQxzt1MLt+TQ/9ug7rb8jfu6om/Vxq1mI3O3f1Up+waeQTpJnyUjBL+bSrynMJL
	W8xejx4rRvhK5iv5P9v5xc1K2+I4L54kjxZ0JhrrjmzxeNvqwg5nd2c/eyfoZw1X
	WwlBQi0P/nRyjdCXsJRtDo3lnWu9bGRDhKSVA24zhr526ht0mzuRMWGMn4a29l1W
	VDu8gJXMn80t9CRpldlAfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718239827; x=
	1718326227; bh=x5M2AluM/v6ethnoYPm1h7tNPOVG9djGYe7jm4R07uM=; b=G
	lPQR41ccINUrnLXFW5qoUpx0PRuZxvYlYZ2J/HvkI7c8GlZ6RqEqx5LD3ignaltO
	LSXjfL/durcbn+ds+vAX0Fh7yyTBRlvzHRavhV8sqCLu9+JZSG9Cl3Z0eGjux7Q3
	+bOk25EQsdX39C1QHuy+MM7B1QSg6UEuNBzliqzM6R1BYlT8SY/GSZprdQazbho7
	/AREHLOGbt/WbqoNu9Uf3PJylA2AiFqaeTWuBjZIPRCILHtyjhU5kM7uZ7AQ6KTm
	sPJeGoqKAfmvtyAGri5ebxC8vnb+PLnHL4u1GS7X28wCGCUxZjFvetRzoZxnjoQl
	btt09QcTblGzURbOdMCPA==
X-ME-Sender: <xms:U0JqZnU3DATQp-m-Lwel2rlXm53raVgqObrbkr2nvhGaepmTluVEUw>
    <xme:U0JqZvnW2JCoJfTio16NlYVklutKxH_iDhPvexQvfTQ47SWpl1sY1wpZz7SDX8mx_
    o15MnK5K7mb>
X-ME-Received: <xmr:U0JqZjaWY5BqT5jESRW3Nj1maKUecML4BBMmokH77ZWDDgadfXtzcpPTk27ud51Tmva2H00iABpBuiK1IzfnBa-Hw_YdZcs_t4HBUQj4fzCo0E8O78vCK3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ejueeuteffueegjeehkeetiedufeehvdehteejtdejteelleehkefgfeefuedtgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:U0JqZiXlBoZm4dB6FnT8QJR-ShqXHLqT8K7aK04MDuJAfB8b-xWUgA>
    <xmx:U0JqZhmTLtN2ipYN8097QJ1ck58-HYBq-ykKgduo4R6icvbStDeeqA>
    <xmx:U0JqZvez74yVag-xT8_vjo0y3FpA0y5Npo0Ym0bCT5yth4SNCwqNUQ>
    <xmx:U0JqZrEbEerVu2m5YJrbBOFkiunZHy7BWgHRoFP0_zwGx5OV0pmoLg>
    <xmx:U0JqZhuQ5cM3SO1e1ODE9mS6ThuuRoDgIBiNfKQfsLJn7npNhgXm_Mn9>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 20:50:25 -0400 (EDT)
Message-ID: <84014d46-ab5c-43ea-875d-659d698fbbdc@themaw.net>
Date: Thu, 13 Jun 2024 08:50:21 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: autofs mounts expiring unexpectedly and unable to remount after
 disappearing
To: Nathaniel Middleton <nathanielm@alleninstitute.org>,
 "autofs@vger.kernel.org" <autofs@vger.kernel.org>
References: <PH7PR12MB5686C29F1D980041ADA33BD3ACC72@PH7PR12MB5686.namprd12.prod.outlook.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 cmF2ZW5AdGhlbWF3Lm5ldD7CwXsEEwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 BQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPiLJ0EE9eJkyV1rqtzct5Ah9pu6
 LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UVCxERgQBOJcPrbgaeYZua
 E4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjClW3ifdD75gHlrU0V
 ZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4W0VgpWczmA
 tHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+YK/0L
 Q2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPw
 DSMZ2NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVn
 cOqyghSE69H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8
 J/tYvFMpag3nTeC3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0zsFN
 BE6c/ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC
 4H5JF7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c
 8qcDWUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5X
 X3qwmCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+v
 QDxgYtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5me
 CYFzgIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJ
 KvqAuiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioy
 z06XNhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0Q
 BC9u1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+
 XZOK7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8n
 AhsMAAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQd
 LaH6zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxh
 imBSqa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rK
 XDvL/NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mr
 L02W+gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtE
 FXmrhiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGha
 nVvqlYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ
 +coCSBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U
 8k5V5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWg
 Dx24eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <PH7PR12MB5686C29F1D980041ADA33BD3ACC72@PH7PR12MB5686.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 02:40, Nathaniel Middleton wrote:
> Summary:
> We define a /mount/path/pathcontd/mountpoint tree in autofs, have historically --ghosted the paths, but have recently attempted to set the offset mounts as browse-able.
> Our configuration works great... at first. Once the timeout hits (I set this to 10s for debugging... but normally have it set to 300s), the autofs (type) mount points start expiring. Once this expiration starts, the offset mounts disappear (often leaving one mount point remaining that is broken). The disappeared mount points are unable to be re-mounted. This has hit us at semi-regular intervals on Centos 7 , but Rocky 8 servers are highly repro-able. This could be due to the lack of activity on the new systems though.

Right, the description sounds like there's been a partial expire of the 
multi-mount (or possibly only

a directory has not been removed).


There are a couple of things to be aware of, first these multi-mounts 
will create the sub-directory tree

below them and remove it when thet expire, that's normal behviour. Only 
the root of the map entry is affected

by the browse setting.


>
> Config:
> distro Name: Rocky Linux 8.8 (Green Obsidian)
> autofs-5.1.4-102.el8_8.2
> NFS4.{0..2}(though... the nfs mounts are not being invoked when this issue happens.)
> Autofs configs:
> Auto.master:
> /allen/programs/celltypes  /etc/auto.programs_celltypes tcp hard intr timeo=600 retrans=2 async --ghost
>
> auto.programs_celltypes(snipping out similar lines to conserve space):
> production -fstype=nfs4 /incoming         aidc-isi1-prd:/ifs/incoming/aibs/celltypes \
>                          /0378             aidc-isi1-prd:/ifs/programs/celltypes/production/0378  \
>                          /brainstim        aidc-isi1-prd:/ifs/programs/celltypes/production/brainstim  \
>                          /conn             aidc-isi1-prd:/ifs/programs/celltypes/production/conn
> workgroups  /0285             aidc-isi1-prd:/ifs/programs/celltypes/workgroups/0285 \
>                         /0378             aidc-isi1-prd:/ifs/programs/celltypes/workgroups/0378
>
>
> We have a couple similar mounts in a similar mount point to "/allen/programs/<different name>/<mount>" if it makes a difference there.
>
> What this looks like:
>
> Temporarily working:
> ls /allen/programs/celltypes/production
> incoming  0378  brainstim conn

Sure that;s what the directory should look like upon access.


>
> Broken:
> ls /allen/programs/celltypes/production
> 0378

And this is what it will look like on a partial expire.

That directory remaining will stop the automount being mounted again and 
make it pretty much

useless from this point on.


What we need to do is work out what's causing the partial expire and fix it.

That can be quite difficult.


There usually is some evidence of an error occurring in full debug logs 
and I need that.

I can try to duplicate it with your example mount but I suspect it won't 
happen when I try it.


I'll have a look at the RHEL revision 102 and see if I can spot anything 
too.


>
> Statting of this path results in a wedged terminal, the autofs mount still is showing however:
> /etc/auto.programs_celltypes on /allen/programs/celltypes/workgroups/0378 type autofs (rw,relatime,fd=105,pgrp=4816,timeout=0,minproto=5,maxproto=5,offset,pipe_ino=83070
> I claim that the autofs mounts should not be expiring at all... and that I want mounted NFS sessions to umount after timeout. Stopping autofs results in a loop of trying to umount the remaining autofs shares until it hits a timeout and gets killed.
> The remaining autofs mounts return busy when umount -a -t autofs (or the session locks up). lsof and fuser show 0 processes using the mount point.
> 4 D root        7929    7805  0  80   0 -  6329 autofs 09:37 pts/2    00:00:00 umount -a -t autofs

I think you'll find that you need to be a bit more careful on umounting 
a sub-tree of mounts because of the order umount uses,

If the maps haven't been changed you should be able to umount the tree 
in the correct order with "automount --force" provided

automount has been terminated already.


>
> If left alone, the state seems to get continually worse as more autofs mounts expire. Example being on the /allen/programs/celltypes/production path (not a NFS mount point)
> ls ing:
> /allen/programs/celltypes/production:
> ^C

Once a partial expire happens it's more or less fatal, all we can do is 
try and identify the case

causing it and fix it, if we can.

>
> Logs:
> Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/production
> Jun  5 10:11:49 n238 automount[19033]: expiring path /allen/programs/celltypes/production
> Jun  5 10:11:49 n238 automount[19033]: umount_multi: path /allen/programs/celltypes/production incl 1
> Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/production
> Jun  5 10:11:49 n238 automount[19033]: expiring path /allen/programs/celltypes/production
> Jun  5 10:11:49 n238 automount[19033]: umount_multi: path /allen/programs/celltypes/production incl 1
> Jun  5 10:11:49 n238 automount[19033]: expired /allen/programs/celltypes/production
> Jun  5 10:21:57 n238 automount[25053]: expire_proc_indirect: expire /allen/programs/celltypes/production
> Jun  5 10:24:27 n238 automount[25053]: expire_proc_indirect: expire /allen/programs/celltypes/production
> Jun  5 10:26:57 n238 automount[25053]: expiring path /allen/programs/celltypes/production
> Jun  5 10:26:57 n238 automount[25053]: umount_multi: path /allen/programs/celltypes/production incl 1
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/0378
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/0378
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/brainstim
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/brainstim
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/conn
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/conn
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/ctyconn
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/ctyconn
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/general
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/general
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/histformfish
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/histformfish
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/humancelltypes
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/humancelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/incoming
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/incoming
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/mfish
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/mfish
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/mfishhisthumanatlas
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/mfishhisthumanatlas
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/mousecelltypes
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/mousecelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/mousegenetictools
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/mousegenetictools
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/nhpcelltypes
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/nhpcelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/synapticphys
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/synapticphys
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/whbi
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/whbi
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_umount_offset: umount offset /allen/programs/celltypes/production/wijem
> Jun  5 10:26:57 n238 automount[25053]: umounted offset mount /allen/programs/celltypes/production/wijem
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/brainstim
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/0378
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/humancelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/histformfish
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/incoming
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/mfishhisthumanatlas
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/mousegenetictools
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/mousecelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/synapticphys
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/nhpcelltypes
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/wijem
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/whbi
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/mfish
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/general
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/ctyconn
> Jun  5 10:26:57 n238 automount[25053]: tree_mapent_delete_offset_tree: deleting offset key /allen/programs/celltypes/production/conn
> Jun  5 10:26:57 n238 automount[25053]: expired /allen/programs/celltypes/production
> Jun  5 10:26:58 n238 automount[25053]: expire_proc_indirect: expire /allen/programs/celltypes/production

Don't see any evidence of a problem having occurred here.

Normally I ask for a full debug log (logging = debug in 
/etc/autofs.conf) from startup of automount until

the problem occurs. You can send it to me privately if you don't want to 
post it.


Ian
