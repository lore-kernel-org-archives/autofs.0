From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: autofs-5.0.8 - get_exports: lookup(hosts): exports lookup failed
 for $(hostname)
Date: Tue, 24 Dec 2013 17:14:46 +0800
Message-ID: <CAF1ZMEcfde4OSCnsepx6Qop_A2BtP0NnDkvfkum-7FCyeXZ=gg@mail.gmail.com>
References: <CAF1ZMEcaxaTw5qVzdPgaeM90B0TTeG_nJgxXbOqGt7fLqK5i+g@mail.gmail.com>
	<1387860260.7351.2.camel@perseus.fritz.box>
	<CAF1ZMEdM8gWae1US0OeSnYYb33AZX5XW8jte18hvJmF1puRFhA@mail.gmail.com>
	<1387875097.7351.10.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tAkO8ifgNJf/gMlbx2fWVbstfWk4w7b5YRpuzKYdS7c=;
        b=Ha1n7NKmijdhuY9GwmZMVz8n/xEDCi2jPc3ygRUwVMdVRHQcbX8i/QlBA/Lh72GXLU
         j5o+W/vplKT1vXTq4dtAHp781bf9II6iNdGlvv5A+L50SXtY/6QdQbaTWYh87hC2he01
         Kyld0cmJo7gZPt7EEgx814MVm9Jq65wdHYc0THAF1ZQB8Ta+SPdzPZtXGaPpGzKsEt+Z
         RpgPIFg7CK2LSCGXgl7ljGihZvOFh3+BUxeo0+ze+m57e8ygEfGJdI4M98Tl3qJGIs1d
         VpsOXpzN5EhHtZQ2kPkinAiPcXBh82OsrfIttAbfargVp+PA8jZfS2vr/vAclKgNQqER
         GfnA==
In-Reply-To: <1387875097.7351.10.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Dec 24, 2013 at 4:51 PM, Ian Kent <raven@themaw.net> wrote:
> What I'm talking about is portmap vs rpcbind as it relates portmap
> protocol versions together with using libtirpc. To make autofs work with
> later protocol versions using libtirpc I had to make a fairly large
> change. That's already available on kernel.org. I posted the patches not
> yet committed (that are in my notional "queue") to the list so you'll
> know what they are.
>
But the problem which user reported did *not* enable libtirpc..

>>
>> so, you know the problem? do you have any fix?
>
> I think I have one in the patch series I sent.
> Assuming you have the current patches available on kernel.org then the
> patch for the protocol not being set likely fixes the current problem.
>
>>
>> thanks
>>
>> >
>> >>
>> >> Lan
>> >>
>> >>
>> >> [1] https://bugs.gentoo.org/show_bug.cgi?id=488886
>> >>
>> >> [2] commit 3247f7cb7e779d2340bd673324045f7617e74ce4
>> >> Author: Ian Kent <raven@themaw.net>
>> >> Date:   Mon May 27 17:47:20 2013 +0800
>> >>
>> >>     autofs-5.0.7 - fix spelling error in last commit
>> >>
>> >> [3] commit 7acfa6cba07a3ad8cb7976046852ce2830bd2f7e
>> >> Author: Ian Kent <ikent@redhat.com>
>> >> Date:   Mon Sep 23 12:18:52 2013 +0800
>> >>
>> >>     autofs-5.0.7 - fix portmap lookup
>> >>
>> >>     The autofs RPC library has fallen behind some.
>> >>
>> >>     When using IPv6 (rpbbind) version 3 or 4 is available whereas with IPv4
>> >>     (portmap) verions 2 and 3 are available.
>> >>
>> >>
>> >> [4] error message
>> >>
>> >> Dec 21 09:10:43 impala automount[31374]: get_exports: lookup(hosts):
>> >> exports lookup failed for caiman
>> >> Dec 21 09:10:43 impala automount[31374]: key "caiman" not found in map
>> >> source(s).
>> >> Dec 21 09:13:06 impala automount[31374]: get_exports: lookup(hosts):
>> >> exports lookup failed for caiman
>> >> Dec 21 09:13:06 impala automount[31374]: key "caiman" not found in map
>> >> source(s).
>> >> Dec 21 09:13:35 impala automount[31374]: create_client: hostname lookup failed:
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe autofs" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>
>
