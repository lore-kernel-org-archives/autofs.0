From: Trond Myklebust <trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org>
Subject: Re: Linux 2.6.27.13
Date: Wed, 28 Jan 2009 14:33:47 -0500
Message-ID: <1233171227.9785.28.camel@heimdal.trondhjem.org>
References: <20090125004823.GA6711@kroah.com>  <4980565E.3000800@krogh.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4980565E.3000800-Q2TZfHgGEy4@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jesper Krogh <jesper-Q2TZfHgGEy4@public.gmane.org>
Cc: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, autofs-CPWUtch7KCBzeIdxy0IIJw@public.gmane.org

On Wed, 2009-01-28 at 13:58 +0100, Jesper Krogh wrote:
> Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.27.13
> > kernel.
> > 
> > It contains a wide range of bugfixes, and all users of the 2.6.27 kernel
> > series are strongly encouraged to upgrade.
> > 
> > I'll also be replying to this message with a copy of the patch between
> > 2.6.27.12 and 2.6.27.13
> 
> Still on a 2.6.27.6  I got this on an NFS client while restarting the 
> NFS-server at the other end. Seems autofs/nfs releated.
> 
> 
> [6367172.212954] ------------[ cut here ]------------
> [6367172.213122] kernel BUG at net/sunrpc/rpcb_clnt.c:498!

Already fixed in 2.6.28 by the following commit.
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git&a=commitdiff&h=9a4bd29fe8f6d3f015fe1c8e5450eb62cfebfcc9

You should probably also apply the following commit (also in 2.6.28),
which fixes a memory leak in the same area.
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git&a=commitdiff&h=96165e2b7c4e2c82a0b60c766d4a2036444c21a0

Cheers
  Trond

--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
