From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Wed, 29 Jan 2014 15:16:32 -0200
Message-ID: <CAEySpB7SCYxwqT0z6J+fdgwwo1q0h4C+jwbzjWPKvLS2g=f0Og@mail.gmail.com>
References: <52E92627.9050801@molgen.mpg.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=btCNnmJVJ3/tFwA5ZMru3ErmAH95OHVeYsDX1mzOw2o=;
        b=hvJHUeMxgqyCAmYacomH7stAdHcuoU6eOzRQzdvBtxe5ikZjLePlB/ww+T3slb2yMs
         WJI7VBSRT0qnk6ZXhGxcPnYGy5pokXRCfx/YQEvqBrl0M9MokbhjDV7UT/phNmNeDFga
         Vm75pgo5f5yBhdL/OfwSJjXkC69rXr5ypTL/434fwjmJfAgfwvZo3GJk1oNN8+dY/r+z
         Xo2+P/GjjOv7/1oiL3aKSah63kU2bf8IvNLK6O/BwSk33G+RClKZkXuarYeN1ZdXJDB7
         aWxmW0tSYmitn/jlWP9vPkNEQcUVvr9j6qdfBEr4Yhu4TzZx0YlodnyukTjEHe1n7SPU
         mBpw==
In-Reply-To: <52E92627.9050801@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, Jan 29, 2014 at 2:02 PM, Donald Buczek <buczek@molgen.mpg.de> wrote:
> Hello,
>
> we are trying to switch from amd to autofs. After successfully testing and
> rolling it out to the first several machines, from time to time we get
> directories stuck with "Too many levels of symbolic links" on a path which
> should be automounted via an indirect map.
>
> linux 3.8.13
> autofs 5.0.8
>
> As an example, here is data from a system where the path /scratch/tmp is
> stuck:
>
> http://www.molgen.mpg.de/~buczek/autofs-demo/
>
>   auto.master    # master map
>   auto.scratch    # indirect map for /scratch
>   autofs            # from /etc/defaults
>   typescript       # shows the problem and a bit of gdb dump of kernel
> structures
>   typescript.l     # same with line numbers for reference
>   gdb-macros     # macros used in the gdb session
>
> From typescript.l , line 122ff it is clear, that /scratch/tmp is not
> currently mounted. On the other hand, the gdb session finds the dentry of
> /scratch/tmp which has d_flags 0x70080 (line 99,120). This is
> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS
> with DCACHE_MOUNTED indicating that there should be something mounted
> there(?). I think, this state is faulty and necessarily leads to ELOOP
> during path walk. Probably the situation is known by the gurus here?
>
> Is there any known bug which can lead to this situation? Any advice?

I've seen this case at least once while investigating another problem, but
unfortunately haven't had the time to dig into it. In the case I've seen, it
failed to trigger the mount (with the "Too many levels of symbolic links"
error) but worked a few minutes (seconds?) later if I tried again without
any other action in between. Seems to suggest some race condition.

Can you reproduce the problem at will? Have you tried with a more
recent 3.13+ kernel?

Thanks,
Leonardo
