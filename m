From: Chuck Lever <chucklever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Libtirpc-devel] [PATCH] Autofs configure fails to detect IPv6 when libtirpc is enabled
Date: Thu, 28 Jul 2011 07:20:54 -0400
Message-ID: <E21E3A76-96FD-4F44-8187-70532FD3D6AD@gmail.com>
References: <1311683346-16881-1-git-send-email-steved@redhat.com> <8A84CF7D-9579-4645-AE5D-FE8358F466C0@gmail.com> <4E2F2DE6.5030500@RedHat.com>  <1311728231.3473.7.camel@perseus.themaw.net> <1311729784.3473.14.camel@perseus.themaw.net> <A8F3853A-9C75-4F65-8EEB-88DD13C3FF9B@gmail.com> <1311734445.3473.19.camel@perseus.themaw.net> <8A86A2AE-A1C7-473E-931A-CF03BD690CE6@gmail.com> <1311819970.3332.3.camel@perseus.themaw.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Transfer-Encoding: 8BIT
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=Qpj0g4PRNNFnpf5szequFJXlKaiyRP7hU9EFMstvEu0=;
        b=snTsO9X9VFrwlAqAsTKxlH8AOrMPyesdParrDdE0KhB6FftEiD6uPg65WWyy/KGVJW
         QRPSYD3LoRqMOFUcKxKEa8+nLPDJCZ5PIK2leAqqOPNONzO3frMynhlyhihdtnkBeJN5
         0XUlI4M79Z1BVJtVWDWoB/Ym5aZTAUhzQx0zs=
In-Reply-To: <1311819970.3332.3.camel-jgopVnDzZD88qxobedHYj6xOck334EZe@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <ikent-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Steve Dickson <SteveD-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, autofs mailing list <autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Libtirpc Devel List <libtirpc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


On Jul 27, 2011, at 10:26 PM, Ian Kent wrote:

> On Tue, 2011-07-26 at 23:30 -0400, Chuck Lever wrote:
>>>> 
>>>> For IPv6 support, use functions that are part of the modern libtirpc
>>>> API.  This is described in Sun doc 816-1435.  You probably will be
>>>> most successful with the "simplified interface" which is described in
>>>> Chapter 4. You might need somewhat more extensive surgery since I'm
>>>> guessing you have separate code paths to invoke the IPv4 and IPv6
>>>> legacy RPC functions; generally speaking that should not be needed
>>>> when using the libtirpc API.
>>> 
>>> I doubt the simplified interface will be adequate since this code was
>>> written because of a need for greater control over timeouts. Perhaps
>>> that won't be the case, I don't know yet.
>> 
>> If you want control over connection timeouts, use the expert-level or
>> bottom-level interfaces.  Otherwise you can set per-RPC timeouts when
>> clnt_call(3t) is invoked.  nfs-utils has some example code
>> (support/nfs/rpc_socket.c is one place to look).
>> 
>>> Your suggestion amounts to saying I need to re-write all my RPC
>> code.
>> 
>> The substantial change with client-side TI-RPC is how CLIENTs are
>> created.  The other RPC operations are similar or the same as they
>> were with the legacy API.  Once you get over getnetconfigent(3t) it's
>> really not as bad as it looks.
>> 
> 
> Umm ...
> 
> Why is __rpcb_findaddr() declared in the public header files but not
> defined anywhere is the source?
> 
> Why is __rpcb_findaddr_timed() defined in the source but not defined in
> the public header files?

This version of libtirpc was split from the Sun version over a decade ago when the code was immature.  So you're going to find this kind of thing in many places.

The TI-RPC API is defined in 816-1435.  You really shouldn't consider using any of the interfaces defined in the headers but not in that doc, as those are internal interfaces and can change.

On the other hand, we have at least two important RPC-based applications that can make use of this interface.  I wonder if it makes sense to harden that API but leave it hidden, so apps external to the library can depend on it.

Such apps would not be portable away from Linux nor to Linux distributions that don't have libtirpc yet.--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
