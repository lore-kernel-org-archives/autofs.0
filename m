From: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: fstatat() AT_NO_AUTOMOUNT man page documentation
Date: Tue, 20 Sep 2011 07:06:19 +0200
Message-ID: <CAKgNAkgeZZ-qf5rm7y+qNrjThgzhUDUMFf1nbSc3yEpEHNu=+Q@mail.gmail.com>
References: <CAKgNAkgOvrNtz+JjXTqzOsH6wQBpQ2AAAG2kBGcCVzObYK=btg@mail.gmail.com>
 <19937.1316470788@redhat.com>
Reply-To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=cOAwpFnOfp+6FQfPaiTZOomF9xXAUwguwhdmWmZJJr0=;
        b=CZo7tAtg6uRyD8dG5xNgQwW3qsBmSzS2pPGbzDgMD/Ol+bJvj8AeO2au8468SLAhx7
         5BSlGBHJXNfAZimLJDqZsP6xLAIuriZTQHJiwnxQmaWqEctaWaTUeEfEi+6fh9ndL6lD
         bof+WVPXAxZ61atV4qDD0+x724fkGpwV/LnYs=
In-Reply-To: <19937.1316470788-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>, npiggin-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi David,

On Tue, Sep 20, 2011 at 12:19 AM, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> w=
rote:
> Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> I've written the following patch for AT__NO_AUTOMOUNT, which you add=
ed
>> to the kernel a while back. Could you please review and ACK/NAK?
>
> It may be worth mentioning that if a mountpoint is already mounted ov=
er, then
> this flag has no effect. =A0It merely prevents further automounting.

Thanks. I added a sentence to say that.

Otherwise the text looks okay?

Cheers,

Michael

diff --git a/man2/fstatat.2 b/man2/fstatat.2
index 2868bfb..23c39dc 100644
--- a/man2/fstatat.2
+++ b/man2/fstatat.2
@@ -22,9 +22,7 @@
 .\" Formatted or processed versions of this manual, if unaccompanied b=
y
 .\" the source, must acknowledge the copyright and authors of this wor=
k.
 .\"
-.\" FIXME: Linux 2.6.38 added AT_NO_AUTOMOUNT
-.\"
-.TH FSTATAT 2 2010-11-21 "Linux" "Linux Programmer's Manual"
+.TH FSTATAT 2 2011-09-19 "Linux" "Linux Programmer's Manual"
 .SH NAME
 fstatat \- get file status relative to a directory file descriptor
 .SH SYNOPSIS
@@ -91,7 +89,19 @@ is absolute, then
 is ignored.

 .I flags
-can either be 0, or include the following flag:
+can either be 0, or include one or more of the following flags ORed:
+.TP
+.BR AT_NO_AUTOMOUNT " (since Linux 2.6.38)"
+Don't automount the terminal ("basename") component of
+.I pathname
+if it is a directory that is an automount point.
+This allows the caller to gather attributes of an automount point
+(rather than the location it would mount).
+This flag can be used in tools that scan directories
+to prevent mass-automounting of a directory of automount points.
+The
+.B AT_NO_AUTOMOUNT
+flag has no effect if the mount point has already been mounted over.
 .TP
 .B AT_SYMLINK_NOFOLLOW
 If

--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
