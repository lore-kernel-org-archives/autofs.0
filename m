From: Ian Kent <raven@themaw.net>
Subject: Re: multiple servers per automount
Date: Fri, 10 Oct 2003 09:08:49 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310100856590.7746-100000@wombat.indigo.net.au>
References: <3F85B03E.2050109@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F85B03E.2050109@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net

On Thu, 9 Oct 2003, Mike Waychison wrote:

> Ogden, Aaron A. wrote:
>
> >Ouch.  As you may know, the limit is *much* lower in linux.  Something
> >that I've been struggling with recently...
> >
> >Under normal circumstances I would not be concerned with 'limitations'
> >of a few hundred active NFS mounts, but such limitations certainly limit
> >scalability for the extreme cases.
> >
> >
>
> The maximum number of plain pseudo-block device filesystems on a given
> filesystem is limitted to 256. (This includes proc, autofs, nfs..).
>
> This is because pseudo-block filesystems all use major 0, and each have
> a different minor (thus the 256 limit).
>
> There are however patches floating around (look at SuSe's kernels, I'm
> not sure about RH) that allow n majors to be used (default 5).  This
> gives you 1280 mounts, a big step up :)
>

But as Aaron and I know things go pear shaped at just shy of 800 mounts
with RedHat kernels. They have the more-unnamed patch.

So this would indicate that even if there is a device system that can
increase the number of unnamed devices that subsystems like NFS cannot
handle this many mounts.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
