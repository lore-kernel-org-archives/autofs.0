From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: fstatat() AT_NO_AUTOMOUNT man page documentation
Date: Mon, 19 Sep 2011 23:19:48 +0100
Message-ID: <19937.1316470788@redhat.com>
References: <CAKgNAkgOvrNtz+JjXTqzOsH6wQBpQ2AAAG2kBGcCVzObYK=btg@mail.gmail.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKgNAkgOvrNtz+JjXTqzOsH6wQBpQ2AAAG2kBGcCVzObYK=btg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>, npiggin-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I've written the following patch for AT__NO_AUTOMOUNT, which you added
> to the kernel a while back. Could you please review and ACK/NAK?

It may be worth mentioning that if a mountpoint is already mounted over, then
this flag has no effect.  It merely prevents further automounting.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
