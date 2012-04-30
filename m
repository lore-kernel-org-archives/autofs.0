From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized pipe
Date: Sun, 29 Apr 2012 18:56:26 -0700
Message-ID: <CA+55aFzEefQWk+0EB2+dcL8DZcn+B7=1HZ1MV0HVMX7prhrmVA@mail.gmail.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com>
 <4F9DDCB6.1070908@zytor.com> <CA+55aFwGZm4+rdJ+xArhsVJ8P5gH3xxCfuoHibotr0Sik484=w@mail.gmail.com>
 <4F9DDE47.5060008@zytor.com> <CA+55aFzDhkVzaUYQwKbkUqoRNb223+w0-k=pOxTZHja75JOMvQ@mail.gmail.com>
 <1335749398.2281.0.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=PK2OT5xB8eXWVHi3fJP0kOEZV4VmXbgtwQ6pjpdeR1k=;
        b=qxhk0fRgIM1Z0zVapS5BTEkkXF1NzgdvofwgtJR4FsvYe11Xl5WYZBcZiZGZAzUZ/E
         1BA7FRkwiTTAkW6BrRcG/kapX0tg0wIZ0xl4P3PHOv16ZOC7dFzhmtuO1d26CTuXTTsg
         dc7M2pDS+tI3LAj8V9GZP75Dwn4KQw/5Eq9lfagxASoD3IgObT/62EBYR3fWir9CUQaJ
         AOajIJgimqXH2Vh0UwjOf9MEB1Bkh5v/PfhmMHjKp/EPRjyb4nY7vStvoLG5ry9xseI2
         XfreKQs064MHjl91ijBtAshH5xJviljojHlQe17qfB/G+msV0hbcpspcIomlyQAvANLi
         CK+g==
In-Reply-To: <1335749398.2281.0.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, Apr 29, 2012 at 6:29 PM, Ian Kent <raven@themaw.net> wrote:
>
> autodir looks ok as well.
>
> http://sourceforge.net/projects/intraperson/files/latest/download

That looks odd, but safe.

Why does the code make the pipe file descriptor non-blocking, when it
then always reads it using that odd "poll_read()" function that does a
loop with poll() and read(). I guess there is some 1-second timeout
thing.

It's a bit odd in other ways too. The "handle_events()" function is
passed the fd, but then it never actually uses it, and uses
'autodir.k_pipe' instead.

So I'm having a bit of trouble following the *logic* to any of that,
but the only reads I found did seem to match the "read whole packet"
model, so it does look ok too.

                     Linus
