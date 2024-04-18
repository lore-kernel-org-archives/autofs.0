Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F07524AF
	for <autofs@vger.kernel.org>; Thu, 18 Apr 2024 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713412022; cv=none; b=JF3h0FdMawC3zpE71zjnK6crOIC2qNLAVxZhKrY1GxyB2AtD6G4mpfq9cjGsePcDfw2KekHct2mm5Mstn1HS7DXAOkYFxfvPWS5+7b2vy2gnmEptYuYBM/UFY8EXrSB3evck+qLRPBPG8wWw2M/2lAegqtdmVxGFUVtBSiVqjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713412022; c=relaxed/simple;
	bh=COPHTjsFFtI0TwgArso204Gpmq/hnali3DJtLigpg5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gXXnfLtsqIbGsZE0DR9G0aUCQgMf+vNxrpS0SLbpo+fW6QY7hkUojtj5L45ByyINHt4odibH7t1lOxAOmen/Zn3X2Vr9PR4GEBkJECkRaPPCB70UAAncBLvr12do8bfNKapXDi2xu4GXgSLsAuFG6b+gl/o0J4yjg6koDXjbUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=AJRoiX1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghVle9ZC; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="AJRoiX1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghVle9ZC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2F26718000B9;
	Wed, 17 Apr 2024 23:46:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Apr 2024 23:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713412018;
	 x=1713498418; bh=ah8ErdMe/sHDDiCkehx/WRiVHKoDNRAO2/68SIqSWZk=; b=
	AJRoiX1xrYpOLkXjMCaPQVCh8hOTga52QHxl9aGOEGCKRVuYhnZdMKNUdnYl/ce3
	Q6KAeDJ76U/wSn/y2r41CbO3Jpq6dM+H99CY2uq0wLEVPyIzlFGXp3LPH0GY3Y8j
	79pgrX58HCdKLrX7BpRcUrLiUOnGjFxTIXdJSGx+ncfxoia2gjDbv0xYgZiTCTRA
	3+9UBIh4dWKskcNQWGBf1lwb7tZY4bU33StRFFUR+CC0kBzoB11qqzmRoqoLZO83
	fPFUpIYUqJ2Z887ERSQhFXDszcGHuB68NMwmYcqwKc38pMNLYTtnwpw5OqiSsGrE
	1I3splQ/yFcidZMMucpJiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713412018; x=
	1713498418; bh=ah8ErdMe/sHDDiCkehx/WRiVHKoDNRAO2/68SIqSWZk=; b=g
	hVle9ZCeRw+tZzCtJD7FFSxD5Yo2kxA5HMEHH8qOZHLsv91K/gWlGjKjjBLeIg9K
	TOxn8gGuhdrxvHZBqVGcwpSeuTjlxnWNTsUQ+LvXDZhFOYQodfyzAjEznFNQdZN4
	zg8SYMpttJJurdILmkdCcPX9KD4NIiKg/PtfaPFHNJjOlW0t6L9xcqwbwb+3gPYs
	MFobsUaPpqxO31Z91R+d6oEnbLaAxR+tPt5U/qgrP+lxDrdRRtSXI1D2UVphfKB+
	ShwjYa9aLXhhu/xJkW0kZ2kFRsNvqQJaBVR8FGDIOnPsguPHETHFHjSDO+IyMfLY
	FPBddF9awUN+ifgEkhQyw==
X-ME-Sender: <xms:spcgZpX-5q2H12UEeH55OJPf4j5CG19EHpTTrGtVBga8Kd1Ms3yNPw>
    <xme:spcgZplfZsMaHtDzkmMbKerJtR3gRc3Ntr8cwX9OGQahHsphFnlgzQqF-svUeTRjq
    4jcCtnPsoOJ>
X-ME-Received: <xmr:spcgZlaC5vK0eZzEZEdLQsJjKOjKfi50TvTr4padhdsawKTrYvlMINvCP9m9J06jM9tyNeQ1xyuSP2RtWWCyAGVtJVEPLL8T6p5l9-XKfgKufR0RdcCujP36>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiudeiledvtdfgheeglefgfeetleejfffhgfdvheevtdeigefffeekjeffvdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:spcgZsUuaoWpEDofYOtCpVzhMEbB5X18dyb1_jEB3bUUehm4R6SwBA>
    <xmx:spcgZjmsGmT2PL0C_967AU3cdQX1tSFU3pSkrOgUz3oCK6yWUiVnag>
    <xmx:spcgZpcmiUkC2YuLnAA-scpBR6QrBn_FYGT4qhcQnQYLVWATAgqjyQ>
    <xmx:spcgZtGp4n-6FLWrgdNv3RtD045x6HzwRAF2wFecY8yhlXyizoCNyw>
    <xmx:spcgZrttjF6n4fZD7glOSnRZuInw1pReJUZWBaEVFwqzA6Upp1YdimXM>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 23:46:57 -0400 (EDT)
Message-ID: <f06e1ea3-22e1-4748-ac61-9235643daa55@themaw.net>
Date: Thu, 18 Apr 2024 11:46:52 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: autofs 5.1.9 snprintf() crash with -D_FORTIFY_SOURCE=3
To: Andreas Hasenack <andreas@canonical.com>,
 autofs mailing list <autofs@vger.kernel.org>
References: <CANYNYEEpJabu=qiQ2VUde6J4HUC9mQSgCGksbLQqGsr1-w5NYg@mail.gmail.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <CANYNYEEpJabu=qiQ2VUde6J4HUC9mQSgCGksbLQqGsr1-w5NYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/4/24 01:28, Andreas Hasenack wrote:
> Hi,
>
> in Ubuntu we are building most packages with -D_FORTIFY_SOURCE=3
> nowadays, and we just got a bug report that 5.1.9 was crashing with a
> buffer overflow warning. When rebuilt with -D_FORTIFY_SOURCE=2, it
> does not crash.
>
> Here is a small reproducer using a loop device. This is on kernel 6.8.0:
>
> /etc/auto.master:
> /- file,sun:/etc/auto.mp strictexpire
>
> "strictexpire" is what triggers the crash.
>
> /etc/auto.mp:
> /mp defaults :/dev/loop0
>
> # automount -f -d3
> Starting automounter version 5.1.9, master map /etc/auto.master
> using kernel protocol version 5.05
> lookup_nss_read_master: reading master file /etc/auto.master
> do_init: parse(sun): init gathered global options: (null)
> lookup_read_master: lookup(file): read entry /-
> master_do_mount: mounting /-
> reading file map /etc/auto.mp
> do_init: parse(sun): init gathered global options: (null)
> *** buffer overflow detected ***: terminated
> Aborted (core dumped)
>
> gdb show this being in the snprintf call in lib/mounts.c when
> ",strictexpire" is being added to the autofs mount options string:
> #9  0x00007ffff7dbaab4 in snprintf (__fmt=0x7ffff7dca232 "%s", __n=93,
> __s=0x7fffec002c1c "") at
> /usr/include/x86_64-linux-gnu/bits/stdio2.h:54
> No locals.
> #10 make_options_string (path=0x5555555b7d50 "/-", pipefd=6,
> type=type@entry=0x7ffff7dca02b "direct", flags=2560) at
> /usr/src/autofs-5.1.9-1ubuntu3/lib/mounts.c:764
>          kver_major = <optimized out>
>          kver_minor = 5
>          options = 0x7fffec002bf0
> "fd=6,pgrp=22935,minproto=5,maxproto=5,direct"
>          max_len = 93
>          len = 44
>          new = <optimized out>
>          __FUNCTION__ = "make_options_string"
>
> lib/mounts.c:760
>      /* maybe add ",strictexpire" */
>      if (flags & MOUNT_FLAG_STRICTEXPIRE) {
>          new = snprintf(options + len,
>                     max_len, "%s", ",strictexpire");
>
> I don't think this is actually overflowing options in this particular
> case, but the max_len argument doesn't seem right, as that was the
> original max size for options.

Ha, I had report of this just the other day and I missed that obvious 
stupid mistake so thanks

for reporting it.


I chose to change the snprintf() to strcat() because it clearly wasn't 
going to overflow as

the calculated maximum size was sure to be larger than the contents.


fyi, what I used was this but I'll update the description to include the 
max_len usage mistake

you have pointed out (and push the change to the repo. in case you 
prefer to use it in Ubuntu):


autofs-5.1.9 - fix crash in make_options_string()

From: Ian Kent <raven@themaw.net>

glibc claims there's a memory overflow when make_options_string() tries
to use the pointer <malloc()ed options string> + <current offset> with
snprintf().

The maximum options string length is calculated earlier in the function
and analysis shows there's no overflow possible.

To fix this use strcat(3) instead of snprintf(), in this case it's
probably less overhead anyway. While we are at it drop the useless error
checks because we know it won't overflow.

Signed-off-by: Ian Kent <raven@themaw.net>
---
  lib/mounts.c |   35 +++++++++--------------------------
  1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/lib/mounts.c b/lib/mounts.c
index 05f18dbcf..7680c59c1 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -695,10 +695,11 @@ static int cacl_max_options_len(unsigned int flags)
         unsigned int kver_minor = get_kver_minor();
         int max_len;

-       /* %d and %u are maximum lenght of 10 and mount type is maximum
-        * length of 9 (e. ",indirect").
+       /* %d and %u are maximum length of 10 and mount type is maximum
+        * length of 9 (ie. ",indirect").
          * The base temaplate is "fd=%d,pgrp=%u,minproto=5,maxproto=%d"
-        * plus the length of mount type plus 1 for the NULL.
+        * plus the length of mount type plus 1 for the NULL (and an
+        * additional 10 characters for good measure!).
          */
         max_len = 79 + 1;

@@ -728,7 +729,7 @@ char *make_options_string(char *path, int pipefd,
         unsigned int kver_major = get_kver_major();
         unsigned int kver_minor = get_kver_minor();
         char *options;
-       int max_len, len, new;
+       int max_len, len;

         max_len = cacl_max_options_len(flags);

@@ -751,21 +752,13 @@ char *make_options_string(char *path, int pipefd,
         if (len < 0)
                 goto error_out;

-       if (len >= max_len)
-               goto truncated;
-
         if (kver_major < 5 || (kver_major == 5 && kver_minor < 4))
                 goto out;

         /* maybe add ",strictexpire" */
         if (flags & MOUNT_FLAG_STRICTEXPIRE) {
-               new = snprintf(options + len,
-                              max_len, "%s", ",strictexpire");
-               if (new < 0)
-                      goto error_out;
-               len += new;
-               if (len >= max_len)
-                       goto truncated;
+               strcat(options, ",strictexpire");
+               len += 13;
         }

         if (kver_major == 5 && kver_minor < 5)
@@ -773,23 +766,13 @@ char *make_options_string(char *path, int pipefd,

         /* maybe add ",ignore" */
         if (flags & MOUNT_FLAG_IGNORE) {
-               new = snprintf(options + len,
-                              max_len, "%s", ",ignore");
-               if (new < 0)
-                      goto error_out;
-               len += new;
-               if (len >= max_len)
-                       goto truncated;
+               strcat(options, ",ignore");
+               len += 7;
         }
  out:
         options[len] = '\0';
         return options;

-truncated:
-       logerr("buffer to small for options - truncated");
-       len = max_len -1;
-       goto out;
-
  error_out:
         logerr("error constructing mount options string for %s", path);
         free(options);


