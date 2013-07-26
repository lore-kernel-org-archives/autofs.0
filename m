From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Linking against libldap_r instead of libldap?
Date: Fri, 26 Jul 2013 14:39:42 -0300
Message-ID: <CAEySpB6VmV=spVO3f0d-wR+ifyiKDMwxtrwrETdceE9QtJZYnA@mail.gmail.com>
References: <CAEySpB4wm76DEJE-752Qd=_vtEMMi_vzr=eGu7RfUaJmbVT2GQ@mail.gmail.com>
	<1372401060.21110.6.camel@perseus.fritz.box>
	<1372404410.21110.12.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NZiuYOzRhR9TqKAhLLfRKMgo82Wp7XMDxSQRuCtC8vk=;
        b=PBtGzj+hJ0BX0hJSXLAWAlrHBrCRBGreLqCATeZQ+ziC0rSkHm1vbKS0JHWzKt0MYL
         0Bx5vnTG7Q+7ccyXWNrX8gknYY+PBMi2CXxfRAiwj/9rYSYYLg0uhX+VmPEjrlZJTDPe
         Q1N7wjRPs52yv9kOx5UzM2yv7R6e2zSBuqvccsJzj8sLzOdR1MCfXowalaTFNKY+/vMy
         NxDBnzK7I1imUTHKJrXmL6A0dxDyezi+cWKnF3oAQFiOyS/h22VBwMkPmwbmoeCR7/9U
         uV0RTBQHQsOEcYWkDpErDx4BnHrUD+7z5LG+yZcfXh3DVSBryD28vdXLN/Dfp1h7zqDG
         hwaA==
In-Reply-To: <1372404410.21110.12.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

On Fri, Jun 28, 2013 at 4:26 AM, Ian Kent <raven@themaw.net> wrote:
> On Fri, 2013-06-28 at 14:31 +0800, Ian Kent wrote:
>> On Thu, 2013-06-27 at 22:42 -0300, Leonardo Chiquitto wrote:
>> > Hi,
>> >
>> > I'm investigating one segmentation fault report (multiple occurrences)
>> > in automount where the OpenSSL context (using LDAP with TLS) is
>> > clearly corrupted. Reading OpenSSL documentation I found that the
>> > the library needs to be correctly initialized in order to run in a multi-
>> > threaded environment. I also found that *only* the reentrant build of
>> > the OpenLDAP libraries (libldap_r) initialize openssl for multi-threading.
>> >
>> > By default (since commit 04dfd15590a) automount is linked against
>> > libldap (non-reentrant), but I failed to find the reason behind the change.
>> > Could you help me understand why it shouldn't be linked against
>> > libldap_r?
>>
>> That was a long time ago, Jan 2008.
>> Sorry, I don't remember why I committed that change.
>>
>> TBH I always thought the re-entrant version of the library should be
>> used so there must have been a case to justify not using it, I just
>> can't remember what it was.
>>
>> Not a good change log entry either .....
>
> I've found a reference to the post this originated from:
> http://www.mail-archive.com/autofs@linux.kernel.org/msg06499.html
>
> I'm guessing the claim actually is that -D_REENTRANT should deal with
> this although LDFLAGS contains -lpthread so perhaps this was actually a
> problem with Mandriva.
>
> In short:
>
> Hello list.
> Latest release (5.0.3) attempt to link against libldap_r, and fails on
> mandriva because of unresolved pthread symbols. However, according to
> ldap maintainer, libldap_r is supposed to be a private library. Hence
> autofs should use -lldap, not -lldap_r. Attached patch fix this.

Thanks for digging that info in the archives, Ian. I finally had more time
to investigate the problem reported to us and it seems to be a valid one.

I'm going to write a separate email with the complete report and proposed
solution.

Thanks,
Leonardo
