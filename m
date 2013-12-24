From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: autofs-5.0.8 - get_exports: lookup(hosts): exports lookup failed
 for $(hostname)
Date: Tue, 24 Dec 2013 12:54:49 +0800
Message-ID: <CAF1ZMEdM8gWae1US0OeSnYYb33AZX5XW8jte18hvJmF1puRFhA@mail.gmail.com>
References: <CAF1ZMEcaxaTw5qVzdPgaeM90B0TTeG_nJgxXbOqGt7fLqK5i+g@mail.gmail.com>
	<1387860260.7351.2.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zLltwhXjRxCgwSOdiE6hBBLCnrmdlAden46D9ZH58j0=;
        b=x92JZsDu+yope11Ot7/lCgGWJKMV8ge+6eGq9tWJEGRmb3G09uqS+Nmf+7KsDERjhL
         M+5lwsOCHt1USyagG2K00mJOQOFDlfghW5y3/FgJPH7RmWSMszhg053iI4FJT6YWaZq1
         3UM1qXpaSc9qSjGnOECCQEakFVQ73dNqJExgIpRz98poJ1gXMIJTQDkftkwrxo7goZer
         pKozsh2r3A90jFoulF/J7ZCETvGV24JF6Hddw6n6040h5/R61YbvPgN+RCnO0YrFjjMm
         6Qxa6PBAdrl0LjNjdnKpwB+LtsuUXUus8tYgwx79Ge0MbCMavyGjojSE9mw7y+Dje/+S
         W5Ow==
In-Reply-To: <1387860260.7351.2.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Dec 24, 2013 at 12:44 PM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2013-12-23 at 14:41 +0800, Dennis Lan (dlan) wrote:
>> Hi Ian:
>>   A user hit a bug[1] in autofs-5.0.8, while not in autofs-5.0.7,
>> even it works with commit [2]
>>   My best guess it could be introduced by commit[3] (but not sure),
>> also I've seen you queued a few patches after 5.0.8, is there any
>> relevant?
>>   most obvious log can be found here [4], or check [1] for more information.
>>   Thanks
>
> AFAICT the ongoing problem is, talking to newer NFS servers works with
> the latest patches but breaks for older servers, and the reverse without
> the patch.
sorry, I didn't follow here..
what do you mean of newer/older servers, do you mean the nfs server
using nfsv2,nfsv3(old protocol), nfsv4( new protocol)?
latest patches, do you mean those queued in git repository?

so, you know the problem? do you have any fix?

thanks

>
>>
>> Lan
>>
>>
>> [1] https://bugs.gentoo.org/show_bug.cgi?id=488886
>>
>> [2] commit 3247f7cb7e779d2340bd673324045f7617e74ce4
>> Author: Ian Kent <raven@themaw.net>
>> Date:   Mon May 27 17:47:20 2013 +0800
>>
>>     autofs-5.0.7 - fix spelling error in last commit
>>
>> [3] commit 7acfa6cba07a3ad8cb7976046852ce2830bd2f7e
>> Author: Ian Kent <ikent@redhat.com>
>> Date:   Mon Sep 23 12:18:52 2013 +0800
>>
>>     autofs-5.0.7 - fix portmap lookup
>>
>>     The autofs RPC library has fallen behind some.
>>
>>     When using IPv6 (rpbbind) version 3 or 4 is available whereas with IPv4
>>     (portmap) verions 2 and 3 are available.
>>
>>
>> [4] error message
>>
>> Dec 21 09:10:43 impala automount[31374]: get_exports: lookup(hosts):
>> exports lookup failed for caiman
>> Dec 21 09:10:43 impala automount[31374]: key "caiman" not found in map
>> source(s).
>> Dec 21 09:13:06 impala automount[31374]: get_exports: lookup(hosts):
>> exports lookup failed for caiman
>> Dec 21 09:13:06 impala automount[31374]: key "caiman" not found in map
>> source(s).
>> Dec 21 09:13:35 impala automount[31374]: create_client: hostname lookup failed:
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
