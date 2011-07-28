From: Chuck Lever <chucklever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Libtirpc-devel] [PATCH] Autofs configure fails to detect IPv6
 when libtirpc is enabled
Date: Thu, 28 Jul 2011 10:45:37 -0400
Message-ID: <CAFMMQGsURY2SWv4pM5T-ofLhbVzCvC8a_+ASqJm_ZCEOXww-6g@mail.gmail.com>
References: <1311683346-16881-1-git-send-email-steved@redhat.com>
	<8A84CF7D-9579-4645-AE5D-FE8358F466C0@gmail.com>
	<4E2F2DE6.5030500@RedHat.com>
	<1311728231.3473.7.camel@perseus.themaw.net>
	<1311729784.3473.14.camel@perseus.themaw.net>
	<A8F3853A-9C75-4F65-8EEB-88DD13C3FF9B@gmail.com>
	<1311734445.3473.19.camel@perseus.themaw.net>
	<8A86A2AE-A1C7-473E-931A-CF03BD690CE6@gmail.com>
	<1311819970.3332.3.camel@perseus.themaw.net>
	<E21E3A76-96FD-4F44-8187-70532FD3D6AD@gmail.com>
	<1311863605.3332.17.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Nkwj7t1vFQRd1Xi+TB6SXWpxL3Zm44TLvbjAzMSvmOc=;
        b=nVqdLEl5247TmE1A2ydMcinu/vbTd5fpdlH1rkz6sxBooYZCOc9BfTZHeYgc3fxbzc
         I2ozNcsNtnNgHupuHBdKl1QmTBgRmHl1oPi5OtO8lk6vAwh0IQO84un6E2ktuKEVq0JW
         CSayZA1zqXfxwOm699cawXj1mpIznBBI0Atco=
In-Reply-To: <1311863605.3332.17.camel-jgopVnDzZD88qxobedHYj6xOck334EZe@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <ikent-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Steve Dickson <SteveD-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, autofs mailing list <autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Libtirpc Devel List <libtirpc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

On Thu, Jul 28, 2011 at 10:33 AM, Ian Kent <ikent-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Thu, 2011-07-28 at 07:20 -0400, Chuck Lever wrote:
>> On Jul 27, 2011, at 10:26 PM, Ian Kent wrote:
>> >
>> > Umm ...
>> >
>> > Why is __rpcb_findaddr() declared in the public header files but n=
ot
>> > defined anywhere is the source?
>> >
>> > Why is __rpcb_findaddr_timed() defined in the source but not defin=
ed in
>> > the public header files?
>>
>> This version of libtirpc was split from the Sun version over a decad=
e
>> ago when the code was immature. =A0So you're going to find this kind=
 of
>> thing in many places.
>
> Yes, I was aware of that, but haven't paid enough attention to the do=
c.
>
>>
>> The TI-RPC API is defined in 816-1435. =A0You really shouldn't consi=
der
>> using any of the interfaces defined in the headers but not in that
>> doc, as those are internal interfaces and can change.
>
> Ummm .. rpcb_getaddr() might be what I'm looking for, I'll look furth=
er.
>
>>
>> On the other hand, we have at least two important RPC-based
>> applications that can make use of this interface. =A0I wonder if it
>> makes sense to harden that API but leave it hidden, so apps external
>> to the library can depend on it.
>
> Yeah, but if I can achieve what I need without it that's the way I'll
> go. It looks like I might not be able to do what I want the way I wan=
t
> with ti-rpc but it is still too early to tell. It's also too early to
> tell if ti-rpc actually already does some or all of what I need alrea=
dy.
> Time will tell.
>
> One example of something I need is to control the timeout, not the
> timeout for interactions after the client is constructed but the time=
out
> of the client construction itself, including any queries to rpcbind t=
hat
> may be needed (hence why I want to do that manually too).

Yes, nfs-utils does this too.  See support/nfs/rpc_socket.c.  It looks
a lot like what is done in autofs's lib/rpc_subs.c.

--=20
"Blast this Christmas music! =A0It's joyful _and_ triumphant!"
=A0-- The Grinch
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
