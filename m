From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC] direct mount support re-work for autofs v4
Date: Sat, 26 Feb 2005 11:27:41 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502261121460.3703@raven-wl.themaw.net>
References: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
 <16927.43698.82318.311057@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16927.43698.82318.311057@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Fri, 25 Feb 2005, Jeff Moyer wrote:

> Hi, Ian,
> 
> Thanks for the write-up!  One question below.
> 
> ==> Regarding [autofs] [RFC] direct mount support re-work for autofs v4; raven@themaw.net adds:
> 
> [snip]
> 
> raven> As far as the daemon goes the changes needed to do this are fairly
> raven> straight forward and reduce overall complexity. They amount to
> raven> identifying the direct map in the master map by its key ("/-"),
> raven> adding an additional mount option "direct" to each mount, adding an
> raven> enumeration function to each map lookup module and to the map cache
> raven> module used by autofs v4.  Together they will be used to perform
> raven> mounts, expire runs and umounts.
> 
> raven> Since a single daemon will handle multiple autofs mounts, we need a
> raven> way to distinguish one from another. This can be done by adding two
> raven> additional kernel message handlers to the daemon for "missing" and
> raven> "expire" events. The new messages will include the ioctl fd that
> raven> autofs uses to communicate with the mount point. The lookup key path
> raven> is not needed in these messages as the lookup information can be
> raven> obtained from the ioctl fd found in the event message. In
> raven> particular, the st_dev together with the st_ino from the stat struct
> raven> should be sufficient for distinct key lookups.
> 
> Isn't the message communicated over the ioctl fd?  If so, why include this
> data in the message?  It seems a bit redundant.

Because the ioctl relates to a particular directory (direct mount point) 
of which there may be many.

Each direct mount map entry is a distinct autofs mount with a distinct 
ioctl fd.

> 
> 
> This is as far as I got.  I'll try to look at this in more detail next
> week.

Cool.

Ian
