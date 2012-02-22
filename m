From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 10:19:41 -0800
Message-ID: <CA+55aFzGyA8QLmri=un4Wm_TnNavCHAMVoY1tfEoA+_UVxT5OA@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <4F4484F0.9070501@zytor.com>
 <CA+55aFwUvuaGdnpwVQLQLF=DdqROmKqz65v+_DXHbebNhPqkLg@mail.gmail.com>
 <4F4529D4.6070008@zytor.com> <CA+55aFzKet5sASgrD==8iZ5m1+-FDpznfuqcNDS5ZyCocwzAbg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=AobHdU3SggLqG69tHh2q2TeBlZr5zXBONYEugwF+XeQ=;
        b=xW+bAWiJb8HExDg35ULee2ByubeY2d+3paYSHOrwks8Yf22sW/Uo/GmQJCdCayuCTJ
         +oaRcHN3s59TIE+DlQ+MYxci6J619jJElrQZzAiNPdVNIZ17OVbfe7MW76w4imW5WQGZ
         DFwusUzJyZxASq9tKfhnZnmp3iMk13JdoFO/A=
In-Reply-To: <CA+55aFzKet5sASgrD==8iZ5m1+-FDpznfuqcNDS5ZyCocwzAbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 22, 2012 at 10:16 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, right now autofs leaks kernel stack way more than that one
> possible alignment word: the whole "name[NAME_MAX+1]" array is leaking
> stuff after the name length (and final zero). So the padding is the
> least of the leaking worries.

Oh, we do have that "memset()" there, and it seems to have been there
since the beginning.

I take all that back. Fixing user space is actually possible.

However, the whole "no regressions" part is that we shouldn't require
updated user space, so we should fix the compat mess in the kernel
regardless.  At which point "fixing user space" becomes irrelevant
again, so ..

                  Linus
